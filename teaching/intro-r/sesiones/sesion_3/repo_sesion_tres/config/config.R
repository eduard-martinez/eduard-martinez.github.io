## Configuracion central del pipeline: librerias y rutas.
## Se carga en cada script con source("config/config.R").

## librerias
if (!require(pacman)) { install.packages("pacman"); library(pacman) }
p_load(rio, tidyverse, janitor, skimr, fixest, modelsummary)

## rutas (relativas a la raiz del proyecto)
dir_raw    <- "data/raw"
dir_clean  <- "data/processed/01_cleaned"
dir_tables <- "output/02_tables"
dir_graphs <- "output/01_graphs"

## crear las carpetas de salida si no existen
for (d in c(dir_clean, dir_tables, dir_graphs)) {
  if (!dir.exists(d)) dir.create(d, recursive = TRUE, showWarnings = FALSE)
}

## orden logico del nivel educativo (si no, R lo ordena alfabeticamente)
niveles_educativos <- c("ninguno", "primaria", "secundaria", "media", "superior")
