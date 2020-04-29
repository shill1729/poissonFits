
# poissonFits

<!-- badges: start -->
<!-- badges: end -->

This package provides convenient functions for fitting Poisson distributions, regressions, and processes to count data of some phenomena or events. It also contains data-sets for examples of approximately Poisson distributed phenomena.

## Installation

You can install the latest version from GitHub with:

``` r
devtools::install_github("shill1729/poissonFits")
```

## Fit a Poisson distribution on the number of hurricanes per year in the Atlantic basin
We can load hurricane data from NHC NOAA, since they conveniently provide an XML file of all storm reports since 1958. See documentation on "stormReport" for more details. The data-set is provided with the package, however, a scraper is also available to get the latest file of storm-reports (which I imagine does not change frequently until after new storm seasons are over). NOTE: Early data contains named storms without designating them either a hurricane, a tropical storm, or a subtropical storm. The parameter for the Poisson distribution is chosen via MLE. A Chi-square test is then performed on the goodness of fit of the distribution to the empirical data.

```r
library(poissonFits)
# Significance level for Chi-square test
alpha <- 0.05

# Default loads no tropical storms;
countData <- loadStormData()

# Pick either the atlantic, pacific, or world
countsYear <- countData$atlantic
# Get just the counts
countsData <- countsYear$freq

# Pass just the count data!
poissonFit(countsData)
```

## Fit a Poisson distribution on the number of mass-shootings in the USA per month
Mother-jones magazine has collected data into a google-sheet tracking the mass-shootings in the USA, see documentation on "shootings" for more info and a link to their data-set. We downloaded this sometime ago provide in the package as a data-set. No scraper is available to update it (yet). The parameter for the Poisson distribution is chosen via MLE. A Chi-square test is then performed on the goodness of fit of the distribution to the empirical data.

```r
library(poissonFits)
# Load data
data("shootings")
# Load the count-data of number of shootings per month
shCounts <- shootingCounts()
# Pass just the counts
poissonFit(shCounts$Freq) # significance level defaults to 0.05
```


