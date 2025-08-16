# LOAD PACKAGES ----

# load R packages
library(ggplot2)
library(performance)
library(psych)
library(rstatix)
library(summarytools)

# READ DATA ----

# github url for raw data
filepath <- "https://raw.githubusercontent.com/craigenders/psych250a/main/data/PTSDData.csv"

# create data frame called PTSD from github data
PTSD <- read.csv(filepath, stringsAsFactors = T)

# INSPECT DATA ----

# summarize entire data frame (summarytools package)
dfSummary(PTSD)
dfSummary(PTSD[,c('Race','AnxiousArousal')])

# DESCRIPTIVE STATISTICS AND 95% CONFIDENCE INTERVALS BY GROUP ----

# descriptive statistics separately by group (psych package)
describeBy(AnxiousArousal ~ Race, data = PTSD)

# means and 95% confidence interval error bars by group (ggplot2 package)
ggplot(data = PTSD, aes(x = Race, y = AnxiousArousal, group = 1)) +
  stat_summary(fun = mean, geom = "line") +
  stat_summary(fun = mean, geom = "point", size = 3) +
  stat_summary(fun.data = mean_cl_normal, geom = "pointrange")

# ANOVA ANALYSIS ----

# anova table with f statistic (base R)
anovaresults <- aov(AnxiousArousal ~ Race, data = PTSD) 
summary(anovaresults)

# R-SQUARE (PROPORTION VARIANCE EXPLAINED) EFFECT SIZE ----

# r-square effect size (performance package)
r2(anovaresults)

# PAIRWISE COMPARISONS (TUKEY TESTS) ----

# pairwise Tukey mean comparisons (base R)
TukeyHSD(anovaresults)

# PAIRWISE STANDARDIZED MEAN DIFFERENCE EFFECT SIZES ----

# standardized mean difference effect size for all comparisons (rstatix package)
cohens_d(AnxiousArousal ~ Race, data = PTSD) 

