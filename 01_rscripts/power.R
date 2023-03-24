# "Power corrupts. Absolute power corrupts absolutely."
#
# Generally speaking, power indicates how likely we are to detect an effect of a
# given size, given a sample of a given size. There are two common types of
# power analyses:
# - An a-priori power analysis is used to determine the minimal sample sized
#   required to detect some effect size.
# - A post hoc power analysis is used to asked about observed power - what was
#   the power to detect the observed effect size, given the sample size used in
#   the study.
# However there are more types of power analyses that are gaining popularity,
# such as the "power curve" analysis... There any many guidelines and rules of
# thumb for conducting power analysis, and but for the very trivial statistical
# tests, things get complicated fast.
#
# Suggesting reading - "Five Common Power Fallacies" by Richard D. Morey.


library(pwr)
library(effectsize) # since power is always a function of effect size



# The `pwr` package has some functions for all the basic sig-tests. In all of
# the `pwr.*.test()` function you need to leave one of the arguments blank, and
# `pwr` will find THAT parameter for you.
#
# Note that in most of the post-hoc examples the power is awful. oh well...


# t test ------------------------------------------------------------------
# For the difference of two means.

## Ad-hoc power analysis:
pwr.t.test(d = 0.2, sig.level = .05, power = .8, type = "two.sample") # what n (per group)?
pwr.t.test(n = 15, sig.level = .05, power = .8, type = "two.sample") # what d?
# Or use `pwr.t2n.test()` for unequal group size.

pwr.t.test(d = 0.11, n = 23, sig.level = .05) # what power?
# Or use `pwr.t2n.test()` for unequal group size.




# Correlation -------------------------------------------------------------
## Ad-hoc power analysis:
pwr.r.test(r = 0.1, sig.level = .05, power = .8) # what n?
pwr.r.test(n = 30, sig.level = .05, power = .8) # what r?
pwr.r.test(r = 0.04, n = 46, sig.level = .05) # what power?




# Proportion --------------------------------------------------------------


## Ad-hoc power analysis:
pwr.p.test(h = ES.h(0.3, 0.5), sig.level = .05, power = .8) # what n?
pwr.p.test(n = 30, sig.level = .05, power = .8) # what h?
pwr.p.test(h = ES.h(0.565, 0.5), n = 46, sig.level = .05) # what power?


# Or use:
# pwr.2p.test: two-sample proportion test
# pwr.2p2n.test: two-sample proportion test (unequal sample sizes)



# Chi-squared test --------------------------------------------------------
# For association (but also possible for goodness of fit)

# (w is phi)
pwr.chisq.test(w = 0.2, df = 1, sig.level = .05, power = .8) # what n?
pwr.chisq.test(N = 20, df = 1, sig.level = .05, power = .8) # what phi?
pwr.chisq.test(w = 0.05, N = 46, df = 1, sig.level = .05) # what power?





# F tests -----------------------------------------------------------------
# general test for any F statistic (or t^2 statistic...)

# f2 is Cohen's f squared
pwr.f2.test(f2 = 0.2, u = 1, sig.level = .05, power = .8) # what n (via v = df2)
pwr.f2.test(v = 35, u = 1, sig.level = .05, power = .8) # what f2?

## Post-hoc power analysis:
# 1. hierarchical regression
# In the next few lessons we will learn how to fit linear model.
pwr.f2.test(f2 = 0.32, v = 42, u = 2, sig.level = .05) # what power?

# 2. single coefficient regression
pwr.f2.test(f2 = 0.31, v = 41, u = 1, sig.level = .05) # what power?
