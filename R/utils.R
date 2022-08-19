# Some utility functions

# Copied from shiny/R/input-utils.R
shinyInputLabel <- function(inputId, label = NULL, control = FALSE) {
  classes <- c(
    if (is.null(label)) "shiny-label-null",
    if (control) "control-label"
  )
  tags$label(
    label,
    `for` = inputId,
    class = if (!is.null(classes)) paste(classes, collapse = " ")
  )
}

# Given a vector or list, drop all the NULL items in it
# Copied from shiny/R/utils.R
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE=logical(1))]
}

dateToTimeList <- function(value){
  if(is.null(value)) return(NULL)
  posixlt_value <- unclass(as.POSIXlt(value))
  time_list <- lapply(posixlt_value[c('hour', 'min', 'sec')], function(x) {
    sprintf("%02d", trunc(x))
  })
  return(time_list)
}

timeListToDate <- function(value) {
  timeStringToDate(paste(c(value$hour, value$min, value$sec), collapse = ':'))
}

timeStringToDate <- function(string) {
  strptime(string, format = "%T")
}

getDefaultTime <- function(){
  timeStringToDate("00:00:00")
}

# From ?is.integer
is.wholenumber <- function(x, tol = .Machine$double.eps^0.5)  abs(x - round(x)) < tol

roundTime <- function(time, minutes) {
  stopifnot(any(class(time) %in% c("POSIXt", "hms")))
  stopifnot(is.wholenumber(minutes))
  if("hms" %in% class(time)) {
    # if hms reset to local time zone instead of UTC
    # works by getting the hour, minute, sec components out, and constructing a new POSIXlt object
    # a bit inefficient, but only happens once for each timeInput
    time <- timeListToDate(dateToTimeList(time))
  }
  time <- as.POSIXct(time)
  # Copied from plyr:::round_any.numeric
  round_any <- function(x, accuracy, f=round){f(x/accuracy) * accuracy}
  s <- round_any(unclass(time), 60 * minutes)
  # Inspired by lubridate::origin
  structure(s, class = c("POSIXct", "POSIXt"), tzone = attr(time, "tzone"))
}
