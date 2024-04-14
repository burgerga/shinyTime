#
# This is a Shiny web application.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyTime)

start_time <- "23:34:56"

ui <- fluidPage(

   titlePanel("shinyTime Example App"),

   sidebarLayout(

      sidebarPanel(
        width = 4,
        timeInput(
          "time_input1", "Enter time",
          value = strptime(start_time, "%T")
        ),
        timeInput(
          "time_input2", "Enter time (5 minute steps)",
          value = strptime(start_time, "%T"),
          minute.steps = 5,
          width = "100px"
        ),
        timeInput(
          "time_input3", "Enter time",
          value = strptime(start_time, "%T"),
          use.civilian = TRUE,
          width = "300px"
        ),
        actionButton("to_current_time", "Current time")
      ),

      mainPanel(
        width = 8,
        textOutput("time_output1"),
        textOutput("time_output2"),
        textOutput("time_output3")
      )
   )
)

server <- function(input, output, session) {
  output$time_output1 <- renderText(strftime(input$time_input1, "%T"))
  output$time_output2 <- renderText(strftime(input$time_input2, "%R"))
  output$time_output3 <- renderText(strftime(input$time_input3, "%r"))

  observeEvent(input$to_current_time, {
    updateTimeInput(session, "time_input1", value = Sys.time())
    updateTimeInput(session, "time_input2", value = Sys.time())
    updateTimeInput(session, "time_input3", value = Sys.time())
  })

}

shinyApp(ui, server)

