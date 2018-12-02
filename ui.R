#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)
library(caret)
library(shinythemes)
library(shinyBS) 


shinyUI(
  
  navbarPage(
    
    "Keyboard typing prediction algorithm",
    
    theme = shinytheme("flatly"),
    
    tabPanel(
      
      "Next word prediction",
      
      
      pageWithSidebar(
        
        headerPanel("Next word prediction"),
        
        sidebarPanel(
          
          textInput("text", label = h3("Text input"), 
                    value = ""),
          
          submitButton("Predict"),
          br(),
          h6(em("Notes:")),
          h6(em("Please type only text words.")),
          h6(em("Do not insert numbers or special symbols."))
          #br(),
          #h6(em("Status:")),
          #h6(em("Do not insert numbers or special symbols."))
          
          
          
        ),
        mainPanel(
          h4("Next word prediction based on 3-Gram vocabuary"),
          verbatimTextOutput("gram3w"),       
          h6(em("This search based on  3-Gram vocaburary and 2 latest typed words.")),
          h4("Next word prediction based on 2-Gram vocabuary"),
          verbatimTextOutput("gram2w"),       
          h6(em("This search based on  2-Gram vocaburary and only 1 latest typed word.")),
          h4("Next word prediction based on 1-Gram vocabuary"),
          verbatimTextOutput("gram1w"),
          h6(em("If nothing is found in previous searching, 1-gram vocaburary will be used.")),
          h4("Next word prediction based on cumulative search"),
          verbatimTextOutput("gram_cumulative"),
          h6(em("If the words has been founded in each step, the word most common at the intersection ")),
          h6(em("of all the words found, or, if there are no intersections, the most common use ")),
          h6(em("based on occurrence rates of each founded word."))
        ))
    ),
    
    
    tabPanel(
      
      "Model",

      h3("Model description"),
      br(),
      p("1) Twitter, blogs, and news data were processed by a natural language algorithm used to create a list of 1,2,3-word sets based on occurrence rates. "),
      br(),
      p("2) These data were sequentially numbered, filtered by the list of forbidden words, cleared of numeric and punctuation characters.  "),
      br(),
      p("3) In order to reduce memory usage and speed up the prediction of the next word in the 2-gram and 3-gram assemblies, "),
      p("the words and combinations were replaced with the numbers of the previous assemblies. "),
      p("This reduced the amount of memory occupied by all assemblies from 35 Mb of text content to 26 Mb, i.e. 25% less."),
      br(),
      p("4) The algorithm predicts the next word based on the last 2 words entered by the user. "),
      p("The search starts with a 3-Gram build. Then select a word from the 2-Gram Assembly, then 1-Gram. "),
      p("If nothing is found, it returns to the 'default words' that were most commonly used. "),
      p("If the words are found in each variant, the word most common at the intersection of all the words found, or, "),
      p("if there are no intersections, the most common use based on occurrence rates of each founded word.")
      
      
    ),
    
    tabPanel(
      
      "About",
      
      h3("Coursera Data Science Specialization"),
      
      h3("Johns Hopkins University"),

      br(),
      h4("Andrey ABRAMOV"),
      br(),
      h3("Data Science Capstone Final Project - Keyboard typing prediction algorithm"),
      br(),      
      
      h4("Short Summary"),
      p("The Keyboard typing prediction algorithm was developed as part of the Coursera Data Science Capstone project."),
      p("The purpose of this project is a model for predicting the user's next word when entering it from the keyboard."), 
      p("The algorithm is implemented with Shiny application using NLP and Text Mining algorithms."),
      p("The developed application based on the proposed algorithm shows all the features and full functionality."),
      br(),
      p("The algorithm is based on processed and cleaned data from Twitter, blogs and news data. "),
      p("The research analysis is carried out and the dictionary containing frequency terms is created. "),
      p("The dataset used for analysis is available on the course data page."),
      br(),
      p("27th of November 2018")
      
      
    )
  )
)
