
# Inspired by https://github.com/rstudio/shiny/blob/master/R/input-daterange.R
#' @export
#' @importFrom htmltools tagList singleton tags
timeInput <- function(inputId, label) {
  tagList(
    singleton(tags$head(
      tags$script(src = "shinyTime/input_binding_time.js")
    )),
    tags$div(id = inputId, class = "my-shiny-time-input form-group shiny input-container",
      if(!is.null(label)) tags$label(class = "control-label", `for` = inputId, label) else NULL,
      tags$div(class = "input-group",
        tags$input(type="number", min="0", max="23", step="1", value = 0),
        tags$b("h"),
        tags$input(type="number", min="0", max="59", step="1", value = 0),
        tags$b("m"),
        tags$input(type="number", min="0", max="59", step="1", value = 0),
        tags$b("s")
      )
    )
  )
}


# Given a vector or list, drop all the NULL items in it
# Copied from shiny/R/utils.R
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE=logical(1))]
}

updateTimeInput <- function(session, inputId, label = NULL) {
  message <- dropNulls(list(label=label))
  session$sendInputMessage(inputId, message)
}
