#server.R

library(dplyr)
library(httr)
library(jsonlite)
library(leaflet)

# Read in data
# setwd("~/Desktop/INFO 201/9-1-1-Incidence-Response-Data")
#source('')
#source('')

endpoint <- "https://data.seattle.gov/resource/pu5n-trf4.json?"
app.token <- "ky71McxIFKv1aPgDQr0yM0huK"
response <- GET(endpoint)
body <- content(response, "text")
SPD.data <- fromJSON(body)
SPD.data <- flatten(SPD.data)



# Start shinyServer
shinyServer(function(input, output) {
  
  filteredData <- reactive({
    # make api request using user defined year range
    year.query.params <- list("$where" = paste0("event_clearance_date between '", input$year.slider[1], "-01-01T0:00:00' and '", input$year.slider[2], "-12-31T23:59:59'"))
    response <- GET(endpoint, query = year.query.params)
    body <- content(response, "text")
    yearly.data <- fromJSON(body)
    yearly.data <- flatten(yearly.data)
    
    # coerce longitude and latitude to numerics
    yearly.data <- mutate(yearly.data, longitude = as.numeric(longitude), latitude = as.numeric(latitude))
  })
  
  output$incident.map <- renderLeaflet({
    # coerce longitude and latitude to numerics
    yearly.data <- mutate(yearly.data, longitude = as.numeric(longitude), latitude = as.numeric(latitude))
    
    # plot points on map
    leaflet(data = yearly.data) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addCircleMarkers(~longitude, ~latitude,
                       radius = 4,
                       stroke = FALSE) %>%
      setView(-122.28, 47.61, zoom = 12)
  })
  
  observe({
    leafletProxy("incident.map", data = filteredData()) %>%
      clearMarkers() %>%
      addCircleMarkers(~longitude, ~latitude, radius = 4, stroke = FALSE)
  })
  
})

