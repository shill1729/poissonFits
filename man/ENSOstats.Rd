% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ENSOstats.R
\name{ENSOstats}
\alias{ENSOstats}
\title{Compute various stats on ENSO data}
\usage{
ENSOstats(
  stats = list(mean = base::mean, median = stats::median, var = stats::var)
)
}
\arguments{
\item{stats}{named list of statistical functions like \code{mean}, \code{median}, \code{var}, etc}
}
\value{
data.frame of stats
}
\description{
{Applies a list of statistical measures against the rows of \code{ENSO} data set, i.e. the yearly moving averages}
}
