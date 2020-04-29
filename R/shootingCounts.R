#' Return number of mass-shootings per month from the Mother-jones data-set
#'
#' @return table
#' @export shootingCounts
shootingCounts <- function()
{
  timeData <- shootingTimes()
  # Poisson count fitting
  counts <- data.frame(table(cut(timeData$arrivals, "month")))
  return(counts)
}
