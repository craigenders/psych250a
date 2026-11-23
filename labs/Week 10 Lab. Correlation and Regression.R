# PRELIMINARIES: LOADING PACKAGES ----

# estimatr provides lm_robust() for robust standard errors
library(estimatr)

# GGally provides ggpairs() for scatterplot matrices
library(GGally)

# ggplot2 draws the graphs
library(ggplot2)

# psych provides corr.test() for correlation matrices
library(psych)

# summarytools provides dfSummary() for data summaries
library(summarytools)

# rstudioapi talks to RStudio, used here to find the folder that contains this script
library(rstudioapi)

# IMPORTING DATA ----

# Option 1: Read From the Course Website ----

# store the web address of the raw data file
filepath <- "https://raw.githubusercontent.com/craigenders/psych250a/main/data/DiaryMood.csv"

# read the file at that address into a data frame named DiaryMood
DiaryMood <- read.csv(filepath, stringsAsFactors = TRUE)

# Option 2: Read From the Folder That Contains the Script ----

# this block is switched off because the data file is not in the same folder as this script
# to use it, save the data file next to this script and remove the # from the three code lines below

# set the working directory to the folder that contains this script
# setwd(dirname(getActiveDocumentContext()$path))

# print the working directory to confirm the location
# getwd()

# read DiaryMood.csv from the working directory into a data frame named DiaryMood
# DiaryMood <- read.csv("DiaryMood.csv", stringsAsFactors = TRUE)

# SUMMARIZING DATA ----

# overview of every variable in the data frame
dfSummary(DiaryMood)

# SELECTING VARIABLES TO CORRELATE ----

# keep the five variables to correlate in a new data frame
vars2corr <- DiaryMood[, c("NumStressors", "Support", "Depress", "Fatigue", "WellBeing")]

# SCATTERPLOT MATRIX ----

# scatterplot matrix with correlations above the diagonal (GGally package)
ggpairs(vars2corr,
        upper = list(continuous = wrap("cor", size = 5)),
        lower = list(continuous = wrap("smooth", method = "lm", se = FALSE, alpha = 0.6)),
        diag = list(continuous = wrap("densityDiag")))

# CORRELATION MATRIX ----

# correlation matrix, confidence intervals, and p-values (psych package)
print(corr.test(vars2corr), short = FALSE)

# SCATTERPLOT WITH REGRESSION LINE ----

# scatterplot with regression line (ggplot2 package)
ggplot(data = DiaryMood, aes(x = NumStressors, y = Depress)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red")

# LINEAR REGRESSION ----

# linear regression of depression on the number of daily stressors (base R)
results <- lm(Depress ~ NumStressors, data = DiaryMood)
summary(results)

# CONFIDENCE INTERVALS FOR THE REGRESSION COEFFICIENTS ----

# 95% confidence intervals for the regression coefficients (base R)
confint(results)

# CHECKING THE RESIDUALS ----

# histogram of the regression residuals (base R)
hist(resid(results))

# SENSITIVITY CHECK: ROBUST STANDARD ERRORS ----

# regression with heteroscedasticity-robust standard errors (estimatr package)
results_robust <- lm_robust(Depress ~ NumStressors, data = DiaryMood, se_type = "HC3")
summary(results_robust)
