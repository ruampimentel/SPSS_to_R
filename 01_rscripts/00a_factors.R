
############################################################################
############################################################################
###                                                                      ###
###                                FACTOR                                ###
###                                                                      ###
############################################################################
############################################################################

# https://www.guru99.com/r-factor-categorical-continuous.html


# Categorical variables in R are stored into a factor. Let’s check the code 
# below to convert a character variable into a factor variable in R. 
# Characters are not supported in machine learning algorithm, and the only 
# way is to convert a string to an integer

?factor()


# Arguments:

# x: A vector of categorical data in R. Need to be a string or integer, not decimal.
# Levels: A vector of possible values taken by x. This argument is optional. 
# The default value is the unique list of items of the vector x.
# Labels: Add a label to the x categorical data in R. 
# For example, 1 can take the label `male` while 0, the label `female`.
# ordered: Determine if the levels should be ordered in categorical data in R.



#################################################################
##                 Nominal Categorical Vectors                 ##
#################################################################

# Create gender vector
gender_vector <- c("Male", "Female", "Female", "Male", "Male")
gender_vector
class(gender_vector)


# Convert gender_vector to a factor
factor_gender_vector <- factor(gender_vector)
factor_gender_vector
class(factor_gender_vector)



##################################################################
##                  Ordinal Categorical Vector                  ##
##################################################################


# Create Ordinal categorical vector 
day_vector <- c('evening', 'morning', 'afternoon', 'midday', 'midnight', 'evening')

# Convert `day_vector` to a factor with ordered level
factor_day <- factor(day_vector, 
                     ordered = TRUE, 
                     levels = c('morning', 'midday', 'afternoon', 'evening', 'midnight')
)

# Print the new variable
factor_day
