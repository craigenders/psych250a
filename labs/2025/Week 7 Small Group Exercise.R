# LOAD R PACKAGES ----

# load R packages
library(psych)
library(summarytools)

# IMPORT DATA FROM EXTERNAL WEBSITE ----

# github url for raw data
filepath <- 'https://raw.githubusercontent.com/craigenders/psych250a/main/data/CancerData.csv'

# create data frame
Cancer <- read.csv(filepath, stringsAsFactors = T)

# ADD CODE BELOW ----