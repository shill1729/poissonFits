#' Filter storm data-set by tropical storm or hurricane
#'
#' @param dta the data-set of all storms, from \code{stormReportScraper()}
#' @param exclude boolean: whether to exclude by keyword or include
#' @param type either "Tropical" or "Hurricane" or "All"
#'
#' @description {Filter the data-set by tropical storms or hurricanes}
#' @details {Note early data-points do not record storm names by whether they are tropical storms or hurricanes.}
#' @return data.frame
#' @export filterStormType
filterStormType <- function(dta, exclude = TRUE, type = "Tropical")
{
  if(!type %in% c("Tropical", "Hurricane", "All"))
  {
    stop("'type' must be either 'All', 'Tropical' or 'Hurricane'")
  }
  if(type == "All")
  {
    return(dta)
  } else
  {
    if(exclude)
    {
      indexes <- unlist(lapply(dta$name, function(x) !grepl(type, x)))
    } else
    {
      indexes <- unlist(lapply(dta$name, function(x) grepl(type, x)))
    }
    new_dta <- dta[indexes, ]
    return(new_dta)
  }

}
