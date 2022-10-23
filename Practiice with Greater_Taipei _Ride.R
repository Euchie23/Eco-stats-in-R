#if(!requireNamespace("remotes")) {
  #install.packages("remotes")
#}
#remotes::install_github("grimbough/FITfileR")

library(FITfileR)
library(tidyr)
library(dplyr)
library(leaflet)
library(grDevices)
library(RColorBrewer)

Greater_Taipei_ride <- readFitFile("Data/221001053555.fit")

GT_ride_records <- records(Greater_Taipei_ride)
GT_ride_records

# listMessageTypes(Greater_Taipei_ride)

## report the number of rows for each set of record messages
# vapply(GT_ride_records, FUN = nrow, FUN.VALUE = integer(1))

# merge all messages into one dataframe
GTride_allrecords <- records(Greater_Taipei_ride) %>% 
  bind_rows() %>% 
  arrange(timestamp()) %>% 
  drop_na() 
GTride_allrecords


# Getting long and lat coordinates
GTride_coords <- GTride_allrecords %>% 
  select(position_long, position_lat)
GTride_coords


#Making interactive map
GTride_map <- GTride_coords %>% 
  as.matrix() %>%
  leaflet(  ) %>%
  addTiles() %>%
  addPolylines( )
GTride_map


GTride_allrecords <- GTride_allrecords %>% 
  mutate(var = c(1:nrow(GTride_allrecords))) %>% 
  mutate(nextLat = lead(position_lat), 
         nextLng = lead(position_long)) %>% 
  filter(var < nrow(GTride_allrecords)) %>% 
  select(-var) %>% 
  mutate(speedRound = round(speed,1)) %>% 
  mutate(altitudeRound = round(altitude,2)) %>% 
  mutate(distanceRound = round(distance,1))



# Arrange Unique Speeds In Order 
speedIndex <- GTride_allrecords %>% 
  select(speedRound) %>%
  unique() %>% 
  arrange() 

speedIndex <- speedIndex %>% 
  mutate(rank = 1:nrow(speedIndex))

#Assign a color to each unique speed
gradientFunction <- colorRampPalette(c("blue4", 
                                       "blue", 
                                       "purple", 
                                       "gold", 
                                       "orangered", 
                                       "red"))

colorIndex <- as.data.frame(gradientFunction(nrow(speedIndex))) %>% 
  mutate(rank = 1:nrow(speedIndex))

#housekeeping
colnames(colorIndex) <- c("color", "rank")
colorIndex$color <- as.character(colorIndex$color)

#join into larger table
GTride_allrecords <- GTride_allrecords %>% 
  left_join(speedIndex, by = "speedRound") %>% 
  dplyr:::left_join.data.frame(colorIndex, by = "rank") 


# making map
gradient_map <- leaflet() %>% 
  addTiles() %>% 
addLegend(position="bottomleft", colors=colorIndex$color, labels=speedIndex$speedRound)  

for(i in 1:nrow(GTride_allrecords)) {
  gradient_map <- addPolylines(map = gradient_map,
                               data = GTride_allrecords,
                               lng = as.numeric(GTride_allrecords[i, c('position_long', 'nextLng')]),
                               lat = as.numeric(GTride_allrecords[i, c('position_lat', 'nextLat')]),
                               color = as.character(GTride_allrecords[i, c('color')])
  )
  
}

gradient_map 