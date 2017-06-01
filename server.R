#server.R 

library(dplyr)
library(httr)
library(jsonlite)
library(shiny)
library(leaflet)
library(lubridate)
library(ggplot2)

# Read in data
# setwd("~/Desktop/INFO 201/9-1-1-Incidence-Response-Data")
#source('')
#source('')

endpoint <- "https://data.seattle.gov/resource/pu5n-trf4.json?"
app.token <- "ky71McxIFKv1aPgDQr0yM0huK"

#Static data load for use with data explorations
static.query.params <- list("$where" = "event_clearance_date between '2010-01-01T0:00:00' and '2017-12-31T23:59:59'")
static.response <- GET(endpoint, query = static.query.params)
static.body <- content(static.response, "text")
static.data <- fromJSON(static.body)
static.data <- flatten(static.data)

#reformat dates for use in graphs
static.data <- static.data %>% mutate(reformatted.date = ymd_hms(event_clearance_date))
static.data <- static.data %>% mutate(hour.of.day = hour(reformatted.date))

#group data by hour of event clearance
data.by.hour <- static.data %>% group_by(hour.of.day) %>% summarise(count = n()) 

#group data by district sector
data.by.sector <- static.data %>% group_by(district_sector) %>% summarise(count = n())

# group data by types of events
occurred.events <- group_by(static.data, event_clearance_group) %>%
  summarise(count = n())
# Start shinyServer
shinyServer(function(input, output) {
  
  # reactive function to adapt to data changes by user
  filteredData <- reactive({
    # make api request
    query.params <- list("$where" = paste0("event_clearance_date between '", input$year.slider[1], "-01-01T0:00:00' and '", input$year.slider[2], "-12-31T23:59:59'"))
    response <- GET(endpoint, query = query.params)
    body <- content(response, "text")
    yearly.data <- fromJSON(body)
    yearly.data <- flatten(yearly.data)
    
    # coerce longitude and latitude to numerics
    yearly.data <- mutate(yearly.data, longitude = as.numeric(longitude), latitude = as.numeric(latitude))
    
    #Reformat dates for easier manipulation
    yearly.data <- mutate(yearly.data, hour.of.day = hour(event_clearance_date))
    
    
  })
  
  # render map with default values
  output$incident.map <- renderLeaflet({
    # plot points on map
    leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      setView(-122.28, 47.61, zoom = 12)
  })
  
  # update map as data changes
  observe({
    leafletProxy("incident.map", data = filteredData()) %>%
      clearMarkers() %>%
      addCircleMarkers(~longitude, ~latitude, radius = 4, stroke = FALSE)
  })
  
  #Line plot of event clearances by hour of day
  output$timeOfDayPlot <- renderPlot({
    ggplot(data.by.hour, aes(x = hour.of.day, y = count)) + geom_point() + geom_line() + 
      labs(x = "Hour of Day", y = "Frequency of Incidences", title = "911 Event Clearances by Hour of Day") +
      xlim(0, 23) + ylim(0, 70)
    
    
  })
  
  #Histogram of events, grouped by the district in which they occurred
  output$bySectorPlot <- renderPlot({
    ggplot(data.by.sector, aes(x = district_sector, y = count)) + geom_bar(stat = "identity") +
      labs(x = "District Sector", y = "Frequency of Incidences", title = "911 Events by District Sector")
  })
  
  output$occurredEventsPlot <- renderPlot({
    ggplot(data = occurred.events, aes(x = event_clearance_group, y = count)) + geom_point(stat = "identity") +
      theme_bw() +
      theme(axis.text = element_text(angle = 90, hjust = 1)) +
      labs(x = "Types of Events", y = "Number of Occurences", title = "Number of Occurence For Each Type Of Accidents.")
  })
})

