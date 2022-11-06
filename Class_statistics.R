install.packages("psych")


#Loading libraries
library (psych)
library (datasets)
library(dplyr)
library(ggplot2)
# students data set url 
students<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/students.txt',header=T, sep="\t", dec='.') 
# to write it:
write.table(students, file = "Data/students.txt", sep = "\t", row.names=T)

#summary(students)
#psych::describe(students)
psych::describeBy(students, students$gender)

plot1 <-ggplot(iris, aes(x=Species, y=Sepal.Length)) + 
  geom_boxplot()

plot2 <-ggplot(iris, aes(x=Species, y=Sepal.Width)) + 
  geom_boxplot() 

plot3 <-ggplot(iris, aes(x=Species, y=Petal.Length)) + 
  geom_boxplot() 

plot4 <-ggplot(iris, aes(x=Species, y=Petal.Width)) + 
  geom_boxplot() 

grid.arrange(plot1, plot2,plot3, plot4, ncol=2)

describeBy (iris, iris$Species)

psych::describeBy (iris,iris$Species)

iris %>% group_by(Species) %>% summarise(across(c(1:4), length))
#or
aggregate(iris[,1:4],by=list(iris$Species), median)
#or
tapply(iris$Sepal.Length , iris$Species, mean)
