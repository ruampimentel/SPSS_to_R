# install.packages(c("tidyverse", "haven"))
library(haven) # for importing and exporting 'SPSS' file
library(tidyverse)
library(readxl) # for importing excel files

# import as dataframe
df <- read.csv("00_data/deaf_numer.csv")

# import as tibble
df_tb <- read_csv("00_data/deaf_numer.csv")

# for SPSS files - import as tibble
spss_tb <- read_spss("00_data/deaf_numer.sav")

# for excel files - import as tibble
xlsx_tb <- read_excel("00_data/deaf_numer.xlsx")


# emotional_1back:
# sID      - subject number
# nFingers - Number of stimulated fingers
# trial    - experimental trial
# block    - experimental block
# acc      - accuracy: 1 correct, 0 error
# rt       - reaction time


data_raw
data_raw2

str(data_raw)
str(data_raw2)

as.data.frame()
as_tibble()