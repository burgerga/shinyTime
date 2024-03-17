# Some utility functions

# Copied from shiny/R/input-utils.R
#' @param inputId The input ID
#' @param label The label text
#' @param control Whether the label is for a control (e.g. a checkbox)
#' @return A label tag
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
#' @param x A vector or list
#' @return A vector or list with all the NULL items removed
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE=logical(1))]
}

#' Convert a time object to a list
#' @param value A time object
#' @return A list with the hour, minute and second components
dateToTimeList <- function(value){
  if(is.null(value)) return(NULL)
  posixlt_value <- unclass(as.POSIXlt(value))
  time_list <- lapply(posixlt_value[c('hour', 'min', 'sec')], function(x) {
    sprintf("%02d", trunc(x))
  })
  time_list[["civilian"]] <- ifelse(posixlt_value$hour < 12, "AM", "PM")
  return(time_list)
}

#' Convert a list to a time object
#' @param value A list with the hour, minute and second components
#' @return A time object
timeListToDate <- function(value) {
  timeStringToDate(paste(c(value$hour, value$min, value$sec), collapse = ':'))
}

#' Convert a string to a time object
#' @param string A string with the time in the format "HH:MM:SS"
#' @return A time object
timeStringToDate <- function(string) {
  strptime(string, format = "%T")
}

#' Get the default time
#' @return A time object with the value "00:00:00"
getDefaultTime <- function(){
  timeStringToDate("00:00:00")
}

#' Round a time object to the nearest minute
#' From ?is.integer
#' @param x A time object
#' @param tol The tolerance for rounding
#' @return A time object rounded to the nearest minute
is.wholenumber <- function(x, tol = .Machine$double.eps^0.5){
  abs(x - round(x)) < tol
}

#' Round a time object to the nearest minute
#' @param time A time object
#' @param minutes The number of minutes to round to
#' @return A time object rounded to the nearest minute
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
