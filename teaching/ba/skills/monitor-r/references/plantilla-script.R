## ============================================
## Taller 4 — La analítica de una cafetería
## Nombre: ______________   Código: __________
## Fecha:  ______________
## Qué hace: calcula los KPIs de la cafetería y
##           construye los gráficos del dueño
## ============================================

## Librerías (p_load instala el paquete si falta y lo carga)
require(pacman)
p_load(dplyr, ggplot2)

## Directorio de trabajo: abre este script desde su carpeta (doble clic)
## y verifica que R esté parado donde crees. Nada de setwd("C:/Users/...").
getwd()
list.files()

## Cargar los datos
## Los originales viven en input/ y NUNCA se modifican: son la copia de respaldo.
ventas <- read.csv("input/ventas_cafeteria.csv")

## Radiografía: siempre que nace una tabla, mírala antes de usarla
dim(ventas)     # filas y columnas
str(ventas)     # tipo de cada columna (¿el precio llegó como texto?)
head(ventas)    # las primeras filas

##=== 1. Transformaciones ===##

## cada paso: un comentario que dice qué hace (y por qué, si aporta),
## una línea de código y una línea que verifica el resultado
ventas <- mutate(ventas, ingreso = precio * cantidad)
summary(ventas$ingreso)

##=== 2. KPIs ===##

## ingreso total y ticket promedio por región (cadena corta: 2 verbos)
kpis_region <- ventas %>%
  group_by(region) %>%
  summarise(ingreso_total   = sum(ingreso),
            ticket_promedio = round(mean(ingreso)),
            n_ventas        = n(),
            .groups = "drop")
kpis_region

##=== 3. Gráficos ===##

## barras: ¿quién lidera? (el título dice el hallazgo, no la variable)
ggplot(kpis_region, aes(x = reorder(region, -ingreso_total), y = ingreso_total)) +
  geom_col(fill = "steelblue") +
  labs(title = "Oeste lidera el ingreso del año",
       x = NULL, y = "Ingreso total ($)") +
  theme_minimal()

##=== 4. Exportar ===##

## Todo lo que hay en output/ lo generó un script: se puede volver a crear.
write.csv(kpis_region, "output/kpis_region.csv", row.names = FALSE)
ggsave("output/grafico_region.png", width = 8, height = 5, dpi = 300)

## ---- Notas de la plantilla (bórralas en tu script) ----------------------
## - El encabezado es obligatorio en todo script del curso: quién, cuándo y
##   para qué. Es lo primero que lee quien califica (y tú, dentro de un mes).
## - Las secciones numeradas cambian con la tarea. En las semanas de modelos:
##   1. Preparación  2. Partición y baseline  3. Modelos  4. Evaluación  5. Exportar.
## - set.seed(<semilla del enunciado>) va en la línea inmediatamente anterior
##   a sample(), rpart(), randomForest(), cv.glmnet() o kmeans().
## - Una carpeta por taller: el script en la raíz, input/ con los datos
##   originales y output/ con tablas y gráficos exportados.
## - Los talleres piden una "Declaración de uso de IA" al final: déjala como
##   comentario (herramienta, para qué la usaste, qué verificaste tú).
