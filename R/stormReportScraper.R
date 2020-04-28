#' Download 1954-present Storm Report from NHC NOAA .gov
#'
#' @description {Get the 1954-present Storm report from NHC NOAA .gov}
#' @details {This function makes a GET call to the NHC NOAA .gov site, where they make available in xml format the entire 1954-present Storm Report.
#' The data is read into a data.frame and ordered by year.}
#' @return data.frame containing \code{year}, \code{basin} and \code{name} of the storm.
#' @export stormReportScraper
stormReportScraper <- function()
{
  # The NHC NOAA Storm Report from 1954-2019
  url <- "https://www.nhc.noaa.gov/TCR_StormReportsIndex.xml"
  resp <- httr::GET(url)
  # Check status of GET call
  status <- httr::http_status(resp)
  if(status$category != "Success")
  {
    stop(paste(status$category, status$reason, status$message))
  } else if(status$category == "Success")
  {
    resp <- httr::content(x = resp, type = "text/xml", encoding = "UTF-8")
    resp <- xml2::as_list(x = resp)
    StormReportInfo <- resp$StormReportInfo

    # Get length of XML-list
    M <- length(StormReportInfo)
    # Loop into a matrix and then convert to data.frame
    dta <- matrix(0, nrow = M, ncol = 3)
    for(i in 1:M)
    {
      year <- unlist(StormReportInfo[[i]]$Year)
      basin <- unlist(StormReportInfo[[i]]$Basin)
      name <- unlist(StormReportInfo[[i]]$StormName)
      dta[i, ] <- c(year, basin, name)
    }
    dta <- as.data.frame(dta)
    names(dta) <- c("year", "basin", "name")
    # Convert to Date and character from factors
    dta$year <- as.Date(dta$year, format = "%Y")
    dta$basin <- as.character(dta$basin)
    dta$name <- as.character(dta$name)
    # Order by year
    dta <- dta[order(dta$year), ]
    # Reindex
    rownames(dta) <- 1:nrow(dta)
    return(dta)
  }
}
