# PRELIMINARIES: LOADING PACKAGES ----

# psych provides describe(), describeBy(), and cohen.d()
library(psych)

# summarytools provides dfSummary() for data summaries
library(summarytools)

# rstudioapi talks to RStudio, used here to find the folder that contains this script
library(rstudioapi)

# IMPORTING DATA ----

# Option 1: Read From the Course Website ----

# store the web address of the raw data file
filepath <- "https://raw.githubusercontent.com/craigenders/psych250a/main/data/Discrimination.csv"

# read the file at that address into a data frame named Discrimination
Discrimination <- read.csv(filepath, stringsAsFactors = TRUE)

# Option 2: Read From the Folder That Contains the Script ----

# this block is switched off because the data file is not in the same folder as this script
# to use it, save the data file next to this script and remove the # from the three code lines below

# set the working directory to the folder that contains this script
# setwd(dirname(getActiveDocumentContext()$path))

# print the working directory to confirm the location
# getwd()

# read Discrimination.csv from the working directory into a data frame named Discrimination
# Discrimination <- read.csv("Discrimination.csv", stringsAsFactors = TRUE)

# CONVERTING CATEGORICAL VARIABLES TO FACTORS ----

# convert Female from 0/1 codes to a factor with descriptive labels
Discrimination$Female <- factor(Discrimination$Female,
                                levels = c(0, 1),
                                labels = c("Male", "Female"))

# print the first few rows to confirm the labels replaced the codes
head(Discrimination)

# SUMMARIZING DATA ----

# overview of every variable in the data frame
dfSummary(Discrimination)

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for entire data frame (psych package)
describe(Discrimination)

# DESCRIPTIVE STATISTICS BY GROUP ----

# descriptive statistics for every variable separately for each group (psych package)
describeBy(Discrimination, group = Discrimination$Female)

# INDEPENDENT-SAMPLES T-TEST ----

# Welch's independent-samples t-test with default two-tailed alternate hypothesis (base R)
results <- t.test(Discrim ~ Female, data = Discrimination)
results

# Standard Error ----

# print standard error of the mean difference
results$stderr

# STANDARDIZED MEAN DIFFERENCE EFFECT SIZE ----

# standardized mean difference effect size (psych package)
cohen.d(Discrim ~ Female, data = Discrimination)

# THE CLASSIC T-TEST ----

# Performing the Classic t-Test ----

# classic independent-samples t-test that assumes equal variances (base R)
results_equal <- t.test(Discrim ~ Female, data = Discrimination, var.equal = TRUE)
results_equal

# print standard error of the mean difference
results_equal$stderr

# Testing Homogeneity of Variance ----

# F test comparing the two group variances, where the null hypothesis is equal variances (base R)
var.test(Discrim ~ Female, data = Discrimination)
