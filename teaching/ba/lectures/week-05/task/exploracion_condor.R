## ============================================
## Taller 5 — Exploración del Caso Cóndor
## Curso: Analítica para los negocios (06327-ECO)
## Autor: Eduard F. Martínez González
## Objetivo: conocer las tablas del caso ANTES de formular preguntas
## ============================================

## -------------------------------------------- ##
## 1. Librerías (pacman instala lo que falte y lo carga)
# install.packages("pacman")
require(pacman)
p_load(dplyr, skimr)

## -------------------------------------------- ##
## 2. Cargar las cuatro tablas del caso (desde la página del curso)
base_clientes <- read.csv("https://eduard-martinez.github.io/teaching/ba/final_project/data/base_clientes.csv")
transacciones <- read.csv("https://eduard-martinez.github.io/teaching/ba/final_project/data/anexo_transacciones.csv")
creditos      <- read.csv("https://eduard-martinez.github.io/teaching/ba/final_project/data/anexo_creditos.csv")
campanas      <- read.csv("https://eduard-martinez.github.io/teaching/ba/final_project/data/anexo_campanas.csv")

## -------------------------------------------- ##
## 3. Radiografía general: ¿cuántas filas y qué variables trae cada tabla?
## (usa glimpse() y skim() con cada una; anota qué es una fila en cada tabla)
glimpse(base_clientes)



## Interpretación: ¿qué es una fila en cada tabla? ¿qué variables te llaman la atención?
##

## -------------------------------------------- ##
## 4. La llave del caso: cliente_id
## ¿Cuántos clientes hay en la base principal? ¿Todos aparecen en los anexos?
n_distinct(base_clientes$cliente_id)



## Interpretación:
##

## -------------------------------------------- ##
## 5. Explora las variables que podrían ser un target
## (ej.: etiqueta_fraude en transacciones, default_90d en creditos,
##  convertido en campanas — ¿qué proporción tiene cada categoría?)
table(transacciones$etiqueta_fraude)



## Interpretación: ¿qué preguntas de negocio sugieren estos targets?
##

## -------------------------------------------- ##
## 6. Cruza una tabla con la base de clientes
## (ej.: ¿los clientes con crédito se ven distintos a los demás?)
con_credito <- creditos %>% distinct(cliente_id) %>% mutate(tiene_credito = 1)
clientes_credito <- left_join(base_clientes, con_credito, by = "cliente_id")



## Interpretación:
##
