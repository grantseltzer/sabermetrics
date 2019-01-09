library(ggplot2)

data <- read.csv("~/R/sabermetrics/stat-award-correlation/data/awards/cy-young-2018.csv")

stats_to_correlate <- list(data$ERA, data$SO, data$WHIP, data$WAR, data$ERA., data$W.L)
filenames          <- c("ERA.png", "Strikeouts.png", "WHIP.png", "WAR.png", "ERA-Plus.png", "Win-Loss.png")
axis_labels        <- c("ERA", "Strikeouts", "WHIP", "WAR", "ERA+", "W-L%")
counter            <- 1
shareVector        <- as.numeric(sub("%", "", data$Share))

# Go through each stat to correlate, creating a plot with each point and linear regression
for (stat in stats_to_correlate){
  model       <- lm(stat ~ shareVector)
  bestFit     <- coef(model)
  correlation <- cor(stat, shareVector)^2
  title       <- paste("Correlation between",axis_labels[counter], "and Share of Cy Young Votes 2018")
  subtitle    <- paste("R-Squared value:", correlation)
 
   scatterPlot <- ggplot(data, aes(shareVector, stat)) +
    geom_point(color = "#031634") + 
    geom_abline(intercept = bestFit[1], slope = bestFit[2], color="red") +                   
    labs(title = title, subtitle = subtitle, x = "Share of Votes (%)", y = axis_labels[counter]) +
    theme(panel.background = element_rect(fill = "#E8DDCB"),
          panel.grid.major = element_line(color = "white"),
          panel.grid.minor = element_line(color = "white"))
  
  scatterPlot   
  
  ggsave(filenames[counter], plot = scatterPlot, device = "png", 
         path = "~/R/sabermetrics/stat-award-correlation/plots",
         scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
         dpi = 300, limitsize = TRUE)
  
  counter = counter+1
}

