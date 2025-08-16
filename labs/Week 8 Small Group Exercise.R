# LOAD R PACKAGES ----

# load R packages
library(ggplot2)
library(performance)
library(psych)
library(rstatix)
library(summarytools)

# IMPORT DATA FROM EXTERNAL WEBSITE ----

# github url for raw data
filepath <- 'https://raw.githubusercontent.com/craigenders/psych250a/main/data/VideoSpeedData.csv'

# create data frame
VideoSpeed <- read.csv(filepath, stringsAsFactors = T)

# ADD CODE BELOW ----