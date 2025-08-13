
rm(list = ls())
linkMap="https://github.com/Magallanes-at-UTDT/dataViz_2025/raw/refs/heads/main/fragilitymap.gpkg"

library(sf)

border=sf::st_read(linkMap,layer = "border")

fragilityMap=sf::st_read(linkMap, layer = "countries")

head(fragilityMap)

library(ggplot2)
mapClus=ggplot() + theme_void() +
geom_sf(data=border, color='grey') + geom_sf(data=fragilityMap, aes(fill=cluster_label))

mapClus
saveRDS(mapClus,file = 'mapClus.rds')