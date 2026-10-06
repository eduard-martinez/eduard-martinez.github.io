##============================================================================##
# script_clase10.R  —  ¿qué tan buenas son las predicciones de los proveedores?
#------------------------------------------------------------------------------#
# Analítica para los negocios (06327-ECO) · Semana 10 · script de la clase
# Dos proveedores le entregaron a Growth, cliente por cliente, la predicción de
# su modelo: quién abandonará Cóndor. Hoy no se entrena nada: se comparan sus
# predicciones con lo que de verdad pasó. Lee desde la URL:
#   - base_clientes.csv          (grano: cliente; abandono = 1 si se fue)
#   - predicciones_modelo_a.csv  (grano: cliente evaluado; pred_a = 1: se va)
#   - predicciones_modelo_b.csv  (grano: cliente evaluado; pred_b = 1: se va)
# El bloque 5, al final, es el taller: se responde y se entrega este archivo.
# Nombre: _______________
##============================================================================##

##============================================================================##
##=== 0. Configuración inicial                                             ===##
##============================================================================##
rm(list = ls())
## librerías (si falta pacman: install.packages("pacman") en la consola)
require(pacman)
p_load(dplyr)

## la base de Cóndor y la carpeta de la página del curso con las predicciones
url_base <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/base_clientes.csv"
url_pred <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-10/script/"

clientes <- read.csv(url_base)
dim(clientes)
## checkpoint: 8000 filas y 29 columnas: una fila por cliente

##============================================================================##
##=== 1. Las predicciones del proveedor A                                  ===##
##============================================================================##
## pregunta: el proveedor A predijo, cliente por cliente, quién se iba
## (pred_a = 1). ¿acertó? a cada predicción se le pega lo que pasó (abandono)
modelo_a <- read.csv(paste0(url_pred, "predicciones_modelo_a.csv"))
dim(modelo_a)

modelo_a <- modelo_a %>%
            left_join(clientes %>% select(cliente_id, abandono),
                      by = "cliente_id")

## cada predicción cae en una de cuatro casillas
modelo_a <- modelo_a %>%
            mutate(resultado = case_when(pred_a == 1 & abandono == 1 ~ "TP",
                                         pred_a == 1 & abandono == 0 ~ "FP",
                                         pred_a == 0 & abandono == 1 ~ "FN",
                                         pred_a == 0 & abandono == 0 ~ "TN"))
head(modelo_a, 12)
table(modelo_a$resultado)
## checkpoint: 1.600 clientes evaluados, los que ningún modelo vio al
## entrenar. el proveedor A tiene 77 TP, 33 FP, 277 FN y 1.213 TN
##   TP: predijo que se iba y se fue
##   FP: predijo que se iba y se quedó (un envío de más)
##   FN: predijo que se quedaba y se fue (un cliente perdido)
##   TN: predijo que se quedaba y se quedó

##============================================================================##
##=== 2. Las predicciones del proveedor B                                  ===##
##============================================================================##
## pregunta: lo mismo con la lista del proveedor B
modelo_b <- read.csv(paste0(url_pred, "predicciones_modelo_b.csv"))

modelo_b <- modelo_b %>%
            left_join(clientes %>% select(cliente_id, abandono),
                      by = "cliente_id")

modelo_b <- modelo_b %>%
            mutate(resultado = case_when(pred_b == 1 & abandono == 1 ~ "TP",
                                         pred_b == 1 & abandono == 0 ~ "FP",
                                         pred_b == 0 & abandono == 1 ~ "FN",
                                         pred_b == 0 & abandono == 0 ~ "TN"))
head(modelo_b, 12)
table(modelo_b$resultado)
## checkpoint: el proveedor B tiene 211 TP, 236 FP, 143 FN y 1.010 TN

##============================================================================##
##=== 3. La línea base: no enviarle la campaña a nadie                     ===##
##============================================================================##
## la decisión sin modelo: predecir que nadie se va (la clase mayoritaria). no
## cuesta nada; un proveedor solo sirve si lo que encuentra vale lo que cuesta
linea_base <- modelo_a %>%
              select(cliente_id, abandono) %>%
              mutate(resultado = ifelse(abandono == 1, "FN", "TN"))
table(linea_base$resultado)
## checkpoint: 354 FN y 1.246 TN: no cuesta nada, pero no encuentra a
## ninguno de los 354 que se van

##============================================================================##
##=== 4. Las tres opciones, lado a lado                                    ===##
##============================================================================##
## pregunta: ¿cuál de las tres opciones clasifica mejor? cada métrica responde
## una pregunta distinta. primero, las cuatro casillas de cada opción
resumen_base <- linea_base %>%
                summarise(opcion = "línea base",
                          TP = sum(resultado == "TP"),
                          FP = sum(resultado == "FP"),
                          FN = sum(resultado == "FN"),
                          TN = sum(resultado == "TN"))

resumen_a <- modelo_a %>%
             summarise(opcion = "proveedor A",
                       TP = sum(resultado == "TP"),
                       FP = sum(resultado == "FP"),
                       FN = sum(resultado == "FN"),
                       TN = sum(resultado == "TN"))

resumen_b <- modelo_b %>%
             summarise(opcion = "proveedor B",
                       TP = sum(resultado == "TP"),
                       FP = sum(resultado == "FP"),
                       FN = sum(resultado == "FN"),
                       TN = sum(resultado == "TN"))

## una fila por opción, con sus envíos y sus tres métricas:
## accuracy:  ¿qué fracción de los 1.600 clasificó bien?       (TP + TN) / total
## precisión: de los que reciben la campaña, ¿cuántos se iban? TP / (TP + FP)
## recall:    de los que se iban, ¿a cuántos encontró?         TP / (TP + FN)
comparacion <- bind_rows(resumen_base, resumen_a, resumen_b) %>%
               mutate(envios    = TP + FP,
                      accuracy  = round((TP + TN) / (TP + FP + FN + TN), 3),
                      precision = round(TP / (TP + FP), 3),
                      recall    = round(TP / (TP + FN), 3))
comparacion
## checkpoint: el proveedor A tiene la mejor accuracy (0.806) y precisión
## (0.700); el B, el mejor recall (0.596). la línea base acierta 0.779 sin
## encontrar a nadie, y su precisión sale NaN porque no le envía a nadie

##============================================================================##
##=== 5. Taller: ¿qué decisión le sale más barata a Growth?                ===##
##============================================================================##
## responde como comentarios, con las cifras de tu tabla comparacion; puedes
## agregar las líneas de código que necesites. guarda el archivo como
## apellido_nombre_taller10.R y súbelo a Intu.
## el costo de oportunidad: enviarle la campaña a un cliente cuesta $2.250, se
## vaya o no. dejar ir a un cliente sin haberle enviado la campaña (un FN) le
## cuesta a Cóndor $5.000: lo que la campaña habría recuperado, en promedio, si
## lo hubiera encontrado.

## pregunta 1. calcula el costo total de cada decisión: enviarle la campaña a la
## lista del proveedor A, a la del proveedor B o no enviársela a nadie
## (costo total = envíos x 2.250 + FN x 5.000). ¿cuál es la más barata?
## respuesta:

## pregunta 2. ¿por qué descartas las otras dos? ¿cambia tu decisión si dejar ir
## a un cliente cuesta $3.000? no adoptar ningún modelo también es una respuesta
## válida.
## respuesta:


