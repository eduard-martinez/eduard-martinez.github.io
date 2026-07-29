## R version 4.4.0
## Last run 2026-07-21

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
firmas <- import("data/processed/01_cleaned/firmas_limpia.rds")

##==: 2. Quality checks :==##
## las columnas numericas deben quedar numericas
stopifnot(is.numeric(firmas$ventas_millones),
          is.numeric(firmas$num_empleados))

## categorias y faltantes razonables
table(firmas$tamano, useNA = "ifany")
table(firmas$innovadora, useNA = "ifany")
summary(firmas$num_empleados)
