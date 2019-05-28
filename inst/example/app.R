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
        timeInput("time_input1", "Enter time", value = strptime("12:34:56", "%T")),
        timeInput("time_input2", "Enter time (5 minute steps)", value = strptime("12:34:56", "%T"), minute.steps = 5),
        actionButton("to_current_time", "Current time")
      ),

      mainPanel(
        textOutput("time_output1"),
        textOutput("time_output2")
      )
   )
)

server <- function(input, output, session) {
  output$time_output1 <- renderText(strftime(input$time_input1, "%T"))
  output$time_output2 <- renderText(strftime(input$time_input2, "%R"))

  observeEvent(input$to_current_time, {
    updateTimeInput(session, "time_input1", value = Sys.time())
    updateTimeInput(session, "time_input2", value = Sys.time())
  })

}

shinyApp(ui, server)

