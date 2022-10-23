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


#Preparing primary data----
SM_ride <- readFitFile("Data/220827075812.fit")


# Merging all messages into one dataframe----
SMride_allrecords <- records(SM_ride) %>% 
  bind_rows() %>% 
  arrange(timestamp()) %>% 
  drop_na() 
SMride_allrecords


# Modifying dataframe for construction of Speed and Altitude maps----
SMride_allrecords <- SMride_allrecords %>% 
  mutate(var = c(1:nrow(SMride_allrecords))) %>% 
  mutate(nextLat = lead(position_lat), 
         nextLng = lead(position_long)) %>% 
  filter(var < nrow(SMride_allrecords)) %>% 
  select(-var) %>% 
  mutate(speedRound = round(speed,1)) %>% 
  mutate(altitudeRound = round(altitude,2)) %>% 
  mutate(distanceRound = round(distance,1))
SMride_allrecords

# Getting long and lat coordinates----
SMride_allcoords <- SMride_allrecords %>% 
  select(position_long, position_lat)
SMride_allcoords


#Making interactive map----
SMride_allmap <- SMride_allcoords %>% 
  as.matrix() %>%
  leaflet(  ) %>%
  addTiles() %>%
  addPolylines( )
SMride_allmap



#Constructing speed map----

# Merging all messages into one dataframe----
SMride_spdrecords <- records(SM_ride) %>% 
  bind_rows() %>% 
  arrange(timestamp()) %>% 
  drop_na() 
SMride_spdrecords

# Making dataframe for construction of Speed map----
SMride_spdrecords <- SMride_spdrecords %>% 
  mutate(var = c(1:nrow(SMride_spdrecords))) %>% 
  mutate(nextLat = lead(position_lat), 
         nextLng = lead(position_long)) %>% 
  filter(var < nrow(SMride_spdrecords)) %>% 
  select(-var) %>% 
  mutate(speedRound = round(speed,1)) %>% 
  mutate(altitudeRound = round(altitude,2)) %>% 
  mutate(distanceRound = round(distance,1))
SMride_spdrecords

# Arrange Unique Speeds In Order----
speedIndex <- SMride_spdrecords %>% 
  select(speedRound) %>%
  unique() %>% 
  arrange() 

speedIndex <- speedIndex %>% 
  mutate(rank = 1:nrow(speedIndex))

#Assign a color to each unique speed----
gradientFunction <- colorRampPalette(c("blue", 
                                       "green", 
                                       "yellow", 
                                       "gold", 
                                       "orangered", 
                                       "red"))

colorIndex_spd <- as.data.frame(gradientFunction(nrow(speedIndex))) %>% 
  mutate(rank = 1:nrow(speedIndex))

#housekeeping
colnames(colorIndex_spd) <- c("color", "rank")
colorIndex_spd$color <- as.character(colorIndex_spd$color)

#join into larger table
SMride_spdrecords <- SMride_spdrecords %>% 
  left_join(speedIndex, by = "speedRound") %>% 
  dplyr:::left_join.data.frame(colorIndex_spd, by = "rank") 

# Making the speed map
spd_map <- leaflet() %>% 
  addTiles() 


for(i in 1:nrow(SMride_spdrecords)) {
  spd_map <- addPolylines(map = spd_map,
                               data = SMride_spdrecords,
                               lng = as.numeric(SMride_spdrecords[i, c('position_long', 'nextLng')]),
                               lat = as.numeric(SMride_spdrecords[i, c('position_lat', 'nextLat')]),
                               color = as.character(SMride_spdrecords[i, c('color')])
  )
  
}

spd_map  %>%
  addLegend("bottomright", 
            colors = c("blue",  "green", "yellow", "gold", "orangered","red"),
            labels = c('0-4kph','5-9kph','10-14kph', '15-19kph', '20-24kph', '> 25kph'),
            title = "Speed",
            opacity = 1)
#Preparing data for altitude map----

# Merging all messages into one data frame for altitude map----
SMride_altrecords <- records(SM_ride) %>% 
bind_rows() %>% 
  arrange(timestamp()) %>% 
  drop_na() 
SMride_altrecords


# Modifying dataframe for construction of Altitude map----
SMride_altrecords <- SMride_altrecords %>% 
  mutate(var = c(1:nrow(SMride_altrecords))) %>% 
  mutate(nextLat = lead(position_lat), 
        nextLng = lead(position_long)) %>% 
  filter(var < nrow(SMride_altrecords)) %>% 
  select(-var) %>% 
  mutate(speedRound = round(speed,1)) %>% 
  mutate(altitudeRound = round(altitude,2)) %>% 
  mutate(distanceRound = round(distance,1))


# Arrange Unique Altitudes In Order ----
altIndex <- SMride_altrecords %>% 
  select(altitudeRound) %>%
  unique() %>% 
  arrange() 

altIndex <- altIndex %>% 
  mutate(rank = 1:nrow(altIndex))

#Assign a color to each unique altitude (blue low, red high)----
gradientFunction <- colorRampPalette(c("#09387A", 
                                       "#126CB3",
                                       "#E9B851",
                                       "#E98D2B",
                                       "#E5493A",
                                       "#B23227"))

colorIndex_alt <- as.data.frame(gradientFunction(nrow(altIndex))) %>% 
  mutate(rank = 1:nrow(altIndex))

#housekeeping (alt)----
colnames(colorIndex_alt) <- c("color", "rank")
colorIndex_alt$color <- as.character(colorIndex_alt$color)

#join into larger table(alt)----
SMride_altrecords <- SMride_altrecords %>% 
  left_join(altIndex, by = "altitudeRound") %>% 
  left_join(colorIndex_alt, by = "rank") 


#PLOT Altitude MAP---- 
alt_map <- leaflet() %>% 
  addTiles() 


for(i in 1:nrow(SMride_altrecords)) {
  alt_map <- addPolylines(map = alt_map,
                          data = SMride_altrecords,
                          lng = as.numeric(SMride_altrecords[i, c('position_long', 'nextLng')]),
                          lat = as.numeric(SMride_altrecords[i, c('position_lat', 'nextLat')]),
                          color = as.character(SMride_altrecords[i, c('color')])
  )
  
}

alt_map %>%
  addLegend("bottomright", 
            colors = c("#09387A",  "#126CB3", "#E9B851", "#E98D2B", "#E5493A","#B23227"),
            labels = c('0-400m','401-800m','801-1200m', '1201-1600m', '1601-1800m', '1801-2400m'),
            title = "Altitude",
            opacity = 1)



