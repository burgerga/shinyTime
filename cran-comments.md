## Test environments
* github actions
* local machine, Manjaro Linux, R 4.2.1
* devtools::check_rhub()
* devtools::check_win_devel()

## R CMD check results
There were no ERRORs, or WARNINGs.
There were 2 NOTEs:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Gerhard Burger <burger.ga@gmail.com>'

Found the following (possibly) invalid URLs:
  URL: https://burgerga.github.io/shinyTime/
    From: DESCRIPTION
          man/shinyTime-package.Rd
    Status: 404
    Message: Not Found
    
  Reason: I switched from manual pkgdown to github actions and have not yet 
  pushed a stable version to github, will do so upon CRAN acceptance 
  (https://burgerga.github.io/shinyTime/dev/ is working)
  
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
  
  (Windows rhub only) Reason: Likely caused by https://github.com/r-hub/rhub/issues/503
  
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found

  (Fedora rhub only) Reason: another rhub issue?

## Downstream dependencies
Checked with revdepcheck, no problems.