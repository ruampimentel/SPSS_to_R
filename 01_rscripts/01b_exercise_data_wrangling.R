
  


# Exercise - Let's Work together --------------------------------------------------



data_raw <- read_csv("00_data/deaf_numer.csv")
# (Try to do the following with dplyr functions.)
# 1. Create a `Group` variable: (the RA forgot to do it...)
#        - For Subject (`sID`) <= 15, Group should be 1,
#        - For Subject >  15, Group should be 2.
#    use `ifelse()` and `mutate()`




# 2. remove the first, practice block (Where block == 1). 
#     TIP: use filter()


# 3. remove error trials (where `acc` == 0)



# 4. Try doing steps 1-3 with the pipe (you can copy your solution and just
#   adjust it to work with the pipe.




# 5. Save that data to:
#        - an Rds file
#        - a csv file


# 6. Rewrite this ugly code using the pipe ( |> or %>% ):
diff(range(sample(head(iris[[1]], n = 10), size = 5, replace = TRUE)))







