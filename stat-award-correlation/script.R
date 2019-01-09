library(ggplot2)
library(stringr)

# Read in data
folder    <- "/home/rstudio/R/sabermetrics/stat-award-correlation/data/awards/with-year/"
file_list <- list.files(path=folder, pattern="*.csv")
data <- do.call("rbind", lapply(file_list, function(x) read.csv(paste(folder, x, sep=''))))
data <- data[data$IP > 150,]

Sixties      <- data[data$Year >= 1960 & data$Year < 1970,]
Seventies    <- data[data$Year >= 1970 & data$Year < 1980,]
Eighties     <- data[data$Year >= 1980 & data$Year < 1990,]
Seventies    <- data[data$Year >= 1990 & data$Year < 2000,]
TwoThousands <- data[data$Year >= 2000 & data$Year < 2010,]
TwoTens      <- data[data$Year >= 2010 & data$Year < 2020,]

stats_to_correlate <- list(data$ERA, data$SO, data$WHIP, data$WAR, data$ERA., data$W.L)
filenames          <- c("ERA.png", "Strikeouts.png", "WHIP.png", "WAR.png", "ERA-Plus.png", "Win-Loss.png")
axis_labels        <- c("ERA", "Strikeouts", "WHIP", "WAR", "ERA+", "W-L%")
counter            <- 1
shareVector        <- as.numeric(sub("%", "", data$Share))

# Go through each stat to correlate, creating a plot with each point and linear regression
for (stat in stats_to_correlate){
  model       <- lm(stat ~ shareVector)
  bestFit     <- coef(model)
  correlation <- cor(x = shareVector, y = stat)^2
  title       <- paste("Correlation between",axis_labels[counter], "and Share of Cy Young Votes")
  subtitle    <- paste("R-Squared value:", correlation)
  
  scatterPlot <- ggplot(data, aes(x = shareVector, y = stat, color = Year)) +
    geom_point() + 
    geom_abline(intercept = bestFit[1], slope = bestFit[2], color="#7B3B3B") +                   
    labs(title = title, subtitle = subtitle, x = "Share of Votes (%)", y = axis_labels[counter]) +
    theme(plot.background  = element_rect(fill = "white"),
          panel.background = element_rect(fill = "#B9D7D9"),
          panel.grid.major = element_line(color = "white"),
          panel.grid.minor = element_line(color = "white"))
  scatterPlot
  ggsave(filenames[counter], plot = scatterPlot, device = "png", 
         path = "~/R/sabermetrics/stat-award-correlation/plots",
         scale = 1, width = 12, height = 8, units = c("in"),
         dpi = 300, limitsize = TRUE)
  
  counter = counter+1
}


