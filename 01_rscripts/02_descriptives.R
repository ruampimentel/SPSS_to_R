

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

# Descriptive methods
mtcars %>% summary() # base R
mtcars %>% skimr::skim() 
mtcars %>% Hmisc::describe()
mtcars %>% psych::describe() # My favorite: Great for numeric variables. 
mtcars %>% pastecs::stat.desc(norm = T) %>% t() %>% round(2) 
mtcars %>% summarytools::dfSummary() %>% summarytools::view() # very handy for a first view
mtcars %>% summarytools::descr(transpose = T)








#################################################################
##         Manipulating the output as any other object         ##
#################################################################

# Psych package ----
## run descriptive ----

# just visualize
mtcars %>% psych::describe()


# Working with iris dataset
# let's get descriptives. Note that all outcomes below are the same!
psych::describe(iris)
describe(iris)
iris %>% describe() 

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
mtcars %>% 
  describe() %>% 
  arrange(-abs(skew)) %>% 
  filter(skew >= 1)

# making life easier
mtcars_desc <- mtcars %>% describe() %>% as_tibble(rownames = "variables")
mtcars_desc

# sort, better, arrange by skew column
mtcars_desc %>% arrange(skew)

# arrange in the descendent order
mtcars_desc %>% arrange(-skew)

# arrange by the absolute value of the skew column
mtcars_desc %>% arrange(abs(skew))

# arrange in the descendant order of the absolute values of the skew column
mtcars_desc %>% arrange(abs(skew))
mtcars_desc %>% arrange(-abs(skew))

# creating a new object arranged by descendent order of absolute values of skew
mtcars_desc2 <- mtcars_desc %>% arrange(-abs(skew))
# Check if we have variables with skew >= 1
mtcars_desc2



##################################################################
##                    Descriptives by Groups                    ##
##################################################################


# IRIS DATASET
iris

# here another approach that I like, that is also nice for other kind of variables
iris %>% summarytools::dfSummary() %>% summarytools::view()
skimr::skim(iris)

# descriptive for the whole variables
describe(iris)

# Now, let's see the same descriptives, by group
psych::describe(iris ~ Species) # with formula, I don't have to use " " for the variable names
psych::describeBy(iris, "Species") # but it also works with " "


iris %>% psych::describeBy("Species")
iris %>% describeBy("Species")

iris %>% psych::describeBy("Species")




#################################################################
##                           Rstatix                           ##
#################################################################


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

# Univariate Shapiro-Wilk normality test.
iris %>% shapiro_test(Sepal.Length)
