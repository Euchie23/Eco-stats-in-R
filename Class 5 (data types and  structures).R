x <-4
typeof (x)
# returns 4 as a double (decimal) not an integer

y <- 4L
typeof(y)
# returns 4 as an integer when you add the L to it.

x1 <- c(TRUE, FALSE, FALSE, TRUE)
typeof(x1)
x2 <- c(1,0,0,1)
typeof(x2)
x3 <- as.logical(c(1,0,0,1))
typeof(x3)

a <- c("M", "F", "F", "U", "F", "M", "M", "M", "F", "U")
typeof(a) # mode character

a.fact <- as.factor(a)
a.fact
# gives levelsshoeing that there are only three groups of characters and the factors are shown in alphabetical order.

factor(a, level=c("U", "F", "M"))
# changes arrangement of how characters are arranged in the levels based on what you want.

mode(a.fact)
# mode is now numeric


library(datasets)
data("iris")

iris.sel<- subset(iris, Species == "setosa" | Species == "virginica")
levels(iris.sel$Species)  # 3 species are still there
# boxplot(Petal.Width ~ Species, iris.sel, horizontal = TRUE)

#need to ask about the dropped_levels.


#Null and NAs

x <- c(23, NA, 1.2, 5)
mean(x, na.rm=T)
# mean cannot be calculated with NA, NA has to first be removed.
y <- c(23, NULL, 1.2, 5)
mean(y)
# mean can be calculated with Null inside the dataset.
# When you subset within a list you need to use the double square brachets