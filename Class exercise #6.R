library (datasets)
head(iris)
plot(iris$Petal.Length)
plot(iris$Petal.Width)
plot(iris$Petal.Length ~ iris$Petal.Width) #or plot(Petal.Length ~ Petal.Width, data = iris)

#customization
plot(Petal.Length ~ Petal.Width, data = iris, 
  xlab = 'Petal width (cm)',
  ylab = 'Petal length (cm)',
  main = "Petal length and width of iris flower",
  pch = 7, cex=2,
  col = rgb (1,0,0,0.10))# 0.10 makes it transparent.



col.iris<-ifelse(iris$Species=='setosa','purple',ifelse(iris$Species=='versicolor','blue','pink')) 
col.iris


plot(Petal.Length ~ Petal.Width, data = iris, 
     xlab = 'Petal width (cm)',
     ylab = 'Petal length (cm)',
     main = "Petal length and width of iris flower",
     pch = 7, cex=2,
     col = col.iris)
     

plot(Petal.Length ~ Petal.Width, data = iris, 
     xlab = 'Petal width (cm)',
     ylab = 'Petal length (cm)',
     main = "Petal length and width of iris flower",
     pch = 7, cex=2,
     col = scales::alpha(col.iris, 0.2)) # 0.2 makes it transparent

#col.iris.hexa <- scales::alpha(col.iris,0.2)
#col.iris.hexa <- as.factor(col.iris.hexa)
#levels(col.iris.hexa)

plot(Petal.Length ~ Petal.Width, data = iris, 
     xlab = 'Petal width (cm)',
     ylab = 'Petal length (cm)',
     main = "Petal length and width of iris flower",
     pch = 7, cex=2,
     col = scales::alpha(col.iris, 0.2)) 

legend(x="bottomright", pch= 7, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))

plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5,
     pch = 7, cex=2, las=1,
     col = scales::alpha(col.iris, 0.2))

legend(x="bottomright", pch= 7, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))


ratio<-iris$Petal.Length/iris$Sepal.Width  # ratio between the length of petal and the width of Sepal
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5,
     pch = 7, las=1, cex= ratio * 2, 
     col = scales::alpha(col.iris, 0.2))

legend(x="bottomright", pch= 7, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))

#PAIRS
# panel plot

pairs(iris[1:4], pch=7, col = scales::alpha(col.iris, 0.2))