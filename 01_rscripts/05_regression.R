
# Source: https://github.com/mattansb/Practical-Applications-in-R-for-Psychologists/blob/master/05%20regression%20101/regression%20basics.R

# The principles of modeling are quite consistent across all types of models (liner and non linear)
# that you can build in R:
# - *Build* a model:
#   - Specify a model
#   - Estimate its parameters
# - *Evaluate* the model's fit
# - *Explore* the model (predict, plot, estimate...)
# Everything in this syntax is also relevant
# to those interested in machine learning, mixed models, structural equation
# modeling, ANOVAs, and more and more...

library(effectsize)   # for parameters_standardize
library(parameters)   # for model_parameters
library(performance)  # for model_performance etc..
library(ggeffects)    # for plotting models

# load a data set
data(hardlyworking)
head(hardlyworking)
# - salary      : Shekels per month
# - xtra_hours  : Hours over (weekly) over time worked
# - n_comps     : Number of compliments given to the boss
# - age         : Age in years.
# - seniority   : Number of years working in the company



# Simple Regression -------------------------------------------------------

# In R, models are build in two parts:
# 1. *Specifying* the model:
#   What are the parameters we want to estimate?
# 2. *Fitting* the model to some data:
#   Actually estimate the parameters using some data.


# Models are usually specified with a formula:
# y ~ x
# This can be read as "y is a function of x" or "y is predicted by x"

# Different model types require different fitting functions (we will get back to
# this later on in the semester, and in the following semester) - to fit a
# Linear Model, we will use `lm()`:
fit <- lm(salary ~ xtra_hours, data = hardlyworking)
fit

# Now that we have the model, we can evaluate and explore it!

# Some basic stuff: estimate, SE, test values, and more...
summary(fit)


## Explore the model's *parameters* ----

# CIs
confint(fit)

# beta
standardize_parameters(fit, method = "basic")

# Get all at once:
model_parameters(fit)
model_parameters(fit, standardize = "basic")

check_model(fit)



## Evaluate the model ----
# Look at some model indices
model_performance(fit)







# Multiple Regression -----------------------------------------------------

# Multiple predictors in a formula are specified with "+":
fit2 <- lm(salary ~ xtra_hours + n_comps, data = hardlyworking)

summary(fit2)


## Explore the model's *parameters* ----
model_parameters(fit2)
model_parameters(fit2, standardize = "basic") # Get Betas



## Evaluate the model ----
model_performance(fit2)


compare_performance(fit, fit2)
compare_performance(fit, fit2) %>% plot()

test_performance(fit, fit2)
anova(fit, fit2)







# More Syntax -------------------------------------------------------------

# If we have non-linear relationships, we can also pre-transform the data,
# BUT... we can also specify any transformations in the formula:
fit_seniority <- lm(salary ~ sqrt(seniority), data = hardlyworking)

fit_seniority %>% summary()
model_parameters(fit_seniority, standardize = "basic") # Get Betas
model_performance(fit_seniority)


# Predict from all variables in the data.frame with a `.` (almost never useful):
fit_all <- lm(salary ~ ., data = hardlyworking)
summary(fit_all)





# Exercise ----------------------------------------------------------------

sai <- psychTools::sai
head(sai)
?psychTools::sai

sai %>% glimpse()

# 1. Fit a linear model, predicting `joyful` from two variables of your choice and
# analyze the data as you would typically do.



