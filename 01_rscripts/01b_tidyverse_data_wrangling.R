# source: https://github.com/mattansb/Practical-Applications-in-R-for-Psychologists/blob/master/02%20data%20wrangling/01%20data.frame.R


# The ***tidyverse***  ----------------------------------------------------

# The tidyverse is an opinionated collection of R packages designed for data
# [analysis]. All packages share an underlying design philosophy, grammar, and
# data structures - "TIDY DATA"!

## What is tidy data?
# 1. Each variable forms one column.
# 2. Each observation forms one row.





library(tidyverse)
# You only need to install packages once, but you need to load them (with
# `library`) every time you open (or restart) R.








# Importing data ----------------------------------------------------------


# Typically, we won't build our data frame in R - we will import data into R,
# and then manipulate it to make it compatible with our needs - modeling,
# plotting, summary tables, etc (we will learn all of these there upcoming
# weeks!)




# load a data frame
data_raw <- read_csv("00_data/deaf_numer.csv")


str(data_raw)
glimpse(data_raw) # better!

# quick exploration plot
# pairs(data_raw)
pairs(data_raw[1:100, ]) # show stop sign running info, 
                         # selecting only first 100 rows, to be faster. 


# emotional_1back:
# sID      - subject number
# nFingers - Number of stimulated fingers
# trial    - experimental trial
# block    - experimental block
# acc      - accuracy: 1 correct, 0 error
# rt       - reaction time






# Manipulating Data -------------------------------------------------------


# `dplyr` has some very useful functions for manipulating your data.
# The first argument in ALL of these functions is a data frame (e.g., data_raw)


## select columns
data_clean <- select(data_raw,
                     sID, nFingers, rt)
data_clean
glimpse(data_clean)

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
data_clean


# group_by -- group data by some variable.
data_clean <- group_by(data_clean,
                       nFingers)

# This doesn't actually change the data in any way, it just lets other functions
# know that they should act on the data according to the groups.
group_keys(data_clean) # see what is grouped by
data_clean # see what is grouped as tibble as well

# For example, mutate():
data_clean <- mutate(data_clean,
                     rt_z = scale(rt))
# What did this do?
data_clean

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



## Piping with  |> or %>% ("and then") -------------------------------------------


# The aim of the pipe ( |> or %>% ) is to make code more human readable.

# For example this.
# What is it doing?
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
# If we want to send to another argument:
# if using |>  : use the _ placeholder.
# if using %>% : use the . placeholder.

# base R
TRUE |> 
  mean(c(1,2,3,4,NA), na.rm = _ ) |>
  sqrt()

# tidyverse
TRUE %>% 
  mean(c(1,2,3,4,NA), na.rm = . ) %>% 
  sqrt()



# The pipe really shines when used with functions that share the tidyverse
# philosophy. For example, because the `dplyr` function all take a *data frame*
# as the FIRST argument, and also all RETURN a data frame, we can PIPE `dplyr`
# functions:

data_clean_piped <- data_raw  %>% 
  select(sID, nFingers, rt) %>% 
  filter(rt < 2500) %>% 
  mutate(sqrt_rt = sqrt(rt),
         rt = rt / 1000)  %>% 
  group_by(nFingers) %>% 
  mutate(rt_z = scale(rt))  %>% 
  ungroup()

# This pipe does all the things we did above:
all.equal(data_clean, data_clean_piped)






# Export data -------------------------------------------------------------


# save to a `.csv` file
write.csv(data_clean_piped, file = "data_clean.csv") # read.csv() into object


# save to a `.sav` file
write_sav(data_clean_piped, path = "data_clean.sav")

# save to a `.rds` file
saveRDS(data_clean_piped, file = "data_clean.Rds")

# we can also save multiple objects into `.rdata` files (BUT DON'T!!):
# it makes us lazy, and sometimes have different versions of files if not
# very very very careful. 
save(data_clean_piped, xlist, file = "selected_objects.rdata")
# Or the whole current environment (Don't!!!!)
save.image(file = "all_objects.rdata")










# Exercise - Let's Work together --------------------------------------------------



data_raw <- read_csv("00_data/deaf_numer.csv")
# (Try to do the following with dplyr functions.)
# 1. Create a `Group` variable: (the RA forgot to do it...)
#        - For Subject (`sID`) <= 15, Group should be 1,
#        - For Subject >  15, Group should be 2.
#    use `ifelse()` and `mutate()`




# 2. remove the first, practice block (Where block == 1). 
#     TIP: use filter()


# 3. remove error trials (where `acc` == 0)



# 4. Try doing steps 1-3 with the pipe (you can copy your solution and just
#   adjust it to work with the pipe.




# 5. Save that data to:
#        - an Rds file
#        - a csv file


# 6. Rewrite this ugly code using the pipe ( |> or %>% ):
diff(range(sample(head(iris[[1]], n = 10), size = 5, replace = TRUE)))







