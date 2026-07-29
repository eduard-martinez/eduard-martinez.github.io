## R version 4.4.0
## Last run 2026-07-27

## La GEIH del curso ya viene limpia: aqui no hay que reparar tipos ni texto.
## Lo que si hay que hacer es DEJARLA LISTA para describir y estimar:
## ordenar las categorias y crear las variables derivadas del analisis.

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
geih <- import("data/raw/geih_nivelacion.csv") %>%
        clean_names()

##==: 2. Quedarnos con la poblacion de analisis :==##
## ocupados de 18 a 65 anios con ingreso laboral positivo
geih <- geih %>%
        filter(edad >= 18, edad <= 65, ingreso_laboral > 0)

##==: 3. Ordenar el nivel educativo (factor con orden logico) :==##
geih <- geih %>%
        mutate(nivel_educativo = factor(nivel_educativo, levels = niveles_educativos))

##==: 4. Estandarizar el texto de las categoricas :==##
geih <- geih %>%
        mutate(sexo         = str_to_lower(str_trim(sexo)),
               departamento = str_trim(departamento))

##==: 5. Variables derivadas del analisis :==##
## log del ingreso: hace legible la distribucion y vuelve los coeficientes %
geih <- geih %>%
        mutate(log_ingreso     = log(ingreso_laboral),
               ingreso_por_hora = ingreso_laboral / (horas_semana * 4.33),
               mujer            = ifelse(sexo == "mujer", 1, 0))

##==: 6. Export :==##
export(geih, "data/processed/01_cleaned/geih_lista.rds")
