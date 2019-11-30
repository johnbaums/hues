Please note this is an update to https://cran.r-project.org/package=hues, with 
incremented version number.


## Test environments
* local macOS install, R 3.6.0
* ubuntu 16.04 (on travis-ci), R 3.6.1
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were 2 NOTEs on win-builder devel:

1. Package suggested but not available for checking: 'ggplot2'
2. Package unavailable to check Rd xrefs: 'ggplot2'

`ggplot2` is not required for basic functionality of the `hues` package, but 
must be installed if users want to use the new `scale_colour_iwanthue` and
`scale_fill_iwanthue` functions. These functions test for `ggplot2` availability
and fail gracefully (with a message prompting user that `ggplot2` should be 
installed). The function docs also clearly state that those functions require 
`ggplot2`. While I could add `ggplot2` as an Import, I'd prefer to keep the 
dependencies lean for those users who don't intend to use these new functions.

There were no NOTEs on other test environments.


## Downstream dependencies
There are currently no downstream dependencies for this package.
