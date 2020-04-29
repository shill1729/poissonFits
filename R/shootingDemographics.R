#' Return demographics of mass-shooters and frequency of occurence by state
#'
#' @param verbose boolean whether to print on call or not
#'
#' @return list
#' @export shootingDemographics
shootingDemographics <- function(verbose = TRUE)
{
  # utils::data(poissonFits::shootings)

  locations <- sub('.*,\\s*','', poissonFits::shootings$location)
  locations <- sub("CA", "California", locations)
  locations <- sub("IL", "Illinois", locations)
  locations <- sub("PA", "Pennsylvania", locations)
  locations <- sub("CO", "Colorado", locations)
  locations <- sub("TX", "Texas", locations)
  locations <- sub("TN", "Tennessee", locations)
  locations <- sub("FL", "Florida", locations)
  locations <- sub("VA", "Virginia", locations)
  locations <- sub("OH", "Ohio", locations)
  locations <- sub("NV", "Nevada", locations)
  locations <- sub("MD", "Maryland", locations)
  stateCount <- table(locations)/length(locations)
  stateCount <- as.data.frame(sort(stateCount, decreasing = TRUE))
  where <- sort(table(poissonFits::shootings$location.1)/length(poissonFits::shootings$location.1))
  genders <- poissonFits::shootings$gender
  genders <- sub("Male", "M", genders)
  genders <- sub("Female", "F", genders)
  genders <- sort(table(genders)/length(genders))
  races <- poissonFits::shootings$race
  races <- sub("white", "White", races)
  races <- sub("black", "Black", races)
  races <- sub("-", "Other", races)
  races <- sub("unclear", "Other", races)
  races <- sort(table(races)/length(races))

  # Printing
  if(verbose)
  {
    print(stateCount)
    print(where)
    print(genders)
    print(races)
  }
  return(list(stateCount = stateCount, where = where, genders = genders, races = races))

}

