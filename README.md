
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shinyTime <a href='https://burgerga.shinyapps.io/shinyTimeExample/' target="_blank"><img src='man/figures/timeInput.png' align="right" height="138.5" /></a>

[![](http://www.r-pkg.org/badges/version/shinyTime)](https://cran.r-project.org/package=shinyTime)
[![](http://cranlogs.r-pkg.org/badges/last-month/shinyTime)](https://cran.r-project.org/package=shinyTime)
[![Build
Status](https://travis-ci.org/burgerga/shinyTime.svg?branch=master)](https://travis-ci.org/burgerga/shinyTime)
[![Buy Me a Coffee at
ko-fi.com](https://img.shields.io/badge/Buy%20me%20a%20coffee-$3-FF5E5B.svg?logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+PHN2ZyAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIiAgIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyIgICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgICB2aWV3Qm94PSIwIDAgNjA3LjUyNTE1IDM4Ni44MTg2NiIgICBoZWlnaHQ9IjM4Ni44MTg2NiIgICB3aWR0aD0iNjA3LjUyNTE1IiAgIHhtbDpzcGFjZT0icHJlc2VydmUiICAgaWQ9InN2ZzQ1MzciICAgdmVyc2lvbj0iMS4xIj48bWV0YWRhdGEgICAgIGlkPSJtZXRhZGF0YTQ1NDMiPjxyZGY6UkRGPjxjYzpXb3JrICAgICAgICAgcmRmOmFib3V0PSIiPjxkYzpmb3JtYXQ+aW1hZ2Uvc3ZnK3htbDwvZGM6Zm9ybWF0PjxkYzp0eXBlICAgICAgICAgICByZGY6cmVzb3VyY2U9Imh0dHA6Ly9wdXJsLm9yZy9kYy9kY21pdHlwZS9TdGlsbEltYWdlIiAvPjxkYzp0aXRsZT48L2RjOnRpdGxlPjwvY2M6V29yaz48L3JkZjpSREY+PC9tZXRhZGF0YT48ZGVmcyAgICAgaWQ9ImRlZnM0NTQxIiAvPjxnICAgICB0cmFuc2Zvcm09Im1hdHJpeCgxLjMzMzMzMzMsMCwwLC0xLjMzMzMzMzMsLTEyNi43MzM3OCw1NzcuMzQ5MzIpIiAgICAgaWQ9Imc0NTQ1Ij48ZyAgICAgICBpZD0iZzQ1NjAiPjxwYXRoICAgICAgICAgaWQ9InBhdGg0NTUxIiAgICAgICAgIHN0eWxlPSJmaWxsOiNmZmZmZmY7ZmlsbC1vcGFjaXR5OjE7ZmlsbC1ydWxlOm5vbnplcm87c3Ryb2tlOm5vbmU7c3Ryb2tlLXdpZHRoOjAuMSIgICAgICAgICBkPSJtIDU0OC40MjcsMzQ1Ljg2NyBjIC02LjMxOSwzMy4zNzQgLTI0LjI4NCw1NC4xNjQgLTQyLjY5Nyw2Ny4wMTkgLTE5LjA0MSwxMy4yOTUgLTQxLjg0OCwyMC4xMjYgLTY1LjA3MiwyMC4xMjYgSCAxMTEuMDczIGMgLTExLjQ2NTYsMCAtMTUuODU3NCwtMTEuMTk0IC0xNS45MDA3LC0xNi44MDEgLTAuMDA1OSwtMC43MzEgMC4wMjA3LC0zLjY1NyAwLjAyMDcsLTMuNjU3IDAsMCAtMC41NDA3LC0xNDUuODEzIDAuNDgzMiwtMjIzLjY5MyAzLjExMDUsLTQ1Ljk3OCA0OS4xNzY4LC00NS45NjMgNDkuMTc2OCwtNDUuOTYzIDAsMCAxNTAuNDA0LDAuNDQxIDIyMi41MzUsMC44ODkgMy4zODMsMC4wMjIgNi43NjEsMC4zODYgMTAuMDQ0LDEuMjA3IDQxLjA2OCwxMC4yNzUgNDUuMzE3LDQ4LjQyOCA0NC44NzgsNjkuNjk2IDgyLjU0OCwtNC41ODYgMTQwLjc5Miw1My42NjQgMTI2LjExNywxMzEuMTc3IG0gLTkyLjczMSwtNzUuNjc1IGMgLTE3LjYwNSwtMi4yIC0zMS45MDgsLTAuNTQ4IC0zMS45MDgsLTAuNTQ4IHYgMTA3Ljc5NSBoIDIxLjY2MiBjIDE0LjMxNywwIDI4LjEyNywtNS45NjEgMzcuNDY5LC0xNi44MSA2LjU3NiwtNy42MzggMTEuODM3LC0xOC4zODggMTEuODM3LC0zMy4yMzcgMCwtMzYuMjk5IC0xOC43MDQsLTUwLjYgLTM5LjA2LC01Ny4yIiAvPjxwYXRoICAgICAgICAgaWQ9InBhdGg0NTUzIiAgICAgICAgIHN0eWxlPSJmaWxsOiNmMTQyNTU7ZmlsbC1vcGFjaXR5OjE7ZmlsbC1ydWxlOm5vbnplcm87c3Ryb2tlOm5vbmU7c3Ryb2tlLXdpZHRoOjAuMSIgICAgICAgICBkPSJtIDI1Ni42MTQsMjAzLjM2NyBjIDMuNTg1LC0xLjgwNSA1Ljg3NSwwLjQzOCA1Ljg3NSwwLjQzOCAwLDAgNTIuNDU3LDQ3Ljg3OCA3Ni4wODksNzUuNDUxIDIxLjAyLDI0LjY2NiAyMi4zOSw2Ni4yMzQgLTEzLjcwNyw4MS43NjYgLTM2LjA5NywxNS41MzEgLTY1Ljc5NSwtMTguMjcyIC02NS43OTUsLTE4LjI3MiAtMjUuNzU1LDI4LjMyNiAtNjQuNzM0LDI2Ljg5MiAtODIuNzYzLDcuNzIyIC0xOC4wMjgsLTE5LjE3IC0xMS43MzIsLTUyLjA3MyAxLjcxNywtNzAuMzg0IDEyLjYyNSwtMTcuMTkgNjguMTE4LC02Ni42NSA3Ni41MjksLTc1LjAxNSAwLDAgMC42MTMsLTAuNjQgMi4wNTUsLTEuNzA2IiAvPjwvZz48L2c+PC9zdmc+)](https://ko-fi.com/L4L6LMTN)

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
