
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

library(datasets)

# Define server logic required to summarize and view the selected
# dataset
function(input, output) {
  
  # By declaring datasetInput as a reactive expression we ensure 
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
  # expression, so will be re-executed whenever datasetInput is
  # invalidated
  # (i.e. whenever the input$dataset changes)
  
    
  output$summary <- renderPrint ({ 
    analysis <- analysisInput()
    if (analysis == 3) {summary(cars[,1])}
  })
  
  output$Boxplot <- renderPlot ({ 
    analysis <- analysisInput()
    if (analysis == 2) {
      boxplot(cars[,1]) 
      title(main = "1920s Cars - Boxplot", ylab = "Speed (mph)")}
  })
  
  output$Histogram <- renderPlot({
    analysis <- analysisInput()
    if (analysis == 1) {
    hist(cars[,1], breaks = 10, col = 'darkgray', border = 'white',
      main = "1920s Cars - Distribution",
      xlab = "Speed (mph)")
      }
  })

}

