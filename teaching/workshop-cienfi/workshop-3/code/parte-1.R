##============================================================================##
# workshop-03_parte-1.R  —  Introduccion a Raster: Sentinel-2 en el sur de Cali
#------------------------------------------------------------------------------#
# Qué lee y qué produce:
#   - lee: data/sentinel_pance.tif (imagen Sentinel-2 del 18-ago-2024 sobre el
#          sur de Cali: Pance, Ciudad Jardin y alrededores; 5 bandas en
#          reflectancia (0-1) a 10 metros: azul (B02), verde (B03), rojo (B04),
#          nir (B08) y swir (B11))
#   - produce: output/pance_rgb.png       (composicion en color verdadero)
#   - produce: output/pance_ndvi.png      (mapa del indice de vegetacion)
#   - produce: output/pance_ndbi.png      (mapa del indice de construccion)
#   - produce: output/indices_lugares.rds (grano: lugar; NDVI y NDBI promedio
#              en un buffer de 200 metros)
##============================================================================##

## configuracion inicial
rm(list = ls())

## llamar y/o instalar librerias
require(pacman)
p_load(tidyverse, ## tidy data
       sf,        ## datos espaciales vectoriales
       terra,     ## datos espaciales raster
       mapview,   ## visualizaciones interactivas
       rio)       ## leer/escribir conjuntos de datos

##============================================================================##
##=== 1. Leer y entender un raster                                         ===##
##============================================================================##

## leer las 5 bandas de la imagen
pance <- rast("data/sentinel_pance.tif")
pance

## atributos basicos del raster
nlyr(pance)   ## numero de bandas
res(pance)    ## resolucion: 10m x 10m
ext(pance)    ## extension (coordenadas en metros)
crs(pance)    ## sistema de referencia: WGS84 / UTM zona 18N (EPSG:32618)

## cada banda mide la reflectancia en una longitud de onda distinta
names(pance)

## seleccionar una banda por su nombre
pance[["nir"]]

## visualizar todas las bandas (una escala de color por banda)
plot(pance)

## visualizar una sola banda: la vegetacion refleja mucho el infrarrojo cercano
plot(pance[["nir"]])

## distribucion de los valores de reflectancia de cada banda
hist(pance)

##============================================================================##
##=== 2. Composiciones RGB                                                 ===##
##============================================================================##

## color verdadero: rojo=banda 3, verde=banda 2, azul=banda 1
plotRGB(pance, r = 3, g = 2, b = 1, stretch = "lin")

## falso color: el infrarrojo en el canal rojo resalta la vegetacion
plotRGB(pance, r = 4, g = 3, b = 2, stretch = "lin")

## export mapa
png("output/pance_rgb.png", width = 1000, height = 1070)
plotRGB(pance, r = 3, g = 2, b = 1, stretch = "lin")
dev.off()

##============================================================================##
##=== 3. Indice de vegetacion (NDVI)                                       ===##
##============================================================================##

## algebra de bandas: NDVI = (nir - rojo) / (nir + rojo)
ndvi <- (pance[["nir"]] - pance[["rojo"]]) / (pance[["nir"]] + pance[["rojo"]])
names(ndvi) <- "ndvi"
ndvi

## valores cercanos a 1 = vegetacion densa; cercanos a 0 = construido o suelo
plot(ndvi)

## raster a data.frame con las coordenadas de cada celda
df_ndvi <- as.data.frame(ndvi, xy = T)

## mapa del ndvi en ggplot
ggplot() +
geom_raster(data = df_ndvi, aes(x = x, y = y, fill = ndvi)) +
scale_fill_distiller(palette = "RdYlGn", direction = 1, name = "NDVI") +
coord_fixed() +
labs(x = NULL, y = NULL) +
theme_minimal()

## export mapa
ggsave("output/pance_ndvi.png", width = 7, height = 7.5, dpi = 300)

##============================================================================##
##=== 4. Indice de construccion (NDBI)                                     ===##
##============================================================================##

## las superficies construidas reflejan mas el swir que el infrarrojo cercano:
## NDBI = (swir - nir) / (swir + nir)
ndbi <- (pance[["swir"]] - pance[["nir"]]) / (pance[["swir"]] + pance[["nir"]])
names(ndbi) <- "ndbi"

## valores altos = zonas urbanizadas; valores bajos = vegetacion
plot(ndbi)

## los dos indices son un espejo: donde hay verde no hay construccion
plot(c(ndvi, ndbi))

## mapa del ndbi en ggplot
df_ndbi <- as.data.frame(ndbi, xy = T)

ggplot() +
geom_raster(data = df_ndbi, aes(x = x, y = y, fill = ndbi)) +
scale_fill_viridis_c(option = "magma", name = "NDBI") +
coord_fixed() +
labs(x = NULL, y = NULL) +
theme_minimal()

## export mapa
ggsave("output/pance_ndbi.png", width = 7, height = 7.5, dpi = 300)

##============================================================================##
##=== 5. Cruce raster-vector  (grano: lugar)                               ===##
##============================================================================##

## lugares de interes (coordenadas geocodificadas previamente, ver workshop 01)
lugares <- tribble(~lugar,              ~long,     ~lat,
                   "Universidad Icesi", -76.52960, 3.34165,
                   "Jardin Plaza",      -76.52756, 3.36878,
                   "Club Campestre",    -76.54379, 3.36688)

## convertir a sf y llevar al CRS del raster (UTM 18N, en metros)
lugares <- st_as_sf(lugares, coords = c("long", "lat"), crs = 4326) %>%
           st_transform(crs(pance))

## buffer de 200 metros alrededor de cada lugar
lugares_buffer <- st_buffer(lugares, dist = 200)

## visualizar los buffers sobre el indice de vegetacion
mapview(ndvi) + mapview(lugares_buffer)

## extract() identifica las celdas que caen dentro de cada buffer y les
## aplica una funcion (aca el promedio); en la parte 2 haremos este cruce
## "a mano" convirtiendo las celdas del raster en poligonos sf
indices_lugares <- extract(c(ndvi, ndbi), lugares_buffer, fun = mean, na.rm = T)

## organizar la tabla: un lugar por fila con sus dos indices
indices_lugares <- lugares_buffer %>%
                   as.data.frame(geometry = NULL) %>%
                   bind_cols(indices_lugares) %>%
                   select(lugar, ndvi, ndbi)
indices_lugares

## export data
export(indices_lugares, "output/indices_lugares.rds")
