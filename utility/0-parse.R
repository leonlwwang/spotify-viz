#' @file 0-parse.R
#' @author Leon Wang
#' @date Fall 2022
#' 
#' R Script to pull the desired raw JSON data from the Spotify API 
#' using the authorization token generated from auth.sh. The data 
#' is then cached into the R environment.
#' 
#' For this project, I am formulating a vector with 30 chunks of JSON data,
#' where I pull up to 50 tracks from each year between 1992-2022. 
#' See README.md for more information on what I am exploring with this data.
#' 
#' The desired endpoint was created with the Spotify API console,
#' accessible here: https://developer.spotify.com/console/

#' Package-checking Function
#' @param lib_name the name of the library to check
#' 
#' Checks if the package is installed and loaded.
#' If not, it attempts to install and load the package.
#' This function is mainly to ensure that the program
#' runs on the STAT 447 Morrow server.
#'
check_package <- function(lib_name) { 
  if (require(lib_name, character.only=T)) {
    cat(lib_name, "is loaded correctly")
  } else {
    cat("installing ", lib_name, "... ")
    install.packages(lib_name, character.only=T)
    if (require(lib_name, character.only=T)) {
      cat(lib_name, "installed and loaded")
    } else {
      stop(cat("could not install ", lib_name))
    }
  }
}

check_package("httr")
check_package("jsonlite")

#' Data-grabbing Function
#' @param token the access token generated by auth.sh
#' @return raw_data, a list of JSON data
#' 
#' Constructs a list called 'data' containing 30 chunks of JSON data,
#' each chunk holding 50 tracks from every year between 1992 to 2022.
#' @note that this function may take a while to execute.
#'
pull_data <- function(token) {
  raw_data <- list()
  cat("\014Pulling data: ")
  for (year in 1992:2022) {
    endpoint <- paste0("https://api.spotify.com/v1/search?q=year%3A", year, "&type=track&market=US&limit=50")
    response <- GET(endpoint, add_headers(Authorization = token))
    if (status_code(response) == 401) {
      stop(cat("\nERROR: the access token expired. Please generate a new one with auth.sh"))
    }
    if (status_code(response) != 200) {
      stop(cat("\nERROR: failed to pull data, code: ", status_code(response)))
    }
    raw <- fromJSON(rawToChar(response$content))
    raw_data <- append(raw_data, raw)
    cat("???")
  }
  # Dump API resources b/c the access token will expire anyways
  rm(raw, response, token, endpoint, year)
  cat("\nComplete")
  Sys.sleep(1)
  cat("\014")
  return(raw_data)
}

# Generate a token from auth.sh
access_token <- paste("Bearer", system("utility/auth.sh", intern=T))
raw_data <- pull_data(access_token)
