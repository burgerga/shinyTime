# Some utility functions (mostly copied from shiny/R/utils.R)

# Copied from shiny/R/utils.R
`%AND%` <- function(x, y) {
  if (!is.null(x) && !is.na(x))
    if (!is.null(y) && !is.na(y))
      return(y)
  return(NULL)
}

# Given a vector or list, drop all the NULL items in it
# Copied from shiny/R/utils.R
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE=logical(1))]
}

# Copied from shiny/R/input-utils.R
controlLabel <- function(controlName, label) {
  label %AND% tags$label(class = "control-label", `for` = controlName, label)
}