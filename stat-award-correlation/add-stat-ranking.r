# Read in data
folder    <- "/home/rstudio/R/sabermetrics/stat-award-correlation/data/By-League/"
saveFolder <- "/home/rstudio/R/sabermetrics/stat-award-correlation/data/By-League/With-Stat-Rank/"
file_list <- list.files(path=folder, pattern="*.csv")

for (i in 1:length(file_list)){
  filename = paste(folder, file_list[i], sep='')
  saveFilename = paste(saveFolder, file_list[i], sep='')
  data <- read.csv(filename)
  
  data$WRank       <- NA
  data <- data[order(-data$W),]
  for(i in 1:nrow(data)){
    data[i,]$WRank = i
  }
  
  data$SORank       <- NA
  data <- data[order(-data$SO),]
  for(i in 1:nrow(data)){
    data[i,]$SORank = i
  }
  
  data$ERARank       <- NA
  data <- data[order(data$ERA),]
  for(i in 1:nrow(data)){
    data[i,]$ERARank = i
  }
  
  data$WARRank       <- NA
  data <- data[order(-data$WAR),]
  for(i in 1:nrow(data)){
    data[i,]$WARRank = i
  }
  
  data$ERAPlusRank       <- NA
  data <- data[order(-data$ERA.),]
  for(i in 1:nrow(data)){
    data[i,]$ERAPlusRank = i
  }
  
  write.csv(data, file = saveFilename, row.names=FALSE)
}

