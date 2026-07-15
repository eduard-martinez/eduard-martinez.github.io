## R version 4.4.0
## Andrea del Pilar Guerrero

##=== 0. Configuracion inicial ===##

## limpiamos el entorno para arrancar en blanco
rm(list = ls())

## los paquetes son colecciones de funciones que alguien mas ya escribio.
## en R primero se instalan (una sola vez, con install.packages) y luego se
## cargan en cada sesion (con library). pacman hace las dos cosas de una:
## p_load instala lo que falte y carga todo.
install.packages("pacman") ## correr solo la primera vez
library(pacman)

## p_load carga los paquetes que vamos a usar:
## - rio : importar/exportar datos
## - skimr : resumenes rapidos de una base
## - tidyverse: coleccion de paquetes para manipular datos (incluye dplyr,
## stringr, tibble, ...). de aca salen mutate, case_when, etc.
p_load(rio, skimr, tidyverse)

## path
raw <- "data/raw/innovacion_empresas.csv"

##=== 1. Importar los datos ===##

## import() detecta el formato por la extension del archivo (.csv) y lo lee.
## el resultado lo guardamos en un objeto llamado df (un data.frame: una tabla
## con filas = empresas y columnas = variables).
df <- import(raw)

## una funcion se llama por su nombre seguido de parentesis con los argumentos:
## funcion(argumento1, argumento2, ...)
## head() muestra las primeras filas para echar un primer vistazo.
head(df)

##=== 2. Estructura y tipo de cada variable ===##

## cuantas filas y columnas tiene la tabla
dim(df)
nrow(df)
ncol(df)
## los nombres de las columnas (las variables)
names(df)

## str() muestra la estructura: el tipo de cada variable y algunos valores.
## los tipos mas comunes en R son:
## - character (chr): texto -> sector_nombre, departamento
## - numeric (num): numeros decimales -> ventas_millones
## - integer (int): numeros enteros -> num_empleados
str(df)

## para preguntar el tipo de UNA variable usamos el signo $ para acceder a
## una columna: df$nombre_columna
class(df$num_empleados)
class(df$ventas_millones)

##===: 3. Limpieza de datos con tidyverse :===##

## al mirar str() notamos que la base viene "sucia" y varias columnas quedaron
## como texto cuando deberian ser numericas o categorias ordenadas:
## - num_empleados trae codigos de "no disponible" ("N/D", "n/d") y vacios
## - ventas_millones usa coma decimal ("857,3")
## - tamano tiene la misma categoria escrita distinto ("Pequena", "pequena")
## - las columnas de innovacion mezclan "1","0","si","Si ","no","NO"
## en esta seccion dejamos todo eso ordenado en un solo paso.

## el operador pipe %>% encadena pasos: toma lo de la izquierda y lo pasa como
## primer argumento a la funcion de la derecha. se lee "y luego...".


## mutate() crea o modifica columnas dentro de la tabla; aca modificamos varias
## en un mismo bloque, una por linea.

df <- df %>%
  ## num_empleados: as.numeric convierte los numeros y deja como NA lo que
  ## no es numero ("N/D",""). R avisa "NAs introducidos por coercion", que
  ## aca es justo lo que queremos.
  mutate(num_empleados = as.numeric(num_empleados),
         ## ventas_millones: cambiamos la coma decimal por punto (str_replace)
         ## y luego convertimos a numero.
         ventas_millones = str_replace(ventas_millones, ",", "."),
         ventas_millones = as.numeric(ventas_millones),
         ## tamano: a minuscula (str_to_lower) y sin espacios sobrantes
         ## (str_trim) para que "Pequena" y "pequena" queden iguales.
         tamano = str_to_lower(str_trim(tamano)),
         ## innova_producto: normalizamos todas las grafias a 1/0. case_when
         ## evalua condiciones en orden y asigna un valor a cada caso; es un
         ## "si... entonces..." de varias ramas, mas legible que ifelse anidado.
         inn_prod = str_to_lower(str_trim(innova_producto)),
         inn_prod = case_when(inn_prod %in% c("1", "si") ~ 1,
                              inn_prod %in% c("0", "no") ~ 0,
                              TRUE ~ NA_real_))

## comprobamos que los tipos y categorias quedaron bien
class(df$num_empleados)
class(df$ventas_millones)
table(df$tamano)
table(df$inn_prod)

##===: 4. Metricas basicas de variables numericas :===##

## medidas resumen sobre una columna numerica. como hay NA, le pedimos a cada
## funcion que los ignore con na.rm = TRUE (si no, devuelven NA).
mean(df$num_empleados, na.rm = TRUE) ## promedio
median(df$num_empleados, na.rm = TRUE) ## mediana
min(df$num_empleados, na.rm = TRUE) ## minimo
max(df$num_empleados, na.rm = TRUE) ## maximo
sd(df$num_empleados, na.rm = TRUE) ## desviacion estandar

## summary() da varias de esas metricas de una sola vez (e informa los NA)
summary(df$num_empleados)

## cuantos faltantes hay en una columna
sum(is.na(df$gasto_id_millones))

##===: 5. Metricas basicas de variables categoricas :===##
## para variables de texto/categorias, table() cuenta cuantas veces aparece
## cada valor distinto.
table(df$departamento)
table(df$tamano)
## unique() lista los valores distintos sin contarlos
unique(df$sector_nombre)
## tabla cruzada: cuenta las combinaciones de dos variables a la vez
table(df$tamano, df$exporta)
##============================================================================##
##=== 6. Resumen general de toda la base ===##
##============================================================================##
## skim() (del paquete skimr) junta todo lo anterior en un solo reporte:
## separa las variables por tipo y muestra faltantes, medias, min, max, etc.
## es la forma mas rapida de tener una foto completa de la base ya limpia.
skim(df)
