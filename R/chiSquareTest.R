#' Chi-square goodness of fit test for Poisson distributions
#'
#' @param countsData the vector of counts of events per time period
#' @param alpha siginificance level, defaults to 0.05
#'
#' @description {Implements the goodness of fit test for Poisson distributions against discrete count data}
#' @details {The tail counts are converted to less than and greater than respectively.
#' If there is a missing category of counts, then we truncate up to the last observed category one unit away from the previous.
#' The original count data is returned along with the category names, for completeness. To be specific, the first and last
#' entries in the modified count data will always be the number of observed data points that had \eqn{\leq} that number of observations,
#' and \eqn{\geq} that number of observations. So for example if the original data set had observations where 2 events occured and 3 events occured but not
#' 1 or zero, then we erase the category for 2 events and add the number of times 2 events occured to the category for 3 events and reconsider it as the number
#' of times 3 or less events occured in the data-set.}
#' @return list
#' @export chiSquareTest
chiSquareTest <- function(countsData, alpha = 0.05)
{
  # Estimate rate parameter, and count arrivals of each Number in the Poisson support
  lambda <- mean(countsData)
  counts <- table(countsData)
  original_counts <- counts
  # Number of count categories
  num_of_counts <- length(counts)
  # Observed counts
  observed_counts <- as.numeric(names(counts))
  leftCategory <- as.numeric(names(counts))[1]
  # If all observed counts are in unit-steps, then we may append tails to end and beginning
  if(all(diff(observed_counts)==1) && leftCategory > 0)
  {
    # Compute sum of counts in first two categories and last two categories
    leftTailSum <- sum(counts[1:2])
    rightTailSUm <- sum(counts[(num_of_counts-1):num_of_counts])
    # Amend second category and second to last category to the computed sums
    counts[c(2, num_of_counts-1)] <- c(leftTailSum, rightTailSUm)
    # Remove beginning and end count categories
    counts <- counts[-c(1, num_of_counts)]
    leftCategory <- as.numeric(names(counts))[1]
    rightCategory <- as.numeric(utils::tail(names(counts), 1))
    p <- c(stats::ppois(leftCategory, lambda), stats::dpois(x = (leftCategory+1):(rightCategory-1), lambda), 1-stats::ppois(rightCategory-1, lambda))
  } else if(all(diff(observed_counts)==1) && leftCategory == 0)
  {
    # Compute sum of counts in first two categories and last two categories
    rightTailSUm <- sum(counts[(num_of_counts-1):num_of_counts])
    # Amend second category and second to last category to the computed sums
    counts[c(num_of_counts-1)] <- c(rightTailSUm)
    # Remove beginning and end count categories
    counts <- counts[-c(num_of_counts)]
    rightCategory <- as.numeric(utils::tail(names(counts), 1))
    p <- c(stats::dpois(x = (0):(rightCategory-1), lambda), 1-stats::ppois(rightCategory-1, lambda))
  } else {
      warning("Missing observations for categories in unit-step range")
      # Pick the index prior to the first skip of a category to cut off the right tail by
      cutOffIndex <- min(which(diff(observed_counts) > 1))
      if(cutOffIndex == 2)
      {
        stop("Not enough categories")
      }
      # Convert P(X=c) to P(X>=c)
      counts[cutOffIndex] <- sum(counts[cutOffIndex:num_of_counts])
      # Compute sum of counts in first two categories
      leftTailSum <- sum(counts[1:2])
      # Amend second category and second to last category to the computed sums
      counts[2] <- leftTailSum
      # Remove beginning and end count categories
      counts <- counts[-c(1, (cutOffIndex+1):num_of_counts)]
      leftCategory <- as.numeric(names(counts))[1]
      rightCategory <- as.numeric(utils::tail(names(counts), 1))
      p <- c(stats::ppois(leftCategory, lambda), stats::dpois(x = (leftCategory+1):(rightCategory-1), lambda), 1-stats::ppois(rightCategory-1, lambda))
  }
  N <- length(countsData)
  expected <- p*N
  chiStat <- sum(((counts-expected)^2)/expected)
  criticalRegion <- stats::qchisq(1-alpha, df = num_of_counts-2)
  pValue <- 1-stats::pchisq(chiStat, df = num_of_counts-2)
  chiResult <- ifelse(chiStat > criticalRegion,
                      paste("Reject null at", 1-alpha, "confidence"),
                      paste("Null cannot be rejected at", 1-alpha,  "confidence")
  )
  chiTest <- data.frame(test = chiStat, df = num_of_counts-2, critical_region = criticalRegion, p_value = pValue, result = chiResult)
  output <- list(original = original_counts,
                 table = cbind(counts = counts, expected = expected),
                 chisq_test = chiTest,
                 lambda = meanCI(x = countsData))
  return(output)
}
