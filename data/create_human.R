# (c) Miikka Juomoja 29.11.2021
#
# Data Wrangling exercise 4

library(dplyr)

# Task 2
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Task 3
summary(hd)
summary(gii)

# Task 4
colnames(hd)[1] <- "h_rank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "hdi"
colnames(hd)[4] <- "life"
colnames(hd)[5] <- "edu"
colnames(hd)[6] <- "mean_edu"
colnames(hd)[7] <- "gni"
colnames(hd)[8] <- "gni_hdi"

colnames(gii)[1] <- "g_rank"
colnames(gii)[2] <- "country"
colnames(gii)[3] <- "gii"
colnames(gii)[4] <- "mmr"
colnames(gii)[5] <- "abr"
colnames(gii)[6] <- "parl"
colnames(gii)[7] <- "edu2F"
colnames(gii)[8] <- "edu2M"
colnames(gii)[9] <- "labF"
colnames(gii)[10] <- "labM"

# Task 5
gii <- mutate(gii, edu2R = edu2F/edu2M)
gii <- mutate(gii, labR = labF /labM)

str(gii)

# Task 6
human <- inner_join(hd, gii, by = "country", suffix = c(".h", ".g"))
dim(human)
write.csv(human, ".\\data\\human1.csv")


# (c) Miikka Juomoja 6.12.2021
#
# Data Wrangling exercise 5
library(stringr)
human <- read.csv(file = ".\\data\\human1.csv")

# Task 1: gni into numeric (I also removed commas)
human$gni <- stringr::str_replace(human$gni, pattern=",", replace ="") %>% as.numeric()

# Task 2: Exclude unneeded variables (NOTE! own naming because exercise 4)
keep <- c("country", "edu2R", "labR", "life", "edu", "gni", "mmr", "abr", "parl")
human <- select(human, one_of(keep))

# Task 3: Remove all rows with missing values 
human <- filter(human, complete.cases(human))

# Task 4: Remove the observations which relate to regions instead of countries.
last <- nrow(human) - 7 # Last 7 areas
human <- human[1:last,]

# Task 5: Row name = country, remove country
rownames(human) <- human$country
human <- dplyr::select(human, -country)
dim(human)

write.csv(human, ".\\data\\human2.csv", row.names = TRUE)