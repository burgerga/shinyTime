#
# This is a Shiny web application.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyTime)

ui <- fluidPage(

   titlePanel("shinyTime Example App"),

   sidebarLayout(
      sidebarPanel(
        timeInput("time_input", "Enter time", value = strptime("12:34:56", "%T")),
        actionButton("to_current_time", "Current time")
      ),

      mainPanel(
        textOutput("time_output")
      )
   )
)

server <- function(input, output, session) {
  output$time_output <- renderText(strftime(input$time_input, "%T"))

  observeEvent(input$to_current_time, {
    updateTimeInput(session, "time_input", value = Sys.time())
  })
}

shinyApp(ui, server)

