# source: https://cran.r-project.org/web/packages/naniar/vignettes/getting-started-w-naniar.html

library(visdat)
library(ggplot2)
library(naniar)

# visualises the whole dataframe at once, and provides information about the 
# class of the data input into R, as well as whether the data is missing or not.
vis_dat(airquality) 

vis_miss(airquality)

airquality %>% 
  ggplot(aes(x = Solar.R, y = Ozone)) + 
  geom_point() # see warning message about missings.

airquality %>% 
  ggplot(aes(Solar.R, Ozone)) + 
  geom_miss_point() # also see missings in the plot!

airquality %>% 
  ggplot( aes(Solar.R,  Ozone)) + 
  geom_miss_point() + 
  facet_wrap(~Month)

# Visualising missing in variables
gg_miss_var(airquality)

gg_miss_var(airquality) + theme_bw() 
gg_miss_var(airquality) + labs(y = "Look at all the missing ones")
gg_miss_var(airquality, facet = Month)


dplyr::n_distinct(airquality)
dplyr::n_distinct(airquality$Ozone)
n_miss(airquality)
n_miss(airquality$Ozone)
n_complete(airquality)
n_complete(airquality$Ozone)
prop_miss_case(airquality)
pct_miss_case(airquality)

# returns a numeric value that describes the number of missings in a 
# given case (aka row), the percent of missings in that row.
miss_case_summary(airquality)


# miss_case_table() tabulates the number of missing values in a case / row. 
# Below, this shows the number of missings in a case:

miss_case_table(airquality)
## There are 111 cases with 0 missings, which comprises about 72% of the data.
## There are then 40 cases with 1 missing, these make up 26% of the data.
## There are then 2 cases with 2 missing - these make up 1% of the data.


prop_miss_var(airquality)


# Similar to pct_miss_case(), 
# prop_miss_case(), pct_miss_var() and prop_miss_var() returns the percent and 
# proportion of variables that contain a missing value.
prop_miss_var(airquality)
pct_miss_var(airquality)

# returns the number of missing values in a variable, and the percent missing in that variable.
miss_var_summary(airquality)

# This describes the number of missings in a variable.

miss_var_table(airquality)
## There are 4 variables with 0 missings, comprising 66.67% of variables in the dataset.
## There is 1 variable with 7 missings
## There is 1 variable with 37 missings



# WITH GROUP BY

pedestrian %>% miss_var_summary()

pedestrian %>%
  group_by(month) %>%
  miss_var_summary() %>% 
  filter(variable == "hourly_counts")
