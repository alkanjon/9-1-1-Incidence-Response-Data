# import libraries
library(shiny)
library(plotly)
library(leaflet)

# shinyUI
shinyUI(
  navbarPage("SPD 911 Incidents",
             
    # tab for interactive map
    tabPanel("Interactive Map",

       # div to fill screen height
       div(class = "outer",
           
           # use custom style.css file
           tags$head(
             includeCSS("style.css")
           ),
           
           # interactive map
           leafletOutput("incident.map", height = "100%"),
           
           # panel for widgets
           absolutePanel(id = "map-controls", top = 0, left = "auto", right = 40, bottom = 0,
                         
             h2("Map Filters"),
             
             # filter by date
             sliderInput("year.slider",
                         "Year",
                         min = 2010,
                         max = strtoi(format(Sys.Date(), "%Y")),
                         value = c(2016, 2017),
                         step = 1,
                         sep = ""),
             
             selectInput("subgroup", label = h4("Incidence Subgroup"),
                         choices = list("Select..." = 1, "Animal Complaints" = 2, "Assaults" = 3, "Auto Recoveries" = 4,
                           "Auto Thefts" = 5, "Burglary Alarms (False)" = 6, "Car Prowl" = 7,
                           "Casualties" = 8, "Commercial Burglaries" = 8, "Disturbances" = 9,
                           "Fraud Calls" = 9, "Gun Calls" = 10, "Hazards" = 11, "Liquor Violations" = 12,
                           "Mental Call" = 13, "Misc. Misdemeanors" = 14, "Narcotics Complaints" = 15,
                           "Noise Disturbance" = 16, "Nuisance, Mischief Complaints" = 17,
                           "Panic Alarms (False)" = 18, "Parking Violations" = 19, "Persons - Lost, Found, Missing" = 20,
                           "Property - Missing, Found" = 21, "Property Damage" = 22, "Residential Burglaries" = 23,
                           "Robbery" = 24, "Suspicious Circumstances" = 25, "Theft" = 26, "Threats, Harassment" = 27,
                           "Traffic-Related Calls" = 28, "Trespass" = 29, "Vehicle Alarms (False)" = 30,
                           "Vice Calls" = 31, "Warrant Calls" = 32),
                         selected = 1)
           )
       )
       
    ),
    
    # tab for data breakdown / charts
    tabPanel("Data Explorer",
      # charts / descriptions
      plotOutput('')
    )
  )
)