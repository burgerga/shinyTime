## Test environments
* travis-ci, Ubuntu 14.04, R 3.6
* local machine, Ubuntu 18.04, R 3.6
* local machine, Windows 10, R 3.6 
* win-builder (devel and release)

## R CMD check results
There were no ERRORs, NOTEs or WARNINGs. 

However, for win-builder release I get: 
```
Error in library.dynam(lib, package, package.lib) : 
  DLL 'Rcpp' not found: maybe not installed for this architecture?"
```

but on my local Windows 10, and win-builder devel everything is fine, 
so I think this might be an issue with the build system. 
(I don't use Rccp at all). 

## Downstream dependencies
There are currently no downstream dependencies for this package