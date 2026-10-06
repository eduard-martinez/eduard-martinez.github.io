##============================================================================##
# _verificacion_semana05.R  —  cifras de Cóndor del Beamer y del script 5
#------------------------------------------------------------------------------#
# Solo para el profesor: rehace, desde las tablas publicadas de Cóndor, cada
# cifra de script/05_inventario_condor.R y de la lámina «¿Qué datos tiene
# Cóndor?». Las cifras de los casos P y M vienen de los documentos de los
# clientes (99_otros/privado_week-05_casos_reales) y no se tocaron.
# Correr desde lectures/week-05/input/:  Rscript _verificacion_semana05.R
##============================================================================##
rm(list = ls())
require(pacman)
p_load(dplyr)

url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes      <- read.csv(paste0(url, "base_clientes.csv"))
transacciones <- read.csv(paste0(url, "anexo_transacciones.csv"))
creditos      <- read.csv(paste0(url, "anexo_creditos.csv"))
campanas      <- read.csv(paste0(url, "anexo_campanas.csv"))

## bloque 1: filas, columnas y clientes
stopifnot(identical(dim(clientes), c(8000L, 29L)), n_distinct(clientes$cliente_id) == 8000,
          identical(dim(transacciones), c(185582L, 11L)), n_distinct(transacciones$cliente_id) == 8000,
          identical(dim(creditos), c(4071L, 11L)), n_distinct(creditos$cliente_id) == 2721,
          identical(dim(campanas), c(13467L, 7L)), n_distinct(campanas$cliente_id) == 6386)
cat("OK bloque 1: las cuatro tablas y su grano\n")

## bloque 2: periodos
stopifnot(identical(format(range(as.Date(transacciones$timestamp))), c("2025-01-01", "2026-03-30")),
          identical(format(range(as.Date(creditos$fecha_solicitud))), c("2025-01-01", "2026-02-28")),
          identical(format(range(as.Date(campanas$fecha_envio))), c("2025-01-01", "2026-03-15")))
cat("OK bloque 2: periodos (todos antes del corte del 31-mar-2026)\n")

## bloque 3: los cinco targets
stopifnot(sum(clientes$abandono) == 1772, median(clientes$gasto_proximo_trim) == 79450,
          sum(transacciones$etiqueta_fraude) == 1480, sum(creditos$default_90d) == 559,
          sum(campanas$convertido) == 1341)
stopifnot(format(round(100 * mean(clientes$abandono), 2), nsmall = 2) == "22.15",
          format(round(100 * mean(creditos$default_90d), 2), nsmall = 2) == "13.73",
          format(round(100 * mean(campanas$convertido), 2), nsmall = 2) == "9.96",
          format(round(100 * mean(transacciones$etiqueta_fraude), 2), nsmall = 2) == "0.80")
cat("OK bloque 3: 22,15 %, 13,73 %, 9,96 % y 0,80 %; mediana del gasto 79.450\n")

## bloque 4: el RFM para segmentar
stopifnot(median(clientes$recencia_dias) == 15, median(clientes$monto_total) == 416650)
cat("OK bloque 4: recencia mediana 15 días, monto mediano 416.650\n")

## bloque 5: la fuga de dias_mora
stopifnot(sum(creditos$default_90d == 0 & creditos$dias_mora < 90) == 3512,
          sum(creditos$default_90d == 1 & creditos$dias_mora >= 90) == 559,
          all(creditos$default_90d == (creditos$dias_mora >= 90)))
cat("OK bloque 5: dias_mora coincide al 100 % con default_90d (3.512 y 559)\n")

cat("\nVERIFICACIÓN COMPLETA: todas las cifras de Cóndor de la semana 5.\n")
