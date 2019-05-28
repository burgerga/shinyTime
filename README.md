
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shinyTime <a href='https://burgerga.shinyapps.io/shinyTimeExample/' target="_blank"><img src='man/figures/timeInput.png' align="right" height="138.5" /></a>

![](http://www.r-pkg.org/badges/version/shinyTime)
![](http://cranlogs.r-pkg.org/badges/grand-total/shinyTime) [![Build
Status](https://travis-ci.org/burgerga/shinyTime.svg?branch=master)](https://travis-ci.org/burgerga/shinyTime)

## Overview

shinyTime provides a `timeInput` widget for Shiny. This widget allows
intuitive time input in the `[hh]:[mm]:[ss]` or `[hh]:[mm]` (24H) format
by using a separate numeric input for each time component. Setting and
getting of the time in R is done with date-time objects.

## Installation

``` r
# Install from CRAN
install.packages("shinyTime")
```

## Usage

As the `shinyTime` package mimics the existing shiny functionality,
using the package is easy:

``` r
ui <- fluidPage(
  # Using the default time 00:00:00
  timeInput("time1", "Time:"),

  # Set to current time
  timeInput("time2", "Time:", value = Sys.time()),

  # Set to custom time 
  timeInput("time3", "Time:", value = strptime("12:34:56", "%T")),
  
  # Use %H:%M format
  timeInput("time4", "Time:", seconds = FALSE)
  
  # Use multiples of 5 minutes
  timeInput("time5", "Time:", minute.steps = 5)
)
```

Note that setting an initial value is done with a [date-time
object](https://www.rdocumentation.org/packages/base/topics/DateTimeClasses),
in the same way as setting a date in `dateInput` can be done with a
`Date` object.

The value retrieved will also be a date-time object. You need to convert
it to character to be able to show the time, as the default character
representation does not include time. For example:

``` r
server <- function(input, output) {
  # Print the time in [hh]:[mm]:[ss] everytime it changes
  observe(print(strftime(input$time1, "%T")))
  
  # Print the time in [hh]:[mm] everytime it changes
  observe(print(strftime(input$time4, "%R")))
}
```

For a demo, visit the [online example
app](https://burgerga.shinyapps.io/shinyTimeExample/) or try the
`shinyTime::shinyTimeExample()` function.

## Donate

If this package is helpful to you please consider getting me a coffee to
keep the work going
;)

<a href='https://ko-fi.com/L4L6LMTN' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi3.png?v=2' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
