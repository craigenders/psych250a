# LOAD R PACKAGES ----

# load R packages
library(fdir) # use for data import method #2 below
library(summarytools) # use for quick data summaries

# IMPORTING DATA METHOD 1: READ DATA FROM A LOCAL HARD DRIVE ----

# location of file on the hard drive
filepath <- '/Users/craig/Documents/GitHub/psych250a/data/CancerData.csv'

# import CancerData.csv from the file path into an R data frame called Cancer
# stringsAsFactors converts alphanumeric variables to "factors" (categorical variables)
Cancer <- read.csv(filepath, stringsAsFactors = T)

# print first and last six rows of the data
head(Cancer)
tail(Cancer)

# IMPORTING DATA METHOD 2: READ DATA FROM THE FOLDER THAT CONTAINS THE R SCRIPT ----

# set the default working directory to the location of this script (fdir package)
set()

# inspect the folder path of the default working directory
getwd()

# import CancerData.csv from the working directory into an R data frame called Cancer
# stringsAsFactors converts alphanumeric variables to "factors" (categorical variables)
Cancer <- read.csv('CancerData.csv', stringsAsFactors = T)

# print first and last six rows of the data
head(Cancer)
tail(Cancer)

# IMPORTING DATA METHOD 3: EXTERNAL WEBSITE ----

# url for raw data
filepath <- 'https://raw.githubusercontent.com/craigenders/psych250a/main/data/CancerData.csv'

# import CancerData.csv from the url filepath into an R data frame called Cancer
# stringsAsFactors converts alphanumeric variables to "factors" (categorical variables)
Cancer <- read.csv(filepath, stringsAsFactors = T)

# print first and last six rows of the data
head(Cancer)
tail(Cancer)

# INSPECT DATA ----

# summarize entire data frame (summarytools package)
dfSummary(Cancer)

# summarize a single variable
dfSummary(Cancer$Depression)

# COMPUTE NEW VARIABLE ----

# compute a new variable by taking the natural log of an existing variable
Cancer$logDepression <- log(Cancer$Depression + 1)

# summarize a single variable
dfSummary(Cancer$logDepression)

# RECODE EXISTING VARIABLE ----

# recode a numeric variable into a binary variable (clinical = 1, subclinical = 0)
Cancer$ClinicalSymp <- ifelse(Cancer$Depression >= 16, 1, 0)

# summarize a single variable
dfSummary(Cancer$ClinicalSymp)

# DEFINE FACTOR (NOMINAL) VARIABLE ----

# recode a numeric variable into a binary variable (clinical = 1, subclinical = 0)
Cancer$ClinicalSymp <- factor(
  Cancer$ClinicalSymp,
  levels = c(0, 1),
  labels = c('Subclinical Range', 'Clinical Range')
)

# summarize a single variable
dfSummary(Cancer$ClinicalSymp)

# SAVE DATA FRAME AS AN R DATA FILE  ----

# save Cancer data frame to the desktop
save(Cancer, file = '~/Desktop/Cancer.RData')

# LOAD DATA FRAME FROM AN R DATA FILE  ----

# load Cancer data frame from the desktop
load('~/Desktop/Cancer.RData')

# SUBSET DATA (SELECT VARIABLES) ----

# a data frame has rows (observations) and columns (variables)
# elements of a data frame are indexed as DataFrame[row indices,column indices]

# create new data frame with a subset of variables from the original
# a subset of variable names appears in the column index after the comma
CancerSubset <- Cancer[,c('Optimism','Depression','VisImpair')]

# print dimensions of original and subset data
dim(Cancer)
dim(CancerSubset)

# SUBSET DATA (SELECT CASES) ----

# create new data frame with only participants with Diagnosis = Malignant
# a selection criterion appears in the row index before the comma
CancerMalig <- Cancer[Cancer$Diagnosis == 'Malignant',]

# print dimensions of original and subset data
dim(Cancer)
dim(CancerMalig)


