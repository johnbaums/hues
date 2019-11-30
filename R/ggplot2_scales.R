#' iwanthue scales to use with ggplot2
#' 
#' These functions allow you to use [iwanthue()] generated palettes with
#' `ggplot2` plots. You need `ggplot2` installed for these to work. Note these
#' only work with discrete scales.
#'
#' @param ... Arguments to pass on to [ggplot2::discrete_scale()].
#' @param aesthetics Character string or vector of character strings listing the
#'   name(s) of the aesthetic(s) that this scale works with. This can be useful,
#'   for example, to apply colour settings to the colour and fill aesthetics at
#'   the same time, via `aesthetics = c("colour", "fill")`.
#' @inheritParams iwanthue
#'
#' @return A `ScaleDiscrete` object that can be added to a `ggplot` object.
#' 
#' @name hues-ggplot2-scales
#' @rdname hues-ggplot2-scales
#' 
#' @author Russell Dinnage <r.dinnage@@gmail.com>
#' @export
#'
#' @examples
#' 
#' if (require('ggplot2')) {
#' 
#'    ggplot(iris, aes(x=Petal.Width, y=Petal.Length)) +
#'      geom_point(aes(color=Species), size=10) + 
#'      scale_colour_iwanthue()
#'     
#'    ggplot(iris, aes(x=Petal.Width, y=Petal.Length)) +
#'      geom_point(aes(color=Species), size=10) + 
#'      scale_colour_iwanthue(hmax = 90)
#'      
#' }
scale_colour_iwanthue <- function(..., hmin=0, hmax=360, cmin=0, cmax=180, 
                                  lmin=0, lmax=100, random=FALSE,
                                  aesthetics = "colour") {
  
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }
  
  ggplot2::discrete_scale(aesthetics,
                          "iwanthue",
                          iwanthue_discrete(hmin, hmax, cmin, cmax, lmin, lmax, 
                                            random),
                          ...)
}

#' @rdname hues-ggplot2-scales
#' @export
#' 
scale_color_iwanthue <- scale_colour_iwanthue

#' @rdname hues-ggplot2-scales
#' @export
#' 
scale_fill_iwanthue <- function(..., hmin=0, hmax=360, cmin=0, cmax=180, lmin=0, 
                                lmax=100, random=FALSE, aesthetics = "fill") {
  
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop('ggplot2 is required for this functionality', call. = FALSE)
  }
  
  ggplot2::discrete_scale(aesthetics,
                          "iwanthue",
                          iwanthue_discrete(hmin, hmax, cmin, cmax, lmin, lmax, 
                                            random),
                          ...)
}

iwanthue_discrete <- function(hmin, hmax, cmin, cmax, lmin, lmax, random) {
  function(n) {
    hues::iwanthue(n, hmin = hmin, hmax = hmax, cmin = cmin, cmax = cmax, 
                   lmin = lmin, lmax = lmax, plot = FALSE, random = random)
  }
}
