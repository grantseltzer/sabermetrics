library(XML)
library(RCurl)

getLeagueOffenseByYear <- function(year) {
        url <- paste("https://www.baseball-reference.com/leagues/MLB/", year, ".shtml", sep="")
        page <- getURL(url)
        table <- readHTMLTable(page, stringsAsFactors = F)
        table <- table$teams_standard_batting
        length <- nrow(table)
        return(table[length,])
}

avgsOverTime <- data.frame(matrix(nrow=119, ncol=7))
colnames(avgsOverTime) <- c("YEAR", "SO", "BB", "1B", "2B", "3B", "HR")

x = 1

for (year in 1900:2019) {
  yearSummaryRow <- getLeagueOffenseByYear(year)
  print(year)
  plateApps      <- as.numeric(yearSummaryRow$PA)
  strikeouts     <- as.numeric(yearSummaryRow$SO) / plateApps * 100
  homeruns       <- as.numeric(yearSummaryRow$HR) / plateApps * 100 
  walks          <- as.numeric(yearSummaryRow$BB) / plateApps * 100 
  doubles        <- as.numeric(yearSummaryRow$`2B`) / plateApps * 100 
  triples        <- as.numeric(yearSummaryRow$`3B`) / plateApps * 100 
  singles        <- (as.numeric(yearSummaryRow$H) - homeruns - doubles - triples)  / plateApps * 100 
  
  avgsOverTime[x,] = list(year, strikeouts, walks, singles, doubles, triples, homeruns)
  
  x = x + 1
}

write.csv(avgsOverTime, file = "/home/rstudio/R/sabermetrics/DefiningModernBaseball/data/league-average-rates-per-PA.csv", row.names=FALSE)