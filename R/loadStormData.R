#' Wrapper to load in storm data quickly
#'
#' @param exclude whether to exclude data by keyword or include
#' @param type "Tropical" "Hurricane" or "All"
#'
#' @description {Use \code{exclude = TRUE} and "Tropical" to get back named storms + hurricanes.
#' Use \code{exclude = FALSE} and "Hurricanes" to get back only hurricanes, etc.}
#' @return list
#' @export loadStormData
loadStormData <- function(exclude = TRUE, type = "Tropical")
{
  dta <- stormReportScraper()
  storms <- filterStormType(dta, exclude, type)
  atlantic <- filterStormBasin(storms)
  pacific <- filterStormBasin(storms, "Pacific")
  world <- filterStormBasin(storms, "World")
  output <- list(world = world, atlantic = atlantic, pacific = pacific)
  msg <- ifelse(exclude, paste("Excluding", type, "storms"), paste("Only", type, "storms"))
  print(msg)
  return(output)
}
