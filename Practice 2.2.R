# Student name: Euchie Jn Pierre
# Student ID: R10H44002

#loading libraries ----
library(dplyr)
library(tidyverse)
library(knitr)


# Preparing data ----
rairuoho <- read.delim ('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/rairuoho.txt')

# Manipulating data ----
# replacing 'nutrient' with 'enriched' within treatment
rairuoho_1 <- rairuoho %>% mutate(treatment = replace(treatment, treatment == 'nutrient', 'enriched'))

# reformatting 'day' as a single variable containing 6 levels and placing values into new 'length' variable.
rairuoho_1<-rairuoho_1%>%pivot_longer(day3:day8,names_to = "day", values_to = "length")

# combining two columns (spatial1 and spatial2) into one column
rairuoho_2 <- rairuoho_1 %>%  unite("spatial coordinates", spatial1:spatial2, sep = "_")

# removing variables 'row' and 'column'
rairuoho_3 <- dplyr::select(rairuoho_2, -row, -column)


# Combination of above code using the PIPE operator----
rairuoho_3_1 <- rairuoho %>% mutate(treatment = replace(treatment, treatment == 'nutrient', 'enriched'))%>%pivot_longer(day3:day8,names_to = "day", values_to = "length")%>%  unite("spatial coordinates", spatial1:spatial2, sep = "_")%>% dplyr::select(-row, -column)
