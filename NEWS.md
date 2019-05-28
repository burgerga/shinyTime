# Change log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).  
Also [Keep a CHANGELOG](http://keepachangelog.com/).

## [Unreleased]

## [1.0.0] - 2019-05-28
### Added 
- Input time with minutes rounded to the nearest user-specified multiple

## [0.2.1] - 2016-10-07
### Added
- Updated style to match other shiny inputs
- Added input validation so that the time returned is always a valid 
time (invalid values are set to 0)

## [0.2.0] - 2016-07-20
### Added
- Support for input in the %H:%M format (without seconds)

### Fixed
- Fixed padding problem on keyboard input
- Keyboard input now properly causes change events

## 0.1.0 - 2016-07-18
### Added
 - Initial release
 
[Unreleased]: https://github.com/burgerga/shinyTime/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/burgerga/shinyTime/compare/v0.2.1...v1.0.0
[0.2.1]: https://github.com/burgerga/shinyTime/compare/v0.2.0...v0.2.1  
[0.2.0]: https://github.com/burgerga/shinyTime/compare/v0.1.0...v0.2.0
