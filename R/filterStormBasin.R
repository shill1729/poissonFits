#' Filter the storm report data set by basin
#'
#' @param dta data-set from \code{stormReportScraper()}
#' @param basin either "Atlantic", "Pacific", or "World"
#'
#' @description {Filter storm data set by basin}
#' @return data.frame
#' @export filterStormBasin
filterStormBasin <- function(dta, basin = "Atlantic")
{
  if(basin == "World")
  {
    counts_per_year <- table(dta$year)
  } else if(basin %in% c("Atlantic", "Pacific"))
  {
    counts_per_year <- table(dta$year[which(dta$basin == basin)])
  } else
  {
    stop("argument 'basin' must be either 'Atlantic', 'Pacific', or 'World'")
  }
  counts_per_year <- as.data.frame(counts_per_year)
  names(counts_per_year) <- c("year", "freq")
  return(counts_per_year)


}
