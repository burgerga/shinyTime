shinyTime
================

<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/burgerga/shinyTime.svg?branch=master)](https://travis-ci.org/burgerga/shinyTime)

This package provides a `timeInput` widget for Shiny. This widget allows intuitive time input in the `[hh]:[mm]:[ss]` (24H) format by using a separate numeric input for each part of the time. Setting and getting of the time in R is done with 'DateTimeClasses' objects.

Usage
=====

As the `shinyTime` package mimics the existing shiny functionality, using the package is easy. Some examples of adding an input widget to the UI:

    ui <- fluidPage(
      # Using the default time 00:00:00
      timeInput("time1", "Time:"),

      # Set to current time
      timeInput("time2", "Time:", value = Sys.time()),

      # Set to custom time using 
      timeInput("time3", "Time:", value = strptime("12:34:56", "%T"))
    )

Note that setting an inital value is done with a [`DateTime`](http://www.inside-r.org/r-doc/base/DateTimeClasses) class, in the same way as setting a date in `dateInput` can done with a `Date` class.

To retrieve the value, take note that the value will alse be in `DateTime` class. You need to convert it to character to be able to print the time, as the default character representation does not include the time. An example:

    server <- function(input, output) {
      # Print the time in [hh]:[mm]:[ss] everytime it changes
      observe(print(strftime(input$time1, "%T"))),
    }

For a fully functional example try the `shinyTimeExample()` function in the package.
