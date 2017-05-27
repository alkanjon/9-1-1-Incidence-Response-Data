#server.R

library(dplyr)
library(httr)
library(jsonlite)
library(leaflet)

# Read in data
# setwd("~/Desktop/INFO 201/9-1-1-Incidence-Response-Data")
#source('')
#source('')

URI <- "https://data.seattle.gov/resource/pu5n-trf4.json"
URI.Token <- "ky71McxIFKv1aPgDQr0yM0huK"
response <- GET(URI)
body <- content(response, "text")
SPD.data <- fromJSON(body)
SPD.data <- flatten(SPD.data)



# Start shinyServer
shinyServer(function(input, output) { 
  
  output$incident.map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(-122.28, 47.61, zoom = 12)
  })
  
})

