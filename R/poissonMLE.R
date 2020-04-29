#' MLE routine for Poisson distributions
#'
#' @param x the sample of random-variates to use in the MLE routine
#'
#' @description {Wrapper to \code{fitdist} from \code{fitdistrplus} for Poisson distributions}
#' @return fitDistr object
#' @export poissonMLE
poissonMLE <- function(x)
{
  poisFit <- fitdistrplus::fitdist(data = as.numeric(x), distr = "pois", method = "mle", discrete = TRUE)
  graphics::plot(poisFit)
  return(poisFit)
}
