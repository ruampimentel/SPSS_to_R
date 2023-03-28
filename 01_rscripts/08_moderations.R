
library(dplyr)
library(datawizard)
library(parameters)
library(performance) # for `compare_performance()`
library(bayestestR)  # for `bayesfactor_models()`
library(emmeans)     # for simple slope analysis
library(ggeffects)   # for model plotting

parental_iris <- read.csv("00_data/parental_iris.csv")

glimpse(parental_iris)
head(parental_iris)

# R doesn't need us to make dummy variables - it can deal
# with factors just fine. This is also true for
# moderation and interactions!





# Categorical moderator ---------------------------------------------------

# Let's prep the data for modeling:
parental_iris <- parental_iris %>% 
  mutate(
    attachment = relevel(factor(attachment), ref = "secure"),
    involvement_c = center(parental_involvement)
  )
# Here instead of z scores we are just to centering the
# variable around 0 (or would be better the z-score?).





## 1. Fit the model(s) ----------------------------------------------------

m_additive <- lm(child_satisfaction ~ involvement_c + attachment,
                 data = parental_iris)


# all you need is to tell R to add an interaction!
m_moderation <- lm(child_satisfaction ~ involvement_c + attachment + involvement_c:attachment,
                   data = parental_iris)

# or use `*` -- A * B = A + B + A:B
m_moderation <- lm(child_satisfaction ~ involvement_c * attachment,
                   data = parental_iris)


# Does the model with an interaction have a better fit?
compare_performance(m_additive, m_moderation)
anova(m_additive, m_moderation)
bayesfactor_models(m_moderation, denominator = m_additive)



# Look at the parameters. What do they mean?
model_parameters(m_moderation)






## 2. Explore the model  --------------------------------------------------
# simple slope analysis!

# We don't (just) care about the model's parameters - what we usually care about
# are the different estimates the model can give us - the simple (conditional)
# slopes.

emtrends(m_moderation,
         ~ attachment, 
         var = "involvement_c", 
         infer = TRUE)

# we can also use contrasts here to COMPARE slopes:
emtrends(m_moderation, ~ attachment, var = "involvement_c") %>% 
  contrast(method = "pairwise",
           infer = TRUE)


## Plot

ggemmeans(m_moderation, c("involvement_c","attachment"))

ggemmeans(m_moderation, c("involvement_c","attachment")) |>  plot()

ggemmeans(m_moderation, c("involvement_c","attachment")) |> plot(add.data = TRUE)

ggemmeans(m_moderation, c("involvement_c","attachment")) |> plot(add.data = TRUE, jitter = 0)




# Continuous moderator ----------------------------------------------------


## Prep the data
parental_iris <- parental_iris |>
  mutate(strictness_c = center(parental_strictness))



## 1. Fit the model(s) ----------------------------------------------------

m_additive <- lm(child_satisfaction ~ involvement_c + strictness_c,
                 data = parental_iris)
m_moderation <- lm(child_satisfaction ~ involvement_c * strictness_c,
                   data = parental_iris)

# compare models:
compare_performance(m_additive, m_moderation)
anova(m_additive, m_moderation)
bayesfactor_models(m_additive, m_moderation)

compare_performance(m_additive, m_moderation) %>% plot

# Look at the parameters. What do they mean?
model_parameters(m_moderation)








## 2. Explore the model  --------------------------------------------------
# simple slope analysis!

emtrends(m_moderation, ~ strictness_c, var = "involvement_c")
# Unfortunately, emmeans/emmtrends reduce covariables (numerical predictors) to
# their mean! If we want to probe the moderation at other multiple values, we
# have two ways to do so:





### A. Probe with a function --------
emtrends(m_moderation, ~strictness_c, "involvement_c",
         # Reduce `strictness_c` to its mean+-sd:
         cov.reduce = list(strictness_c = mean_sd),
         infer = TRUE)


ggemmeans(m_moderation, c("involvement_c","strictness_c [meansd]")) |>
  plot(add.data = TRUE, jitter = 0)





### B. Pick-a-point --------
# We can also ask for specific values at which to probe:

emtrends(m_moderation, ~strictness_c, "involvement_c",
         # Probe when `strictness_c` is -4, 78
         at = list(strictness_c = c(-4, 78)),
         infer = TRUE)


ggemmeans(m_moderation, c("involvement_c","strictness_c [-4, 78]")) |>
  plot(add.data = TRUE, jitter = 0)



# Once again, note that in R, model fitting and hypothesis testing are not as
# closely knit as they are in SPSS. For simple slope analysis, in SPSS, we would
# re-fit new models for each simple slope, in R we instead (1) fit a model, (2)
# test the simple slope of interest.


