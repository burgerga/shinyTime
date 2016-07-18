#' shinyTime: A timeInput widget for Shiny
#'
#' Provides a widget for inputting time in the h:m:s format.
#'
#' @docType package
#' @name shinyTime
NULL

# Inspired by https://github.com/rstudio/shiny/blob/master/R/input-daterange.R
#' @export
#' @importFrom htmltools tagList singleton tags
timeInput <- function(inputId, label, value = NULL) {
  if(is.null(value)) value <- getDefaultTime()
  value_list <- parseTimeFromValue(value)
  style <- "width: 5ch"
  oninput <- "if(this.value < 10) this.value = '0' + this.value"
  tagList(
    singleton(tags$head(
      tags$script(src = "shinyTime/input_binding_time.js")
    )),
    tags$div(id = inputId, class = "my-shiny-time-input form-group shiny input-container",
      controlLabel(inputId, label),
      tags$div(class = "input-group",
        tags$input(type="number", min="0", max="23", step="1", value = value_list$hour,
                   style = style, oninput = oninput),
        tags$b(":"),
        tags$input(type="number", min="0", max="59", step="1", value = value_list$min,
                   style = style, oninput = oninput),
        tags$b(":"),
        tags$input(type="number", min="0", max="59", step="1", value = value_list$sec,
                   style = style, oninput = oninput)
      )
    )
  )
}

#' @export
updateTimeInput <- function(session, inputId, label = NULL, value = NULL) {
  value <- parseTimeFromValue(value)
  message <- dropNulls(list(label=label, value = value))
  session$sendInputMessage(inputId, message)
}

#' Run a simple example app using the shinyTime functionality
#'
#' This functions runs a very simple app demonstrating the shinyTime functionality.
#'
#' @family shinyTime
#' @importFrom shiny runApp
#' @export
shinyTimeExample <- function() {
  runApp(system.file('example', package='shinyTime', mustWork=T), display.mode='showcase')
}
