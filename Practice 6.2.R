#loading libraries----
library(ggplot2)
library (gganimate)

grow<-function(start_1,start_2){
  num_gen<-30
  N1 <- rep(0,10)
  N2 <- rep(0,10)
  generation<-1:num_gen
  growth.rate<-1.2
  K1<-100
  K2<-120
  a12<-0.8
  a21<-0.8
  N1[1]<-start_1
  N2[1]<-start_2
  for (i in 2:num_gen)  {
    N1[i] = N1[i-1] + (growth.rate* N1[i-1] * ((K1-N1[i-1]-(a12*N2[i-1]))/K1))
    N2[i] = N2[i-1] + (growth.rate * N2[i-1] * ((K2-N2[i-1]-(a21*N1[i-1]))/K2))
    generation[1]=1
    print (N1[i])
  }
if (N1[1]>2){
  plot(N1~generation,typ="b",ylim=c(0,max(c(K1,K2))),ylab="N") 
}  else {
  plot(N1~generation,typ="n",ylim=c(0,max(c(K1,K2))), ylab="N")
}
print(N2[1])
if (N2[1]>0){
  lines(N2~generation,typ="b",col=2)}
}

  par(mar=c(9,4,1,1),mfrow=c(3,1),las=1)

  grow(1,0)
  text(4,110,"Species 1 alone")
  
  grow(0,1)
  text(4,110,"Species 2 alone")
  
  grow(2.5,2)
  text(6,110,"Both Species competing")
  
  
  LV<-NULL
  LV$spe_1<-N1
  LV$spe_2<-N2
  LV$generation<-generation
  LV<-as.data.frame(LV)
  
  p <- ggplot(LV, aes(x = generation, y=spe_1, size =2)) +
    geom_point(show.legend = FALSE, alpha = 0.7) +
    scale_color_viridis_d() +
    scale_size(range = c(0, 12)) +
    labs(x = "Generation", y = "Individuals")
  
  p + transition_time(generation) +
    labs(title = "Generation: {frame_time}") +
    shadow_wake(wake_length = 0.2, alpha = FALSE)