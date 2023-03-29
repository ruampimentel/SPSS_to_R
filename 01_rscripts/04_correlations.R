
# loading packages
library(dplyr)
library(psych)

# The corr.test() function produce a output similar to SPSS
head(bfi)

# looking at the data
df <- bfi %>% as_tibble()
df %>% glimpse()

# Let's check the correlation between all items of neuroticism
# same result
df %>% select(N1, N2, N3, N4, N5)
df %>% select(N1:N5)
df %>% select(starts_with("N"))

neuroticism <- df %>% select(N1, N2, N3, N4, N5)


cor <- neuroticism %>% corr.test() 
cor
class(cor)
str(cor)

# The output is a list object containing multiple datasets. You can visualize it
# just running the object name (in this case, I called it "cor"),
# or you can visualize it data frame by itself by calling it from the list.
# to access dataframes with a list, you use the "$" sign.

# See each dataframe separated.
cor$r
cor$n
cor$p

# round to two decimal places
round(cor$r, 2)    # same output
cor$r %>% round(2) # same output



# To export to excel, one of the easiest ways, is creating another list 
# only with the objects you want. 
list_cor <- list(r = cor$r,
                 n = cor$n,
                 p = cor$p)

# then, use openxlsx::write.xlsx to export all dataframes at one for a single 
# Excel file. Each object of the list will be a different sheet in the excel file. 
# To put all of them in the same sheet, it requires a bit more work.
library(openxlsx)
write.xlsx(list_cor, "cor_test.xlsx")






#################################################################
##                      easystats package                      ##
#################################################################


# using easystats syntax ----
library(correlation)

neuroticism <- df %>% select(N1, N2, N3, N4, N5)

neuroticism %>% correlation() # see obs about adjustment method.
neuroticism %>% correlation() %>% summary()
neuroticism %>% correlation() %>% summary(redundant = T)



## treat as a dataframe.
neuroticism %>% correlation() %>% arrange(r)
neuroticism %>% correlation() %>% arrange(-r)






# correlation by group using easystats -----
df %>% 
  select(N1:N5, gender) %>% 
  group_by(gender) %>% 
  correlation() 

df %>% 
  select(N1:N5, gender) %>% 
  group_by(gender) %>% 
  correlation() 



