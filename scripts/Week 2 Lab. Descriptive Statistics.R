# PRELIMINARIES: LOADING PACKAGES ----

# ggplot2 produces the histograms and density plots
library(ggplot2)

# psych provides describe() and describeBy() for descriptive statistics
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

# set the working directory to the folder that contains this script
setwd(dirname(getActiveDocumentContext()$path))

# print the working directory to confirm the location
getwd()

# read ClinicalTrial.csv from the working directory into a data frame named ClinicalTrial
ClinicalTrial <- read.csv("ClinicalTrial.csv", stringsAsFactors = TRUE)

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
print(dfSummary(ClinicalTrial), method = "render")

# Summarizing a Subset of Variables ----

# overview of just Condition and COWeek8
print(dfSummary(ClinicalTrial[, c("Condition", "COWeek8")]), method = "render")

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for every variable in the data frame
describe(ClinicalTrial)

# DISTRIBUTION PLOTS BY GROUP ----

# histogram with density curve for COWeek8, one panel per Condition group
ggplot(ClinicalTrial, aes(x = COWeek8, colour = Condition)) +
  geom_histogram(aes(y = after_stat(density))) +
  geom_density() +
  facet_wrap(~ Condition)

# DESCRIPTIVE STATISTICS BY GROUP ----

# descriptive statistics for COWeek8 within each Condition group
describeBy(COWeek8 ~ Condition, data = ClinicalTrial)

# STANDARDIZING VARIABLES AS Z-SCORES ----

# convert COWeek8 to z-scores and store them as a new variable zCOWeek8
ClinicalTrial$zCOWeek8 <- scale(ClinicalTrial$COWeek8)

# descriptive statistics for COWeek8 and its z-score version
describe(ClinicalTrial[, c("COWeek8", "zCOWeek8")])

# descriptive statistics for zCOWeek8 within each Condition group
describeBy(zCOWeek8 ~ Condition, data = ClinicalTrial)
