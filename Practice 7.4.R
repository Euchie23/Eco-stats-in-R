#loading libraries ----
library(dplyr)
library(tidyr)


#preparing data
rairuoho <- read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/rairuoho.txt',header=T, sep='\t', dec = '.')
head(rairuoho_1)

rairuoho_1 <-rairuoho %>% mutate(treatment = as.factor(replace(treatment, treatment == 'nutrient', 'enriched')))%>%pivot_longer(day3:day8,names_to = "day", values_to = "length")%>%  unite("spatial coordinates", spatial1:spatial2, sep = "_")%>% dplyr::select(-row, -column)%>% mutate(treatment_no=as.numeric(rairuoho_1$treatment), .after=treatment)
head(rairuoho_1)

#making function to calculate t.score and p-value
my.t.test <- function(x, y){
  xy.1<-c()
  y.1<-c()
  x.1<-c()
  y.2<-c()
  x.2<-c()
  for (i in 1:length(x))  {
    x.1[i] <- x[i]-mean(x,na.rm=TRUE)
    x.2[i] <- x.1[i]^2
    for (j in 1:length(y))   {
      y.1[j] <- y[j]-mean(y,na.rm = TRUE)
      y.2[j] <- y.1[j]^2
      xy.1[i] <- x.1[i]*y.1[i]
    }
  }
  r<-sum(xy.1)/sqrt(sum(x.2)*sum(y.2))
  t<-r*sqrt((length(xy.1)-2)/(1-r^2))
  pval <- 2*pt(q=t, length(x) + length(y)-2)
   if (pval<=0.05) {
     print(paste("The difference in means is statistically significant, null hypothesis rejected"))
  } else{
     print(paste("The difference in means is NOT statistically significant, alternative hypothesis rejected"))
  }
  return(paste("t.score =", round(t, 3), ("   "),(paste("p-value =",abs(round(pval, 10))))))
}
my.t.test(rairuoho_1$length, rairuoho_1$treatment_no)
