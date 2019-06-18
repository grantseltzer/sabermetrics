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