#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

source("Predict.R")




shinyServer(function(input, output) {


  output$gram3w <- renderText({
    hope <- as.character(Gram3procedure(as.character(input$text)))
  })

  output$gram2w <- renderText({
    hope <- as.character(Gram2procedure(as.character(input$text)))
  })
  
  output$gram1w <- renderText({
    hope <- as.character(Gram1procedure(as.character(input$text)))
  })

  output$gram_cumulative <- renderText({
    hope <- as.character(Gram_C_procedure(as.character(input$text)))
  })
})