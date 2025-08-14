rm(list = ls())
setwd("~/Documents/GITHUBs/UBA/DataViz/R_codes_forDashboard")
set.seed(123)  # For reproducibility


###
library(sf)
library(ggplot2)

###

link1="https://github.com/magallanes-at-UBA/DataViz/raw/main/"
link2="fromPython/fragilitymap.gpkg"

border=sf::st_read(paste0(link1,link2),layer = "border")

fragilityMap=sf::st_read(paste0(link1,link2), layer = "countries")

head(fragilityMap)

##
ggplot() + theme_void() +
geom_sf(data=border, color='grey') + 
    geom_sf(data=fragilityMap, aes(fill=cluster_label)) 

###
ggplot() + theme_void() +
geom_sf(data=border, color='grey') + 
    geom_sf(data=fragilityMap, aes(fill=cluster_label)) + 
      theme(legend.position = "bottom")


###
mapClus=ggplot() + theme_void() +
    geom_sf(data=border, color='grey') + 
    geom_sf(data=fragilityMap, aes(fill=cluster_label)) + 
    scale_fill_viridis_d(name = NULL) +
    theme(legend.position = "bottom")

mapClus

saveRDS(mapClus,file = 'dashboards/mapClus.rds')