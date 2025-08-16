# LOAD R PACKAGES ----

# load R packages
library(ggplot2)
library(Hmisc)
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

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for entire data frame (psych package)
# both psych and Hisc have describe functions
# psych::describe specifies the psych package's describe function
psych::describe(ClinicalTrial)

# 95% CONFIDENCE INTERVAL ----

# 95% confidence interval (Hisc package)
smean.cl.normal(ClinicalTrial$COWeek8)

# 95% CONFIDENCE INTERVAL BY GROUP ----

# 95% confidence interval by group (Hisc package)
with(ClinicalTrial, tapply(COWeek8, Condition, smean.cl.normal))

# means and 95% confidence interval error bars by group (ggplot2 package)
ggplot(ClinicalTrial, aes(x = Condition, y = COWeek8)) +
  stat_summary(fun.data = mean_cl_normal, geom = 'pointrange')
