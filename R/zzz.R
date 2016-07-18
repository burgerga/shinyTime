#' Sets up the package when it's loaded
#'
#' Adds the content of www to shinyTime/, and registers an inputHandler to massage the output from
#' JavaScript into an R structure.
#'
#' @importFrom shiny addResourcePath registerInputHandler
#'
#' @noRd
#'
.onLoad <- function(libname, pkgname) {
  # Add directory for static resources
  addResourcePath('shinyTime', system.file('www', package='shinyTime', mustWork = TRUE))
  # Do some processing on the data we get from javascript before we pass it on to R
  registerInputHandler('my.shiny.timeInput', function(data, ...) {
    # Replace NULL by NA (will make it numeric automatically)
    data[sapply(data, is.null)] <- NA
    # Convert to vector
    unlist(data)
  })
}

#' Cleans up when package is unloaded
#'
#' Reverses the effects from .onLoad
#'
#' @importFrom shiny removeInputHandler
#'
#' @noRd
#'
.onUnload <- function(libpath) {
  removeInputHandler('my.shiny.timeInput')
}