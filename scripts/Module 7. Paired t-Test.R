# LOAD R PACKAGES ----

# load R packages
library(psych)
library(summarytools)

# READ DATA ----

# github url for raw data
filepath <- "https://raw.githubusercontent.com/craigenders/psych250a/main/data/BodySatWideData.csv"

# create data frame called BodySat from github data
BodySat <- read.csv(filepath, stringsAsFactors = T)

# INSPECT DATA ----

# summarize entire data frame (summarytools package)
dfSummary(BodySat)
dfSummary(BodySat[,c('BodySat18','BodySat10')])

# COMPUTE NEW CHANGE SCORE VARIABLE ----

# create change scores
BodySat$BodySatCha <- BodySat$BodySat18 - BodySat$BodySat10

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for entire data frame (psych package)
describe(BodySat)

# T-TEST WITH TWO-TAILED ALTERNATE HYPOTHESIS ----

# paired t-test with default two-tailed alternate hypotheses (base R)
results <- t.test(BodySat$BodySat18, BodySat$BodySat10, paired = TRUE)
results

# print standard error
cat("standard error of mean difference:", results$stderr)

# STANDARIZED MEAN DIFFERENCE EFFECT SIZE ----

# standardized mean difference effect size
cat("standardized mean difference effect size:", mean(BodySat$BodySatCha) / sd(BodySat$BodySatCha))
