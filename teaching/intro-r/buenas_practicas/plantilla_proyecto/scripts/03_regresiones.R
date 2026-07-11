## ============================================================
##  [Curso Nivelatorio de R | Proyecto final]
##  03_regresiones.R — Modelos y tabla de regresion
##  Autor: [Nombre Apellido] | Fecha: [AAAA-MM-DD]
##  Lee : datos/procesados/[base]_limpia.rds
##  Deja: output/tablas/tabla_regresiones.docx
## ============================================================

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, fixest, modelsummary)

## rutas
datos_proc <- "datos/procesados"
out_tab    <- "output/tablas"

##==: 1. Cargar la base limpia

## base <- import(file.path(datos_proc, "[base]_limpia.rds"))

##==: 2. Modelos (de lo simple a lo completo)

## modelo_1 <- lm([y] ~ [x], data = base)
## modelo_2 <- lm([y] ~ [x] + [controles], data = base)

##==: 3. Tabla de regresion

## modelos <- list("(1)" = modelo_1, "(2)" = modelo_2)
##
## msummary(modelos,
##          coef_rename = c(...),
##          gof_map = c("nobs", "r.squared"),
##          stars = TRUE,
##          output = file.path(out_tab, "tabla_regresiones.docx"))

##==: 4. Interpretacion (como comentarios, con unidades y sin causalidad)

## el coeficiente de [x] indica que ...
