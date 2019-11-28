#' Generate a colour palette by k-means clustering of CIE Lab colour space.
#' 
#' Generate a palette of distinct colours through k-means clustering of CIE Lab 
#' colour space.
#' 
#' @param n Numeric. The number of colours to generate.
#' @param hmin Numeric, in the range [0, 360]. The lower limit of the hue range 
#'   to be clustered.
#' @param hmax Numeric, in the range [0, 360]. The upper limit of the hue range 
#'   to be clustered.
#' @param cmin Numeric, in the range [0, 180]. The lower limit of the chroma 
#'   range to be clustered.
#' @param cmax Numeric, in the range [0, 180]. The upper limit of the chroma 
#'   range to be clustered.
#' @param lmin Numeric, in the range [0, 100]. The lower limit of the luminance 
#'   range to be clustered.
#' @param lmax Numeric, in the range [0, 100]. The upper limit of the luminance 
#'   range to be clustered.
#' @param plot Logical. Should the colour swatches be plotted (using 
#'   \code{\link{swatch}})?
#' @param random Logical. If \code{TRUE}, clustering will be determined by the 
#'   existing RNG state. If \code{FALSE}, the seed will be set to \code{1} for 
#'   clustering, and on exit, the function will restore the pre-existing RNG 
#'   state.
#' @return A vector of \code{n} colours (as hexadecimal strings), representing 
#'   centers of clusters determined through k-means clustering of the CIE Lab 
#'   colour space delimited by \code{hmin}, \code{hmax}, \code{cmin}, 
#'   \code{cmax}, \code{lmin} and \code{lmax}.
#' @details Note that \code{iwanthue} currently doesn't support \code{hmin} 
#'   greater than \code{hmax} (which should be allowed, since hue is circular).
#' @references 
#' \itemize{
#'   \item Examples follow those presented at \href{http://tools.medialab.sciences-po.fr/iwanthue/}{iwanthue - colors for data scientists}
#'   \item \href{https://github.com/medialab/iwanthue}{iwanthue on
#'   GitHub}   
#' }
#' @seealso \code{\link{swatch}}
#' @export
#' @importFrom colorspace LAB hex coords
#' @importFrom stats kmeans
#' @importFrom methods as
#' @examples 
#' iwanthue(5)
#' iwanthue(5, plot=TRUE)
#' iwanthue(5, 0, 240, 0, 24, 0, 100, plot=TRUE)    # shades
#' iwanthue(5, 0, 360, 0, 54, 67, 100, plot=TRUE)   # pastel
#' iwanthue(5, 0, 360, 54, 180, 27, 67, plot=TRUE)  # pimp
#' iwanthue(5, 0, 360, 36, 180, 13, 73, plot=TRUE)  # intense
#' iwanthue(3, 0, 300, 60, 180, 73, 100, plot=TRUE) # fluoro
#' iwanthue(3, 220, 260, 12, 150, 0, 53, plot=TRUE) # blue ocean
iwanthue <- function(n, hmin=0, hmax=360, cmin=0, cmax=180, lmin=0, lmax=100, 
                     plot=FALSE, random=FALSE) {
  stopifnot(hmin >= 0, cmin >= 0, lmin >= 0, 
            hmax <= 360, cmax <= 180, lmax <= 100, 
            hmin <= hmax, cmin <= cmax, lmin <= lmax,
            n > 0)
  if(!random) {
    if (exists(".Random.seed", .GlobalEnv)) {
      old_seed <- .GlobalEnv$.Random.seed
      on.exit(.GlobalEnv$.Random.seed <- old_seed)
    } else {
      on.exit(rm(".Random.seed", envir = .GlobalEnv))
    }
    set.seed(1)
  }
  lab <- colorspace::LAB(as.matrix(
    expand.grid(seq(0, 100, 1), seq(-100, 100, 5), seq(-110, 100, 5))))
  if (any((hmin != 0 || cmin != 0 || lmin != 0 ||
           hmax != 360 || cmax != 180 || lmax != 100))) {
    hcl <- as(lab, 'polarLUV')
    hcl_coords <- colorspace::coords(hcl)
    hcl <- hcl[which(hcl_coords[, 'H'] <= hmax & hcl_coords[, 'H'] >= hmin &
                       hcl_coords[, 'C'] <= cmax & hcl_coords[, 'C'] >= cmin & 
                       hcl_coords[, 'L'] <= lmax & hcl_coords[, 'L'] >= lmin), ]
    lab <- as(hcl, 'LAB')    
  }
  lab <- lab[which(!is.na(colorspace::hex(lab))), ]
  clus <- stats::kmeans(colorspace::coords(lab), n, iter.max=50)
  if (isTRUE(plot)) {
    swatch(colorspace::hex(colorspace::LAB(clus$centers)))
  }
  unname(colorspace::hex(colorspace::LAB(clus$centers)))
}
