# PRELIMINARIES: LOADING PACKAGES ----

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

# set the working directory to the folder that contains this script
setwd(dirname(getActiveDocumentContext()$path))

# print the working directory to confirm the location
getwd()

# read Cancer.csv from the working directory into a data frame named Cancer
Cancer <- read.csv("Cancer.csv", stringsAsFactors = TRUE)

# VIEWING THE DATA ----

# print the first six rows of the data frame
head(Cancer)

# print the last six rows of the data frame
tail(Cancer)

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
print(dfSummary(Cancer), method = "render")

# overview of the single variable Depression
print(dfSummary(Cancer$Depression), method = "render")

# COMPUTING A NEW VARIABLE ----

# create logDepression as the natural log of Depression plus 1
Cancer$logDepression <- log(Cancer$Depression + 1)

# overview of the new variable
print(dfSummary(Cancer$logDepression), method = "render")

# RECODING A VARIABLE ----

# create ClinicalSymp: 1 if Depression is 16 or higher, otherwise 0
Cancer$ClinicalSymp <- ifelse(Cancer$Depression >= 16, 1, 0)

# overview of the new variable
print(dfSummary(Cancer$ClinicalSymp), method = "render")

# DEFINING A FACTOR ----

# convert ClinicalSymp from 0/1 codes to a factor with descriptive labels
Cancer$ClinicalSymp <- factor(Cancer$ClinicalSymp,
                              levels = c(0, 1),
                              labels = c("Subclinical Range", "Clinical Range"))

# overview of the factor version
print(dfSummary(Cancer$ClinicalSymp), method = "render")

# SAVING AND LOADING AN R DATA FILE ----

# save the Cancer data frame to an R data file on the desktop
save(Cancer, file = "~/Desktop/Cancer.RData")

# load the Cancer data frame from the R data file on the desktop
load("~/Desktop/Cancer.RData")

# SUBSETTING DATA ----

# Selecting Variables ----

# create CancerSubset containing only Optimism, Depression, and VisImpair
CancerSubset <- Cancer[, c("Optimism", "Depression", "VisImpair")]

# print the number of rows and columns of the original data frame
dim(Cancer)

# print the number of rows and columns of the subset
dim(CancerSubset)

# Selecting Cases ----

# create CancerMalig containing only participants with a malignant diagnosis
CancerMalig <- Cancer[Cancer$Diagnosis == "Malignant", ]

# print the number of rows and columns of the original data frame
dim(Cancer)

# print the number of rows and columns of the subset
dim(CancerMalig)
