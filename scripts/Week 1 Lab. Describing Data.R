# LOAD R PACKAGES ----

# load R packages
library(ggplot2)
library(psych)
library(summarytools)

# READ DATA ----

# github url for raw data
filepath <- "https://raw.githubusercontent.com/craigenders/psych250a/main/data/CancerData.csv"

# create data frame called Cancer
Cancer <- read.csv(filepath, stringsAsFactors = T)

# INSPECT DATA ----

# summarize entire data frame (summarytools package)
dfSummary(Cancer)

# DESCRIPTIVE STATISTICS ----

# descriptive statistics for entire data frame (psych package)
describe(Cancer)

# HISTOGRAMS AND KERNEL DENSITY PLOTS FOR NUMERIC VARIABLES ----

# histogram and kernel density plot for numeric variable (ggplot2 package)
ggplot(Cancer, aes(x = Depression)) +
  geom_histogram(aes(y = after_stat(density)), bins = 61) +
  geom_density()

# histogram and kernel density plot for numeric variable (ggplot2 package)
ggplot(Cancer, aes(x = Optimism)) +
  geom_histogram(aes(y = after_stat(density)), bins = 15) +
  geom_density()

# histogram and kernel density plot for numeric variable (ggplot2 package)
ggplot(Cancer, aes(x = VisImpair)) +
  geom_histogram(aes(y = after_stat(density)), bins = 50) +
  geom_density()

# HISTOGRAMS AND KERNEL DENSITY PLOTS BY GROUP ----

describeBy(Cancer[,c('Depression','Optimism')], group = Cancer$Diagnosis)

# histogram and kernal density plot separately by group (ggplot2 package)
ggplot(Cancer, aes(x = Depression, colour = Diagnosis)) +
  geom_histogram(aes(y = after_stat(density)), bins = 40) +
  geom_density() +
  facet_wrap(~ Diagnosis)

# histogram and kernal density plot separately by group (ggplot2 package)
ggplot(Cancer, aes(x = Optimism, colour = Diagnosis)) +
  geom_histogram(aes(y = after_stat(density)), bins = 15) +
  geom_density() +
  facet_wrap(~ Diagnosis)

# FREQUENCY DISTRIBUTIONS FOR DISCRETE VARIABLES  ----

# frequency distributions for discrete or categorical variables (summarytools package)
freq(Cancer$Diagnosis)
freq(Cancer$Optimism)
freq(Cancer$Comorbids)

# BAR PLOTS FOR DISCRETE VARIABLES  ----

# bar plots for discrete or categorical variable (ggplot2 package)
ggplot(Cancer, aes(x = factor(Diagnosis))) + geom_bar()
ggplot(Cancer, aes(x = factor(Gender))) + geom_bar()


