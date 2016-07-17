# Take the value from javascript and do stuff with it (for example converting it to Date object)
.onLoad <- function(libname, pkgname) {
  # Add directory for static resources
  addResourcePath('shinyTime', system.file('www', package='shinyTime', mustWork = TRUE))
  shiny::registerInputHandler('my.shiny.timeInput', function(data, ...) {
    # Replace NULL by NA (will make it numeric automatically)
    data[sapply(data, is.null)] <- NA
    # Convert to vector
    unlist(data)
  })
}

.onUnload <- function(libpath) {
  shiny::removeInputHandler('my.shiny.timeInput')
}