#' Compute various stats on ENSO data
#'
#' @param stats named list of statistical functions like \code{mean}, \code{median}, \code{var}, etc
#'
#' @description {Applies a list of statistical measures against the rows of \code{ENSO} data set, i.e. the yearly moving averages}
#' @return data.frame of stats
#' @export ENSOstats
ENSOstats <- function(stats = list(mean = base::mean, median = stats::median, var = stats::var))
{
  z <- data.frame(do.call(cbind, lapply(stats, function(x) apply(poissonFits::atlanticStormsENSO[,-c(1,2)], 1, x))))
  names(z) <- names(stats)
  return(z)
}

