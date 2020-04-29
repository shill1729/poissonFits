
# poissonFits

<!-- badges: start -->
<!-- badges: end -->

This package provides convenient functions for fitting Poisson distributions, regressions, and processes to count data of some phenomena or events.

## Installation

You can install the latest version from GitHub with:

``` r
devtools::install_github("shill1729/poissonFits")
```

## Load data from NHC/NOAA

Load hurricane data from NHC NOAA, since they conveniently provide an XML file of all storm reports since 1958. The data-set is provided with the package however, a scraper is also available to get the latest file of storm-reports (Which I imagine does not change frequently until after new storm seasons are over). NOTE: Early data contains named storms without designating them either a hurricane, a tropical storm, or a subtropical storm.

``` r
library(poissonFits)
# Default loads no tropical storms;
countData <- loadStormData()

# Load only tropical storms
# countData <- loadStormData(exclude = FALSE)

# Load only modern named Hurricanes
# countData <- loadStormData(exclude = FALSE, type = "Hurricane")
```

## Fit a Poisson distribution on the number of hurricanes per year in the Atlantic basin
The parameter for the Poisson distribution is chosen via MLE. A Chi-square test is then performed on the goodness of fit of the distribution to the empirical data.

```r
library(poissonFits)
# Significance level for Chi-square test
alpha <- 0.05

# Assuming we loaded countDat from the previous example
countsYear <- countData$atlantic
# Get just the counts
countsData <- countsYear$freq

# Pass just the count data!
poissonFit(countsData)
```

## Fit a Poisson distribution on the number of mass-shootings in the USA per month
Same as the above example, just different dat: the parameter for the Poisson distribution is chosen via MLE. A Chi-square test is then performed on the goodness of fit of the distribution to the empirical data.

```r
library(poissonFits)
# Load data
data("shootings")
# Load the count-data of number of shootings per month
shCounts <- shootingCounts()
# Pass just the counts
poissonFit(shCounts$Freq) # significance level defaults to 0.05
```


