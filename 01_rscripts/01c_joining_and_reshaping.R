library(tidyverse)


data_raw <- read_csv("00_data/deaf_numer.csv")

data_clean <- data_raw  %>% 
  select(sID, nFingers, rt) %>% 
  filter(rt < 2500) %>% 
  mutate(sqrt_rt = sqrt(rt),
         rt = rt / 1000)  %>% 
  group_by(nFingers) %>% 
  mutate(rt_z = scale(rt))  %>% 
  ungroup()

# Join data frames --------------------------------------------------------



# Sometimes our data is split across more than one data frame. Sometimes examples:
# - Data from different sessions is stored in different files
# - Dyad data is split (mother data in one file, baby in another).
# - Data from different questionnaires / tasks is stored in separate files.

# For example, we have:
# 1. A file with performance on some task.
data_clean

# 2. A file with demographic info for each subject.
subject_info <- read_csv("00_data/deaf_numer_sinfo.csv")
subject_info


# We can easily JOIN these data according to some key - the subject.
data_clean_joined <- data_clean %>% full_join(subject_info, by = "sID")
data_clean_joined <- data_clean %>% full_join(subject_info) # what is the difference?

data_clean_joined



# remove what we don't need
rm(data_clean, data_clean_joined, data_raw, subject_info)


# Reshaping data ----------------------------------------------------------


# Most modeling functions in R take a data frame that is tidy. Unfortunately,
# this is not true for other unmentionable statistical programs...

emotionalWM <- readxl::read_excel("00_data/Zhang2018_emotionalWM.xlsx")
# data from https://doi.org/10.3389%2Ffnbeh.2018.00065

emotionalWM
glimpse(emotionalWM)

View(emotionalWM)
# Is this data tidy? (No. Why not?)



## Wide to long ----


# To make this data tidy, we need to make it LONG (it is now WIDE).
# We can do this with `pivot_longer()`:

emotionalWM_long <- emotionalWM %>%
  pivot_longer(
    cols = positive_average:negative_O2,
    names_to = "condition",
    values_to = "ERP" # Amplitudes of ERP components at electrodes of interest 
  )

emotionalWM_long
# Is this data tidy?





## Long to wide ----
emotionalWM_long <- emotionalWM %>%
  pivot_longer(
    cols = positive_average:negative_O2,
    names_sep = "_",
    names_to = c("emotion", "area"),
    values_to = "ERP"
  )

emotionalWM_long

# Is THIS data tidy?





# Sometimes we might want to take long form data and make it wide.
# We can do this with `pivot_wider()`
emotionalWM_wide_again <- emotionalWM_long  %>% 
  pivot_wider(
    names_from = c("emotion", "area"),
    values_from = "ERP"
  )
emotionalWM_wide_again


