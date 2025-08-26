# LOAD R PACKAGES ----

# load R packages
library(ggplot2)
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
dfSummary(ClinicalTrial[,c('Condition','COWeek8')])

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for entire data frame (psych package)
describe(ClinicalTrial)

# HISTOGRAMS AND KERNEL DENSITY PLOTS BY GROUP ----

# histogram and kernal density plot separately by group (ggplot2 package)
ggplot(ClinicalTrial, aes(x = COWeek8, colour = Condition)) +
  geom_histogram(aes(y = after_stat(density)), bins = 30) +
  geom_density() +
  facet_wrap(~ Condition)

# DESCRIPTIVE STATISTICS BY GROUP ----

# descriptive statistics separately by group (psych package)
describeBy(COWeek8 ~ Condition, data = ClinicalTrial)

# STANDARDIZING VARIABLES AS Z-SCORES ----

# convert to z-scores (base R)
ClinicalTrial$zCOWeek8 <- scale(ClinicalTrial$COWeek8)

# descriptive statistics for a subset of variables (psych package)
describe(ClinicalTrial[,c('COWeek8','zCOWeek8')])

# descriptive statistics separately by group (psych package)
describeBy(zCOWeek8 ~ Condition, data = ClinicalTrial)

