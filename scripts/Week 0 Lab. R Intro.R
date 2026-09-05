# R BASICS ----

# The Assignment Operator ----

# define a new object called Constant that equals 1
Constant <- 1

# print the contents of Constant
Constant

# Vectors ----

# define a new object called vars2analyze with the names of three variables
vars2analyze <- c("Depression", "Optimism", "VisImpair")

# define a new object called axis_limits with two numeric values
axis_limits <- c(0, 10)

# print the contents of both objects
vars2analyze
axis_limits

# Comments ----

# this is a comment statement that will be ignored

# define a new object called Constant that equals 1
Constant <- 1

# the next line is switched off, so Constant stays equal to 1
# Constant <- 2

# Section Headers ----

# DEFINE A CONSTANT ----

# define a new object called Constant that equals 1
Constant <- 1

# DEFINE A VECTOR ----

# define a new object called axis_limits with two numeric values
axis_limits <- c(0, 10)

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
# the print() wrapper with method = "render" is needed for the HTML output in Rmd
# print(dfSummary(Cancer), method = "render")
dfSummary(Cancer)

# overview of the single variable Depression
# the print() wrapper with method = "render" is needed for the HTML output in Rmd
# print(dfSummary(Cancer$Depression), method = "render")
dfSummary(Cancer$Depression)

# COMPUTING A NEW VARIABLE ----

# create logDepression as the natural log of Depression plus 1
Cancer$logDepression <- log(Cancer$Depression + 1)

# overview of the original and the new variable
# the print() wrapper with method = "render" is needed for the HTML output in Rmd
# print(dfSummary(Cancer[, c("Depression", "logDepression")]), method = "render")
dfSummary(Cancer[, c("Depression", "logDepression")])

# the same computation without Cancer$ creates a vector outside the data frame
logDepVector <- log(Cancer$Depression + 1)

# print the first six values of the vector
head(logDepVector)

# the data frame still has the same columns as before
names(Cancer)

# RECODING A VARIABLE ----

# create ClinicalSymp: 1 if Depression is 16 or higher, otherwise 0
Cancer$ClinicalSymp <- ifelse(Cancer$Depression >= 16, 1, 0)

# convert ClinicalSymp from 0/1 codes to a factor with descriptive labels
Cancer$ClinicalSymp <- factor(Cancer$ClinicalSymp,
                              levels = c(0, 1),
                              labels = c("Subclinical Range", "Clinical Range"))

# overview of the new variable
# the print() wrapper with method = "render" is needed for the HTML output in Rmd
# print(dfSummary(Cancer$ClinicalSymp), method = "render")
dfSummary(Cancer$ClinicalSymp)

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
