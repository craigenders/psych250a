# LOAD PACKAGES ----

# load R packages
library(psych)
library(summarytools)

# READ DATA ----

# github url for raw data
filepath <- 'https://raw.githubusercontent.com/craigenders/psych250a/main/data/DiscriminationData.csv'

# create data frame called Discrim from github data
Discrim <- read.csv(filepath, stringsAsFactors = T)

# INSPECT DATA ----

# summarize entire data frame (summarytools package)
dfSummary(Discrim)

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for entire data frame (psych package)
describe(Discrim)

# DESCRIPTIVE STATISTICS BY GROUP ----

# summary statistics separately by group (psych package)
describeBy(Discrimination ~ Gender, data = Discrim)

# T-TEST WITH TWO-TAILED ALTERNATE HYPOTHESIS ----

# independent t-test with default two-tailed alternate hypotheses (base R)
results <- t.test(Discrimination ~ Gender, data = Discrim)
results

# print standard error
cat('standard error of mean difference:', results$stderr)

# STANDARIZED MEAN DIFFERENCE EFFECT SIZE ----

# standardized mean difference effect size (psych package)
cohen.d(Discrimination ~ Gender, data = Discrim)
