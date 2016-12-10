---
title: "ShinyApp_CourseProject"
author: "Temilade Sorungbe"
date: "9 December 2016"
output: html_document
runtime: shiny
---

##Summary 
This Shiny App performs 3 types of exploratory analyses on the speed (mph) of cars recorded in the cars dataset. The user should select one of the following 3 types of exploratory analyses below:

1) Data summary - a list of the following data statistics: minimum, 1st quantile, median, mean, 3rd quantile and maximum

2) Histogram - a distribution plot of the data 

3) Box plot - A graphical summary of the data specifically the minimum, 1st quanitile, median, 3rd quantile, maximum and outliers 

```{r echo=FALSE, warning=FALSE, message=FALSE}

library(shiny)

# Define UI for dataset viewer application
shinyApp(
  
ui = fluidPage(

  # Sidebar with controls to select analysis
    
  sidebarLayout(
    sidebarPanel(
      
      selectInput("analysis", 
                  label = "Choose a type of exploratory analysis:", 
                  choices = c("Data Summary", "Histogram", "Boxplot"),
                  selected = "Histogram"),
    
    submitButton("Update View")
    
    ),
  
  
    # Show the histogram, box plot or data summary of the dataset 
    
    mainPanel(
      h4("Data Summary"),
      tableOutput("summary"),
      
      h4("Histogram"),
      plotOutput("Histogram"),
      
      h4("Boxplot"),
      plotOutput("Boxplot")
    )
  )
),

server = function(input, output) {
  
  # By declaring analysisInput as a reactive expression we ensure 
  # that:
  #
  #  1) It is only called when the inputs it depends on changes
  #  2) The computation and result are shared by all the callers 
  #	  (it only executes a single time)
  #
  
  analysisInput <- reactive({
    switch(input$analysis,
           "Histogram" = 1,
           "Boxplot" = 2,
           "Data Summary" = 3)
  })
  
  # The output$summary, output$Boxplot and output$Histogram depends 
  # on the analysisInput reactive
  # expression, so will be re-executed whenever analysisInput is
  # invalidated (i.e. whenever the input$analysis changes)
  
    
  output$summary <- renderPrint ({ 
    analysis <- analysisInput()
    if (analysis == 3) {summary(cars)}
  })
  
  output$Boxplot <- renderPlot ({ 
    analysis <- analysisInput()
    if (analysis == 2) {
      boxplot(cars) 
      title(main = "1920s Cars - Boxplot", ylab = "Speed (mph)")}
  })
  
  output$Histogram <- renderPlot({
    analysis <- analysisInput()
    if (analysis == 1) {
    par(mfcol= c(1,2), oma=c(4,2,4,2))  
    hist(cars[,1], breaks = 10, col = 'darkgray', border = 'white',
      main = "1920s Cars - Distribution",
      xlab = "Speed (mph)")
    
    hist(cars[,2], breaks = 10, col = 'darkgray', border = 'white',
      main = "1920s Cars - Distribution",
      xlab = "Distance(ft)")
      }
  })

},

  options = list(height = 500)
)

```
