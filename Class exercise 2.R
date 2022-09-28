# Manipulation (in class version)
rm(list = ls())

library(datasets)
data("iris")
head(iris)

str(iris)
summary (iris)

XQuartz(iris)
fix(iris)

# Selection
iris <- iris

Setosa <- iris[c(1:50),]
Versicolor <- iris[c(51:100),]
Virginica <- iris[c(101:150),]
str(iris)


#recoding
species <- ifelse(iris$Species=="setosa", 'daisy', )



#sorting
ind_1 <- order(iris$Sepal.Length)
ind_1


Setosa <-iris$Species=='setosa'
SetosaDF <-iris[Setosa,]

Versicolor <-iris$Species=='versicolor'
VersicolorDF <-iris[Versicolor,]

Virginica <-iris$Species=='virginica'
VirginicaDF <-iris[Virginica,]

flower_colors <- ifelse (iris$Species=='setosa','purple', ifelse (iris$Species=='versicolor', 'blue','red')) #data for new column

iris[,6] <- flower_colors #adding a new column to the data frame.
colnames(iris)[6]='FlowerColors' #renaming the new colomn

#reordering
ind2 <-iris[order(iris$Sepal.Width, decreasing = T),]

VersicolorDF [,6] <- NULL # removing column number 6
VersicolorDF

flower_colors

Quartz()
fix(iris)
iris
sep.w
