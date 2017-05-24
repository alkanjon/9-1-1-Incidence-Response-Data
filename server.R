#server.R

library(dplyr)
library(httr)
library(jsonlite)

# Read in data
setwd("~/Desktop/INFO 201/9-1-1-Incidence-Response-Data")
#source('')
#source('')
URI <- "https://data.seattle.gov/resource/pu5n-trf4.json"
response <- GET(URI)
body <- content(response, "text")
SPD.data <- fromJSON(body)

# Start shinyServer
shinyServer(function(input, output) { 
  
})


response <- GET("https://api.spotify.com/v1/artists/0oSGxfWSnnOXhD2fKuz2Gy/albums")  # albums by Bowie
body <- content(response, "text")  # extract the body JSON
parsed.data <- fromJSON(body)  # convert the JSON string to a list