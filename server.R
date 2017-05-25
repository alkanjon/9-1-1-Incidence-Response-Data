#server.R

library(dplyr)
library(httr)
library(jsonlite)

# Read in data
setwd("~/Desktop/INFO 201/9-1-1-Incidence-Response-Data")
#source('')
#source('')

URI <- "https://data.seattle.gov/resource/pu5n-trf4.json"
URI.Token <- "urMEfPn6KX0XAeZI6sTjOOAKDKylzmg8rrba"
response <- GET(URI)
body <- content(response, "text")
SPD.data <- fromJSON(body)
SPD.data <- flatten(SPD.data)



# Start shinyServer
shinyServer(function(input, output) { 
  
})

