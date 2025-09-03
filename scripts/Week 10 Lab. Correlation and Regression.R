# LOAD PACKAGES ----

# load R packages
library(GGally)
library(ggplot2)
library(psych)
library(summarytools)

# READ DATA ----

# github url for raw data
filepath <- 'https://raw.githubusercontent.com/craigenders/psych250a/main/data/DiaryData.csv'

# create data frame called Diary from github data
Diary <- read.csv(filepath, stringsAsFactors = T)

# INSPECT DATA ----

# summarize entire data frame (summarytools package)
dfSummary(Diary)

# SUBSET DATA: SELECT VARIABLES TO CORRELATE ----

# select variables to correlate
vars2corr <- Diary[, c('NumStressors', 'Support', 'Depress', 'Fatigue', 'WellBeing')]

# SCATTERPLOT MATRIX ----

# create the scatterplot matrix (GGalley package)
ggpairs(vars2corr,
        upper = list(continuous = wrap('cor', size = 5)),
        lower = list(continuous = wrap('smooth', method = 'lm', se = F, alpha = 0.6)),
        diag = list(continuous = wrap('densityDiag')))

# CORRELATION MATRIX ----

# correlation matrix, confidence intervals, and p-values (psych package)
print(corr.test(vars2corr), short = FALSE)

# SCATTERPLOT WITH REGRESSION LINE ----

# scatterplot with regression line (ggplot2 package)
ggplot(data = Diary, aes(x = NumStressors, y = Depress)) +
  geom_point(color = 'blue') +
  geom_smooth(method = 'lm', color = 'red')

# LINEAR REGRESSION WITH 95% CONFIDENCE INTERVALS ----

# linear regression (base R)
results <- lm(Depress ~ NumStressors, data = Diary)
summary(results)

# 95% confidence intervals (base R)
confint(results)
