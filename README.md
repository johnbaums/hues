<!-- README.md is generated from README.Rmd. Please edit that file -->
hues
====

[![Travis-CI Build Status](https://travis-ci.org/johnbaums/hues.svg?branch=master)](https://travis-ci.org/johnbaums/hues)

This package generates and plot palettes of optimally distinct colours in perceptually uniform colour space, based on [iwanthue](http://tools.medialab.sciences-po.fr/iwanthue/). This is done through k-means clustering of CIE Lab colour space, according to user-selected constraints on hue, chroma, and lightness.

### Installation

The development version of `hues` can be installed using `install_github` from the [`devtools`](https://cran.r-project.org/web/packages/devtools/index.html) package:

``` r
# install.packages('devtools') # uncomment if devtools isn't already installed
devtools::install_github('johnbaums/hues')
```

### Examples

The examples below show palettes corresponding to some presets given at the [iwanthue](http://tools.medialab.sciences-po.fr/iwanthue) website.

``` r
library(hues)
iwanthue(5, plot=TRUE)
```

![](README_files/ex-1.png)

``` r
iwanthue(5, 0, 240, 0, 24, 0, 100, plot=TRUE)    # shades
```

![](README_files/ex-2.png)

``` r
iwanthue(5, 0, 360, 0, 54, 67, 100, plot=TRUE)   # pastel
```

![](README_files/ex-3.png)

``` r
iwanthue(5, 0, 360, 54, 180, 27, 67, plot=TRUE)  # pimp
```

![](README_files/ex-4.png)

``` r
iwanthue(5, 0, 360, 36, 180, 13, 73, plot=TRUE)  # intense
```

![](README_files/ex-5.png)

``` r
iwanthue(3, 0, 300, 60, 180, 73, 100, plot=TRUE) # fluoro
```

![](README_files/ex-6.png)

``` r
iwanthue(3, 220, 260, 12, 150, 0, 53, plot=TRUE) # blue ocean
```

![](README_files/ex-7.png)
