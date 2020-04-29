#' Compute waiting times between mass shootings in the USA using the mother-jones data-set
#'
#' @return data.frame
#' @export shootingTimes
shootingTimes <- function()
{
  # utils::data(shootings)
  # Extract arrival and waiting times (in days)
  arrivals <- as.Date(poissonFits::shootings$date, "%m-%d-%Y")
  waiting <- as.numeric(diff.Date(arrivals))
  timeData <- data.frame(arrivals = arrivals, waiting = c(0, waiting))
  return(timeData)
}
