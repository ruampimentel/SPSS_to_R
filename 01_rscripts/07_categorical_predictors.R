# source: https://github.com/mattansb/Practical-Applications-in-R-for-Psychologists/blob/master/06%20categorical%20predictors%20and%20model%20comparison/01%20categorical%20predictors.R

library(dplyr)
library(parameters)


anxiety_adhd <- read.csv("00_data/anxiety_adhd.csv") %>% 
  mutate(ID = factor(ID),
         treat_group = factor(treat_group),
         sex = factor(sex))

anxiety_adhd %>% glimpse()

# see the levels of a factor
levels(anxiety_adhd$treat_group)


# Unfortunately, regressions (and other models) cannot "deal" with categorical
# predictors; Instead, they require all the predictors to be numerical. The way
# to deal with this is to code categorical variables as a series of numerical
# variables that together encode all the information in the categorical
# variable. These are usually called "dummy variables", as each one alone only
# tells part of the story.
#
# Let's see how we do this in R.







# (1) Model Fitting -------------------------------------------------------



## Adding dummy variables (manually) ---------------------------------------

# Option 1: The SPSS way - make the dummy vars by hand...

##>>>>>>>>>>>>>>>>>>>>>>>>>>##
##      ______________      ##
##    /.--------------.\    ##
##   //                \\   ##
##  //                  \\  ##
## || .-..----. .-. .--. || ##
## ||( ( '-..-'|.-.||.-.||| ##
## || \ \  ||  || ||||_|||| ##
## ||._) ) ||  \'-'/||-' || ##
##  \\'-'  `'   `-' `'  //  ##
##   \\                //   ##
##    \\______________//    ##
##     '--------------'     ##
##                          ##
##      DO NOT DO THIS      ##
##                          ##
##<<<<<<<<<<<<<<<<<<<<<<<<<<##


anxiety_adhd <- anxiety_adhd  %>% 
  mutate(d_placebo = ifelse(treat_group == "placebo", 1, 0),
         d_treat   = ifelse(treat_group == "treat",   1, 0))


fit_dummy <- lm(anxiety ~ d_placebo + d_treat,
                data = anxiety_adhd)

summary(fit_dummy)
model_parameters(fit_dummy)
model_performance(fit_dummy)








## Adding dummy variables (automagically) ----------------------------------
# Option 2: let R do all the hard work... Just put the factor in the formula!

fit_factor <- lm(anxiety ~ treat_group, data = anxiety_adhd)
summary(fit_factor)
model_parameters(fit_factor)
model_parameters(fit_dummy)



# How does R determine what and how to dummy-code?
# If `X` is a factor, treatment coding is used, with the FIRST level as the base
# group.
#
# If `X` is a character vactor, it is first converted into a factor (level order
# is alphabetical).

# see the coding scheme:
contrasts(anxiety_adhd$treat_group)




## Change contrast scheme --------------------------------------------------

## 1. change base group in dummy coding
anxiety_adhd %>% 
  mutate(treat_group = relevel(treat_group, ref = "placebo")) # only print

anxiety_adhd <- anxiety_adhd %>% 
  mutate(treat_group = relevel(treat_group, ref = "placebo")) # create an updated object


contrasts(anxiety_adhd$treat_group)

fit_factor2 <- lm(anxiety ~ treat_group, data = anxiety_adhd)
model_parameters(fit_factor2)

# Or change the first level of the factor by re-leveling the factor...
# (`forcats` is a good package for working with factors)




## 2. change to effects coding:
# Another popular coding scheme is the effects coding, where the "base group" is
# the AVERAGE of all the groups (so the first contrast is the difference between
# the mean of group 1 and the total mean, etc). Unfortunately, it makes
# parameter interpretation quite hard...
contrasts(anxiety_adhd$treat_group) <- contr.sum
contrasts(anxiety_adhd$treat_group)

fit_factor3 <- lm(anxiety ~ treat_group, data = anxiety_adhd)
model_parameters(fit_factor3) # what do there mean???



?contr.treatment # even more types...
# We can also use weighted effect coding with the {wec} package.




# All pair-wise comparisons.
emmeans(fit_factor2, ~ treat_group) %>% 
  contrast(method = "pairwise",
           infer = TRUE)
# Note the automatic p-value adjustment
# (We will see more complex contrasts when we learn about ANOVAs.)




# This is the time to note that in R, model ~fitting~ and ~hypothesis testing~
# are not as closely knit as they are in SPSS. Whereas in SPSS we would fit
# several models with different dummy coding or variable centering, in R we work
# in 2 stages:
# 1) fit a model
# 2) Ask the model questions - test contrasts / effects of interest, get
#   predictions...
#
# This 2-part method makes life A LOT EASIER once models become more and more
# complex...






## Plot
library(ggeffects)
ggemmeans(fit_factor2, "treat_group") |>
  plot(add.data = TRUE, jitter = 0.1)

