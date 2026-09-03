# LOAD R PACKAGES ----

# load R packages
library(ggplot2)
library(psych)
library(summarytools)

# IMPORT DATA FROM EXTERNAL WEBSITE ----

# github url for raw data
filepath <- 'https://raw.githubusercontent.com/craigenders/psych250a/main/data/BodySatData.csv'

# create data frame
BodySat <- read.csv(filepath, stringsAsFactors = T)

# ADD CODE BELOW ----