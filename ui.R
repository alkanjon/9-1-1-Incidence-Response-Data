# import libraries
library(shiny)
library(plotly)

# shinyUI
shinyUI(
  navbarPage("SPD 911 Incidents",
             
    # tab for interactive map
    tabPanel("Interactive Map",
      sidebarLayout(
        
        # widgets
        sidebarPanel(
          # filter by event clearance
          
          # filter by incident report
          
          # filter by date
          sliderInput("year.slider",
                      "Filter by Year",
                      min = 2010,
                      max = strtoi(format(Sys.Date(), "%Y")),
                      value = c(2016, 2017),
                      step = 1,
                      sep = "")
        ),
        
        # plot
        mainPanel(
          plotOutput('')
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