## R version 4.4.0
## Last run 2026-07-21

## Ejecuta el pipeline completo desde el dato crudo.
## Uso: abrir repo_sesion_dos.Rproj y correr  source("pipeline/run_pipeline.R")
## (01_explore no va aqui: es para conocer la base a mano, no produce salidas)

##==: 1. Transformacion :==##
source("pipeline/02_clean/02_clean.R")     # crudo    -> firmas limpias
source("pipeline/03_join/03_join.R")       # limpias  -> firmas + sector
source("pipeline/04_tables/04_tables.R")   # cruzadas -> tablas del informe

##==: 2. Validaciones :==##
source("pipeline/validaciones/01_validar_firmas.R")
source("pipeline/validaciones/02_validar_firmas_sector.R")
