#loading libraries ----
library(dplyr)
library(tidyr)


#preparing data
rairuoho <- read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/rairuoho.txt',header=T, sep='\t', dec = '.')
head(rairuoho)

rairuoho_1 <-rairuoho %>% mutate(treatment = as.factor(replace(treatment, treatment == 'nutrient', 'enriched')))%>%  unite("spatial coordinates", spatial1:spatial2, sep = "_")%>% dplyr::select(-row, -column)%>% mutate(treatment_no= as.numeric(treatment), .after=treatment)
head(rairuoho_1)

#making function to calculate t.score and p-value
my.t.test <- function(x, y){
  xy.1<-c()
  y.1<-c()
  x.1<-c()
  y.2<-c()
  x.2<-c()
  if (class(x) != "numeric") {
    x <- as.numeric(x)
    for (i in 1:length(x))  {
      x.1[i] <- x[i]-mean(x,na.rm=TRUE)
      x.2[i] <- x.1[i]^2 }
  }else{
    for (i in 1:length(x))  {
      x.1[i] <- x[i]-mean(x,na.rm=TRUE)
      x.2[i] <- x.1[i]^2
    }
  }
  if (class(y) != "numeric") {
    y <- as.numeric(y)  
    for (j in 1:length(y))   {
      y.1[j] <- y[j]-mean(y,na.rm = TRUE)
      y.2[j] <- y.1[j]^2}
  } else {
    for (j in 1:length(y))   {
      y.1[j] <- y[j]-mean(y,na.rm = TRUE)
      y.2[j] <- y.1[j]^2}
  }
  for (i in 1:length(x.1)) {
    for (j in 1:length(y.1)) 
      xy.1[i] <- x.1[i]*y.1[i]
  }
  df <- (length(x)/2 + length(y)/2)-2
  r<-sum(xy.1)/sqrt(sum(x.2)*sum(y.2))
  t<-r*sqrt((length(xy.1)-2)/(1-r^2))
  pval <- 2*pt(-abs(t), df)
  if (pval<= 0.05) {
    print(paste("The difference in means is statistically significant, null hypothesis rejected"))
  } else{
    print(paste("The difference in means is NOT statistically significant, alternative hypothesis rejected"))
  }
  return(paste("t.score =", round(t, 4), ("   "),(paste("df =", df)),("   "),(paste("p-value =", round(pval, 10)))))
}
my.t.test(rairuoho_1$day3, rairuoho_1$treatment_no)
my.t.test(rairuoho_1$day4, rairuoho_1$treatment_no)
my.t.test(rairuoho_1$day5, rairuoho_1$treatment_no)
my.t.test(rairuoho_1$day6, rairuoho_1$treatment_no)
my.t.test(rairuoho_1$day7, rairuoho_1$treatment_no)
my.t.test(rairuoho_1$day8, rairuoho_1$treatment_no)
t.test(rairuoho_1$day8, rairuoho_1$day3)
t.test(rairuoho_1$day4 ~ rairuoho_1$day3)

my.t.test(rairuoho_1$day8, rairuoho_1$day3)
x<- rairuoho_1$day8
y<- rairuoho_1$day3