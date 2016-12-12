
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
      
      selectInput("analysis", 
                  label = "Choose a type of exploratory analysis:", 
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

