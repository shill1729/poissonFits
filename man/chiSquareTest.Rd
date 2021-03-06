% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chiSquareTest.R
\name{chiSquareTest}
\alias{chiSquareTest}
\title{Chi-square goodness of fit test for Poisson distributions}
\usage{
chiSquareTest(countsData, alpha = 0.05)
}
\arguments{
\item{countsData}{the vector of counts of events per time period}

\item{alpha}{siginificance level, defaults to 0.05}
}
\value{
list
}
\description{
{Implements the goodness of fit test for Poisson distributions against discrete count data}
}
\details{
{The tail counts are converted to less than and greater than respectively.
If there is a missing category of counts, then we truncate up to the last observed category one unit away from the previous.
The original count data is returned along with the category names, for completeness. To be specific, the first and last
entries in the modified count data will always be the number of observed data points that had \eqn{\leq} that number of observations,
and \eqn{\geq} that number of observations. So for example if the original data set had observations where 2 events occured and 3 events occured but not
1 or zero, then we erase the category for 2 events and add the number of times 2 events occured to the category for 3 events and reconsider it as the number
of times 3 or less events occured in the data-set.}
}
