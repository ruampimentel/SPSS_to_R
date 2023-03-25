# Source: https://www.dataquest.io/blog/load-clean-data-r-tidyverse/
# https://www.geeksforgeeks.org/data-cleaning-in-r/


library(nycflights13)
library(tidyverse)

flights
?flights

# You might also have noticed the row of three (or four) letter abbreviations 
# under the column names. These describe the type of each variable:
#   
# - int stands for integers.
# - dbl stands for doubles, or real numbers.
# - chr stands for character vectors, or strings.
# - dttm stands for date-times (a date + a time).
# 
# There are three other common types of variables that aren’t used in this 
# dataset but you’ll encounter later in the book:
#   
# - lgl stands for logical, vectors that contain only TRUE or FALSE.
# - fctr stands for factors, which R uses to represent categorical variables with fixed possible values.
# - date stands for dates.



# Dplyr Basic ----

# In this chapter you are going to learn the five key dplyr functions that allow you to solve the vast majority of your data manipulation challenges:
#   
# - Pick observations by their values (filter()).
# - Reorder the rows (arrange()).
# - Pick variables by their names (select()).
# - Create new variables with functions of existing variables (mutate()).
# - Collapse many values down to a single summary (summarise()).

# These can all be used in conjunction with group_by() which changes the scope of 
# each function from operating on the entire dataset to operating on it group-by-group. 
# These six functions provide the verbs for a language of data manipulation.


# All verbs work similarly:
#   
# - The first argument is a data frame.
# - The subsequent arguments describe what to do with the data frame, 
#   using the variable names (without quotes).
# - The result is a new data frame.
# 
# Together these properties make it easy to chain together multiple simple steps 
# to achieve a complex result. Let’s dive in and see how these verbs work.

filter(flights, month == 1, day == 1)

jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25))

# what is the problem?
filter(flights, month = 1)

# With logical operators
filter(flights, month == 11 | month == 12)
nov_dec <- filter(flights, month %in% c(11, 12))

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# Missing values
NA > 5
10 == NA
NA + 10
NA / 2
NA == NA

# Let x be Mary's age. We don't know how old she is.
x <- NA

# Let y be John's age. We don't know how old he is.
y <- NA

# Are John and Mary the same age?
x == y
#> [1] NA
# We don't know!

is.na(x)

df <- tibble(x = c(1, NA, 3))
df

filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# ---------------------------------------------------------------------------
arrange(flights, year, month, day)
arrange(flights, desc(dep_delay))


df <- tibble(x = c(5, 2, NA))
df
arrange(df, x) # Missing values are always sorted at the end
arrange(df, desc(x)) # Missing values are always sorted at the end


# Select ----
select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))

# There are a number of helper functions you can use within select():
#   
# - starts_with("abc"): matches names that begin with “abc”.
# - ends_with("xyz"): matches names that end with “xyz”.
# - contains("ijk"): matches names that contain “ijk”.

?select()

# Rename -----
rename(flights, tail_num = tailnum)
select(flights, time_hour, air_time, everything())


# Mutate -----

flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)


transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

# Next = Group by