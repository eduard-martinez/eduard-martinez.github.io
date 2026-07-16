## ============================================================
##  Introducción al Business Analytics (06278-ECO)
##  Semana 6 | SOLUCIÓN DE REFERENCIA del Taller 6 (uso interno)
##  "La base que llegó del sistema" — Ferretería El Tornillo
##  Reproduce el código esperado del estudiante leyendo el CSV
##  publicado. Sirve para calificar: toda cifra sale de aquí.
##
##  Nota de procedencia: ferreteria_raw.csv (67×7) fue construido
##  a mano por la sesión que armó la semana 6 (no hay generador);
##  este script documenta todas sus propiedades.
## ============================================================

rm(list = ls())

## Librerías / Libraries
require(pacman)
p_load(dplyr, ggplot2, skimr)

## ============================================================
## Punto 1 — Setup y radiografía (0.75)
## ============================================================
## El estudiante usa data/ferreteria_raw.csv por ruta relativa
ferreteria_raw <- read.csv("../task/ferreteria_raw.csv")

cat("== P1 ==\n")
print(dim(ferreteria_raw))        # 67 filas x 7 columnas
skim(ferreteria_raw)
## 1c esperado:
##  - 67 filas, 7 columnas.
##  - Una fila = las ventas de UN producto en UNA sede en UN mes
##    (producto-sede-mes del cuatrimestre Ene-Abr).
##  - precio llega como character (debería ser numeric): hay valores
##    con "$" adentro.

## ============================================================
## Punto 2 — Diagnóstico (1.0) — SIN corregir nada
## ============================================================
cat("\n== P2a: consistencia ==\n")
print(unique(ferreteria_raw$sede))      # 7 valores para 4 sedes reales
print(table(ferreteria_raw$sede))       # Norte/norte/NORTE + Sur/SUR + Centro + Palmira
print(unique(ferreteria_raw$producto))  # 6 valores para 4 productos
## R reporta 7 sedes y 6 productos porque cada variante de
## mayúsculas es, para R, una categoría distinta.

cat("\n== P2b: unicidad ==\n")
print(sum(duplicated(ferreteria_raw)))  # 3 filas duplicadas exactas

cat("\n== P2c: validez (rango) ==\n")
print(summary(ferreteria_raw$unidades)) # min = -4 (¿unidades negativas?)
print(ferreteria_raw[!is.na(ferreteria_raw$unidades) & ferreteria_raw$unidades < 0, ])
## LA FILA COMPLETA: Centro | Abr | Martillo | 38000 | -4 | "devolucion"
## <- la columna observaciones documenta que es una DEVOLUCIÓN.

cat("\n== P2d: validez (outlier) ==\n")
## conversión temporal solo para mirar
ferreteria_raw <- mutate(ferreteria_raw,
                         precio_num = as.numeric(gsub("\\$", "", precio)))
g_diag <- ggplot(ferreteria_raw, aes(x = precio_num)) +
  geom_histogram(bins = 20)
print(ferreteria_raw[!is.na(ferreteria_raw$precio_num) &
                       ferreteria_raw$precio_num > 100000 &
                       ferreteria_raw$producto == "Tornillo", ])
## LA FILA: un TORNILLO a $250.000 (los demás tornillos cuestan ~$250):
## error de captura (mil veces el valor real). Nota: los taladros a
## ~$450.000 NO son outliers - ese es su precio normal.

cat("\n== P2e: completitud ==\n")
print(sum(is.na(ferreteria_raw$precio_num)))  # 2 NA de origen en precio
print(sum(is.na(ferreteria_raw$unidades)))    # 2 NA en unidades

## ============================================================
## Punto 3 — Limpieza (1.5)
## ============================================================
cat("\n== P3a: duplicados ==\n")
ferreteria_clean <- distinct(select(ferreteria_raw, -precio_num))
print(nrow(ferreteria_raw) - nrow(ferreteria_clean))   # 3 (coincide con P2b)

cat("\n== P3b: categorías ==\n")
ferreteria_clean <- mutate(ferreteria_clean,
                           sede     = toupper(sede),
                           producto = toupper(producto))
print(table(ferreteria_clean$sede))       # 4 sedes
print(table(ferreteria_clean$producto))   # 4 productos

cat("\n== P3c: tipo de precio ==\n")
ferreteria_clean <- mutate(ferreteria_clean,
                           precio = as.numeric(gsub("\\$", "", precio)))
print(class(ferreteria_clean$precio))     # numeric
print(sum(is.na(ferreteria_clean$precio)))
## 2 NA: los MISMOS 2 del P2e -> no se crearon NA nuevos. ✓

cat("\n== P3d: outlier con condición específica ==\n")
ferreteria_clean <- mutate(ferreteria_clean,
                           precio = ifelse(producto == "TORNILLO" & precio > 100000,
                                           250,
                                           precio))
print(summary(ferreteria_clean$precio))
## max vuelve a ~455.000 (los taladros, legítimos). Justificación
## esperada: un tornillo no cuesta $250.000; el resto de tornillos
## cuesta $250 -> error de captura (x1000). La condición lleva
## producto + umbral para no tocar los taladros.

cat("\n== P3e: la decisión de criterio (unidades = -4) ==\n")
## La fila trae observaciones = "devolucion": es un movimiento REAL.
## Cualquiera de las tres opciones vale SI está justificada; la rúbrica
## evalúa la justificación y que hayan LEÍDO observaciones antes.
## Opción de esta solución: CONSERVAR la fila (devolución legítima) y
## reportar su efecto: restará ~4×38.000 = $152.000 del ingreso del
## Centro en abril — que es exactamente lo que debe hacer una devolución.
## Alternativas defendibles:
##   - convertir a NA (si el reporte pedido excluye devoluciones)
##   - eliminarla (defendible SOLO si se argumenta que el reporte es de
##     ventas brutas; débil si no leyó observaciones)

cat("\n== P3f: estructura final ==\n")
ferreteria_clean <- select(ferreteria_clean, -observaciones)
## Justificación: 63/67 valores vacíos y las 4 notas ya se usaron en el
## diagnóstico; no aporta al análisis. (OJO al calificar: eliminarla
## ANTES del P3e = perdió la evidencia de la devolución.)
ferreteria_clean <- mutate(ferreteria_clean, ingreso = precio * unidades)
print(str(ferreteria_clean))

## ============================================================
## Punto 4 — EDA (1.0)
## ============================================================
cat("\n== P4a: verificación vs. skim inicial ==\n")
skim(ferreteria_clean)
## Tres cambios esperables (cualquier trío vale):
##  - precio: character -> numeric
##  - sede: 7 valores únicos -> 4 | producto: 6 -> 4
##  - filas: 67 -> 64 (duplicados)
##  - max de precio ya no es el tornillo de 250.000
##  - los NA que quedan (2+2) venían del origen

cat("\n== P4b: la tabla del gerente ==\n")
kpis_sede <- group_by(ferreteria_clean, sede)
kpis_sede <- summarise(kpis_sede,
                       ingreso_total    = sum(ingreso, na.rm = TRUE),
                       unidades_totales = sum(unidades, na.rm = TRUE),
                       n_transacciones  = n(),
                       .groups = "drop")
kpis_sede <- arrange(kpis_sede, desc(ingreso_total))
print(kpis_sede)

cat("\n== P4 (pista): la misma tabla sobre el RAW (el reporte errado) ==\n")
raw_tmp <- mutate(read.csv("../task/ferreteria_raw.csv"),
                  precio  = as.numeric(gsub("\\$", "", precio)),
                  ingreso = precio * unidades)
kpis_raw <- group_by(raw_tmp, sede)
kpis_raw <- summarise(kpis_raw, ingreso_total = sum(ingreso, na.rm = TRUE),
                      .groups = "drop")
print(arrange(kpis_raw, desc(ingreso_total)))
## 7 filas en vez de 4, con el ingreso del Norte partido en tres y el
## tornillo de $250.000 inflando su sede: ese era el reporte del gerente.

## P4c: gráfico (el estudiante lo exporta con ggsave a output/)
g_sedes <- ggplot(kpis_sede,
                  aes(x = reorder(sede, ingreso_total), y = ingreso_total)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "El ingreso del cuatrimestre se concentra en pocas sedes",
       x = NULL, y = "Ingreso (COP)") +
  theme_minimal()
## ggsave("output/ingreso_sede_taller6.png", g_sedes, width = 7, height = 4.5)

## P4d esperado: comparar el ranking por ingreso vs. por unidades —
## la sede que más factura no necesariamente es la que más unidades
## mueve (mezcla de productos baratos [tornillos/guantes] vs. caros
## [taladros]); leerlo como "tipo de negocio" de cada sede.

## ============================================================
## Punto 5 — Acta y hallazgos (0.75) — referencia
## ============================================================
## ACTA modelo:
##  - Duplicados: eliminadas 3 filas exactas (causa probable: doble
##    exportación del sistema).
##  - Categorías: sede y producto con toupper(); de 7 a 4 sedes y de
##    6 a 4 productos.
##  - precio: eliminado "$" y convertido a numeric (0 NA nuevos; los
##    2 NA venían del origen).
##  - Valor imposible: unidades = -4 con observación "devolucion" ->
##    CONSERVADA como movimiento real (resta $152.000 al Centro-Abr).
##  - Outlier: TORNILLO a 250.000 -> 250 (error de captura x1000;
##    condición producto+umbral para no tocar taladros).
##  - Columna eliminada: observaciones (94% vacía, ya usada en el
##    diagnóstico).
## Hallazgos tipo (con número) + 1 pregunta abierta que pida MÁS datos
## (p. ej. "¿el ingreso por sede refleja tamaño de la sede o mezcla de
## productos? necesitaría m2/tráfico por sede para separarlo").
