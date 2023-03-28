
# https://www.statmethods.net/r-tutorial/index.html
# https://www.guru99.com/r-data-types-operator.html






# Declare variables of different types
# Numeric
x <- 28
class(x)
typeof(x)
# remove the object x from the envrionment
rm(x)

x # doesn't exist more.

# String
y <- "Hello world!"

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




#https://www.guru99.com/r-factor-categorical-continuous.html
