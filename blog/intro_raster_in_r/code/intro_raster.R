
## Instalar/llamar las librerías de la clase
require(pacman) 
p_load(tidyverse,
       sf,
       osmdata,
       terra,
       mapview)

## Leer un archivo raster
nl_r <- rast("https://eduard-martinez.github.io/blog/intro_raster_in_r/data/night_light_202301.tif")

## Información general
nl_r          

## Visualización


## Obtener los límites administrativos de Cali desde OpenStreetMap
cali <- getbb(place_name = "Cali, Colombia", 
              featuretype = "boundary:administrative", 
              format_out = "sf_polygon")

## Seleccionar la segunda geometría
cali <- cali[2, ]

## Visualizar la geometría de Cali sobre un mapa interactivo
mapview(cali)

## Recortar el raster original (nl_r) usando el polígono de Cali
cali_r <- 

## Visualizar el raster recortado de Cali

## Guardar el raster recortado como archivo GeoTIFF en el disco
writeRaster(cali_r, "cali_recorte.tif", overwrite=T)

## Convertir el raster recortado en un data.frame, incluyendo las coordenadas (x, y)
df <- as.data.frame(cali_r, xy = TRUE)

# Leer archivo RDS que contiene los polígonos de manzanas censales de Cali
mnz <- read_rds("https://eduard-martinez.github.io/blog/intro_raster_in_r/data/manzanas_cali.rds") %>% 
       st_as_sf()

## Visualizar las primeras filas del objeto de manzanas
head(mnz)

## raster to sf
cali_sf <- as.polygons(cali_r) %>% st_as_sf()
st_crs(cali_sf) == st_crs(mnz)

## transformar el CRS
cali_sf <- st_transform(cali_sf , st_crs(mnz))

## unir los shapefiles
mnz_nl <- st_join(x=mnz , y=cali_sf)

## Visualizar resultado
mapview(mnz_nl, zcol = "night_light_201301")

## Convertir el objeto sf en un data.frame plano
df_nl <- as.data.frame(mnz_nl, geometry = NULL)
head(df_nl)

## Graficar relación entre población y luminosidad
ggplot(data = df_nl, 
       aes(x = log(personas), y = log(night_light_201301))) +
geom_point() +
geom_smooth(method="lm", se =T , color = "blue") +
theme_bw()

## regresion
lm(asinh(night_light_201301) ~ asinh(personas), data = df_nl)

