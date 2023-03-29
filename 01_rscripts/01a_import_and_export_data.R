# install.packages(c("tidyverse", "haven", "readxl"))
library(haven) # for importing and exporting 'SPSS' file
library(tidyverse) # for csv to tibble
library(readxl) # for importing excel files


## How does R know where the file is? ------------------

getwd() # Where is R looking now?

setwd("/Users/ruampimentel/Library/CloudStorage/OneDrive-UniversityofToledo/SPSS_to_R") # set it to something specific

# Giving the full file path:
data_raw <- read.csv("/Users/ruampimentel/Library/CloudStorage/OneDrive-UniversityofToledo/SPSS_to_R/00_data/deaf_numer.sav") # it only works on my laptop
# relative path
data_raw <- read.csv("00_data/deaf_numer.csv")



##################################################################
##                  Importing as relative path                  ##
##################################################################


# For csv files - as dataframe
df <- read.csv("00_data/deaf_numer.csv")

# For csv files - as tibble
df_tb <- read_csv("00_data/deaf_numer.csv")

# for SPSS files - import as tibble
spss_tb <- read_spss("00_data/deaf_numer.sav")

# for excel files - import as tibble
xlsx_tb <- read_excel("00_data/deaf_numer.xlsx")


df      # dataframe
df_tb   # tibble
spss_tb # tibble
xlsx_tb # tibble


# Show click and point option


# deaf_numer:
# sID      - subject number
# nFingers - Number of stimulated fingers
# trial    - experimental trial
# block    - experimental block
# acc      - accuracy: 1 correct, 0 error
# rt       - reaction time

as.data.frame()
as_tibble()

class(df)
class(df_tb)
class(spss_tb)
class(xlsx_tb)



# Export data -------------------------------------------------------------

getwd()

# save to a `.csv` file
write.csv(df, file = "deaf_numer.csv") 
write.csv(df, file = "00_data/deaf_numer.csv") 

# save to a `.sav` file
write_sav(df, path = "deaf_numer.sav")
write_sav(df, path = "00_data/deaf_numer.sav")

# save to a `.xlsx` file 
library(writexl)
write_xlsx(df, path = "deaf_numer.xlsx")
write_xlsx(df, path = "00_data/deaf_numer.xlsx")




# save to a `.rds` file
saveRDS(df, file = "deaf_numer.Rds")

# load using readRDS() into object.
same_data <- readRDS("deaf_numer.Rds")
# why would you want to do this? (e.g., factors...)

# not only data frames:
xlist <- list(a = 1, b = list(b1 = c(1, 2, 3), bx = "a"))
saveRDS(xlist, file = "some list I made.Rds")

# we can also save multiple objects into `.rdata` files (BUT DON'T!!):
save(same_data, xlist, file = "selected_objects.rdata")
# Or the whole current environment (Don't!!!!)
save.image(file = "all_objects.rdata")