#' Compute sample mean and confidence intervals
#'
#' @param x random variates to compute mean of
#' @param alpha significance level, defaults to 0.05
#'
#' @description {Computes the sample mean and confidence interval around the estimate}
#' @details {For samples \eqn{\leq 45} in size, the Student-t distribution is used to compute the CI, otherwise the normal distribution is used.}
#' @return data.frame
#' @export meanCI
meanCI <- function(x, alpha = 0.05)
{
  mu <- mean(x)
  volat <- stats::sd(x)
  n <- length(x)
  if(n <= 45)
  {
    # Use Student-t
    # Use normal
    t_alpha <- stats::qt(1-alpha/2, df = n-1)
    err <- t_alpha*volat/sqrt(n)
    lb <- mu-err
    ub <- mu+err
  } else if(n > 45)
  {
    # Use normal
    z_alpha <- stats::qnorm(1-alpha/2)
    volat <- stats::sd(x)

    err <- z_alpha*volat/sqrt(n)
    lb <- mu-err
    ub <- mu+err

  }
  return(data.frame(lb = lb, mu = mu, ub = ub, err = err, n = n, cl = 1-alpha))
}
