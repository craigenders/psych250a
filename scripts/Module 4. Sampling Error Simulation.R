# LOAD R PACKAGES ----

# load R packages
library(psych)

# SPECIFY POPULATION PARAMETERS ----

# simulation inputs
pop_mean <- 5         # population mean
pop_sd <- 5.96        # population standard deviation
sample_N <- 165       # sample size
normal_data <- TRUE   # TRUE = normal data, FALSE = skewed data

# GENERATE AND INSPECT ONE SAMPLE OF DATA ----

# simulate artificial data set from the population
if(normal_data){ # simulate normal data
  mysample <- rnorm(n = sample_N, mean = pop_mean, sd = pop_sd)
} else { # simulate skewed data
  mysample <- pop_mean + ((rchisq(sample_N, pop_mean) - pop_mean)/sqrt(2*pop_mean)) * pop_sd
}

# graph the simulated sample data
hist(mysample, breaks = 50, main = "Distribution of Population Data")

# descriptive statistics for the simulated sample data
describe(mysample)

# SIMULATION WITH 100,000 RANDOM SAMPLES OF DATA ----

# initialize data set to hold 100,000 sample means
samplemeans <- rep(0, 100000)
# loop to draw 100,000 random samples
for(s in 1:100000){
  if(normal_data){ # normal data
    sampledata <- rnorm(n = sample_N, mean = pop_mean, sd = pop_sd)
  } else { # skewed data
    sampledata <- pop_mean + ((rchisq(sample_N, pop_mean) - pop_mean)/sqrt(2*pop_mean)) * pop_sd
  }
  # store the sample mean in element of s
  samplemeans[s] <- mean(sampledata)
}

# graph sampling distribution of the sample means
hist(samplemeans[samplemeans >= 0 & samplemeans <= 10], xlim = c(0,10), ylim = c(0,2000), breaks = seq(0,10, by = .02), main = "Distribution of 100,000 Sample Means")
text(5, 2000, paste0("Average of the 100,000 Sample Means = ", round(mean(samplemeans), 3)))
text(5, 1900, paste0("Standard Deviation of the 100,000 Sample Means = ", round(sd(samplemeans), 3)))
