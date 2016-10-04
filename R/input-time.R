#' shinyTime: A Time Input Widget for Shiny
#'
#' Provides a time input widget for Shiny. This widget allows intuitive time input in the
#' \code{[hh]:[mm]:[ss]} or \code{[hh]:[mm]} (24H) format by using a separate numeric input for each
#' time component. The interface with R uses \code{\link{DateTimeClasses}} objects.
#'
#' @docType package
#' @name shinyTime
NULL

#' Create a time input
#'
#' Creates a time widget that consists of separate numeric inputs for the hours, minutes, and
#' seconds. The input and output values of the time widget are instances of
#' \code{\link{DateTimeClasses}}, these can be converted to and from character strings with
#' \code{\link{strptime}} and \code{\link{strftime}}. For a simple example app see
#' \code{\link{shinyTimeExample}}.
#'
#' @inheritParams shiny::textInput
#' @param value The desired time value. Must be a instance of \code{\link{DateTimeClasses}}.
#' @param seconds Show input for seconds. Defaults to FALSE
#'
#' @family shinyTime functions
#' @seealso \code{\link{strptime}}, \code{\link{strftime}}
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'   # Default value is 00:00:00
#'   timeInput("time1", "Time:"),
#'
#'   # Set to current time
#'   timeInput("time2", "Time:", value = Sys.time()),
#'
#'   # Set to custom time
#'   timeInput("time3", "Time:", value = strptime("12:34:56", "%T")),
#'
#'   # Use %H:%M format
#'   timeInput("time4", "Time:", seconds = FALSE)
#' )
#'
#' shinyApp(ui, server = function(input, output) { })
#' }
#'
#' @importFrom htmltools tagList singleton tags
#' @export
timeInput <- function(inputId, label, value = NULL, seconds = TRUE) {
  if(is.null(value)) value <- getDefaultTime()
  value_list <- parseTimeFromValue(value)
  style <- "width: 8ch"
  input.class <- "form-control"
  tagList(
    singleton(tags$head(
      tags$script(src = "shinyTime/input_binding_time.js")
    )),
    tags$div(id = inputId, class = "my-shiny-time-input form-group shiny input-container",
      controlLabel(inputId, label),
      tags$div(class = "input-group",
        tags$input(type="number", min="0", max="23", step="1", value = value_list$hour,
                   style = style, class = paste(c(input.class, 'shinytime-hours'), collapse = " ")),
        tags$input(type="number", min="0", max="59", step="1", value = value_list$min,
                   style = style, class = paste(c(input.class, 'shinytime-mins'), collapse = " ")),
        if(seconds) tags$input(type="number", min="0", max="59", step="1", value = value_list$sec,
                   style = style, class = paste(c(input.class, 'shinytime-secs'), collapse =  " ")) else NULL
      )
    )
  )
}

#' Change a time input on the client
#'
#' Change the label and/or value of a time input
#'
#' @inheritParams shiny::updateTextInput
#' @param value The desired time value. Must be a instance of \code{\link{DateTimeClasses}}.
#'
#' @family shinyTime functions
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- fluidPage(
#'   timeInput("time", "Time:"),
#'   actionButton("to_current_time", "Current time")
#' )
#'
#' server <- function(input, output, session) {
#'   observeEvent(input$to_current_time, {
#'     updateTimeInput(session, "time", value = Sys.time())
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#'
#' @export
updateTimeInput <- function(session, inputId, label = NULL, value = NULL) {
  value <- parseTimeFromValue(value)
  message <- dropNulls(list(label=label, value = value))
  session$sendInputMessage(inputId, message)
}

#' Show the shinyTime example app
#'
#' Run a simple shiny app demonstrating the shinyTime functionality.
#'
#' @family shinyTime functions
#' @importFrom shiny runApp
#' @export
shinyTimeExample <- function() {
  runApp(system.file('example', package='shinyTime', mustWork=T), display.mode='showcase')
}
