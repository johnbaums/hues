#' Plot colour swatches for a vector of colours
#' 
#' Plot named colour swatches for a vector of colours.
#' 
#' @param x a vector of colours, specified as: colour names (i.e. colour names
#'   returned by [colors()]); numeric indices into [palette()], or hexadecimal
#'   strings in the form `"#RRGGBB"`, where `RR`, `GG`, and `BB` are pairs of
#'   hexadecimal digits representing red, green, and blue components, in the
#'   range `00` to `FF`.
#' @return `NULL`. The colour swatch is plotted to the active plotting device.
#' @seealso [iwanthue]
#' @importFrom graphics barplot par strwidth
#' @export
#' @examples 
#' swatch(colours()[1:10])
#' swatch(1:4)
#' swatch(iwanthue(5))
swatch <- function(x) {
  par(mai=c(0.2, max(strwidth(x, "inch") + 0.4, na.rm = TRUE), 0.2, 0.4))
  barplot(rep(1, length(x)), col=rev(x), space = 0.1, axes=FALSE, 
          names.arg=rev(x), cex.names=0.8, horiz=T, las=1)
  return(invisible(NULL))
}
