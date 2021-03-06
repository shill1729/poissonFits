% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filterStormBasin.R
\name{filterStormBasin}
\alias{filterStormBasin}
\title{Filter the storm report data set by basin}
\usage{
filterStormBasin(dta, basin = "Atlantic")
}
\arguments{
\item{dta}{data-set from \code{stormReportScraper()}}

\item{basin}{either "Atlantic", "Pacific", or "World"}
}
\value{
data.frame
}
\description{
{Filter storm data set by basin}
}
