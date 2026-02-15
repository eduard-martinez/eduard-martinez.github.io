## Eduard F. Martinez-Gonzalez
## Workshop Cienfi: Introduccion a Datos Espaciales en R

##==: 1. Configuracon Inicial

## clean environment
rm(list=ls())

## llamar pacman 
install.packages(pacman)
require(pacman)

## llamar y/o instalar librerias
p_load(tidyverse,    ## tidy data
       rio,          ## leer/escribir conjuntos de datos
       sf,           ## datos espaciales
       mapview,      ## visualizaciones
       tidygeocoder, ## geocodificar
       ggspatial,    ## mapas base en ggplot2 (tiles OSM, Stamen, Esri) 
       osmdata)      ## packages osm data

##==: 2. Geocodificar Direcciones

## obtener las coordenadas de una dirección
geo("" , method="arcgis") 

## Almacenar la dirección en un objeto
casa <- geo("" , method="arcgis") 

## Convertir el objeto a SF
?st_as_sf

## la función mapview adiciona la capa de OpenStreetMap
?mapview

##==: 3. Geocodificar Varias Direcciones

## leer base de datos
cali <- import("https://eduard-martinez.github.io/blog/intro_gis_in_r/data/data_cali.rds")
cali

## geocodificar vector de direcciones
cali <- geocode(cali , address="direccion" , method="arcgis")
cali

## convertir a objeto espacial
cali <- st_as_sf(x=cali , coords=c("long","lat") , crs=4326)

## visualizar puntos
mapview(cali)

##==: 4. Geocodificar Direcciones

## Ver features disponibles
available_features() %>% head(20)

## Ver tags de una feature
available_tags("amenity") %>% head(20)

## obtener bbox
opq(bbox = getbb("Cali Colombia"))

## construir consulta OSM
osm <- opq(bbox = getbb("Cali Colombia")) %>%
       add_osm_feature(key = "amenity", value = "restaurant")

## ejecutar consulta y convertir a sf


## extraer puntos


## visualizar restaurantes


## obtener polígono administrativo de Granada
granada <- getbb(place_name = "Granada, Cali", 
                 featuretype = "boundary:administrative", 
                 format_out = "sf_polygon")

mapview(granada)

## filtrar restaurantes dentro de Granada
?st_crop

## calcular distancias geodésicas
cali$dist <- st_distance(x=cali , y=icesi)
cali$dist <- as.numeric(cali$dist)/1000
cali %>% head()

## ggplot básico
ggplot() + geom_sf(data=cali , size=3)

## ggplot con variable
ggplot() + geom_sf(data=cali , aes(color=dist) , size=3)

## ggplot con escala viridis
ggplot() + 
geom_sf(data=cali , aes(color=dist) , size=3) +
scale_color_viridis_b(option = "D") +
theme_minimal()

## ggplot con fondo OSM
map <- ggplot() + 
       annotation_map_tile(type="osm" , zoom=14) +
       geom_sf(data=cali , aes(color=dist) , size=3) +
       scale_color_viridis_b(option = "D") +
       theme_minimal()
map 

## añadir elementos cartográficos
map +
annotation_north_arrow(location="tr" , which_north="true" , style=north_arrow_fancy_orienteering) +
annotation_scale(location = "bl", width_hint = 0.4) 



