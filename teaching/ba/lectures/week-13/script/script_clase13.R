## Analitica para los negocios (06327-ECO)
## week-13: clustering con las notas del curso (clase + taller)
## Nombre: _______________

##==: 0. initial setup :==##

## clean environment
rm(list=ls())

## load/install packages
require(pacman)
p_load(dplyr , ggplot2)

##==: 1. prepare data :==##

## 1.1. load data (una fila por estudiante: promedio de quices y parcial 1)
url_notas <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-13/script/notas_curso.csv"
notas <- read.csv(url_notas , colClasses=c(codigo="character"))
dim(notas)
head(notas , 3)

##==: 2. el numero de grupos :==##

## 2.1. el codo: la suma de distancias a los centroides para k = 1..8
X <- notas %>% select(promedio_quices , parcial_1)
wss <- c()
for (k in 1:8) {
  set.seed(13)
  wss[k] <- kmeans(X , centers=k , nstart=25)$tot.withinss
}
plot(1:8 , wss , type="b" , pch=16 , xlab="k (numero de grupos)" ,
     ylab="suma de distancias a los centroides")

##==: 3. k-means con 3 grupos :==##

## 3.1. estimar k-means con k = 3 (el codo cae fuerte hasta 2-3 y luego duda;
## las dos notas ya estan en la misma escala, 0 a 5)
set.seed(13)
km <- kmeans(X , centers=3 , nstart=25)

## 3.2. numerar los grupos de mejor a menor promedio y pegarlos a la base
orden <- order(-rowSums(km$centers))
notas$grupo <- match(km$cluster , orden)

## 3.3. la caracterizacion corta: el centroide es el estudiante promedio del grupo
notas %>%
group_by(grupo) %>%
summarise(quices = round(mean(promedio_quices) , 1) ,
          parcial = round(mean(parcial_1) , 1) , n = n())

## 3.4. el mapa: cada punto es un estudiante del curso
ggplot(notas , aes(x=promedio_quices , y=parcial_1 , color=factor(grupo))) +
geom_point(size=3) +
labs(x="promedio de quices" , y="parcial 1" , color="grupo") +
theme_minimal()

##==: 4. taller :==##

## taller individual. repite la seccion 3 con CUATRO grupos (centers=4) y pega
## el resultado en una columna nueva (por ejemplo notas$grupo4), sin borrar el
## grupo de la clase. buscate con filter(codigo == "TU-CODIGO") y responde
## como comentario: ¿en que grupo te clasificaba el algoritmo con k = 3 y en
## cual te clasifica ahora con k = 4? ¿como cambio? caracteriza tu grupo nuevo
## (cuantos son y sus promedios de quices y parcial) y di que lo distingue del
## grupo donde estabas. guarda el archivo como apellido_nombre_taller13.R y
## subelo a Intu.

## 4.1. tu codigo:

## 4.2. tu respuesta:
