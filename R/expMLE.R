#' MLE routine for exponential distributions
#'
#' @param x the sample of random-variates of waiting times to use in the MLE routine
#'
#' @description {Wrapper to \code{fitdist} from \code{fitdistrplus} for exponential distribution distributions}
#' @return fitDistr object
#' @export expMLE
expMLE <- function(x)
{
  expFit <- fitdistrplus::fitdist(data = as.numeric(x), distr = "exp", method = "mle", discrete = FALSE)
  graphics::plot(expFit)
  return(expFit)
}
