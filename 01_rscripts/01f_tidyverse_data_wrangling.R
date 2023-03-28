# Source: https://www.dataquest.io/blog/load-clean-data-r-tidyverse/
# https://www.geeksforgeeks.org/data-cleaning-in-r/


library(nycflights13)
library(tidyverse)

flights
?flights

# different display
flights %>% as.data.frame()
cars %>% as_tibble()


# Dplyr Basic ----
flights <- flights

filter(flights, month == 1, day == 1)
flights %>% filter(month == 1, day == 1)


jan1 <- flights %>% filter(month == 1, day == 1)
jan1

(dec25 <- flights %>% filter(month == 12, day == 25))

# what is the problem?
flights %>% filter( month = 1)

# With logical operators
flights %>% filter( month == 11 | month == 12)
nov_dec <- flights %>% filter( month %in% c(11, 12))

flights %>% filter( !(arr_delay > 120 | dep_delay > 120))
flights %>% filter(arr_delay <= 120, dep_delay <= 120)

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
# We don't know!

is.na(x)

df <- tibble(x = c(1, NA, 3)) # create tibble just like dataframes
df

df %>% filter( x > 1)
df %>% filter( is.na(x) | x > 1)

# ---------------------------------------------------------------------------
flights %>% arrange( year, month, day)
flights %>% arrange( desc(dep_delay) )

df <- tibble(x = c(5, 2, NA))
df
df %>% arrange( x) # Missing values are always sorted at the end
df %>% arrange( desc(x) ) # Missing values are always sorted at the end


# Select ----
flights %>% select( year, month, day)
flights %>% select( year:day)
flights %>% select(-(year:day))

# There are a number of helper functions you can use within select():
#   
# - starts_with("abc"): matches names that begin with “abc”.
# - ends_with("xyz"): matches names that end with “xyz”.
# - contains("ijk"): matches names that contain “ijk”.

?select()

# Rename -----
flights %>% rename( tail_num = tailnum)
flights %>% select(time_hour, air_time, everything())


# Mutate -----

flights_sml <- flights %>% 
  select(year:day, 
         ends_with("delay"), 
         distance, 
         air_time
  )

flights_sml %>% 
  mutate(gain = dep_delay - arr_delay,
         speed = distance / air_time * 60
  )

flights_sml %>% 
  mutate(gain = dep_delay - arr_delay,
         hours = air_time / 60,
         gain_per_hour = gain / hours
  )


# Next = Group by

