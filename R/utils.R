# Some utility functions (mostly copied from shiny/R/utils.R)

# Copied from shiny/R/utils.R
`%AND%` <- function(x, y) {
  if (!is.null(x) && !is.na(x))
    if (!is.null(y) && !is.na(y))
      return(y)
  return(NULL)
}

# Copied from shiny/R/input-utils.R
controlLabel <- function(controlName, label) {
  label %AND% tags$label(class = "control-label", `for` = controlName, label)
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
    strptime(paste(c(value$hour, value$min, value$sec), collapse = ':'), "%T")
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
  stopifnot(is.wholenumber(minutes))
  # Copied from plyr:::round_any.numeric
  round_any <- function(x, accuracy, f=round){f(x/accuracy) * accuracy}
  s <- round_any(unclass(as.POSIXct(time)), 60 * minutes)
  # Inspired by lubridate::origin
  structure(s, class = c("POSIXct", "POSIXt"), tzone = "UTC")
}
