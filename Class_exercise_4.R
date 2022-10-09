library(dplyr)
select1 <- dplyr::select(iris, Sepal.Length, Sepal.Width)
head(select1)
select2<-dplyr::select(iris, Sepal.Length:Petal.Width)
head(select2,2)
setosa <- iris[setosa]
filtered1<-filter(iris,Species=="setosa")
filtered1
filtered2<-filter(iris, Species=="versicolor",Sepal.Width>3)
filtered2
filtered3<-filter(iris, Species=="versicolor", Sepal.Width>2.5, Sepal.Length>5.0)
filtered3
tail(filtered3)
filtered3[c(33:35), c(1,3)]# calling out specific rows and columns
mutated1<-mutate(iris, Greater.Half= Sepal.Width > 0.5* Sepal.Length)
table(mutated1$Greater.Half)# to check how many reach the criteria you stated in mutated1 object
table(iris$.)
arranged1 <- arrange(iris, Sepal.Width) #arranges in ascending order based off Sepal.width
arranged1
arranged2 <- arrange(iris, desc(Sepal.Width))#arranges in descending order
arranged2
group1 <- group_by(iris, Species) # I want to group by species.
group1
gp.mean <-summarise(group1, Mean.Sepal = mean(Sepal.Width), Mean.Petal=mean(Petal.Width))
gp.mean
# %>% = PIPE operator will let you do many functions in just one line like the example below to arrange and filter information fdrom the same dataset
Object1<-iris%>%arrange(iris$Sepal.Width)%>%filter(Species=="setosa", Sepal.Width>3)
Object1

library(tidyr)
getwd()
TW_Corals<-read.table("Data/tw_corals.txt", header=T, sep='\t', dec = '.')
TW_Corals
TW_Corals_long<-TW_Corals%>%pivot_longer(Southern_TW:Northern_Is,names_to = "Region", values_to = "Richness")
head(TW_Corals_long)
TW_Corals_wide<-pivot_wider(TW_Corals_long,names_from = "Region", values_from = "Richness")
income<-read.table("Data/metoo.txt", header=T, sep='\t', dec = '.', na.strings = "n/a")
income
income_long<-income%>%pivot_longer(cols=-state, names_to = c("gender", "work_type"), values_to = "income", names_sep = "_") #changing it to a long version.
income_long
income_wide<-income_long%>%pivot_wider(names_from = c("gender", "work_type"), values_from = "income", names_sep = "") # to return to previous table version
income_wide
