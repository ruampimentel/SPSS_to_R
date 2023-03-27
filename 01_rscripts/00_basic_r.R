
# https://www.statmethods.net/r-tutorial/index.html
# https://www.guru99.com/r-data-types-operator.html





# Basics types
# 4.5 is a decimal value called numerics.
# 4 is a natural value called integers. Integers are also numerics.
# TRUE or FALSE is a Boolean value called logical binary operators in R.
# The value inside ” ” or ‘ ‘ are text (string). They are called characters.

# Declare variables of different types
# Numeric
x <- 28
class(x)
typeof(x)


# String
y <- "R is Fantastic"
class(y)

# Boolean
z <- TRUE
class(z)

# Creating new variables



# Print variable x
x <- 42
x

y  <- 10
y

# We call x and y and apply a subtraction
x-y


# Vectors ----
# Numerical
vec_num <- c(1, 10, 49)
vec_num

# Character 
vec_chr <- c("a", "b", "c")
vec_chr

# Boolean 
vec_bool <-  c(TRUE, FALSE, TRUE)
vec_bool


# Create the vectors
vect_1 <- c(1, 3, 5)
vect_2 <- c(2, 4, 6)
# Take the sum of A_vector and B_vector
sum_vect <- vect_1 + vect_2
# Print out total_vector
sum_vect


# Slice the first five rows of the vector
my_vector <- c(1,1,1,1,1,2,2,2,2,2)
my_vector[1:5]

# Faster way to create adjacent values
c(1:10)
1:10 # same


# Arithmetic Operators ----

# +  addition
# - subtraction
# * multiplication
# / division
# ^ or ** exponentiation


# Logical Operators ----

# > greater than
# >= greather than or equal to
# == exactly equal to
# != not equal to


# functions
# source: https://www.guru99.com/r-functions-programming.html

## Math functions

x <- 35

abs(x)	# Takes the absolute value of x
log(x, base = 2)	# Takes the logarithm of x with base y; 
log(x) # if base is not specified, returns the natural logarithm
exp(x)	# Returns the exponential of x
sqrt(x)	# Returns the square root of x
factorial(x) #	Returns the factorial of x (x!)

### Also works with vectors! (here is the greater potential!)
x_vector <- c(3, 54, -3, -98, 6)

abs(x_vector)	# Takes the absolute value of x

y_vec <- seq(32, 41, by = 1) 
y_vec <- 32:41 # same results as before

y_vec

log(y_vec, base = 2)	# Takes the logarithm of x with base y; 
log(y_vec) # if base is not specified, returns the natural logarithm
exp(y_vec)	# Returns the exponential of x
sqrt(y_vec)	# Returns the square root of x
factorial(y_vec) #	Returns the factorial of x (x!)



## Basic statistics functions ----
cars # example dataset. This dataset is loaded from base R.
cars <- cars # just so we can see in our environment.

head(cars) # take a look at the data
glimpse(cars) # take another look at the data
?cars # read about the dataset

# Operator	Description

cars$speed # look only to the speed column. In this way we are getting a vector as output

mean(cars$speed)	
median(cars$speed)
var(cars$speed)	# Variance of x
sd(cars$speed)	# Standard deviation of x
scale(cars$speed)	# Standard scores (z-scores) of x

cars$speed_z <- scale(cars$speed) # adding a column with z scores
                                  # this is the base R way to add column.
head(cars) # take a look at the new data with the column

quantile(cars$speed)	# The quartiles of x
summary(cars$speed)	# Summary of x: mean, min, max etc..
summary(cars) # we can also check the summary for the entire dataset. Flexible function!


## Writing functions

square_function <- function(n) {
  n^2
}  

# calling the function and passing value 4
square_function(4)

rm(square_function)

# using other fucntions inside your functions.
# function.name <- function(arguments) 
# {
#   computations on the arguments	
#   some other code
# }

z_scores <- function(n) {
  m <- mean(v) # store mean in an object
  s <- sd(v)   # store sd in object
  (n - m)/s   # get n, subtracts the mean (m), and divide by sd(s)
}


a <- 1:5
z_scores(a) # my function - returns an object the same class of the input.
            # in this case we input vector. returns a vector

scale(a)    # base R function - returns

## multi argument

times <- function(x,y) {
  x * y
}
times(2,4)

# importing data


# basic descriptives

# basic plotting

# package

# getting help
help.start()   # general help
help(dplyr)      # help about function foo
?dplyr           # same thing
# select dplyr and use the F1 key


#https://www.guru99.com/r-factor-categorical-continuous.html
