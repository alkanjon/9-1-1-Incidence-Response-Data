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
      plotOutput('timeOfDayPlot'),
      p("The above graph details the hour of day (based on a 24-hour clock) at which events were cleared. Events have two clear peaks,
        One in the early morning at roughly 0100, and one in the evening at 1800 hours. Crime is lowest in the later stages of the morning,
        around 0600."),
      br(),
      plotOutput('bySectorPlot'),
      p("The bar graph above shows the distribution of 911 events across Seattle PD's district sectors. Districts K and M see the highest rates of 911 events,
        while districts 99, G, and S see lower rates."),
      br(),
      plotOutput("occurredEventsPlot"),
      p("The graph above shows the number of occurrences for each type of events. Based on the graph
        traffic related calls occur the most.")
    ),
    
    tabPanel("About the Data",
             h2("Why SPD Data"),
             p("We chose to analyze Seattle Police Department data because we wanted to provide a tool that would be beneficial to the
               thousands of new home buyers entering the Seattle market. Being able to gain quick insights into crime in different 
               neighborhoods would be a valuable ability to have when deciding where to live in Seattle. Furthermore, being able to 
               discern crimes on a visual level could help users identify what kind of crimes might apply to them in certain neighborhoods.
               This could help them make the best decision for them and potentially their families."),
             br(),
             h2("Insights"),
             p("From our analysis we were able to derive insights into the neighborhoods, times, and the crimes most likely to take place
               in Seattle."),
             p("The most reported incidences were in regards to traffic, suspisious circumstances, and disturbances. Which tells us that 
               calls in the Seattle area are, on the surface level, are not dangerous and could to some degree be taken out of consideration
               when searching for a new home."),
             p("The times that calls were most frequently called in at were 6PM, 1AM, and 12PM. While this data can be useful to people 
               looking into where to live, this insight would most likely be more useful for the SPD. Knowing this, the SPD could deploy more
               patrolls during this hour in areas with higher call rates to reduce response time and most likely deal with violators of the 
               law in a quicker fashion."),
             p("Finally, using our data we were able to identify the sectors (SPD Beats) that had the highest number of reported incidents.
               The two sectors that had the most calls were the K and M sector. Interestingly, both of these sectors are within the West
               Precint of Seattle. This could help the SPD and current/future homebuyers in the Seattle area identify high incidents
               areas to aviod.")
    )
  )
)