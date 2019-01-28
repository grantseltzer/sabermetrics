library(ggplot2)

folder    <- "/home/rstudio/R/sabermetrics/stat-award-correlation/data/By-League/With-Stat-Rank/"
file_list <- list.files(path=folder, pattern="*.csv")

statCorrelationsOverTime <- data.frame(matrix(nrow=length(file_list), ncol=7)) 
colnames(statCorrelationsOverTime) <- c("League", "Year", "Wins", "ERA", "SO", "WAR", "ERA+")

for (i in 1:length(file_list)) {
  data <- read.csv(paste(folder, file_list[i], sep=''))
  year <- strsplit(strsplit(file_list[i], "-")[[1]][3], ".csv")[[1]]
  league <- strsplit(file_list[i], "_")[[1]][1]
  
  winsCor <- cor(x = data$Rank, y = data$WRank)
  eraCor <- cor(x = data$Rank, y = data$ERARank)^2
  soCor <- cor(x = data$Rank, y = data$SORank)^2
  warCor <- cor(x = data$Rank, y = data$WARRank)^2
  eraPlusCor <- cor(x = data$Rank, y = data$ERAPlusRank)^2
  statCorrelationsOverTime[i, ] =  list(league, year, winsCor, eraCor, soCor, warCor, eraPlusCor)
}

write.csv(statCorrelationsOverTime, file = "/home/rstudio/R/sabermetrics/stat-award-correlation/data/correlations-over-time.csv", row.names=FALSE)
