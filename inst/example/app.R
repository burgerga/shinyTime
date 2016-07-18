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
        timeInput("time_input", "Enter time here", value = strptime("12:34:56", "%T")),
        actionButton("to_current_time", "Current time"),
        actionButton("change_label", "Change label")
      ),

      # Show a plot of the generated distribution
      mainPanel(
        textOutput("time_output")
      )
   )
))

# Define server logic
server <- shinyServer(function(input, output, session) {
  output$time_output <- renderText(strftime(input$time_input, "%T"))

  observeEvent(input$to_current_time, {
    updateTimeInput(session, "time_input", value = Sys.time())
  })
  observeEvent(input$change_label, {
    updateTimeInput(session, "time_input", label = "Label changed:")
  })
})

# Run the application
shinyApp(ui = ui, server = server)

