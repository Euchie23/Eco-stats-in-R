#loading library----
library(tidyr)
library(dplyr)


# Constructing dataframe----
subjects   <- c("subject_1", "subject_2", "subject_3","subject_4", "subject_5" )
before_diet<- c(104, 95, 87, 77, 112 )
after_diet <- c(96, 91, 81, 75, 118)
bubbleTdiet0 <- data.frame(subjects, before_diet, after_diet)

#reformating dataframe---
bubbleTdiet1<-data.frame(bubbleTdiet0%>%pivot_longer(before_diet:after_diet,names_to = "time_of_measurement", values_to = "weight"))
bubbleTdiet<- mutate_at(bubbleTdiet1, vars(time_of_measurement), as.factor)# putting time of measurement column as factor.


# constructing character and numeric vectors (weight loss %) from 'bubbleTdiet'----
char_vec <- bubbleTdiet0$subjects[c(1:5)]
num_vec <- as.numeric(round((bubbleTdiet0$before_diet-bubbleTdiet0$after_diet)/bubbleTdiet0$before_diet*100, digits = 0)) # rounding of the decimal points to '0'
num_vec_p<- paste(num_vec,"%",sep = "")#adding '%' sign to figures

# constructing table with two columns char_vec and num_vec.
weight_loss_tbl <- data.frame(char_vec, num_vec)
colnames(weight_loss_tbl) <- c('subjects','weight_loss')



#constructing a message to add to the list BUBBLE_DIET 
message <- 'Manipulating data in R is so much fun!'



# storing previous 4 elements in a list called WEIGHT_LOSS
WEIGHT_LOSS <- list(char_vec=char_vec, num_vec=num_vec, num_vec_p=num_vec_p,weight_loss_tbl=weight_loss_tbl)

# Storing previous three elements in a list called BUBBLE_DIET----
BUBBLE_DIET <- list(bubbleTdiet=bubbleTdiet,WEIGHT_LOSS=WEIGHT_LOSS, message=message)
