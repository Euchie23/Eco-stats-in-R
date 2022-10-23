#PLot the world
library(maptools)
library(leaflet)
data(wrld_simpl) 
plot(wrld_simpl)
plot(wrld_simpl,xlim=c(100,130),ylim=c(-20,50),col='olivedrab3',bg='lightblue')

plot(wrld_simpl,xlim=c(115,128),ylim=c(19.5,27.50),col='olivedrab3',bg='lightblue')