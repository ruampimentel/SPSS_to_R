# source: https://github.com/mattansb/Practical-Applications-in-R-for-Psychologists/blob/master/02%20data%20wrangling/01%20data.frame.R


# The ***tidyverse***  ----------------------------------------------------

# The tidyverse is an opinionated collection of R packages designed for data
# [analysis]. All packages share an underlying design philosophy, grammar, and
# data structures - "TIDY DATA"!

## What is tidy data?
# 1. Each variable forms one column.
# 2. Each observation forms one row.





# install.packages(c("tidyverse", "haven"))
library(haven) # for importing and exporting 'SPSS' file
library(tidyverse)
# You only need to install packages once, but you need to load them (with
# `library`) every time you open (or restart) R.








# Importing data ----------------------------------------------------------


# Typically, we won't build our data frame in R - we will import data into R,
# and then manipulate it to make it compatible with our needs - modeling,
# plotting, summary tables, etc (we will learn all of these there upcoming
# weeks!)




# load a data frame
data_raw <- read.csv("00_data/deaf_numer.csv")

# for SPSS files
data_raw <- read_spss("00_data/deaf_numer.sav")


# see also the `readxl` pkg for excel files.


str(data_raw)
glimpse(data_raw) # better!
pairs(data_raw[1:100, ])


# emotional_1back:
# sID      - subject number
# nFingers - Number of stimulated fingers
# trial    - experimental trial
# block    - experimental block
# acc      - accuracy: 1 correct, 0 error
# rt       - reaction time


## How does R know where the file is? ------------------

getwd() # Where is R looking now?
setwd("/Users/ruampimentel/Library/CloudStorage/OneDrive-UniversityofToledo/SPSS_to_R/00_data") # set it to something specific

# Giving the full file path:
data_raw <- read.csv("/Users/ruampimentel/Library/CloudStorage/OneDrive-UniversityofToledo/SPSS_to_R/00_data/deaf_numer.sav") # it only works on my laptop






# Manipulating Data -------------------------------------------------------


# `dplyr` has some very useful functions for manipulating your data.
# The first argument in ALL of these functions is a data frame (e.g., data_raw)


## select columns
data_clean <- select(data_raw,
                     sID, nFingers, rt)
head(data_clean)


## filter -- selects rows:
data_clean <- filter(data_clean,
                     rt < 2500)
nrow(data_clean)
nrow(data_raw)


## mutate -- makes a new variable, or change an existing one
data_clean <- mutate(data_clean,
                     sqrt_rt = sqrt(rt), # new
                     rt = rt / 1000)     # change RT from ms to seconds
head(data_clean)


# group_by -- group data by some variable.
data_clean <- group_by(data_clean,
                       nFingers)
# This doesn't actually change the data in any way, it just lets other functions
# know that they should act on the data according to the groups.
group_keys(data_clean) # see what is grouped by


# For example, mutate():
data_clean <- mutate(data_clean,
                     rt_z = scale(rt))
# What did this do?


## ALWAYS ungroup when you're done with grouping!
data_clean <- ungroup(data_clean)
group_keys(data_clean)



View(data_clean)


# for even more functions, see the dplyr cheatsheet:
# https://posit.co/resources/cheatsheets/


# There are many packages that can help with manipulating, recoding and
# transforming data.
#
# `dplyr` itself has some useful functions that can be used inside `mutate()`
# functions (https://dplyr.tidyverse.org/reference/index.html#section-vector-functions),
# and another real powerhouse is the `sjmisc` package - see examples: http://strengejacke.de/sjmisc-cheatsheet.pdf.



## Piping with  |>  ("and then") -------------------------------------------


# The aim of the pipe (|>) is to make code more human readable.

# For example this:
sqrt(mean(c(1,2,3,4,NA), na.rm = TRUE))
# is not very readable - it is read from in -> out...


# even this (which does the same thing), isn't really readable - why are we
# reading from the inside out??? And not from left to right??
sqrt(
  mean(
    c(1,2,3,4,NA),
    na.rm = TRUE
  )
)


# But using the pipe...
c(1,2,3,4,NA) |>
  mean(na.rm = TRUE) |>
  sqrt()
# amazing!


# The pipe will always* "send" the results from the left, into the FIRST unnamed
# argument of the function on the right.
# If we want to send to another argument, we can use the _ placeholder:
TRUE |>
  mean(c(1,2,3,4,NA), na.rm = _) |>
  sqrt()



# The pipe really shines when used with functions that share the tidyverse
# philosophy. For example, because the `dplyr` function all take a *data frame*
# as the FIRST argument, and also all RETURN a data frame, we can PIPE `dplyr`
# functions:
data_clean_piped <- data_raw |>
  select(sID, nFingers, rt) |>
  filter(rt < 2500) |>
  mutate(sqrt_rt = sqrt(rt),
         rt = rt / 1000) |>
  group_by(nFingers) |>
  mutate(rt_z = scale(rt)) |>
  ungroup()

# This pipe does all the things we did above:
all.equal(data_clean, data_clean_piped)



# Sometimes you will see this type of pipe %>% - it is sort of an 'older' version
# of the |> pipe, and in 99% of cases they both do the same thing.




# Export data -------------------------------------------------------------


# save to a `.csv` file
write.csv(data_clean_piped, file = "data_clean.csv") # read.csv() into object


# save to a `.sav` file
write_sav(data_clean_piped, path = "data_clean.sav")





# save to a `.rds` file
saveRDS(data_clean_piped, file = "data_clean.Rds")
# load using readRDS() into object.
same_data <- readRDS("data_clean.Rds")
# why would you want to do this? (e.g., factors...)

# not only data frames:
xlist <- list(a = 1, b = list(b1 = c(1, 2, 3), bx = "a"))
saveRDS(xlist, file = "some list I made.Rds")









# we can also save multiple objects into `.rdata` files (BUT DON'T!!):
save(data_clean_piped, xlist, file = "selected_objects.rdata")
# Or the whole current environment (Don't!!!!)
save.image(file = "all_objects.rdata")
#
# load using load() into environment




# Exercise ----------------------------------------------------------------



data_raw <- read.csv("data/deaf_numer.csv")
# (Try to do the following with dplyr functions.)
# 1. Create a `Group` variable: (the RA forgot to do it...)
#        - For Subject (`sID`) <= 15, Group should be 1,
#        - For Subject >  15, Group should be 2.
#    TIP: use `ifelse()`
#    (see `02 flow control.R` from last lesson)
# 2. remove the first, practice block (Where block == 1)
# 3. remove trials following an error
#    TIP: use `lag()`
# 4. remove error trials (where `acc` == 0)
# 5. remove RTs that fall beyond +/- 2 SD from *each participant's*
#    mean in *each* of the "finger" conditions.
# 6. create the variable `vib_strength`, randomly sampled from
#    `c(soft = 0.3, strong = 1.0)`

# 7. Try doing steps 1--6 with the pipe (you can copy your solution and just
#   adjust it to work with the pipe.

# 8. Save that data to:
#        - an Rds file
#        - a csv file

# 9. Rewrite this ugly code using the pipe (|>):
diff(range(sample(head(iris[[1]], n = 10), size = 5, replace = TRUE)))



library(tidyverse)


data_raw <- read.csv("data/deaf_numer.csv")

data_clean <- data_raw |>
  select(sID, nFingers, rt) |>
  filter(rt < 2500)


# Join data frames --------------------------------------------------------



# Sometimes our data is split across more than one data frame. Sometimes examples:
# - Data from different sessions is stored in different files
# - Dyad data is split (mother data in one file, baby in another).
# - Data from different questionnaires / tasks is stored in separate files.

# For example, we have:
# 1. A file with performance on some task.
head(data_clean)
# 2. A file with demographic info for each subject.
subject_info <- read.csv("data/deaf_numer_sinfo.csv")
head(subject_info)


# We can easily JOIN these data according to some key - the subject.
data_clean_joined <- data_clean |>
  full_join(subject_info, by = "sID")
head(data_clean_joined, n = 12)







# Reshaping data ----------------------------------------------------------


# Most modeling functions in R take a data frame that is tidy. Unfortunately,
# this is not true for other unmentionable statistical programs...

emotionalWM <- readxl::read_excel("data/Zhang2018_emotionalWM.xlsx")
# data from https://doi.org/10.3389%2Ffnbeh.2018.00065
head(emotionalWM)
# Is this data tidy? (No. Why not?)



## Wide to long ----


# To make this data tidy, we need to make it LONG (it is now WIDE).
# We can do this with `pivot_longer()`:

emotionalWM_long <- emotionalWM |>
  pivot_longer(
    cols = positive_average:negative_O2,
    names_to = "condition",
    values_to = "mV"
  )
head(emotionalWM_long)
# Is this data tidy?





## Long to wide ----

emotionalWM_long <- emotionalWM |>
  pivot_longer(
    cols = positive_average:negative_O2,
    names_sep = "_",
    names_to = "emotion", "area",
    values_to = "mV"
  )
head(emotionalWM_long)
# Is THIS data tidy?





# Sometimes we might want to take long form data and make it wide.
# We can do this with `pivot_wider()`
emotionalWM_wide_again <- emotionalWM_long |>
  pivot_wider(
    names_from = c("emotion", "area"),
    values_from = "mV"
  )
head(emotionalWM_wide_again)


