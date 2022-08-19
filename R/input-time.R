#' @keywords internal
"_PACKAGE"

#' Create a time input
#'
#' Creates a time widget that consists of separate numeric inputs for the hours, minutes, and
#' seconds. The input and output values of the time widget are instances of
#' \code{\link{DateTimeClasses}}, these can be converted to and from character strings with
#' \code{\link{strptime}} and \code{\link{strftime}}.
#' Additionally, the input can be specified as a character string in the `hh:mm:ss` format or an
#' \code{\link[hms]{hms}} class. For a simple example app see \code{\link{shinyTimeExample}}.
#'
#' @inheritParams shiny::textInput
#' @param value The desired time value. Must be a instance of \code{\link{DateTimeClasses}}.
#' @param seconds Show input for seconds. Defaults to TRUE.
#' @param minute.steps Round time to multiples of \code{minute.steps} (should be a whole number).
#' If not NULL sets \code{seconds} to \code{FALSE}.
#'
#' @returns Returns a \code{POSIXlt} object, which can be converted to
#' a \code{POSIXct} object with \code{as.POSIXct} for more efficient storage.
#'
#' @family shinyTime functions
#' @seealso \code{\link{strptime}}, \code{\link{strftime}}, \code{\link{DateTimeClasses}}
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
#'   # Set to custom time using hms
#'   timeInput("time4", "Time:", value = hms::as_hms("23:45:07")),
#'
#'   # Set to custom time using character string
#'   timeInput("time5", "Time:", value = "21:32:43"),
#'
#'   # Use hh:mm format
#'   timeInput("time6", "Time:", seconds = FALSE),
#'
#'   # Use multiples of 5 minutes
#'   timeInput("time7", "Time:", minute.steps = 5)
#' )
#'
#' shinyApp(ui, server = function(input, output) { })
#' }
#'
#' @importFrom htmltools tagList singleton tags
#' @export
timeInput <- function(inputId, label, value = NULL, seconds = TRUE, minute.steps = NULL) {
  if(is.null(value)) value <- getDefaultTime()
  if(is.character(value)) value <- strptime(value, format = "%T")
  if(!is.null(minute.steps)) {
    stopifnot(is.wholenumber(minute.steps))
    seconds = F
    value <- roundTime(value, minute.steps)
  }
  value_list <- dateToTimeList(value)
  style <- "width: 8ch"
  input.class <- "form-control"
  tagList(
    singleton(tags$head(
      tags$script(src = "shinyTime/input_binding_time.js")
    )),
    tags$div(id = inputId, class = "my-shiny-time-input form-group shiny input-container",
      shinyInputLabel(inputId, label, control = TRUE),
      tags$div(class = "input-group",
        tags$input(type="number", min="0", max="23", step="1", value = value_list$hour,
                   style = style, class = paste(c(input.class, 'shinytime-hours'), collapse = " ")),
        tags$input(type="number", min="0", max="59", step=minute.steps, value = value_list$min,
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
  value <- dateToTimeList(value)
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
