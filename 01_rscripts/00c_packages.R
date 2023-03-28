# only the first time - Downloading the 'app' into your phone
install.packages("dplyr") # need quotation marks

# every time you restart R session - Opening the 'app' in your phone to use
library("dplyr")    # works with and 
library(dplyr)      # without quotation marks



# getting help
help.start()   # general help
help(dplyr)      # help about function foo
?dplyr           # same thing
# F1 key


# Install all packages for this workshop

install.packages(c("tidyverse", "easystats", 
                   "visdat", "dplyr",
                   "ggplot2", "naniar",
                   "haven", "readxl","writexl",
                   "nycflights13","rstatix",
                   "psych", "openxlsx",
                   "effectsize", "parameters", 
                   "performance", "ggeffects",
                   "afex", "emmeans", "effectsize", 
                   "ggeffects", "datawizard",
                   "bayestestR", "pwr",
                   "lavaan", "DataExplorer",
                   "readr"))

