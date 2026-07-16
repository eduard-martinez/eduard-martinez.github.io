## ============================================
## Taller 12 — InmoValle: el avaluador instantáneo
## SOLUCION DE REFERENCIA (solo para el profesor)
## Correr desde week-12/input/:
##   Rscript _solucion_taller12.R
## (los estudiantes leen data/apartamentos_cali.csv;
##  aqui se lee desde ../task/)
## ============================================

## Librerías / Libraries
pacman::p_load(dplyr, rpart, rpart.plot, randomForest, glmnet)

mets <- function(real, pred) {
  c(MAE  = round(mean(abs(real - pred)), 1),
    RMSE = round(sqrt(mean((real - pred)^2)), 1))
}

## Cargar datos / Load data
apartamentos <- read.csv("../task/apartamentos_cali.csv")
dim(apartamentos)              # 320 x 8
summary(apartamentos$precio_millones)
## 0c: target = precio_millones (continuo) -> REGRESION; la metrica
##     va en millones de pesos (MAE = "me equivoco por X millones").


## ============================================
## Punto 1 — Partición y baseline
## ============================================
set.seed(12)
idx   <- sample(1:nrow(apartamentos), size = round(0.8 * nrow(apartamentos)))
train <- apartamentos[idx, ]
test  <- apartamentos[-idx, ]
dim(train); dim(test)          # 256 / 64

media_train <- round(mean(train$precio_millones), 1)
media_train                    # 326
mets(test$precio_millones, media_train)   # MAE 86.8 | RMSE 108.4
## 1c: "todo apartamento vale 326M" se equivoca en promedio por ~87M.
##     Esa es la vara del torneo.


## ============================================
## Punto 2 — El Lasso y la formula publicable
## ============================================
x_train <- model.matrix(precio_millones ~ ., data = train)[, -1]
x_test  <- model.matrix(precio_millones ~ ., data = test)[, -1]

set.seed(12)   # los pliegues de la CV usan el azar
lasso_cv <- cv.glmnet(x = x_train, y = train$precio_millones, alpha = 1)
round(lasso_cv$lambda.1se, 2)             # 5.27
round(as.matrix(coef(lasso_cv, s = "lambda.1se")), 3)
##  (Intercept)          12.9
##  area_m2               2.703   <- cada m2 suma ~2.7M
##  habitaciones          0.549   <- casi nada (el area ya lo cuenta)
##  banos                11.855
##  estrato              31.935   <- cada nivel de estrato ~32M
##  piso                  0.000   <- EXPULSADA por el Lasso
##  distancia_centro_km  -3.913   <- cada km resta ~3.9M
##  antiguedad_anos      -0.688

pred_lasso <- as.numeric(predict(lasso_cv, newx = x_test, s = "lambda.1se"))
mets(test$precio_millones, pred_lasso)    # MAE 35.0 | RMSE 43.7

## 2c: el Lasso expulso "piso" (coeficiente exactamente 0) y dejo
##     "habitaciones" casi en cero: con el area en el modelo, las
##     habitaciones no agregan informacion (redundantes). Eso ES la
##     seleccion de variables automatica.


## ============================================
## Punto 3 — Arbol podado y bosque
## ============================================
set.seed(12)
arbol <- rpart(precio_millones ~ ., data = train, method = "anova")
tabla_cp <- arbol$cptable
tope     <- min(tabla_cp[, "xerror"]) + tabla_cp[which.min(tabla_cp[, "xerror"]), "xstd"]
cp_opt   <- tabla_cp[which(tabla_cp[, "xerror"] <= tope)[1], "CP"]
round(cp_opt, 4)                          # 0.0126
arbol_podado <- prune(arbol, cp = cp_opt)
sum(arbol_podado$frame$var == "<leaf>")   # 11 hojas
pred_arbol <- predict(arbol_podado, newdata = test)
mets(test$precio_millones, pred_arbol)    # MAE 44.7 | RMSE 57.0

set.seed(12)
bosque <- randomForest(precio_millones ~ ., data = train, ntree = 500)
pred_rf <- predict(bosque, newdata = test)
mets(test$precio_millones, pred_rf)       # MAE 39.2 | RMSE 47.5
importance(bosque)                        # area >> habitaciones ~ estrato > ...

## Torneo:
## baseline 86.8/108.4 | lasso 35.0/43.7 | arbol 44.7/57.0 | bosque 39.2/47.5
## GANA EL LASSO — al reves de la semana 11. El proceso que fija los
## precios es (casi) lineal, y en cancha lineal el modelo lineal manda.


## ============================================
## Punto 4 — MEMORANDO (referencia)
## ============================================
## a) Despliegue: el Lasso. No solo es el mas preciso (MAE 35M contra
##    39M del bosque y 87M de la regla tonta): entrega una FORMULA que
##    InmoValle puede publicar en su web — cada m2 suma ~2.7M, cada
##    nivel de estrato ~32M, cada bano ~12M, cada km lejos del centro
##    resta ~3.9M y cada ano de antiguedad ~0.7M. Piso no importa.
## b) La letra menuda: su RMSE (43.7) queda bastante por encima del
##    MAE (35) -> hay embarradas ocasionales. Mirando residuales, se
##    concentran en apartamentos de ESTRATO 6: el mercado de lujo paga
##    una prima que una recta no captura. Recomendacion: formula
##    automatica para estratos 2-5, avaluo con perito para el 6.
## c) Riesgo: el modelo aprendio de ventas pasadas de Cali; si el
##    mercado se recalienta o cambia por zonas, recalibrar. Y la
##    formula NO es causal: subirle un bano a tu apartamento no le
##    "agrega" 12M — el coeficiente describe el mercado, no renova.
