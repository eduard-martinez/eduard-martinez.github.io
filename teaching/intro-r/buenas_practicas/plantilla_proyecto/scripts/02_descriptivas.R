## ============================================================
##  [Curso Nivelatorio de R | Proyecto final]
##  02_descriptivas.R — Figuras y tablas descriptivas
##  Autor: [Nombre Apellido] | Fecha: [AAAA-MM-DD]
##  Lee : datos/procesados/[base]_limpia.rds
##  Deja: output/figuras/*.png ; output/tablas/descriptivas.docx
## ============================================================

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, modelsummary)

## rutas
datos_proc <- "datos/procesados"
out_fig    <- "output/figuras"
out_tab    <- "output/tablas"

##==: 1. Cargar la base limpia (de disco, no de la memoria)

## base <- import(file.path(datos_proc, "[base]_limpia.rds"))

##==: 2. Descriptivas por grupo

## resumen <- base %>%
##            group_by([grupo]) %>%
##            summarise(...)

##==: 3. Figuras

## grafico_1 <- ggplot(...) + ... + theme_minimal()
## ggsave(file.path(out_fig, "[nombre].png"), grafico_1,
##        width = 8, height = 5, dpi = 300)

##==: 4. Tabla descriptiva exportable

## datasummary_skim(base, output = file.path(out_tab, "descriptivas.docx"))
