##============================================================================##
# script_clase11.R  —  el primer árbol de la casa
#------------------------------------------------------------------------------#
# Analítica para los negocios (06327-ECO) · Semana 11 · script de la clase
# Cóndor entrena su propio árbol de decisión para predecir el abandono y lo
# califica con clientes que el árbol no vio. Lee desde la URL:
#   - base_clientes.csv  (grano: cliente; abandono = 1 si se fue)
# El bloque 4, al final, es el taller: se responde y se entrega este archivo.
# Nombre: _______________
##============================================================================##

##============================================================================##
##=== 0. Los datos y las variables                                         ===##
##============================================================================##
rm(list = ls())
## librerías (si falta pacman: install.packages("pacman") en la consola)
require(pacman)
p_load(dplyr, rpart, rpart.plot)

## la base de Cóndor
url_base <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/base_clientes.csv"
clientes <- read.csv(url_base)
dim(clientes)

## de una vez elegimos las variables: el target (abandono, como categoría) y
## cinco señales que existen el día de la decisión y no tienen vacíos
clientes <- clientes %>%
            select(cliente_id, abandono, recencia_dias, num_sesiones_ult30d,
                   frecuencia_tx, antiguedad_meses, gasto_promedio_mensual) %>%
            mutate(abandono = factor(abandono))
## checkpoint: 8.000 filas; quedan 7 columnas, una fila por cliente

##============================================================================##
##=== 1. Entrenamiento y testeo                                            ===##
##============================================================================##
## pregunta: ¿cómo sabemos si el árbol generaliza y no se memoriza la
## respuesta? con el 80 % aprende; con el 20 % que no vio, se califica
set.seed(10)
idx_train <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
train <- clientes[idx_train, ]
test  <- clientes[-idx_train, ]

nrow(train)
nrow(test)
table(test$abandono)
## checkpoint: 6.400 entrenan y 1.600 califican (los mismos de la semana 10);
## de los 1.600, se fueron 354

##============================================================================##
##=== 2. Entrenar el árbol y pintarlo                                      ===##
##============================================================================##
## pregunta: ¿qué preguntas aprende a hacer? rpart prueba todos los cortes y
## elige, en cada paso, el que mejor separa a quienes se van
arbol <- rpart(abandono ~ recencia_dias + num_sesiones_ult30d + frecuencia_tx +
                          antiguedad_meses + gasto_promedio_mensual,
               data = train, method = "class")

rpart.plot(arbol, extra = 101)
## cada caja: la clase que predice (1 = se va), cuántos se quedaron y cuántos
## se fueron (ceros | unos) y el % de los clientes que cae ahí
## checkpoint: 2 nodos de decisión y 3 hojas. pregunta 1: ¿frecuencia_tx >= 9?
## pregunta 2 (solo si transa poco): ¿recencia_dias < 158? la única hoja que
## predice «se va» tiene 94 que se quedaron y 269 que se fueron

##============================================================================##
##=== 3. Predicciones y matriz de confusión                                ===##
##============================================================================##
## pregunta: ¿cómo le fue con los 1.600 que no vio?
test <- test %>%
        mutate(pred_arbol = predict(arbol, newdata = test, type = "class"))

table(Real = test$abandono, Prediccion = test$pred_arbol)
## checkpoint: en la fila Real = 1 están los 354 que se fueron: el árbol
## encontró a 59 (TP) y se le escaparon 295 (FN). en la fila Real = 0, le
## envió la campaña de más a 17 (FP) y acertó con 1.229 (TN)

##============================================================================##
##=== 4. Taller: tu propio árbol                                           ===##
##============================================================================##
## el árbol de la clase usa los frenos de fábrica de rpart y quedó con 3
## hojas. entrena tu propia versión cambiándole algo: dale más profundidad
## agregando dentro de rpart() el argumento que viste en la teoría,
##   control = rpart.control(maxdepth = 4, cp = 0, minsplit = 2, minbucket = 1)
## (puedes usar otra profundidad en vez de 4). guarda el archivo como
## apellido_nombre_taller11.R y súbelo a Intu.

## pregunta 1. entrena tu árbol, píntalo con rpart.plot(tu_arbol, extra = 101)
## y saca su matriz de confusión en el test, como en el bloque 3.
## tu código:

## pregunta 2. compara las dos matrices y responde como comentario: ¿tu árbol
## encuentra a más de los 354 que se van? ¿cuántos envíos de más hace (FP)?
## ¿con cuál de los dos te quedas para la campaña de Growth y por qué?
## respuesta:
