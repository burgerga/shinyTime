# shinyTime 1.0.2

## Minor changes

- Add information on `timeInput` return type (#14)

## Bug fixes

- Replaced outdated shiny utils label functions (#16)

- Added correct timezone handling to `roundTime` function (#11)

# shinyTime 1.0.1

## Bug fixes

- Removed use of ES6 that caused `shinyTime` to fail on older browsers (#8)

# shinyTime 1.0.0

## Major changes 

- Input time with minutes rounded to the nearest user-specified multiple

# shinyTime 0.2.1

## Minor changes

- Updated style to match other shiny inputs

- Added input validation so that the time returned is always a valid 
time (invalid values are set to 0)

# shinyTime 0.2.0

## Minor changes

- Added support for input in the %H:%M format (without seconds)

## Bug fixes

- Fixed padding problem on keyboard input

- Keyboard input now properly causes change events

# shinyTime 0.1.0

- Initial release
