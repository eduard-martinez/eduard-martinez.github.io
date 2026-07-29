## R version 4.4.0
## Last run 2026-07-27

## Ejecuta el pipeline completo desde el dato crudo.
## Uso: abrir repo_sesion_tres.Rproj y correr  source("pipeline/run_pipeline.R")
## (01_explore no va aqui: es para conocer la base a mano, no produce salidas)

##==: 1. Transformacion :==##
source("pipeline/02_clean/02_clean.R")                  # crudo -> base lista
source("pipeline/03_descriptives/03_descriptives.R")    # lista -> tablas y figuras
source("pipeline/04_models/04_models.R")                # lista -> tabla de regresiones

##==: 2. Validaciones :==##
source("pipeline/validaciones/01_validar_geih.R")
source("pipeline/validaciones/02_validar_modelos.R")
