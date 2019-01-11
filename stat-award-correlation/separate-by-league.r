# Read in data
folder    <- "/home/rstudio/R/sabermetrics/stat-award-correlation/data/By-League"
saveFolder <- "/home/rstudio/R/sabermetrics/stat-award-correlation/data/By-League/With-Stat-Rank"
file_list <- list.files(path=folder, pattern="*.csv")

for (i in 1:length(file_list)){
  
  data <- read.csv(paste(folder, file_list[i], sep=''))
  
  for (x in 2:nrow(data)) {
    if (data[x,]$Rank == 1) {
      al <- data[1:x-1,]
      al_filename <- paste(saveFolder, "AL_",file_list[i], sep="")
      write.csv(al, file = al_filename,row.names=FALSE)
      
      nl <- data[x:nrow(data),]
      nl_filename <- paste(saveFolder, "NL_",file_list[i], sep="")
      write.csv(nl, file = nl_filename,row.names=FALSE)
      
      break
    }
  }
}

