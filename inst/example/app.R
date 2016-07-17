#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyTime)


# Define UI for application
ui <- shinyUI(fluidPage(

   # Application title
   titlePanel("shinyTime Example App"),

   sidebarLayout(
      sidebarPanel(
        timeInput("time_input", "Enter time here")
      ),

      # Show a plot of the generated distribution
      mainPanel(
        textOutput("time_output")
      )
   )
))

# Define server logic
server <- shinyServer(function(input, output) {
  output$time_output <- renderText(input$time_input)
  observe(print(input$time_input))
})

# Run the application
shinyApp(ui = ui, server = server)

