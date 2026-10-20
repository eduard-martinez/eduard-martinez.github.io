##============================================================================##
# script_clase12.R  —  ¿qué tan popular será una canción urbana?
#------------------------------------------------------------------------------#
# Analítica para los negocios (06327-ECO) · Semana 12 · script de la clase
# SonoUrbano, un sello de música urbana, debe decidir qué canciones comprar
# para su catálogo. Hoy el target es un número: la popularidad de Spotify
# (0-100), que resume las reproducciones recientes de cada canción. El árbol
# de la semana pasada, con un promedio en cada hoja. Lee desde la URL:
#   - canciones_urbanas.csv  (grano: canción; 2.427 canciones urbanas reales
#     de la base pública de Spotify: reggaeton y latin hip hop)
# El bloque 4, al final, es el taller: se responde y se entrega este archivo.
# Nombre: _______________
##============================================================================##

##============================================================================##
##=== 0. Los datos y las variables                                         ===##
##============================================================================##
rm(list = ls())
## librerías (si falta pacman: install.packages("pacman") en la consola)
require(pacman)
p_load(dplyr, rpart, rpart.plot)

## la base de canciones de la página del curso
url_canciones <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-12/script/canciones_urbanas.csv"
canciones <- read.csv(url_canciones)
dim(canciones)
head(canciones, 3)

## son canciones reales: busca las de tu artista (grepl busca el texto dentro
## del nombre)
canciones %>%
filter(grepl("Bad Bunny", artista)) %>%
select(cancion, anio, popularidad) %>%
head(3)
## checkpoint: 2.427 canciones y 10 columnas. el target es popularidad (0-100);
## las predictoras son anio, duracion_seg, bailabilidad, energia y colaboracion
## (1 = el título trae un featuring); cancion y artista identifican cada fila

##============================================================================##
##=== 1. Entrenamiento y testeo                                            ===##
##============================================================================##
## pregunta: ¿cómo sabemos si el árbol generaliza y no memoriza? con el 80 %
## aprende; con el 20 % que no vio, se califica
set.seed(12)
idx_train <- sample(1:nrow(canciones), size = round(0.8 * nrow(canciones)))
train <- canciones[idx_train, ]
test  <- canciones[-idx_train, ]

nrow(train)
nrow(test)
round(mean(train$popularidad), 1)
## checkpoint: 1.942 canciones entrenan y 485 califican. el promedio de train
## es 44.9 puntos: la línea base es pronosticarle eso a todas

##============================================================================##
##=== 2. Entrenar el árbol y pintarlo                                      ===##
##============================================================================##
## pregunta: ¿qué preguntas aprende? igual que la semana pasada, pero ahora
## cada hoja guarda el promedio de popularidad de su grupo
arbol <- rpart(popularidad ~ anio + duracion_seg + bailabilidad + energia +
                             colaboracion,
               data = train)

rpart.plot(arbol, type = 5, extra = 101, box.palette = "GnBu",
           shadow.col = "gray87", branch = 0.3, digits = 3)
## cada caja: arriba los puntos que predice (el promedio de su grupo), abajo
## cuántas canciones de train caen ahí y qué % son
## checkpoint: 4 nodos y 5 hojas, con dos variables. primero el año: las de
## 2019-2020 prometen 63.6 y las de 2018, 51.9. en el catálogo viejo manda la
## duración: menos de 157 segundos queda en 14, 276 o más en 26.5 y el resto
## en 37.7. ni la bailabilidad, ni la energía, ni el featuring ganaron una
## pregunta

##============================================================================##
##=== 3. Pronósticos y el error en puntos                                  ===##
##============================================================================##
## pregunta: ¿por cuántos puntos de popularidad se equivoca cada opción en las
## 485 canciones que no vio?
test <- test %>%
        mutate(pron_arbol = round(predict(arbol, newdata = test), 1))

head(test %>% select(cancion, artista, anio, duracion_seg, popularidad,
                     pron_arbol) %>%
       mutate(error = round(abs(pron_arbol - popularidad), 1)), 8)

## ¿y una canción conocida? el árbol no sabe quién canta: el artista no está
## entre las predictoras
test %>%
filter(cancion == "Estamos Bien") %>%
select(cancion, artista, anio, popularidad, pron_arbol)

## el MAE: el error promedio, en puntos (la línea base pronostica el promedio)
mae_arbol    <- mean(abs(test$pron_arbol - test$popularidad))
mae_promedio <- mean(abs(round(mean(train$popularidad), 1) - test$popularidad))
round(mae_arbol, 1)
round(mae_promedio, 1)
## checkpoint: el promedio se equivoca 24.4 puntos por canción; el árbol, 21:
## 3.4 puntos menos. a Estamos Bien (Bad Bunny, popularidad 76) le pronostica
## 51.9, el promedio de su hoja: para atinarle a los éxitos falta la variable
## que el árbol no tiene, el artista

##============================================================================##
##=== 4. Taller: tu propio árbol de regresión                              ===##
##============================================================================##
## el árbol de la clase usa los frenos de fábrica de rpart. entrena tu propia
## versión cambiándole algo: suelta los frenos y fija la profundidad agregando
## dentro de rpart() el argumento
##   control = rpart.control(maxdepth = 4, cp = 0, minsplit = 2, minbucket = 1)
## (puedes usar otra profundidad en vez de 4). guarda el archivo como
## apellido_nombre_taller12.R y súbelo a Intu.

## pregunta 1. entrena tu árbol, píntalo como en el bloque 2 y calcula su MAE
## en el test, como en el bloque 3.
## tu código:

## pregunta 2. compara los dos MAE y responde como comentario: ¿tu árbol le
## gana al de fábrica? ¿cuál de los dos usarías para decidir los lanzamientos
## y por qué? quedarte con el de fábrica también es una respuesta válida.
## respuesta:
