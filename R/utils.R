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

parseTimeFromValue <- function(value){
  if(is.null(value)) return(NULL)
  posixlt_value <- unclass(as.POSIXlt(value))
  time_list <- lapply(posixlt_value[c('hour', 'min', 'sec')], function(x) {
    sprintf("%02d", trunc(x))
  })
  return(time_list)
}

getDefaultTime <- function(){
  return(as.POSIXlt("0:0:0", format = "%H:%M:%S"))
}