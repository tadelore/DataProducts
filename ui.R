
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Define UI for dataset viewer application
fluidPage(

  # Sidebar with controls to select analysis

  sidebarLayout(
    sidebarPanel(
      
      helpText("This Shiny App performs 3 types of exploratory analyses on", 
                "the cars dataset. The user should select one of the",
                "3 types of exploratory analyses below and",
                "click on 'Update View' to view results:"),
      
      selectInput("analysis", 
                  label = "Select a type of exploratory analysis:", 
                  choices = c("Histogram", "Boxplot", "Data Summary"),
                  selected = "Histogram"),
    
    submitButton("Update View")
    ),
  
  
    # Show the histogram, box plot or data summary of the dataset and an HTML 
    # table with the requested number of observations
    mainPanel(
      h4("Data Summary"),
      tableOutput("summary"),
      
      h4("Histogram"),
      plotOutput("Histogram"),
      
      h4("Boxplot"),
      plotOutput("Boxplot")
    )
  )
)


