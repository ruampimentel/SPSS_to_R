
# source: https://github.com/mattansb/Practical-Applications-in-R-for-Psychologists/blob/master/02%20data%20wrangling/01%20data.frame.R
# Data frames -------------------------------------------------------------

# data frames are the most common way to store and work with DATA. Given you're
# familiar with excel or SPSS, this should feel natural.
#
# In data frames, each column is a vector of some type.
# In the tidyverse way: 
# each vector represents a "variable", 
# and each row represents some "observation".


# we can make a data frame with the function `data.frame()`
school_grades <- data.frame(
  names = c("Dana", "Avi", "Michal", "Asaf", "Jody", "Beth", "Moshe"),
  
  id = c(305850916, 381345273, 203912400, 229889795,
         304786643, 317171280, 326876070),
  
  sex = factor(c("F", "M", "F", "M", "F", "F", "M"),
               labels = c("female", "male")),
  
  math.grades = c(93, 30, NA, 88, 100, 67, 79),
  
  english.grades = c(100, 45, 90, 77, 88, 90, 66)
)
school_grades


# Some useful function to explore data frames:
str(school_grades)          # see data structure
head(school_grades, n = 3)  # get first few rows - useful when printing very long data frames
tail(school_grades, n = 3)  # get last few rows
ncol(school_grades)         # how many columns?
nrow(school_grades)         # how many rows?
View(school_grades)         # view it in R's viewer.



## extract & replace with [row, column]
school_grades[1, ]  # first row
school_grades[, 1]  # first column
school_grades[3, 5] # 3rd row, 5th column

# What will this do?
school_grades[c(1, 2, 3, 1, 1, 1), ]


# many ways to do the same thing...
school_grades[4, 5]
school_grades[4, "english.grades"]
school_grades$english.grades[4]
# school_grades[["english.grades"]][4]
# school_grades[, 5][4]
# school_grades[, "english.grades"][4]




# change and add variables
school_grades[c(2, 3, 6), 2] <- NA
school_grades$pass.english <- school_grades$english.grades >= 56
school_grades$english.grades_bonus <- school_grades$english.grades + 10
school_grades$math.grades_z <- scale(school_grades$math.grades)
school_grades



mean(school_grades$english.grades)
sd(school_grades$english.grades)





# What do these do?
school_grades[school_grades$sex == "female", c("names", "math.grades", "math.grades_z")]

school_grades[school_grades$pass.english, c("names", "english.grades")]

mean(school_grades$math.grades[school_grades$pass.english])



school_grades_clean <- na.omit(school_grades)
school_grades_clean










