## R version 4.4.0
## Last run 2026-07-27

## Script para CONOCER la base antes de describirla y estimar. No transforma
## ni exporta nada: solo mira. Ejecutar linea por linea.

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
geih <- import("data/raw/geih_nivelacion.csv") %>%
        clean_names()

##==: 2. Vistazo general :==##
dim(geih)      # filas y columnas
names(geih)    # nombres de las variables
head(geih)     # primeras filas
glimpse(geih)  # tipo de cada variable y primeros valores
skim(geih)     # faltantes, min/max, percentiles

##==: 3. Categorias de cada variable cualitativa :==##
table(geih$sexo)             # dos categorias, en minusculas
table(geih$nivel_educativo)  # llega SIN orden (R lo pondria alfabetico)
n_distinct(geih$departamento)  # 24 cabeceras

##==: 4. El ingreso: por que trabajaremos en logaritmos :==##
summary(geih$ingreso_laboral)  # ojo con la distancia entre mediana y maximo
sd(geih$ingreso_laboral)       # dispersion enorme en niveles

## la cola larga a la derecha se ve de inmediato en el histograma
hist(geih$ingreso_laboral)       # asimetria extrema
hist(log(geih$ingreso_laboral))  # en logs, casi simetrica

##==: 5. Faltantes, duplicados y rangos :==##
sum(duplicated(geih))          # filas repetidas
colSums(is.na(geih))           # faltantes por columna
range(geih$edad)               # 18 a 65 por construccion
range(geih$horas_semana)

##==: 6. El hallazgo que guia el analisis :==##
## las mujeres tienen MAS educacion promedio y MENOS ingreso mediano
geih %>%
  group_by(sexo) %>%
  summarise(n              = n(),
            ingreso_median = median(ingreso_laboral),
            educacion_prom = mean(anios_educacion),
            .groups = "drop")
