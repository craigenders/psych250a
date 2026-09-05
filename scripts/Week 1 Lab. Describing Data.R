# PRELIMINARIES: LOADING PACKAGES ----

# ggplot2 produces the histograms, density plots, and bar plots
library(ggplot2)

# psych provides the describe() function for descriptive statistics
library(psych)

# summarytools provides dfSummary() and freq() for data summaries
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

# set the working directory to the folder that contains this script
setwd(dirname(getActiveDocumentContext()$path))

# print the working directory to confirm the location
getwd()

# read Cancer.csv from the working directory into a data frame named Cancer
Cancer <- read.csv("Cancer.csv", stringsAsFactors = TRUE)

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
# the print() wrapper with method = "render" is needed for the HTML output in Rmd
# print(dfSummary(Cancer), method = "render")
dfSummary(Cancer)

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for every variable in the data frame
describe(Cancer)

# HISTOGRAMS AND KERNEL DENSITY PLOTS ----

# Depression Distribution ----

# histogram with overlaid kernel density curve for Depression
ggplot(Cancer, aes(x = Depression)) +
  geom_histogram(aes(y = after_stat(density))) +
  geom_density()

# Optimism Distribution ----

# histogram with overlaid kernel density curve for Optimism
ggplot(Cancer, aes(x = Optimism)) +
  geom_histogram(aes(y = after_stat(density))) +
  geom_density()

# Visual Impairment Distribution ----

# histogram with overlaid kernel density curve for VisImpair
ggplot(Cancer, aes(x = VisImpair)) +
  geom_histogram(aes(y = after_stat(density))) +
  geom_density()

# DISTRIBUTION PLOTS BY GROUP ----

# Depression Distributions by Diagnosis ----

# histogram with density curve for Depression, one panel per Diagnosis group
ggplot(Cancer, aes(x = Depression, colour = Diagnosis)) +
  geom_histogram(aes(y = after_stat(density))) +
  geom_density() +
  facet_wrap(~ Diagnosis)

# Optimism Distributions by Diagnosis ----

# histogram with density curve for Optimism, one panel per Diagnosis group
ggplot(Cancer, aes(x = Optimism, colour = Diagnosis)) +
  geom_histogram(aes(y = after_stat(density))) +
  geom_density() +
  facet_wrap(~ Diagnosis)

# FREQUENCY DISTRIBUTIONS FOR DISCRETE VARIABLES ----

# frequency table for the categorical variable Diagnosis
# the print() wrapper with method = "render" is needed for the HTML output in Rmd
# print(freq(Cancer$Diagnosis), method = "render")
freq(Cancer$Diagnosis)

# frequency table for the 13-point Optimism scale
# the print() wrapper with method = "render" is needed for the HTML output in Rmd
# print(freq(Cancer$Optimism), method = "render")
freq(Cancer$Optimism)

# frequency table for the three-category Comorbids variable
# the print() wrapper with method = "render" is needed for the HTML output in Rmd
# print(freq(Cancer$Comorbids), method = "render")
freq(Cancer$Comorbids)

# BAR PLOTS FOR DISCRETE VARIABLES ----

# bar plot of the number of participants in each Diagnosis group
ggplot(Cancer, aes(x = factor(Diagnosis))) + geom_bar()

# bar plot of the number of participants in each sex group
ggplot(Cancer, aes(x = factor(Male))) + geom_bar()
