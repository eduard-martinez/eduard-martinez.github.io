## ============================================
## Semana 12 — Verificación de cifras de la práctica
## (reproduce EXACTAMENTE el código del estudiante y
##  imprime los checkpoints que van en la página)
## Correr desde week-12/input/:
##   Rscript _verificacion_practica12.R
## ============================================

library(dplyr)
library(rpart)
library(rpart.plot)
library(randomForest)
library(glmnet)

mets <- function(real, pred) {
  c(MAE  = round(mean(abs(real - pred)), 3),
    RMSE = round(sqrt(mean((real - pred)^2)), 3))
}

## ── Paso 1: cargar y partir ──
notas <- read.csv("notas_regresion.csv")
set.seed(12)
idx   <- sample(1:nrow(notas), size = round(0.8 * nrow(notas)))
train <- notas[idx, ]
test  <- notas[-idx, ]
cat("== dims ==\n"); print(dim(train)); print(dim(test))

## ── Paso 2: baseline ──
media_train <- round(mean(train$nota_final), 2)
cat("media de train:", media_train, "\n")
cat("baseline en test:\n"); print(mets(test$nota_final, media_train))

## ── Paso 3: Lasso con CV ──
x_train <- model.matrix(nota_final ~ ., data = train)[, -1]
y_train <- train$nota_final
x_test  <- model.matrix(nota_final ~ ., data = test)[, -1]

set.seed(12)   # los pliegues de la CV usan el azar
lasso_cv <- cv.glmnet(x = x_train, y = y_train, alpha = 1)
cat("\n== lasso ==\n")
cat("lambda.1se:", round(lasso_cv$lambda.1se, 4), "\n")
cat("coeficientes en lambda.1se:\n")
print(round(as.matrix(coef(lasso_cv, s = "lambda.1se")), 4))
pred_lasso <- as.numeric(predict(lasso_cv, newx = x_test, s = "lambda.1se"))
cat("metricas lasso test:\n"); print(mets(test$nota_final, pred_lasso))

## ── Paso 4: arbol de regresion con poda 1-SE ──
set.seed(12)
arbol <- rpart(nota_final ~ ., data = train, method = "anova")
cat("\n== arbol ==\n")
print(round(arbol$cptable, 4))
tabla_cp <- arbol$cptable
tope     <- min(tabla_cp[, "xerror"]) + tabla_cp[which.min(tabla_cp[, "xerror"]), "xstd"]
cp_opt   <- tabla_cp[which(tabla_cp[, "xerror"] <= tope)[1], "CP"]
cat("tope 1-SE:", round(tope, 4), "| cp:", round(cp_opt, 4), "\n")
arbol_podado <- prune(arbol, cp = cp_opt)
cat("hojas podado:", sum(arbol_podado$frame$var == "<leaf>"), "\n")
pred_arbol <- predict(arbol_podado, newdata = test)
cat("metricas arbol test:\n"); print(mets(test$nota_final, pred_arbol))

## ── Paso 5: random forest ──
set.seed(12)
bosque <- randomForest(nota_final ~ ., data = train, ntree = 500)
pred_rf <- predict(bosque, newdata = test)
cat("\n== bosque ==\n")
cat("metricas RF test:\n"); print(mets(test$nota_final, pred_rf))
cat("importancia:\n"); print(round(importance(bosque), 1))

## ── Torneo ──
cat("\n== TORNEO (MAE / RMSE en test) ==\n")
cat("baseline:", mets(test$nota_final, media_train), "\n")
cat("lasso   :", mets(test$nota_final, pred_lasso), "\n")
cat("arbol   :", mets(test$nota_final, pred_arbol), "\n")
cat("bosque  :", mets(test$nota_final, pred_rf), "\n")
