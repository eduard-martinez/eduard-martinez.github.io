##============================================================================##
# workshop-03_parte-2.R  —  Luces Nocturnas (VIIRS) + Puntos de Google Maps en Cali
#------------------------------------------------------------------------------#
# Qué lee y qué produce:
#   - lee: data/nl_cali_viirs.tif  (VIIRS mensual 2012-04 a 2025-10 recortado al
#          perimetro urbano de Cali; 162 bandas, una por mes)
#   - lee: data/puntos_maps.rds    (19.081 establecimientos de Google Maps en
#          Cali: nombre, categoria, resenas, calificacion y ubicacion)
#   - produce: output/serie_luz_cali.rds (grano: mes; luz promedio en Cali)
#   - produce: output/puntos_luz.rds     (grano: establecimiento; con la luz
#              promedio de 2024 de la celda que lo contiene)
##============================================================================##

## configuracion inicial
rm(list = ls())

## llamar y/o instalar librerias
require(pacman)
p_load(tidyverse, ## tidy data (incluye lubridate y ggplot2)
       sf,        ## datos espaciales vectoriales
       terra,     ## datos espaciales raster
       osmdata,   ## limites administrativos desde OpenStreetMap
       mapview,   ## visualizaciones interactivas
       rio)       ## leer/escribir conjuntos de datos

##============================================================================##
##=== 1. Leer y entender el stack de VIIRS  (grano: celda x mes)           ===##
##============================================================================##

## el producto original de VIIRS cubre Colombia; este stack ya viene recortado
## al perimetro urbano de Cali y con el control de calidad aplicado: pixel-mes
## sin observaciones libres de nube -> NA y ruido negativo del sensor -> 0
nl_cali <- rast("data/nl_cali_viirs.tif")
nl_cali

## en la parte 1 las bandas eran colores; aca cada banda es un MES (aaaamm)
head(names(nl_cali))
tail(names(nl_cali))

## seleccionar un mes por el nombre de la banda
nl_cali[["202001"]]

## visualizar un mes
plot(nl_cali[["202001"]])

## comparar el primer y el ultimo enero de la serie
plot(nl_cali[[c("201301", "202501")]])

##============================================================================##
##=== 2. El perimetro urbano de Cali (OpenStreetMap)                       ===##
##============================================================================##

## en el workshop 02 este poligono recorto el raster de Colombia; aca lo
## usaremos para verificar los puntos y enmascarar los cruces
cali <- getbb(place_name = "Cali, Colombia",
              featuretype = "boundary:administrative",
              format_out = "sf_polygon")

## seleccionar la segunda geometria (perimetro urbano)
cali <- cali[2, ]
mapview(cali)

##============================================================================##
##=== 3. La dimension temporal: luz promedio por mes  (grano: mes)         ===##
##============================================================================##

## promedio de todas las celdas de Cali, mes a mes
serie <- global(nl_cali, "mean", na.rm = T)
head(serie)

## organizar como tibble con fecha
serie_luz <- serie %>%
             rownames_to_column("mes") %>%
             transmute(fecha = ym(mes),
                       luz   = mean)

## evolucion 2012-2025: note la caida durante la cuarentena de 2020
ggplot(serie_luz, aes(x = fecha, y = luz)) +
geom_line(color = "grey40") +
geom_point(size = 0.8) +
geom_vline(xintercept = ym("202004"), color = "red", linetype = "dashed") +
annotate("text", x = ym("202004"), y = max(serie_luz$luz),
         label = "cuarentena", color = "red", hjust = -0.1) +
labs(x = NULL, y = "Luz promedio (nW/cm2/sr)") +
theme_minimal()

## export data
export(serie_luz, "output/serie_luz_cali.rds")

##============================================================================##
##=== 4. Puntos de Google Maps  (grano: establecimiento)                   ===##
##============================================================================##

## establecimientos extraidos de Google Maps: nombre, categoria buscada,
## numero de resenas, calificacion y la geometria del punto (WGS84)
puntos <- read_rds("data/puntos_maps.rds")
head(puntos)

## los puntos ya vienen dentro del perimetro urbano; el filtro espacial
## lo confirma (en datos crudos este paso descarta puntos mal geocodificados)
nrow(puntos)
puntos <- st_filter(puntos, cali)
nrow(puntos)

## visualizar una categoria
mapview(filter(puntos, str_detect(categoria, "Cancha")))

##============================================================================##
##=== 5. Cruce 1, del raster a los puntos  (grano: establecimiento)        ===##
##============================================================================##

## colapsar los 12 meses de 2024 en una capa de luz promedio
luz_2024 <- mean(nl_cali[[paste0("2024", sprintf("%02d", 1:12))]], na.rm = T)
names(luz_2024) <- "luz_2024"
plot(luz_2024)

## para que el cruce sea transparente: convertir cada celda del raster en un
## poligono sf que carga su valor de luz (misma logica del workshop 02)
celdas <- as.polygons(luz_2024, aggregate = F, round = F) %>%
          st_as_sf()
head(celdas)
mapview(celdas, zcol = "luz_2024")

## revisar que los dos objetos comparten el CRS
st_crs(celdas) == st_crs(puntos)

## union espacial: cada punto hereda el valor de la celda que lo contiene
puntos <- st_join(x = puntos, y = celdas)
head(puntos)

## extract() hace el mismo cruce en una sola linea; compruebe la equivalencia
luz_extract <- extract(luz_2024, puntos)$luz_2024
all.equal(puntos$luz_2024, luz_extract)

## luz promedio por categoria ("googleame" es una etiqueta de la fuente)
luz_categoria <- puntos %>%
                 as.data.frame(geometry = NULL) %>%
                 filter(categoria != "googleame") %>%
                 group_by(categoria) %>%
                 summarise(n_puntos = n(),
                           luz      = mean(luz_2024, na.rm = T),
                           .groups  = "drop") %>%
                 filter(n_puntos >= 100) %>%
                 arrange(desc(luz))
luz_categoria

## graficar las 10 categorias en zonas mas iluminadas
luz_categoria %>%
head(10) %>%
ggplot(aes(x = reorder(categoria, luz), y = luz)) +
geom_col(fill = "steelblue") +
coord_flip() +
labs(x = NULL, y = "Luz promedio 2024 en la celda del establecimiento") +
theme_minimal()

## export data
export(puntos, "output/puntos_luz.rds")

##============================================================================##
##=== 6. Cruce 2, de los puntos al raster  (grano: celda)                  ===##
##============================================================================##

## rasterizar los puntos: contar establecimientos por celda del raster
n_est <- rasterize(puntos, luz_2024, fun = "count", background = 0)
n_est <- crop(n_est, cali, mask = T)
names(n_est) <- "n_est"
plot(n_est)

## apilar las dos capas y pasar a data.frame
densidad <- c(luz_2024, n_est) %>%
            as.data.frame(xy = T)
head(densidad)

## relacion entre densidad de negocios y luz nocturna
ggplot(densidad, aes(x = asinh(n_est), y = asinh(luz_2024))) +
geom_point(alpha = 0.4) +
geom_smooth(method = "lm", se = T, color = "blue") +
theme_bw()

## regresion como en el workshop 02
lm(asinh(luz_2024) ~ asinh(n_est), data = densidad)
