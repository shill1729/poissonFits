#' Scrape the ENSO data-set from NHC NOAA website
#'
#'
#' @description {http GET call to noaa .gov for ENSO data-table. Use this to get the latest data-tables.}
#' @return data.frame
#' @export ENSOscraper
ENSOscraper <- function()
{
  # URL for NHC NOAA ENSO dataset, a PHP file
  url <- "https://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/ONI_v5.php"
  resp <- httr::GET(url = url)
  cont <- httr::content(x = resp, type = "text/html", encoding = "UTF-8")
  parsedResp <- XML::htmlParse(file = cont)
  tables <- XML::readHTMLTable(doc = parsedResp)
  # There are only 11 tables in the list of tables, so it is easy to find the one we wnat
  enso <- tables[[9]]
  # The first row is the climatology season names
  seasonNames <- enso[1, -1]
  seasonNames <- as.character(lapply(seasonNames, as.character))
  # They peskily reiterate the season names every 11th row
  enso <- enso[!((1:nrow(enso)-1)%%11==0), ]
  # They update the 12-columns periodically all year, we remove incomplete rows (the last row)
  if(is.na(as.character(enso[nrow(enso), 12])))
  {
    enso <- enso[-nrow(enso), ]
  }
  # Convert from factors to numeric
  enso[, -1] <- apply(enso[, -1], 2, as.numeric)
  enso <- data.frame(year = enso$V1, enso[, -1])
  # Reassign season names to data.frame
  names(enso)[-1] <- seasonNames
  # Reindex data-frame
  rownames(enso) <- 1:nrow(enso)
  return(enso)

}
