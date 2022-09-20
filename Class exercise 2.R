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

Setosa <-iris$Species=='setosa'
SetosaDF <-iris[Setosa,]

Versicolor <-iris$Species=='versicolor'
VersicolorDF <-iris[Versicolor,]

Virginica <-iris$Species=='virginica'
VirginicaDF <-iris[Virginica,]
