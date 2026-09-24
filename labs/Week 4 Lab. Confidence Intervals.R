# PRELIMINARIES: LOADING PACKAGES ----

# ggplot2 produces the error bar plot
library(ggplot2)

# Rmisc provides CI() and group.CI() for confidence intervals
library(Rmisc)

# psych provides describe() for descriptive statistics
library(psych)

# summarytools provides dfSummary() for data summaries
library(summarytools)

# rstudioapi talks to RStudio, used here to find the folder that contains this script
library(rstudioapi)

# IMPORTING DATA ----

# Option 1: Read From the Course Website ----

# store the web address of the raw data file
filepath <- "https://raw.githubusercontent.com/craigenders/psych250a/main/data/ClinicalTrial.csv"

# read the file at that address into a data frame named ClinicalTrial
ClinicalTrial <- read.csv(filepath, stringsAsFactors = TRUE)

# Option 2: Read From the Folder That Contains the Script ----

# this block is switched off because the data file is not in the same folder as this script
# to use it, save the data file next to this script and remove the # from the three code lines below

# set the working directory to the folder that contains this script
# setwd(dirname(getActiveDocumentContext()$path))

# print the working directory to confirm the location
# getwd()

# read ClinicalTrial.csv from the working directory into a data frame named ClinicalTrial
# ClinicalTrial <- read.csv("ClinicalTrial.csv", stringsAsFactors = TRUE)

# CONVERTING CATEGORICAL VARIABLES TO FACTORS ----

# convert Condition from 0/1 codes to a factor with descriptive labels
ClinicalTrial$Condition <- factor(ClinicalTrial$Condition,
                                  levels = c(0, 1),
                                  labels = c("Varenicline", "Varenicline + Naltrexone"))

# convert Male from 0/1 codes to a factor with descriptive labels
ClinicalTrial$Male <- factor(ClinicalTrial$Male,
                             levels = c(0, 1),
                             labels = c("Female", "Male"))

# convert QuitCigsWeek4 from 0/1 codes to a factor with descriptive labels
ClinicalTrial$QuitCigsWeek4 <- factor(ClinicalTrial$QuitCigsWeek4,
                                      levels = c(0, 1),
                                      labels = c("No Quit", "Quit"))

# convert QuitCigsWeek8 from 0/1 codes to a factor with descriptive labels
ClinicalTrial$QuitCigsWeek8 <- factor(ClinicalTrial$QuitCigsWeek8,
                                      levels = c(0, 1),
                                      labels = c("No Quit", "Quit"))

# print the first few rows to confirm the labels replaced the codes
head(ClinicalTrial)

# SUMMARIZING DATA ----

# overview of every variable in the data frame
# the print() wrapper with method = "render" is needed for the HTML output in Rmd
# print(dfSummary(ClinicalTrial), method = "render")
dfSummary(ClinicalTrial)

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for every variable in the data frame
describe(ClinicalTrial)

# 95% CONFIDENCE INTERVAL ----

# mean and 95% confidence interval for COWeek8
CI(ClinicalTrial$COWeek8, ci = 0.95)

# Changing the Confidence Level ----

# mean and 90% confidence interval for COWeek8
CI(ClinicalTrial$COWeek8, ci = 0.90)

# mean and 99% confidence interval for COWeek8
CI(ClinicalTrial$COWeek8, ci = 0.99)

# 95% CONFIDENCE INTERVAL BY GROUP ----

# mean and 95% confidence interval for COWeek8 within each Condition group
group.CI(COWeek8 ~ Condition, data = ClinicalTrial, ci = 0.95)

# group means with 95% confidence interval error bars
ggplot(ClinicalTrial, aes(x = Condition, y = COWeek8)) +
  stat_summary(fun.data = mean_cl_normal, geom = "pointrange")
