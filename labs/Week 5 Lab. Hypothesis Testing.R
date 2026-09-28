# PRELIMINARIES: LOADING PACKAGES ----

# psych provides describe() for descriptive statistics
library(psych)

# summarytools provides dfSummary() for data summaries
library(summarytools)

# rstudioapi talks to RStudio, used here to find the folder that contains this script
library(rstudioapi)

# IMPORTING DATA ----

# Option 1: Read From the Course Website ----

# store the web address of the raw data file
filepath <- "https://raw.githubusercontent.com/craigenders/psych250a/main/data/Cancer.csv"

# read the file at that address into a data frame named Cancer
Cancer <- read.csv(filepath, stringsAsFactors = TRUE)

# Option 2: Read From the Folder That Contains the Script ----

# this block is switched off because the data file is not in the same folder as this script
# to use it, save the data file next to this script and remove the # from the three code lines below

# set the working directory to the folder that contains this script
# setwd(dirname(getActiveDocumentContext()$path))

# print the working directory to confirm the location
# getwd()

# read Cancer.csv from the working directory into a data frame named Cancer
# Cancer <- read.csv("Cancer.csv", stringsAsFactors = TRUE)

# CONVERTING CATEGORICAL VARIABLES TO FACTORS ----

# convert Diagnosis from 0/1 codes to a factor with descriptive labels
Cancer$Diagnosis <- factor(Cancer$Diagnosis,
                           levels = c(0, 1),
                           labels = c("Non-malignant", "Malignant"))

# convert Male from 0/1 codes to a factor with descriptive labels
Cancer$Male <- factor(Cancer$Male,
                      levels = c(0, 1),
                      labels = c("Female", "Male"))

# print the first few rows to confirm the labels replaced the codes
head(Cancer)

# SUMMARIZING DATA ----

# overview of every variable in the data frame
dfSummary(Cancer)

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for every variable in the data frame
describe(Cancer)

# ONE-SAMPLE T-TEST ----

# Two-Tailed Test ----

# two-tailed test with null mean = 13
t.test(Cancer$Depression, mu = 13, alternative = "two.sided")

# One-Tailed Test ----

# one-tailed test in the positive direction with null mean = 13
t.test(Cancer$Depression, mu = 13, alternative = "greater")
