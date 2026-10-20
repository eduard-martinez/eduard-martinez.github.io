## Analitica para los negocios (06327-ECO)
## week-12: arboles de regresion con canciones urbanas reales de Spotify
## Nombre: _______________

##==: 0. initial setup :==##

## clean environment
rm(list=ls())

## load/install packages
require(pacman)
p_load(dplyr , rpart , rpart.plot)

##==: 1. prepare data :==##

## 1.1. load data (la base publica del curso: una fila por cancion)
url_canciones <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-12/script/canciones_urbanas.csv"
canciones <- read.csv(url_canciones)
dim(canciones)
head(canciones , 3)

## 1.2. son canciones reales: busca las de tu artista
canciones %>% 
filter(grepl("Bad Bunny" , artista)) %>% 
select(cancion , anio , popularidad) %>% head(3)

## 1.3. split data: el 80% aprende y con el 20% que no vio se califica
set.seed(12)
idx_train <- sample(1:nrow(canciones) , size=round(0.8*nrow(canciones)))
train <- canciones[idx_train , ]
test <- canciones[-idx_train , ]
c(train = nrow(train) , test = nrow(test))

## 1.4. la referencia: predecir todas las canciones con el promedio del train
round(mean(train$popularidad) , 1)

##==: 2. arbol de regresion :==##

## 2.1. estimar el arbol con las opciones por defecto de rpart
arbol <- rpart(popularidad ~ tempo + duracion_seg + bailabilidad + energia + colaboracion ,
               data=train)

## 2.2. dibujarlo: cada hoja predice el promedio de popularidad de su grupo
rpart.plot(arbol , type=4 , extra=101 , box.palette="GnBu" ,
           shadow.col="gray87" , branch=0.3 , digits=3)

##==: 3. predecir y evaluar :==##

## 3.1. predecir: a cada cancion le toca el promedio de su hoja
test$pron_arbol <- round(predict(arbol , test) , 1)

## 3.2. ocho canciones conocidas, de hojas distintas
ocho <- test %>%
        filter(cancion %in% c("Si Te Vas" , "Atrévete" , "Con Calma" ,
                              "Aullando" , "Me Gusta" , "Felices los 4" ,
                              "Zumba" , "Taboo")) %>%
        select(cancion , artista , tempo , duracion_seg , popularidad , pron_arbol) %>%
        mutate(error = round(abs(pron_arbol - popularidad) , 1)) %>%
        arrange(desc(pron_arbol))
ocho

## 3.3. mae en el test: el arbol vs el promedio
round(c(mae_arbol = mean(abs(test$pron_arbol - test$popularidad)) ,
        mae_promedio = mean(abs(round(mean(train$popularidad) , 1) - test$popularidad))) , 1)

##==: 4. taller :==##

## el arbol de la clase usa solo atributos de la cancion. agrega anio a la
## formula de 2.1, entrena de nuevo, dibujalo como en 2.2 y calcula su mae
## como en 3.3. responde como comentario: ¿mejora el mae? ¿que variable se
## toma la raiz? ¿te sirve ese arbol para valorar una cancion que sale esta
## semana? guarda el archivo como apellido_nombre_taller12.R y subelo a Intu.

## 4.1. tu codigo:

## 4.2. tu respuesta:
