
# https://www.statmethods.net/r-tutorial/index.html
# https://www.guru99.com/r-data-types-operator.html




# Data Types ------

## scalars
## vectors (numerical, character, logical)
## matrices
## data frames
## list

# Basics types
# 4.5 is a decimal value called numerics.
# 4 is a natural value called integers. Integers are also numerics.
# TRUE or FALSE is a Boolean value called logical binary operators in R.
# The value inside ” ” or ‘ ‘ are text (string). They are called characters.

# Declare variables of different types
# Numeric
x <- 28
class(x)

# String
y <- "R is Fantastic"
class(y)

# Boolean
z <- TRUE
class(z)

# Creating new variables

# First way to declare a variable:  use the `<-`
# name_of_variable <- value
# Second way to declare a variable:  use the `=`
# name_of_variable = value

# Print variable x
x <- 42
x

y  <- 10
y

# We call x and y and apply a subtraction
x-y


# Numerical
## A vector is a one-dimensional array. We can create a vector with 
# all the basic R data types we learnt before. 
# The simplest way to build vector data structures in R, is to use the c command.
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
