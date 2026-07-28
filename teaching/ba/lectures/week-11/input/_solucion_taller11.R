## ============================================
## Taller 11 — ConectaTel: ¿quién se nos va?
## SOLUCION DE REFERENCIA (solo para el profesor)
## Correr desde week-11/input/:
##   Rscript _solucion_taller11.R
## (los estudiantes leen data/clientes_conectatel.csv;
##  aqui se lee desde ../task/)
## ============================================

## Librerías / Libraries
pacman::p_load(dplyr, rpart, rpart.plot, randomForest)

## Cargar datos / Load data
clientes <- read.csv("../task/clientes_conectatel.csv")
clientes$fuga <- as.factor(clientes$fuga)

## Radiografía
dim(clientes)                 # 350 x 6
table(clientes$fuga)          # No 245 / Si 105
## Punto 0c: clase minoritaria = "Si" (los fugados), 105/350 = 30%.
##           Es justo la clase que le importa a la VP.


## ============================================
## Punto 1 — Partición y la vara
## ============================================
set.seed(11)
idx   <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
train <- clientes[idx, ]
test  <- clientes[-idx, ]

table(train$fuga)             # No 192 / Si 88
table(test$fuga)              # No 53 / Si 17
round(max(table(test$fuga)) / nrow(test), 3)   # baseline 0.757

## 1c: la regla "nadie se fuga" acierta 75.7%... y detecta CERO fugados
##     (recall de "Si" = 0). Para la VP es inservible: su problema es
##     encontrar a los que se van, no acertar en los que se quedan.


## ============================================
## Punto 2 — El memorizador y la poda
## ============================================
set.seed(11)   # la CV interna de rpart usa el azar
memorizador <- rpart(fuga ~ ., data = train, method = "class",
                     control = rpart.control(cp = 0.0001, minsplit = 2, minbucket = 1))

sum(memorizador$frame$var == "<leaf>")   # 39 hojas
round(mean(predict(memorizador, train, type = "class") == train$fuga), 3)  # 1.000
round(mean(predict(memorizador, test,  type = "class") == test$fuga), 3)   # 0.771

## 2b: brecha 1.000 -> 0.771 = 23 puntos. AQUI el memorizador si paga:
##     con datos ruidosos, las 39 hojas son ruido aprendido de memoria.

round(memorizador$cptable, 4)
## Regla 1-SE: arbol mas pequeno que empata con el minimo (dentro de 1 xstd)
tabla_cp <- memorizador$cptable
tope     <- min(tabla_cp[, "xerror"]) + tabla_cp[which.min(tabla_cp[, "xerror"]), "xstd"]
cp_opt   <- tabla_cp[which(tabla_cp[, "xerror"] <= tope)[1], "CP"]
round(cp_opt, 4)                          # 0.0284 (tope = 0.50 + 0.069 = 0.569)
arbol <- prune(memorizador, cp = cp_opt)
sum(arbol$frame$var == "<leaf>")          # 5 hojas
rpart.plot(arbol, type = 4, extra = 104)

pred_arbol <- predict(arbol, newdata = test, type = "class")
table(Real = test$fuga, Modelo = pred_arbol)
tp <- sum(test$fuga == "Si" & pred_arbol == "Si")
fn <- sum(test$fuga == "Si" & pred_arbol == "No")
fp <- sum(test$fuga == "No" & pred_arbol == "Si")
tn <- sum(test$fuga == "No" & pred_arbol == "No")
c(tp, fn, fp, tn)                          # 8 9 8 45
round((tp + tn) / nrow(test), 3)           # accuracy 0.757
round(tp / (tp + fp), 3)                   # precision 0.500
round(tp / (tp + fn), 3)                   # recall    0.471

## 2d: el arbol podado EMPATA en accuracy con el baseline (0.757) y aun
##     asi NO es inutil: detecta 8 de 17 fugados (recall 47.1%) donde el
##     baseline detecta 0. Con clases desbalanceadas la accuracy premia
##     acertar la clase grande; la metrica del negocio aqui es el RECALL
##     de "Si". (Leccion central del taller.)


## ============================================
## Punto 3 — El bosque y el umbral de retención
## ============================================
set.seed(11)
bosque <- randomForest(fuga ~ ., data = train, ntree = 500)
pred_rf <- predict(bosque, newdata = test)
table(Real = test$fuga, Modelo = pred_rf)   # TP 11 / FN 6 / FP 5 / TN 48
round(mean(pred_rf == test$fuga), 3)        # accuracy 0.843
## precision Si = 11/16 = 0.688 ; recall Si = 11/17 = 0.647
importance(bosque)
## antiguedad_meses 36.0 > minutos_soporte 30.0 > factura 24.8 >
## reclamos 23.5 >> plan_premium 4.2

## Umbral de retencion: sobre-alertar es barato
prob_si <- predict(bosque, newdata = test, type = "prob")[, "Si"]
pred_03 <- ifelse(prob_si >= 0.3, "Si", "No")
table(Real = test$fuga, Modelo = pred_03)   # TP 12 / FN 5 / FP 16 / TN 37
tp3 <- sum(test$fuga == "Si" & pred_03 == "Si")
fn3 <- sum(test$fuga == "Si" & pred_03 == "No")
fp3 <- sum(test$fuga == "No" & pred_03 == "Si")
round(tp3 / (tp3 + fn3), 3)                 # recall 0.706
round(tp3 / (tp3 + fp3), 3)                 # precision 0.429

## 3d: con umbral 0.3 la lista de llamadas crece de 16 a 28 clientes y
##     captura 12 de los 17 fugados (recall 70.6% vs 64.7%). El costo:
##     16 falsas alarmas — pero la VP declaro que la llamada es barata
##     y perder un cliente cuesta ~18 meses de factura. Con esa
##     asimetria, el umbral bajo se justifica; el punto exacto se
##     afinaria con los costos reales.


## ============================================
## Punto 4 — MEMORANDO (referencia)
## ============================================
## Modelo a desplegar: Random Forest con umbral 0.3 (lista de llamadas).
## Cifras: detecta 12 de 17 fugas del test (70.6%); de cada 28 llamadas,
## ~12 son fugas reales. El arbol de 5 hojas queda como "vocero" del
## perfil de riesgo: clientes NUEVOS (poca antiguedad), con MUCHOS
## minutos de soporte y factura alta — el cliente reciente que llama
## mucho a quejarse es el que se va. plan_premium casi no informa.
## Riesgo: el modelo aprendio de la fuga del ANO PASADO; si la causa
## de fuga cambia (nuevo competidor, alza de tarifas), hay que
## re-entrenar. Y el test tiene solo 17 fugados: las metricas de "Si"
## se mueven con 1-2 casos.
