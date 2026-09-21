# LOAD PACKAGES ----

# load R packages
library(psych)
library(summarytools)

# READ DATA ----

# github url for raw data
filepath <- 'https://raw.githubusercontent.com/craigenders/psych250a/main/data/ClinicalTrialData.csv'

# create data frame called ClinicalTrial from github data
ClinicalTrial <- read.csv(filepath, stringsAsFactors = T)

# INSPECT DATA ----

# summarize entire data frame (summarytools package)
dfSummary(ClinicalTrial)

# DESCRIPTIVE STATISTICS BY GROUP ----

# summary statistics separately by group (psych package)
describeBy(COWeek8 ~ Condition, data = ClinicalTrial)

# T-TEST WITH TWO-TAILED ALTERNATE HYPOTHESIS ----

# independent t-test with default two-tailed alternate hypotheses (base R)
results <- t.test(COWeek8 ~ Condition, data = ClinicalTrial)
results

# print standard error
cat('standard error of mean difference:', results$stderr)

# STANDARIZED MEAN DIFFERENCE EFFECT SIZE ----

# standardized mean difference effect size (psych package)
cohen.d(COWeek8 ~ Condition, data = ClinicalTrial)