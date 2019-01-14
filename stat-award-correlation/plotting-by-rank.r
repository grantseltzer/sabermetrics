library(ggplot2)

folder    <- "/home/rstudio/R/sabermetrics/stat-award-correlation/data/By-League/With-Stat-Rank/"
file_list <- list.files(path=folder, pattern="*.csv")

for (i in 1:1){

  data <- read.csv(paste(folder, file_list[i], sep=''))
  year <- strsplit(strsplit(file_list[i], "-")[[1]][3], ".csv")[[1]]
  league <- strsplit(file_list[1], "_")[[1]][1]
  
  stats_to_correlate <- list(data$ERARank, data$SORank, data$WARRank, data$ERAPlusRank, data$WRank)
  filenames          <- c("ERA.png", "Strikeouts.png",  "WAR.png", "ERA-Plus.png", "Wins.png")
  axis_labels        <- c("ERA-Rank", "Strikeouts-Rank",  "WAR-Rank", "ERAPlus-Rank", "Wins-Rank")
  counter            <- 1
  
  for (stat in stats_to_correlate){
      model       <- lm(stat ~ data$Rank)
      bestFit     <- coef(model)
      correlation <- cor(x = data$Rank, y = stat)^2
      title       <- paste("Correlation between", axis_labels[counter], "and Place in Cy Young Voting", league ,year)
      subtitle    <- paste("R-Squared value:", correlation)

      scatterPlot <- ggplot(data, aes(x = data$Rank, y = stat)) +
       geom_point() + 
       geom_abline(intercept = bestFit[1], slope = bestFit[2], color="#7B3B3B") +                   
       labs(title = title, subtitle = subtitle, x = "Voting Rank", y = axis_labels[counter]) +
       theme(plot.background  = element_rect(fill = "white"),
             panel.background = element_rect(fill = "#B9D7D9"),
             panel.grid.major = element_line(color = "white"),
             panel.grid.minor = element_line(color = "white"))
      
       ggsave(paste(file_list[i], axis_labels[counter], ".png", sep=""), plot = scatterPlot, device = "png", 
             path = "~/R/sabermetrics/stat-award-correlation/plots",
             scale = 1, width = 12, height = 8, units = c("in"),
             dpi = 300, limitsize = TRUE)
      
      counter = counter + 1
    }
}

