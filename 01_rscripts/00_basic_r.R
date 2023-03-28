
# https://www.statmethods.net/r-tutorial/index.html
# https://www.guru99.com/r-data-types-operator.html


#################################################################
##                            Basic                            ##
#################################################################



# Declare variables of different types
# Numeric
x <- 28

class(x)
typeof(x)

# remove the object x from the environment
rm(x)

x # doesn't exist more.

# String
y <- "These are words... words are chracters..."
y

class(y)

# Boolean
z <- TRUE
class(z)

# Creating new variables
x <- 42
y  <- 10


# Print variables
x
y

# We call x and y and apply a subtraction
x - y

# remove variables
rm(x)
rm(y)
rm(z)

# what is the problem?
rm(x)

# Vectors ----
# Numerical
vec_num <- c(1, 10, 49)

# Character 
vec_chr <- c("a", "b", "c")

# Boolean 
vec_bool <-  c(TRUE, FALSE, TRUE)

# print
vec_num
vec_chr
vec_bool


# Create the vectors
vect_1 <- c(1, 3, 5)
vect_2 <- c(2, 4, 6)

# Take the sum of vect_1 and vect_2
sum_vect <- vect_1 + vect_2

# Print out total_vector
sum_vect


# Slice the first five rows of the vector
my_vector <- c(1,1,1,1,1,2,2,2,2,2)
my_vector      # print
my_vector[1:5] # slice

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
y_vec

y_vec2 <- 32:41 # same results as before
y_vec2

log(y_vec, base = 2)	# Takes the logarithm of x with base y; 
log(y_vec) # if base is not specified, returns the natural logarithm
exp(y_vec)	# Returns the exponential of x
sqrt(y_vec)	# Returns the square root of x
factorial(y_vec) #	Returns the factorial of x (x!)

# go to `00a_factors.R`