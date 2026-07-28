## ============================================================
##  Introduccion al Business Analytics (06278-ECO)
##  Semana 12 | Script de generacion de datos
##  apartamentos_cali.csv  (taller 12)
##  Universidad Icesi | Periodo 2026-01
## ============================================================
##
##  DESCRIPCION
##  Genera el dataset sintetico del Taller 12: 320 apartamentos
##  vendidos en Cali por la inmobiliaria "InmoValle", con sus
##  caracteristicas y el precio de venta en millones de pesos.
##
##  VARIABLES
##  - area_m2            : area construida
##  - habitaciones       : 1 a 4 (correlacionada con el area)
##  - banos              : 1 a 3
##  - estrato            : 2 a 6
##  - piso               : 1 a 15 (aporte casi nulo al precio)
##  - distancia_centro_km: distancia al centro de la ciudad
##  - antiguedad_anos    : anos desde la construccion
##  - precio_millones    : precio de venta (target)
##
##  NOTA DE DISENO (verificada abajo):
##  - El proceso es mayormente LINEAL (area, estrato, banos,
##    distancia, antiguedad) + un SALTO no lineal: los estrato 6
##    pagan una prima fija de 60M (mercado de lujo). Por eso el
##    bosque le gana por poco al Lasso, pero el Lasso entrega la
##    ecuacion legible -> trade-off real para el memorando.
##  - "piso" tiene aporte ~0 y "habitaciones" es casi redundante
##    con el area: el Lasso (lambda.1se) los saca del modelo.
##
##  USO:  cd week-12/input && Rscript _generar_apartamentos.R
## ============================================================

rm(list = ls())
set.seed(1207)
n <- 320

area_m2      <- round(pmax(32, pmin(180, rnorm(n, mean = 78, sd = 26))))
habitaciones <- pmax(1, pmin(4, round(area_m2 / 35 + rnorm(n, 0, 0.5))))
banos        <- pmax(1, pmin(3, round(habitaciones / 1.4 + rnorm(n, 0, 0.45))))
estrato      <- sample(2:6, size = n, replace = TRUE,
                       prob = c(0.15, 0.30, 0.25, 0.18, 0.12))
piso         <- sample(1:15, size = n, replace = TRUE)
distancia_centro_km <- round(runif(n, min = 1, max = 15), 1)
antiguedad_anos     <- sample(0:40, size = n, replace = TRUE)

precio_raw <- 3.1 * area_m2 +
              27  * estrato +
              60  * (estrato == 6) +      # prima de lujo (salto no lineal)
              14  * banos +
              2.5 * habitaciones +
              0.3 * piso +                # aporte despreciable
              -5.5 * distancia_centro_km +
              -0.9 * antiguedad_anos +
              rnorm(n, mean = 0, sd = 34)

precio_millones <- round(pmax(85, precio_raw))

apartamentos <- data.frame(area_m2, habitaciones, banos, estrato, piso,
                           distancia_centro_km, antiguedad_anos,
                           precio_millones)
apartamentos <- apartamentos[sample(1:n), ]
rownames(apartamentos) <- NULL

write.csv(apartamentos, "../task/apartamentos_cali.csv", row.names = FALSE)

## ── Verificacion de la historia pedagogica ──────────────────
library(rpart)
library(randomForest)
library(glmnet)

mets <- function(real, pred) {
  c(MAE  = round(mean(abs(real - pred)), 1),
    RMSE = round(sqrt(mean((real - pred)^2)), 1))
}

set.seed(12)
idx   <- sample(1:n, size = round(0.8 * n))
train <- apartamentos[idx, ]
test  <- apartamentos[-idx, ]
cat("== dims ==\n"); print(dim(train)); print(dim(test))

media_train <- round(mean(train$precio_millones), 1)
cat("media train:", media_train, "\n")
cat("baseline test:\n"); print(mets(test$precio_millones, media_train))

## Lasso
x_tr <- model.matrix(precio_millones ~ ., data = train)[, -1]
x_te <- model.matrix(precio_millones ~ ., data = test)[, -1]
set.seed(12)
lasso_cv <- cv.glmnet(x = x_tr, y = train$precio_millones, alpha = 1)
cat("\nlambda.1se:", round(lasso_cv$lambda.1se, 3), "\n")
print(round(as.matrix(coef(lasso_cv, s = "lambda.1se")), 3))
pred_lasso <- as.numeric(predict(lasso_cv, newx = x_te, s = "lambda.1se"))
cat("lasso test:\n"); print(mets(test$precio_millones, pred_lasso))

## Arbol podado 1-SE
set.seed(12)
arbol <- rpart(precio_millones ~ ., data = train, method = "anova")
tabla <- arbol$cptable
tope  <- min(tabla[, "xerror"]) + tabla[which.min(tabla[, "xerror"]), "xstd"]
cp_o  <- tabla[which(tabla[, "xerror"] <= tope)[1], "CP"]
podado <- prune(arbol, cp = cp_o)
cat("\ncp 1-SE:", round(cp_o, 4), "| hojas:", sum(podado$frame$var == "<leaf>"), "\n")
pred_arb <- predict(podado, newdata = test)
cat("arbol test:\n"); print(mets(test$precio_millones, pred_arb))

## Bosque
set.seed(12)
rf <- randomForest(precio_millones ~ ., data = train, ntree = 500)
pred_rf <- predict(rf, newdata = test)
cat("\nbosque test:\n"); print(mets(test$precio_millones, pred_rf))
cat("importancia:\n"); print(round(importance(rf), 0))

cat("\n== TORNEO (MAE / RMSE) ==\n")
cat("baseline:", mets(test$precio_millones, media_train), "\n")
cat("lasso   :", mets(test$precio_millones, pred_lasso), "\n")
cat("arbol   :", mets(test$precio_millones, pred_arb), "\n")
cat("bosque  :", mets(test$precio_millones, pred_rf), "\n")
