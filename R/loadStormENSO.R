#' Load a data-frame of number of storms in the atlantic basin plus ENSO moving averages
#'
#' @param exclude whether to exclude by keyword type or only include
#' @param type the keyword either "All", "Tropical" or "Hurricane"
#'
#' @description {Load a data.frame of number of hurricanes and ENSO moving averages per year.
#' You can exclude all storms with "Tropical Storm" in their name by setting \code{exclude = TRUE} and \code{type = "Tropical"}, etc. Pacific
#' storms are missing reports prior to the 90s so they cannot be used here.}
#' @return data.frame
#' @export loadStormENSO
loadStormENSO <- function(exclude = TRUE, type = "Tropical")
{
  countData <- loadStormData(exclude, type)
  countsYear <- countData$atlantic
  climateData <- data.frame(year = countsYear$year, num_storms = countsYear$freq, poissonFits::ENSO[, -1])
  climateData$year <- as.Date(climateData$year)
  return(climateData)
}
