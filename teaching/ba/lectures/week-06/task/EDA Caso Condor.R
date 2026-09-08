##============================================================================##
# EDA Caso Condor.R  —  la base analítica de Cóndor y el arranque del EDA
#------------------------------------------------------------------------------#
# Analítica para los negocios (06327-ECO) · Semana 6 · monitoría con Santiago
# Eduard F. Martínez González
##============================================================================##

##============================================================================##
##=== 1. Configuración inicial                                             ===##
##============================================================================##
rm(list = ls())
## librerías (si falta pacman: install.packages("pacman") en la consola)
require(pacman)
p_load(dplyr, ggplot2, skimr)

## url de los datos (lineamientos del proyecto): nada se descarga ni se guarda
url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"

##============================================================================##
##=== 2. Cargar las cuatro tablas  (cada una con su propio grano)          ===##
##============================================================================##
## transacciones pesa ~15 MB: paciencia
clientes      <- read.csv(paste0(url, "base_clientes.csv"))
transacciones <- read.csv(paste0(url, "anexo_transacciones.csv"))
creditos      <- read.csv(paste0(url, "anexo_creditos.csv"))
campanas      <- read.csv(paste0(url, "anexo_campanas.csv"))

##============================================================================##
##=== 3. Regla cero: ¿qué representa una fila en cada tabla?               ===##
##============================================================================##
head(clientes, 3)
head(transacciones, 3)
head(creditos, 3)
head(campanas, 3)

## filas vs. clientes distintos: si no coinciden, hay varias filas por cliente
c(filas = nrow(clientes),      clientes = n_distinct(clientes$cliente_id))
c(filas = nrow(transacciones), clientes = n_distinct(transacciones$cliente_id))
c(filas = nrow(creditos),      clientes = n_distinct(creditos$cliente_id))
c(filas = nrow(campanas),      clientes = n_distinct(campanas$cliente_id))

## antes de correr la línea siguiente: base_clientes tiene una fila por cliente y
nrow(left_join(clientes, campanas, by = "cliente_id"))

##============================================================================##
##=== 4. Base analítica  (grano: cliente)                                  ===##
##============================================================================##

## transacciones -> una fila por cliente
tx_cliente <- transacciones %>%
              group_by(cliente_id) %>%
              summarise(n_compras         = sum(tipo == "compra"),
                        n_rechazadas      = sum(estado == "rechazada"),
                        n_fraude          = sum(etiqueta_fraude),
                        monto_promedio_tx = mean(monto),
                        .groups = "drop")

## créditos -> una fila por cliente (solo quienes pidieron crédito)
cred_cliente <- creditos %>%
                group_by(cliente_id) %>%
                summarise(n_creditos    = n(),
                          monto_credito = sum(monto_aprobado),
                          n_mora90      = sum(default_90d),
                          .groups = "drop")

## campañas -> una fila por cliente (solo quienes recibieron campañas)
camp_cliente <- campanas %>%
                group_by(cliente_id) %>%
                summarise(n_campanas    = n(),
                          n_convertidas = sum(convertido),
                          .groups = "drop")

## ¿una fila por cliente? deben coincidir con los clientes distintos del bloque 3
c(nrow(tx_cliente), nrow(cred_cliente), nrow(camp_cliente))

## unir a la base principal: left_join conserva los 8.000 clientes
base <- clientes %>%
        left_join(tx_cliente,   by = "cliente_id") %>%
        left_join(cred_cliente, by = "cliente_id") %>%
        left_join(camp_cliente, by = "cliente_id")

## radiografía de la base analítica
skim(base)

##============================================================================##
##=== 5. El EDA de SU pregunta  (de aquí en adelante, solo preguntas)      ===##
##============================================================================##
## el código va debajo de cada pregunta; cada respuesta es una salida de R y una
## línea "## HALLAZGO:". herramientas: skim(), table(), summary(), group_by() +
## summarise(), mutate(), filter(), ggplot(). solo lo que acerque a SU pregunta

## 5.1 la radiografía, leída con criterio
## - ¿qué es una fila de base? ¿cuántas filas y columnas? ¿duplicados o imposibles?
## - ¿qué columnas tienen NA? separen los "no aplica" (csat sin tickets, score sin
##   crédito, duración sin sesiones) del resto. ¿qué hacen con cada grupo y por qué
##   no conviene imputar con la mediana?


## 5.2 la variable objetivo de SU pregunta
## - ¿cuál es, en qué tabla vive y con qué grano? si vive en un anexo (fraude,
##   mora, conversión), su base analítica es ese anexo + columnas de clientes por
##   left_join: constrúyanla aquí con la lógica del bloque 4 y verifiquen las filas
## - ¿cómo se distribuye? binario: la proporción de 1 es su baseline. continuo:
##   histograma, media y mediana


## 5.3 las variables candidatas
## - tres o cuatro que, según la pregunta, deberían relacionarse con el target;
##   digan por qué antes de mirarlas
## - histograma o tabla de frecuencias de cada una: ¿cola larga? ¿media ≈ mediana?
## - el caso más extremo, en su FILA COMPLETA: ¿error de captura o cliente distinto?


## 5.4 comparaciones por grupo
## - tasa (target binario) o mediana (continuo) por tramos de las candidatas:
##   group_by() + summarise(); las numéricas primero en tramos con cut()
## - incluyan una variable que creían importante (ciudad, canal, ocupación):
##   ¿discrimina o sale plana? ¿cuántos clientes hay en cada grupo?


## 5.5 relaciones entre señales
## - las dos que más discriminan: ¿miden lo mismo o se complementan? un cruce o un
##   gráfico de dispersión coloreado por el target. si dicen lo mismo, ¿cuál queda?


## 5.6 lo que NO pueden usar
## - ¿qué columnas se conocen DESPUÉS del evento que quieren anticipar (dias_mora,
##   monto_recuperado, gasto_proximo_trim...)? fuera de los predictores, y anótenlo


## 5.7 cierre: acta y hallazgos
## - tres HALLAZGOS con número, para alguien de Cóndor que no sabe R
## - dos HIPÓTESIS para el modelo
## - el ACTA: faltantes, extremos, columnas excluidas y por qué (cinco líneas)
## - guarden su base analítica en data/ (write.csv): es el arranque de la Entrega 2


##============================================================================##
## DECLARACIÓN DE USO DE IA
## Herramienta y modelo usados: _______________ (o "No usamos IA")
## La usamos para: _______________________________
## Verificamos por nuestra cuenta: ____________________
##============================================================================##
