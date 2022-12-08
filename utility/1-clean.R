#' @file 1-clean.R
#' @author Leon Wang
#' @date Fall 2022
#' 
#' R Script to load the raw JSON data from 0-parse.R, extract each year's
#' relevant data, clean it, and prepare it for data processing/visualization.
#' 
#' See README.md for more information on what I am exploring with this data.

# Package checker from 0-parse.R
check_package("curl")
check_package("data.table")

#' Cleaning function
#' @param data the data to extract and clean from
#' @return a DataTable with the desired data to work with
#' 
#' Loops through the 30 chunks of JSON data and extracts the relevant 
#' information from each chunk and appends it to a DataTable that is
#' returned at the end of the function.
#'
clean_data <- function(data) {
  cat("\014cleaning...")
  for (chunk in raw_data) {
    date <- chunk[["items"]][["album"]][["release_date"]][1]
    year <- substr(date, 0, 4)
    duration <- chunk[["items"]][["duration_ms"]]
    if (exists("DF")) {
      yr <- seq(year, year, length.out=length(duration))
      temp <- data.frame(year=yr, rawtime=duration)
      DF <- rbind(DF, temp)
    } else {
      yr <- seq(year, year, length.out=length(duration))
      DF <- data.frame(year=yr, rawtime=duration)
    }
  }
  rm(date, year, duration, chunk, yr, temp)
  cat("\014Data Cleaned")
  Sys.sleep(1)
  cat("\014")
  DT <- setDT(DF)
  DT[, time := rawtime/60000]
  DT[, rawtime := NULL]
  return(DT)
}

data <- clean_data(raw_data)
