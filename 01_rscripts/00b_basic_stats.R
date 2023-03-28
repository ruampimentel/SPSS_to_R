
## Basic statistics functions ----
cars # example dataset from base R.
cars <- cars # Put it in our environment.


head(cars) # take a look at the data
?cars # read about the dataset

# Operator	Description

cars$speed # look only to the speed column. 
# In this way we are getting a vector as output

class(cars)

mean(cars$speed)	
mean(cars) # problem - mean() only accept Vectors (and date)! 	
?mean()    # it does not accept a data frame
mean(cars$dist)	# works again 

median(cars$speed)
var(cars$speed)	# Variance of x
sd(cars$speed)	# Standard deviation of x
scale(cars$speed)# Standard scores (z-scores) of x

# add a column with z score
cars$speed_z <- scale(cars$speed) 
# this is the base R way to add column.

head(cars) # take a look at the new data with the column

quantile(cars$speed)	# The quartiles of x
summary(cars$speed)	# Summary of x: mean, min, max etc..
summary(cars) # we can also check the summary for the entire dataset. Flexible function!

# remove from the environment
rm(cars) 

## Writing functions
square_function <- function(n) {
  n^2
}  

# calling the function and passing value 4
square_function(4)

rm(square_function)

# using other functions inside your functions.
# function.name <- function(arguments) 
# {
#   computations on the arguments	
#   some other code
# }

z_scores <- function(n) {
  m <- mean(n) # store mean in an object
  s <- sd(n)   # store sd in object
  (n - m)/s   # get n, subtracts the mean (m), and divide by sd(s)
}


a <- 1:5
z_scores(a) # my function - returns an object the same class of the input.
# in this case we input vector. returns a vector

scale(a)    # base R function - returns array

## multi argument

times <- function(x,y) {
  x * y
}
times(2,4)


