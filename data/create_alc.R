# (c) Miikka Juomoja 21.11.2021
#
# Data Wrangling exercise 2

library(dplyr)

# 3. Read Data
smat <- read.table(".\\data\\student-mat.csv",
                 as.is = TRUE,
                 sep = ";",
                 header = TRUE)

spor <- read.table(".\\data\\student-por.csv",
                 as.is = TRUE,
                 sep = ";",
                 header = TRUE)

str(smat)
dim(smat)
str(spor)
dim(spor)

# 4. Join the two datasets, which have same columns
# Exclude columns failures, paid, absences, G1, G2, G3 from join

excl_col <- c("failures", "paid", "absences", "G1", "G2", "G3")
join_by <- setdiff(colnames(smat), excl_col)

mat_por <- inner_join(smat, spor, by = join_by, suffix = c(".m", ".p"))
str(mat_por)
dim(mat_por) # 370  39 Correct count

alc <- select(mat_por, one_of(join_by))

str(alc)
dim(alc)

# 5. Combine the 'duplicated' answers

for(column_name in excl_col) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(alc, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# 6. Create alc_use and high_use

alc <- alc %>% mutate(alc_use = Dalc + Walc / 2,
                      high_use = alc_use > 2)

# 7. Save joined data (370 0bservations)

glimpse(alc)
write.csv(alc, ".\\data\\alc.csv")