


# Base R

## TWO sample t test
t.test(mpg ~ am, data = mtcars)                       # Welch Two Sample t-test
t.test(mpg ~ am, data = mtcars, var.equal = TRUE)    # t-test

## ONE sample t test
t.test(extra ~ 1, data = sleep)
t.test(extra ~ 1, data = sleep)

mtcars %>% head

t.test(mpg ~ am, mtcars)
t.test(mpg ~ am, data = mtcars, var.equal = TRUE)
