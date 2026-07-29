## R version 4.4.0
## Last run 2026-07-27

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
geih    <- import("data/processed/01_cleaned/geih_lista.rds")
modelos <- readRDS("data/processed/01_cleaned/modelos.rds")

##==: 2. Quality checks :==##
## los cuatro modelos deben correr sobre TODAS las observaciones
## (si alguno pierde filas, hay NA que no vimos en la limpieza)
stopifnot(all(sapply(modelos, nobs) == nrow(geih)))

## los efectos fijos deben absorber las 24 cabeceras
stopifnot(modelos[["(4) + EF depto"]]$fixef_sizes[["departamento"]] ==
          n_distinct(geih$departamento))

##==: 3. La heterocedasticidad que justifica los errores robustos :==##
## si hubiera homocedasticidad, esta columna seria casi igual en todos los grupos
geih %>%
  mutate(residuo = resid(modelos[["(3) + Sexo"]])) %>%
  group_by(nivel_educativo) %>%
  summarise(desv_residuo = sd(residuo), .groups = "drop")

##==: 4. Comparacion entre el modelo (3) y el modelo con efectos fijos :==##
## el coeficiente se mueve poco; el error estandar SI cambia
sapply(modelos, function(m) coef(m)["anios_educacion"])
