

# Descriptive
library(tidyverse)
library(psych)

# mtcars is always loaded in the background. 
# create an object with this data, you can call it whatever, including `mtcars`

# Base R datasets
iris
mtcars

head(iris)
head(mtcars)

mtcars <- mtcars
iris <- iris
stats::filter()
# Descriptive methods
mtcars %>% summary() # base R
mtcars %>% skimr::skim() 
mtcars %>% Hmisc::describe()
mtcars %>% psych::describe() # My favorite
mtcars %>% pastecs::stat.desc(norm = T) %>% t() %>% round(2) 
mtcars %>% summarytools::dfSummary() %>% summarytools::view() # very handy for a first view
mtcars %>% summarytools::descr(transpose = T)

# Psych package ----
## run descriptive ----

# just vizualize
mtcars %>% psych::describe()

# save the output as a new objects, called `mtcars_desc`, or whatever you want to call
mtcars_desc <- mtcars %>% 
  psych::describe() %>%   # this is the main function that I need!
  as_tibble(rownames = "variables")  # transforming it in tibble as I like.

# Working with iris dataset
# let's get descriptives. Note that both outcomes below are the same!
psych::describe(iris)
describe(iris)
iris %>% describe()
# This method is quite nice for numeric variables. 

# sort, better, arrange by skew column
mtcars %>% describe() %>% arrange(skew)
# arrange in the descendent order
mtcars %>% describe() %>% arrange(-skew)

# arrange by the absolute value of the skew column
mtcars %>% describe() %>% arrange(abs(skew))
# arrange in the descendent order of the absolute values of the skew column
mtcars %>% describe() %>% arrange(abs(skew))
mtcars %>% describe() %>% arrange(-abs(skew))

# Check if we have variables with skew >= 1
mtcars %>% describe() %>% arrange(-abs(skew)) %>% 
  filter(skew >= 1)

# making life easier

mtcars_desc <- mtcars %>% describe() %>% as_tibble(rownames = "variables")

# sort, better, arrange by skew column
mtcars_desc %>% arrange(skew)
# arrange in the descendent order
mtcars_desc %>% arrange(-skew)

# arrange by the absolute value of the skew column
mtcars_desc %>% arrange(abs(skew))

# arrange in the descendent order of the absolute values of the skew column
mtcars_desc %>% arrange(abs(skew))
mtcars_desc %>% arrange(-abs(skew))

# creating a new object arranged by descendent order of absolute values of skew
mtcars_desc2 <- mtcars_desc %>% arrange(-abs(skew))
# Check if we have variables with skew >= 1
mtcars_desc2

mtcars %>% describe() %>% arrange(-abs(skew)) %>% 
  filter(skew >= 1)

mtcars %>% 
  describe() %>% 
  arrange(-abs(skew)) %>% 
  filter(skew >= 1)

mtcars_desc2 %>% filter(skew >= 1)


# IRIS DATASET

# here another approach that I like, that is also nice for other kind of variables
iris %>% summarytools::dfSummary() %>% summarytools::view()
skimr::skim(iris)

# Now, let's see the same descriptives, by group
psych::describe(iris ~ Species) # with formula, I don't have to use " " for the variable names
psych::describeBy(iris, "Species")


iris %>% psych::describeBy("Species")
iris %>% describeBy("Species")

iris %>% psych::describeBy("Species")


## check skew - arranging (sorting) by skew ----


a %>% arrange(abs(skew))


### variables with skew > 1.9 ----
a %>% arrange(abs(skew)) %>% 
  filter(abs(skew) > 1.9) 

### variables with adequate skew (skew < 1.9) ----
a %>% arrange(abs(skew)) %>% 
  filter(abs(skew) <= 1.9) 

# Rstatix ---------

## source: https://github.com/kassambara/rstatix

library(rstatix)

# Compute summary statistics for one or multiple numeric variables. Can handle grouped data.
get_summary_stats(iris) 

# Compute frequency table of categorical variables.
iris %>% freq_table(Species)

# Detect univariate outliers using boxplot methods.
mtcars %>% identify_outliers(hp) 
mtcars %>% identify_outliers(mpg) 
?identify_outliers()

mahalanobis_distance()# Compute Mahalanobis Distance and Flag Multivariate Outliers.
# Univariate Shapiro-Wilk normality test.
iris %>% shapiro_test(Sepal.Length)

cars
