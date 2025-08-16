# load R packages
library(ggplot2)
library(psych)
library(summarytools)

# github url for raw data
filepath <- 'https://raw.githubusercontent.com/craigenders/psych250a/main/data/CancerPositiveData.csv'

# create data frame called Cancer from github data
Cancer <- read.csv(filepath, stringsAsFactors = T)

# summarize entire data frame (summarytools package)
dfSummary(Cancer)

# descriptive statistics for entire data frame (psych package)
describe(Cancer)

# default two-tailed test with null mean = 16 (base R)
t.test(Cancer$Depression, mu = 16, alternative = 'two.sided')