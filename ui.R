#ui.R

library(shiny)
library(plotly)
shinyUI(navbarPage('Electoral College',
                   # Create a tab panel for your map
                   tabPanel('Tab Title',
                            titlePanel('Page Title'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                # Input to select variable to map
                                selectInput()
                              ),
                              
                              # Main panel
                              mainPanel(
                                plotlyOutput('')
                              )
                            )
                   ), 
                   
                   # Create a tabPanel to show your scatter plot
                   tabPanel('Tab Title',
                            # Add a titlePanel to your tab
                            titlePanel('Page Title'),
                            
                            # Create a sidebar layout for this tab (page)
                            sidebarLayout(
                              
                              # Create a sidebarPanel for your controls
                              sidebarPanel(
                        
                              ),
                              
                              mainPanel(
                                plotlyOutput('')
                              )
                            )
                   )
))