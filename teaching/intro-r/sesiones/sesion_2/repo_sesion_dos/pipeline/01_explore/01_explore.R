## R version 4.4.0
## Last run 2026-07-21

## Script para CONOCER las bases antes de limpiarlas. No transforma
## ni exporta nada: solo mira. Ejecutar linea por linea.

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
firmas   <- import("data/raw/innovacion_empresas.csv") %>%
            clean_names()
sectores <- import("data/raw/sectores_agregado.csv") %>%
            clean_names()

##==: 2. Vistazo general a la base de firmas :==##
dim(firmas)      # filas y columnas
names(firmas)    # nombres de las variables
head(firmas)     # primeras filas
glimpse(firmas)  # tipo de cada variable y primeros valores

##==: 3. Tipos y categorias de cada variable :==##
class(firmas$ventas_millones)   # llego como texto?
class(firmas$num_empleados)     # llego como texto?
unique(firmas$tamano)           # categorias escritas distinto?
unique(firmas$innova_producto)  # como esta codificada la innovacion?
table(firmas$departamento)      # frecuencias por departamento

##==: 4. Faltantes, duplicados y rangos :==##
sum(duplicated(firmas))               # filas repetidas
sum(is.na(firmas$gasto_id_millones))  # faltantes en gasto en I+D
summary(firmas$num_empleados)         # ojo con min/max imposibles

##==: 5. La base sectorial (para el cruce posterior) :==##
glimpse(sectores)  # una fila por sector, ya limpia
