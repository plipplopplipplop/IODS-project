# (c) Miikka Juomoja 14.11.2021
#
# Data Wrangling exercise 1

library(dplyr)

# 2. Read Data
rd <- read.table(".\\data\\JYTOPKYS3-data.txt",
                 as.is = TRUE,
                 sep = "\t",
                 header = TRUE)


# 3. Generate new dataset from original data
# 3.1 Rename Age, Attitude, and Points with small letter
rd <- dplyr::rename(rd, age = Age)
rd <- dplyr::rename(rd, attitude = Attitude)
rd <- dplyr::rename(rd, points = Points)


# 3.2 deep = ~d_sm + d_ri + d_ue
# d_sm = ~D03 + D11 + D19 + D27
# d_ri = ~D07 + D14 + D22 + D30
# d_ue = ~D06 + D15 + D23 + D31
rd <- rd %>% dplyr::mutate(d_sm = D03 + D11 + D19 + D27,
                           d_ri = D07 + D14 + D22 + D30,
                           d_ue = D06 + D15 + D23 + D31)
rd <- rd %>% dplyr::mutate(deep = d_sm + d_ri + d_ue)


# 3.3 stra = ~st_os + st_tm
# st_os = ~ST01 + ST09 + ST17 + ST25
# st_tm = ~ST04 + ST12 + ST20 + ST28
rd <- rd %>% dplyr::mutate(st_os = ST01 + ST09 + ST17 + ST25,
                           st_tm = ST04 + ST12 + ST20 + ST28)
rd <- rd %>% dplyr::mutate(stra = st_os + st_tm)


# 3.4 surf = ~su_lp + su_um + su_sb
# su_lp = ~SU02 + SU10 + SU18 + SU26
# su_um = ~SU05 + SU13 + SU21 + SU29
# su_sb = ~SU08 + SU16 + SU24 + SU32

rd <- rd %>% dplyr::mutate(su_lp = SU02 + SU10 + SU18 + SU26,
                           su_um = SU05 + SU13 + SU21 + SU29,
                           su_sb = SU08 + SU16 + SU24 + SU32)
rd <- rd %>% dplyr::mutate(surf = su_lp + su_um + su_sb)


# 4. Save the new data set into a file
write.table(rd, ".\\data\\learning2014.txt", sep = "\t")
