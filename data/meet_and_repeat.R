# (c) Miikka Juomoja 12.12.2021
#
# Data Wrangling exercise 6

library(dplyr)
library(tidyr)

# Task 1
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

RATS
BPRS

# Task 2
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Task 3
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3, 4)))

BPRSL <-  BPRS %>%
  gather(key = weeks, value = bprs, -treatment, -subject)


# Task 4
# Longitudinal data allow for the measurement of within-sample change
# over time, enable the measurement of the duration of events, and
# record the timing of various events

# E.g. With BPRS it is 1-8 Weeks and RATS 1 to 64 WD. This data can then
# be categorized. For example in RATS there are 16 individuals in three
# groups. Longitudinal data can be split into groups and individuals and
# then draw the charts over a time span. Making the data longidutinal
# will break it in a form which can be intepreted this way. As an example
# in BPRS each treatment data can be reformed so each treatment has
# data in 8 weeks of measurements. Instead of having a wide set of data
# where these are combined.