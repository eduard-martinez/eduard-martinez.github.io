# ============================================================
# Script generador del dataset notas_regresion.csv
# Semana 12 — Árboles de Regresión
# Introducción al Business Analytics · 06278-ECO
# PhD. Eduard F. Martínez-González
# ============================================================

## Limpiar entorno
rm(list = ls())

## Fijar semilla para reproducibilidad
set.seed(42)
n <- 300

## ── Variables predictoras ──────────────────────────────────

parcial_1  <- round(pmax(0, pmin(5, rnorm(n, mean = 3.2, sd = 0.8))), 1)
parcial_2  <- round(pmax(0, pmin(5, rnorm(n, mean = 3.1, sd = 0.9))), 1)
tareas     <- round(pmax(0, pmin(5, rnorm(n, mean = 3.6, sd = 0.7))), 1)
quices     <- round(pmax(0, pmin(5, rnorm(n, mean = 3.3, sd = 0.8))), 1)
asistencia <- round(pmax(30, pmin(100, rnorm(n, mean = 75, sd = 15))))

## ── Variable de resultado ──────────────────────────────────
## parcial_2 tiene el mayor peso → será la primera división del árbol
## El ruido (sd = 0.25) garantiza que el modelo no sea perfecto

nota_final_raw <- 0.30 * parcial_2 +
                  0.25 * parcial_1 +
                  0.18 * tareas +
                  0.12 * quices +
                  0.008 * asistencia +
                  rnorm(n, mean = 0, sd = 0.25)

nota_final <- round(pmax(0.5, pmin(5.0, nota_final_raw)), 2)

## ── Armar dataset ──────────────────────────────────────────
notas <- data.frame(parcial_1, parcial_2, tareas, quices, asistencia, nota_final)

## ── Guardar CSV ────────────────────────────────────────────
rm(list = ls()[-grep("notas ",paste0(ls()," "))])
#write.csv(notas, "../db/notas_regresion.csv", row.names = FALSE)
