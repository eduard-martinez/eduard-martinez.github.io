# ============================================================================
# Introducción al Business Analytics (06278-ECO) — Semana 04
# TASK: Trabajo autónomo — Análisis de operaciones de una cadena de cafeterías
# ============================================================================

# ── 0. Setup ─────────────────────────────────────────────────────────────────
# Carga dplyr y lee el dataset.
library(dplyr)

## load data
cafeteria <- read.csv("/Users/eduard-martinez/Library/CloudStorage/Dropbox/Web-Page/my_web_page/teaching/ba/week-04/task/cafeteria.csv")

# ============================================================================
# PARTE 1: Transformaciones básicas (select, filter, mutate, arrange)
# ============================================================================

# ── 1.1. Selección de columnas ──────────────────────────────────────────────
# La gerencia solo necesita ver: sucursal, producto, precio y unidades.
# Crea un objeto llamado "cafe_red" con solo esas columnas.


# ── 1.2. Filtrado ───────────────────────────────────────────────────────────
# a) Filtra las transacciones de la ciudad "Cali". Guarda en "ventas_cali".



# b) Filtra las transacciones de Bebidas con precio mayor a 5000.
#    Guarda en "bebidas_caras".


# ── 1.3. Creación de variables ──────────────────────────────────────────────

# a) Crea una columna "ingreso" = precio × unidades.
#    Guarda el resultado en "cafe_ing".


# ── 1.4. Ordenamiento ──────────────────────────────────────────────────────
# Ordena "cafe_ing" de mayor a menor ingreso. Muestra las primeras 5 filas.
# Pista: después de arrange(), puedes usar head() para ver solo las primeras.


# ============================================================================
# PARTE 2: Resúmenes globales (summarise)
# ============================================================================

# ── 2.1. Calcula sobre "cafe_ing" (que ya tiene la columna ingreso): ────────
#   - ingreso_total: suma de todos los ingresos
#   - ticket_promedio: promedio de ingreso por transacción
#   - precio_max: precio unitario máximo registrado
#   - n_transacciones: número total de transacciones
# Guarda en "resumen_global".



# Responde: ¿cuál es el ticket promedio de Café Central?
# Respuesta: ___


# ============================================================================
# PARTE 3: Descriptivas por grupo (group_by + summarise)
# ============================================================================

# ── 3.1. KPIs por ciudad ───────────────────────────────────────────────────
# Usando "cafe_ing", calcula por CIUDAD:
#   - ingreso_total
#   - ticket_promedio (promedio de ingreso)
#   - n_transacciones
# Guarda en "kpis_ciudad". No olvides .groups = "drop".





