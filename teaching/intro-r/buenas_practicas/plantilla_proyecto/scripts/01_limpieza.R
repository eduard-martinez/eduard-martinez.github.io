## ============================================================
##  [Curso Nivelatorio de R | Proyecto final]
##  01_limpieza.R — De la base cruda a la base de analisis
##  Autor: [Nombre Apellido] | Fecha: [AAAA-MM-DD]
##  Lee : datos/originales/[base].csv
##  Deja: datos/procesados/[base]_limpia.rds ([grano: una fila por ...])
## ============================================================

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, janitor)

## rutas
datos_orig <- "datos/originales"
datos_proc <- "datos/procesados"

##==: 1. Importar

## base_raw <- import(file.path(datos_orig, "[base].csv")) %>%
##             clean_names()

##==: 2. Diagnosticar

## glimpse(base_raw)
## skim(base_raw)

##==: 3. Limpiar (un bloque por problema, con su decision comentada)

## duplicados


## estandarizar texto


## corregir tipos


## faltantes y valores imposibles


##==: 4. Exportar

## export data
## export(base, file.path(datos_proc, "[base]_limpia.rds"))

## clean
## rm(base_raw)
