## Analitica para los negocios (06327-ECO)
## week-10: ¿que tan buenas son las predicciones de los proveedores? (clase + taller)
## Nombre: _______________

##==: 0. initial setup :==##

## clean environment
rm(list = ls())

## load/install packages
require(pacman)
p_load(dplyr)

## load data (la base de Condor: una fila por cliente; abandono = 1 si se fue)
url_base <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/base_clientes.csv"
url_pred <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-10/script/"
clientes <- read.csv(url_base)
dim(clientes)

##==: 1. proveedor A :==##

## 1.1. load data (pred_a = 1: el modelo dice que el cliente se va)
modelo_a <- read.csv(paste0(url_pred, "predicciones_modelo_a.csv"))
dim(modelo_a)

## 1.2. pegarle a cada prediccion lo que de verdad paso
modelo_a <- modelo_a %>%
            left_join(clientes %>% select(cliente_id, abandono),
                      by = "cliente_id")

## 1.3. cada prediccion cae en una casilla: TP (dijo se va y se fue), FP (un
## envio de mas), FN (un cliente perdido), TN (dijo se queda y se quedo)
modelo_a <- modelo_a %>%
            mutate(resultado = case_when(pred_a == 1 & abandono == 1 ~ "TP",
                                         pred_a == 1 & abandono == 0 ~ "FP",
                                         pred_a == 0 & abandono == 1 ~ "FN",
                                         pred_a == 0 & abandono == 0 ~ "TN"))
head(modelo_a, 12)
table(modelo_a$resultado)

##==: 2. proveedor B :==##

## 2.1. lo mismo con la lista del proveedor B
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

##==: 3. la linea base: no enviarle la campaña a nadie :==##

## 3.1. la decision sin modelo: predecir que nadie se va (la clase mayoritaria)
linea_base <- modelo_a %>%
              select(cliente_id, abandono) %>%
              mutate(resultado = ifelse(abandono == 1, "FN", "TN"))
table(linea_base$resultado)

##==: 4. las tres opciones, lado a lado :==##

## 4.1. las cuatro casillas de cada opcion
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

## 4.2. una fila por opcion: accuracy = (TP+TN)/total , precision = TP/(TP+FP) ,
## recall = TP/(TP+FN)
comparacion <- bind_rows(resumen_base, resumen_a, resumen_b) %>%
               mutate(envios    = TP + FP,
                      accuracy  = round((TP + TN) / (TP + FP + FN + TN), 3),
                      precision = round(TP / (TP + FP), 3),
                      recall    = round(TP / (TP + FN), 3))
comparacion

##==: 5. taller :==##

## el costo de oportunidad: enviarle la campaña a un cliente cuesta $2.250, se
## vaya o no; dejar ir a un cliente sin campaña (un FN) le cuesta a Condor
## $5.000. responde como comentarios, con las cifras de tu tabla comparacion;
## puedes agregar las lineas de codigo que necesites. guarda el archivo como
## apellido_nombre_taller10.R y subelo a Intu.

## 5.1. calcula el costo total de cada decision: la lista del proveedor A, la
## del B o no enviarle a nadie (costo total = envios x 2.250 + FN x 5.000).
## ¿cual es la mas barata?
## respuesta:

## 5.2. ¿por que descartas las otras dos? ¿cambia tu decision si dejar ir a un
## cliente cuesta $3.000? no adoptar ningun modelo tambien es una respuesta
## valida.
## respuesta:
