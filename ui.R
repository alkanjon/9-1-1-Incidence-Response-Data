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
                         choices = list("SELECT..." = 1, "ANIMAL COMPLAINTS" = 2, "ASSAULTS" = 3, "AUTO RECOVERIES" = 4,
                           "AUTO THEFTS" = 5, "BURGLARY ALARMS (FALSE)" = 6, "CAR PROWL" = 7,
                           "CASUALTIES" = 8, "COMMERICAL BURGLARIES" = 8, "DISTURBANCES" = 9,
                           "FRAUD CALLS" = 9, "GUN CALLS" = 10, "HAZARDS" = 11, "LIQUOR VIOLATIONS" = 12,
                           "MENTAL CALL" = 13, "MISCELLANEOUS MISDEMEANORS" = 14, "NARCOTICS COMPLAINTS" = 15,
                           "NOISE DISTURBANCE" = 16, "NUISANCE, MISCHIEF COMPLAINTS" = 17,
                           "PANIC ALARMS (FALSE)" = 18, "PARKING VIOLATIONS" = 19, "PERSONS - LOST, FOUND, MISSING" = 20,
                           "PROPERTY - MISSING, FOUND" = 21, "PROPERTY DAMAGE" = 22, "RESIDENTIAL BURGLARIES" = 23,
                           "ROBBERY" = 24, "SUSPICIOUS CIRCUMSTANCES" = 25, "THEFT" = 26, "THREATS, HARASSMENT" = 27,
                           "TRAFFIC-RELATED CALLS" = 28, "TRESPASS" = 29, "VEHICLE ALARMS (FALSE)" = 30,
                           "VICE CALLS" = 31, "WARRANT CALLS" = 32),
                         selected = 1)
           )
       )
       
    ),
    
    # tab for data breakdown / charts
    tabPanel("Data Explorer",
      # charts / descriptions
      h2("Data Explorations"),
      plotOutput('timeOfDayPlot')
    )
  )
)