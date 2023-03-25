


# Base R ----

## TWO sample t test
t.test(mpg ~ am, data = mtcars)                       # Welch Two Sample t-test
t.test(mpg ~ am, data = mtcars, var.equal = TRUE)    # t-test

## ONE sample t test
t.test(extra ~ 1, data = sleep)
t.test(extra ~ 1, data = sleep)

mtcars %>% head

t.test(mpg ~ am, mtcars)
t.test(mpg ~ am, data = mtcars, var.equal = TRUE)


# Rstatix
library(rstatix)

mtcars %>% t_test(mpg ~ am)
mtcars %>% t_test(mpg ~ am, var.equal = T)
mtcars %>% t_test(mpg ~ am, var.equal = T)

# calculating effect size
mtcars %>% rstatix::cohens_d(mpg ~ am)

effectsize::cohens_d(mpg ~ am, data = mtcars, pooled_sd = F)

cohens_d(mpg ~ am, data = mtcars, pooled_sd = FALSE)

bfi %>% summarytools::dfSummary()


# BONUS ----

# running multiple t-tests
bfi %>% 
  group_by(education) %>% 
  t_test(N1 ~ gender, var.equal = T)   

# adjusting p.values
bfi %>% 
  group_by(education) %>% 
  t_test(N1 ~ gender)   %>% 
  adjust_pvalue(method = "bonferroni") 


