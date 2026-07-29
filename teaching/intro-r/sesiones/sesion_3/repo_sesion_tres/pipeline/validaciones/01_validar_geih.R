## R version 4.4.0
## Last run 2026-07-27

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
geih <- import("data/processed/01_cleaned/geih_lista.rds")

##==: 2. Quality checks :==##
## las variables del analisis deben quedar numericas
stopifnot(is.numeric(geih$ingreso_laboral),
          is.numeric(geih$anios_educacion),
          is.numeric(geih$log_ingreso))

## el nivel educativo debe quedar ordenado, no alfabetico
stopifnot(is.factor(geih$nivel_educativo),
          identical(levels(geih$nivel_educativo), niveles_educativos),
          !any(is.na(geih$nivel_educativo)))   # ningun nivel quedo fuera de levels

## la poblacion de analisis y el log deben ser validos
stopifnot(all(geih$edad >= 18 & geih$edad <= 65),
          all(geih$ingreso_laboral > 0),
          all(is.finite(geih$log_ingreso)))

## categorias y faltantes razonables
table(geih$sexo, useNA = "ifany")
table(geih$nivel_educativo, useNA = "ifany")
colSums(is.na(geih))
summary(geih$ingreso_laboral)
