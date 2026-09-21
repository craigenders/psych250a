#-------------------------------------------------------------------#
# INSTALL R PACKAGES ----
#-------------------------------------------------------------------#

# install.packages('remotes')
# remotes::install_github("bkeller2/fdir")
# install.packages('openxlsx')
# install.packages('haven')

#-------------------------------------------------------------------#
# LOAD R PACKAGES ----
#-------------------------------------------------------------------#

library(fdir)       # sets the working directory to the location of this script
library(openxlsx)   # imports excel .xlsx files
library(haven)      # imports spss, sas, and stata data files

#-------------------------------------------------------------------#
# SET THE DEFAULT WORKING DIRECTORY (FDIR) ----
#-------------------------------------------------------------------#

# set working directory
set()

# print working directory
getwd()

#-------------------------------------------------------------------#
# IMPORT PROPRIETARY FORMAT FROM EXCEL (OPENXLSX) ----
#-------------------------------------------------------------------#

# import excel .xlsx file from the working directory
mydata_excel <- read.xlsx('Cancer_Excel.xlsx', colNames = TRUE)

# convert string/character variables to R factors 
mydata_excel[] <- lapply(mydata_excel, function(x) if (is.character(x)) factor(x) else x)

# summarize data
summary(mydata_excel)

#-------------------------------------------------------------------#
# IMPORT PROPRIETARY FORMAT FROM R (BASE R) ----
#-------------------------------------------------------------------#

# import R .Rdata (or .rda) file from the working directory
load('Cancer_R.Rdata')

# summarize data
summary(mydata_R)

#-------------------------------------------------------------------#
# IMPORT PROPRIETARY FORMAT FROM SPSS (HAVEN) ----
#-------------------------------------------------------------------#

# import spss .sav file from the working directory
mydata_spss <- read_sav('Cancer_SPSS.sav')  

# convert string/character variables to R factors 
mydata_spss[] <- lapply(mydata_spss, function(x) if (is.character(x)) factor(x) else x)

# summarize data
summary(mydata_spss)

#-------------------------------------------------------------------#
# IMPORT COMMA DELIMITED TEXT WITH NAMES IN HEADER (BASE R) ----
#-------------------------------------------------------------------#

# import comma delimited .csv data with variable names from the working directory
mydata_csv1 <- read.csv('Cancer_Header.csv',     # file in working directory
                     stringsAsFactors = TRUE,    # convert text variables to R factors
                     header = TRUE,              # variable names in the first row
                     na.strings = c('NA', '999', '999.00'))     # values representing missing data

# summarize data
summary(mydata_csv1)

#-------------------------------------------------------------------#
# IMPORT COMMA DELIMITED TEXT WITHOUT NAMES IN HEADER (BASE R) ----
#-------------------------------------------------------------------#

# import comma delimited .csv data without variable names from the working directory
mydata_csv2 <- read.csv('Cancer_NoHeader.csv',  # file in working directory
                    stringsAsFactors = TRUE,    # convert text variables to R factors
                    header = FALSE,             # no variable names in the first row
                    na.strings = c('NA', '999', '999.00'))  # values representing missing data

# name data columns
names(mydata_csv2) <- c('Participant','Diagnosis','Age','Gender','Comorbids',
                    'Optimism','Depression','VisImpair')

# summarize data
summary(mydata_csv2)

#-------------------------------------------------------------------#
# IMPORT SPACE DELIMITED TEXT WITH NAMES IN HEADER (BASE R) ----
#-------------------------------------------------------------------#

# import space delimited .dat data with variable names from the working directory
mydata_dat1 <- read.table('Cancer_Header.dat',      # file in working directory
                         stringsAsFactors = TRUE,   # convert text variables to R factors
                         header = TRUE,             # variable names in the first row
                         sep = '',                  # whitespace separates variables  
                         na.strings = c('NA', '999', '999.00'))  # values representing missing data

# summarize data
summary(mydata_dat1)

#-------------------------------------------------------------------#
# IMPORT SPACE DELIMITED TEXT WITHOUT NAMES IN HEADER (BASE R) ----
#-------------------------------------------------------------------#

# import space delimited .dat data without variable names from the working directory
mydata_dat2 <- read.table('Cancer_NoHeader.dat',     # file in working directory
                          stringsAsFactors = TRUE,   # convert text variables to R factors
                          header = FALSE,            # no variable names in the first row
                          sep = '',                  # whitespace separates variables  
                          na.strings = c('NA', '999', '999.00'))  # values representing missing data

# name data columns
names(mydata_dat2) <- c('Participant','Diagnosis','Age','Gender','Comorbids',
                        'Optimism','Depression','VisImpair')

# summarize data
summary(mydata_dat2)
