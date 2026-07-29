## R version 4.4.0
## Last run 2026-07-27

## Los cuatro modelos de la Unidad 4, de lo simple a lo defendible:
## (1) simple -> (2) + edad -> (3) + sexo -> (4) + efectos fijos.

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
geih <- import("data/processed/01_cleaned/geih_lista.rds")

##==: 2. Modelo 1: el retorno simple a la educacion :==##
## la dependiente esta en logs -> el coeficiente se lee como cambio porcentual
modelo_1 <- lm(log_ingreso ~ anios_educacion, data = geih)

##==: 3. Modelo 2: control por edad :==##
## compara personas de la MISMA edad (las cohortes jovenes estudian mas)
modelo_2 <- lm(log_ingreso ~ anios_educacion + edad, data = geih)

##==: 4. Modelo 3: dummy de sexo :==##
## sexo es texto y R crea la dummy solo; la referencia es "hombre"
modelo_3 <- lm(log_ingreso ~ anios_educacion + edad + sexo, data = geih)

##==: 5. Modelo 4: efectos fijos de departamento y errores robustos :==##
## | departamento  -> absorbe todo lo constante dentro de cada departamento
## vcov = "hetero" -> errores estandar robustos a heterocedasticidad
modelo_fe <- feols(log_ingreso ~ anios_educacion + edad + sexo | departamento,
                   data = geih)

##==: 6. Tabla de regresiones :==##
modelos <- list("(1) Simple"     = modelo_1,
                "(2) + Edad"     = modelo_2,
                "(3) + Sexo"     = modelo_3,
                "(4) + EF depto" = modelo_fe)

##==: 7. Export :==##
msummary(modelos,
         coef_rename = c(anios_educacion = "Anios de educacion",
                         edad = "Edad", sexomujer = "Mujer"),
         gof_map = c("nobs", "r.squared"),
         stars = TRUE,
         output = "output/02_tables/tabla_regresiones.csv")

saveRDS(modelos, "data/processed/01_cleaned/modelos.rds")
