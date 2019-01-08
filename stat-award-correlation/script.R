data <- read.csv("~/R/sabermetrics/stat-award-correlation/data/awards/cy-young-2018.csv")

stats_to_correlate <- list(data$ERA, data$SO, data$WHIP, data$WAR, data$ERA., data$W.L)
filenames          <- c("ERA.png", "Strikeouts.png", "WHIP.png", "WAR.png", "ERA-Plus.png", "Win-Loss.png") 
counter            <- 1

for (stat in stats_to_correlate){
  
  bestFit     <- coef(lm(stat ~ Vote.Pts, data = data))
  correlation <- cor(stat, data$Vote.Pts)
 
  scatterPlot <- ggplot(data, aes(Vote.Pts, stat), color=black) + geom_point() +
    geom_abline(intercept = bestFit[1], slope = bestFit[2]) +
    annotate("text", x=mean(data$Vote.Pts), y=min(stat), label = correlation)
  
  ggsave(filenames[counter], plot = scatterPlot, device = "png", 
         path = "~/R/sabermetrics/stat-award-correlation/plots",
         scale = 1, width = NA, height = NA, units = c("in", "cm", "mm"),
         dpi = 300, limitsize = TRUE)
  
  counter = counter+1
}
