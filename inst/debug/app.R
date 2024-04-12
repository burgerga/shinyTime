library(shiny)
library(bslib)
library(shinyTime)

start_time <- "23:34:56"

getTimeInput <- local({
  nTimeInputs <- 0
  timeInputs <- c()
  function(label = NULL, value = strptime(start_time, "%T"), ...) {
    nTimeInputs <<- nTimeInputs + 1
    if(is.null(label)) label <- paste("genTimeInput", nTimeInputs)
    id <- paste0("gen_time_input", nTimeInputs)
    timeInputs <<- c(timeInputs, id)
    timeInput(id, label, value, ...)
  }
})

getTimeInputs <- function(widths, ...) {
  purrr::map(widths, \(x) getTimeInput(width = paste0(x, "px"), ...))
}

widths <- seq(100,500,50)

cards <- list(
  card(
    full_screen = TRUE,
    card_header("Width"),
    layout_column_wrap(
      width = 1/3,
      card(
        card_header("5-minute steps"),
        !!!getTimeInputs(widths = widths, minute.steps = 5)
      ),
      card(
        card_header("24H"),
        !!!getTimeInputs(widths = widths)
      ),
      card(
        card_header("12H"),
        !!!getTimeInputs(widths = widths, use.civilian = TRUE)
      )
    )
  ),
  card(
    full_screen = TRUE,
    card_header("Alignment"),
    card(
        textInput("text_example", 'Example text input'),
        getTimeInput(label = "Enter time"),
        getTimeInput(label = "Enter time (5 minute steps)", minute.steps = 5),
        getTimeInput(label = "Enter time (civilian)", use.civilian = TRUE)
    )
  )
)

sb <- sidebar(
  timeInput("source_time", "Desired time",
            value = strptime("00:00:00", "%T")),

  actionButton("to_desired_time", "Apply desired time"),
  actionButton("to_current_time", "Set to current time")
)

ui <- page_navbar(
  title = "shinyTimeDebug",
  sidebar = sb,
  nav_spacer(),
  nav_panel("Width", cards[[1]]),
  nav_panel("Alignment", cards[[2]])
)

server <- function(input, output, session) {
  updateAllTimeInputs <- function(time, update_source = F) {
    timeInputIds <- get("timeInputs", envir = environment(getTimeInput))
    if(update_source) timeInputIds <- c("source_time",timeInputIds)
    purrr::map(timeInputIds, \(x) updateTimeInput(session, x, value = time))
  }

  observeEvent(input$to_current_time, updateAllTimeInputs(Sys.time(), update_source = T))
  observeEvent(input$to_desired_time, updateAllTimeInputs(input$source_time))

}

shinyApp(ui, server)