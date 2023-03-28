library(ggplot2)
library(dplyr)


mpg <- mpg # preloaded data

# create canvas
ggplot(mpg)

# variables of interest mapped
ggplot(mpg, aes(x = displ, y = hwy))

# data plotted
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

# -------------------------------

iris <- iris # preloaded data


ggplot(iris) 

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) 

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point()

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, col = Species)) + # col = color
  geom_point()

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length)) + 
  geom_point(col = 'red')




#################################################################
##                    Exploring other geoms                    ##
#################################################################
# source: https://uc-r.github.io/ggplot_intro


# Left column: x and y mapping needed!
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth()


# Right column: no y mapping needed!
ggplot(mpg, aes(x = class)) +
  geom_bar()  

ggplot(mpg, aes(x = hwy)) +
  geom_histogram() 



# we can add geoms:
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

# specify different colors
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue") +
  geom_smooth(color = "red")






# color aesthetic passed to each geom layer
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  geom_smooth(se = FALSE)





# color aesthetic specified for only the geom_point layer
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE)
