
grow <- function (growth.rate, num_gene) { # argument "growth.rate" of function "grow" 
  num_gen<-num_gene
  generation<-1:num_gen
  N <- rep (0,num_gen)
  N[1] <- 1
  for (i in 2:num_gen) {
    N[i]=growth.rate*N[i-1] # not the use growth.rate argument
  }
  plot(N~generation,type='b', main=paste("Rate =", growth.rate,", ", num_gene, "generations")) 
}

grow(2, 10)



#6.2 

ex.grow <- function (growth.rate, num_gene) { # argument "growth.rate" of function "grow" 
  num_gen<-num_gene
  generation<-1:num_gen
  N <- rep (0,num_gen)
  N[1] <- 10
  for (i in 2:num_gen) {
    N[i]=N[i-1]+(growth.rate*N[i-1]*((100-N[i-1])/100)) # not the use growth.rate argument
    }
  plot(N~generation,type='b', main=paste("Rate =", growth.rate,", ", num_gene, "generations")) 
}

ex.grow(2.5,50)

saveGIF({
  for (i in 2:10) {
    ex.grow(i)
  }})
