# Source: https://www.dataquest.io/blog/load-clean-data-r-tidyverse/
# https://www.geeksforgeeks.org/data-cleaning-in-r/


library(nycflights13)
library(tidyverse)

flights
?flights





# Dplyr Basic ----


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

# then, talk about pipe!