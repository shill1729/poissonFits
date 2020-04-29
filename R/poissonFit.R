#' Fit a Poisson distribution to a set of count data of some phenomena over a time-period
#'
#' @param countsData the vector of number of events per time period
#' @param alpha the significance level
#' @param verbose (boolean) whether or not to print output on function call
#'
#' @description {This function runs a Chi-square test and fits the MLE Poisson parameter estimate to a given data-set of counts over time.}
#' @details {A wrapper to \code{chiSquareTest} and \code{poissonMLE}}
#' @return list
#' @export poissonFit
poissonFit <- function(countsData, alpha = 0.05, verbose = TRUE) {
  chiTest <- chiSquareTest(countsData, alpha)
  poisFit <- poissonMLE(countsData)
  if(verbose)
  {
    print(chiTest)
    print(summary(poisFit))
  }
  return(list(chiTest = chiTest, poisFit = poisFit))
}
