library("DataExplorer")
library(dplyr)

# source: https://towardsdatascience.com/four-r-packages-for-automated-exploratory-data-analysis-you-might-have-missed-c38b03d4ee16

# install.packages("tidyverse")
library(dplyr)
library(readr)


# read csv file
# https://www.kaggle.com/datasets/sulianova/cardiovascular-disease-dataset?resource=download
df <- read_delim(
    file = "00_data/cardio_train.csv",
    col_types = "iifidiiffffff",
    delim=";")


# pre-processing
df <- df %>% 
  # remove the id
  select(-id) %>%
  # age: days -> years
  mutate(age = round(age / 365))

# observe first rows
df

df %>%
  create_report(
    output_file = "Report - dataExplorer",
    #output_file = paste("Report", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"), sep=" - "),
    report_title = "EDA Report - Cardiovascular Disease Dataset",
    y = "cardio"
  )

# REPORT

# plots the dataset structure
plot_str(df)

# plots the bar chart for each discrete feature
plot_bar(df)

plot_bar(df, by="cardio")

# plots quantile-quantile for each continuous feature
plot_qq(df)

# plots density estimates for each continuous feature
plot_density(df)

# to visualize correlation heatmap
plot_correlation(df)

# performs Principal Component Analysis (PCA) and plots the percentage of variance explained by each principal component:
plot_prcomp(df) # 2 grqaphs


#install.packages("GGally")
library(GGally)

# change plot size (optional)
options(repr.plot.width = 20, repr.plot.height = 10)

df %>% 
  select("age", "cholesterol", "height", "weight") %>%
  ggpairs(mapping = aes(color = df$cardio, alpha = 0.5))


# Check this tutorial:
# https://cran.r-project.org/web/packages/DataExplorer/vignettes/dataexplorer-intro.html
