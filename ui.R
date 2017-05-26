# import libraries
library(shiny)
library(plotly)

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
        absolutePanel(id = "map-controls", top = 0, left = "auto", right = 40, bottom = "auto", width = 330, height = "100%",
          
          # filter by date
          sliderInput("year.slider",
                      "Filter by Year",
                      min = 2010,
                      max = strtoi(format(Sys.Date(), "%Y")),
                      value = c(2016, 2017),
                      step = 1,
                      sep = "")
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