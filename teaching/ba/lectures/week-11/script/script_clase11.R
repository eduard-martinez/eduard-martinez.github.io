## Analitica para los negocios (06327-ECO)
## week-11: el primer arbol de la casa (clase + taller)
## Nombre: _______________

##==: 0. initial setup :==##

## clean environment
rm(list = ls())

## load/install packages
require(pacman)
p_load(dplyr, rpart, rpart.plot)

##==: 1. prepare data :==##

## 1.1. load data (la base de Condor: una fila por cliente; abandono = 1 si se fue)
url_base <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/base_clientes.csv"
clientes <- read.csv(url_base)
dim(clientes)

## 1.2. el target (abandono, como categoria) y cinco señales que existen el dia
## de la decision y no tienen vacios
clientes <- clientes %>%
            select(cliente_id, abandono, recencia_dias, num_sesiones_ult30d,
                   frecuencia_tx, antiguedad_meses, gasto_promedio_mensual) %>%
            mutate(abandono = factor(abandono))

## 1.3. split data: el 80% aprende y con el 20% que no vio se califica
set.seed(10)
idx_train <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
train <- clientes[idx_train, ]
test  <- clientes[-idx_train, ]

nrow(train)
nrow(test)
table(test$abandono)

##==: 2. arbol de decision :==##

## 2.1. estimar el arbol con las opciones por defecto de rpart
arbol <- rpart(abandono ~ recencia_dias + num_sesiones_ult30d + frecuencia_tx +
                          antiguedad_meses + gasto_promedio_mensual,
               data = train, method = "class")

## 2.2. dibujarlo: cada caja trae la clase que predice (1 = se va), cuantos se
## quedaron y cuantos se fueron (ceros | unos) y el % que cae ahi
rpart.plot(arbol, extra = 101)

##==: 3. predicciones y matriz de confusion :==##

## 3.1. predecir con los 1.600 que el arbol no vio
test <- test %>%
        mutate(pred_arbol = predict(arbol, newdata = test, type = "class"))

## 3.2. la matriz: en la fila Real = 1 estan los que se fueron
table(Real = test$abandono, Prediccion = test$pred_arbol)

##==: 4. taller :==##

## el arbol de la clase usa los frenos de fabrica de rpart y quedo con 3
## hojas. entrena tu propia version cambiandole algo: dale mas profundidad
## agregando dentro de rpart() el argumento que viste en la teoria,
##   control = rpart.control(maxdepth = 4, cp = 0, minsplit = 2, minbucket = 1)
## (puedes usar otra profundidad en vez de 4). guarda el archivo como
## apellido_nombre_taller11.R y subelo a Intu.

## 4.1. entrena tu arbol, pintalo con rpart.plot(tu_arbol, extra = 101) y saca
## su matriz de confusion en el test, como en 3.2.
## tu codigo:

## 4.2. compara las dos matrices y responde como comentario: ¿tu arbol
## encuentra a mas de los 354 que se van? ¿cuantos envios de mas hace (FP)?
## ¿con cual de los dos te quedas para la campaña de Growth y por que?
## respuesta:
