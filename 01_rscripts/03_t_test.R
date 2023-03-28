


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


# Rstatix ----
library(rstatix)

mtcars %>% t_test(mpg ~ am)
mtcars %>% t_test(mpg ~ am, var.equal = T)
mtcars %>% t_test(mpg ~ am, var.equal = F)


## Levene's test - Homogeneity
iris %>% levene_test(Sepal.Length ~ Species)
iris %>% levene_test(Sepal.Width ~ Species)
iris %>% levene_test(Petal.Length ~ Species)

# calculating effect size
mtcars %>% rstatix::cohens_d(mpg ~ am) # formula: DV ~ group (IV)
effectsize::cohens_d(mpg ~ am, data = mtcars, pooled_sd = F) # formula: DV ~ group (IV)

# what is the problem?
cohens_d(mpg ~ am, data = mtcars, pooled_sd = FALSE)




#########################################################
##                    BONUS - adv R                    ##
#########################################################
library(psych)

bfi %>% summarytools::dfSummary()
?bfi

bfi %>% glimpse()

bfi <- bfi %>% 
  rowwise() %>% # it is like group_by for each row. So each row it is its own group.
  mutate(N = mean(c(N1, N2, N3, N4, N5), na.rm = T)) %>% 
  ungroup()


# running multiple t-tests
bfi %>% 
  group_by(education) %>% 
  t_test(N ~ gender, var.equal = T)   

# gender
# Males = 1
# Females =2

# adjusting p.values and creating a new object
N_t_values <- bfi %>% 
  group_by(education) %>% 
  t_test(N ~ gender)   %>% 
  adjust_pvalue(method = "bonferroni") # I like 'holm

# Cohen's d
N_d_values <- bfi %>% 
  group_by(education) %>% 
  cohens_d(N ~ gender)

# Joining (merging) results in a single data frame
N_t_values %>% full_join(N_d_values)
N_t_values %>% left_join(N_d_values)


N_res <- N_t_values %>% full_join(N_d_values)
N_res


N_res %>% 
  rename(d = effsize) %>% 
  arrange(abs(d))

# Export
# xlsx::write.xlsx(N_res, "Neuroticism_results.xlsx")