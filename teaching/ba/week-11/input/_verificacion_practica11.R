## ============================================
## Semana 11 — Verificación de cifras de la práctica
## (solo para el profesor: reproduce EXACTAMENTE el
##  código que corre el estudiante y imprime los
##  checkpoints que van en la página)
## Correr desde week-11/input/:
##   Rscript _verificacion_practica11.R
## ============================================

library(dplyr)
library(rpart)
library(rpart.plot)
library(randomForest)

met <- function(real, pred, positivo = "Aprobado") {
  tp <- sum(real == positivo & pred == positivo)
  fn <- sum(real == positivo & pred != positivo)
  fp <- sum(real != positivo & pred == positivo)
  tn <- sum(real != positivo & pred != positivo)
  c(TP = tp, FN = fn, FP = fp, TN = tn,
    accuracy  = round((tp + tn) / length(real), 3),
    precision = round(tp / (tp + fp), 3),
    recall    = round(tp / (tp + fn), 3))
}

## ── Paso 1: cargar y partir (como el estudiante) ──
credito <- read.csv("credito_clasificacion.csv")
credito$decision <- as.factor(credito$decision)

set.seed(11)
n         <- nrow(credito)
idx_train <- sample(1:n, size = round(0.8 * n))
train     <- credito[idx_train, ]
test      <- credito[-idx_train, ]

cat("== dims ==\n"); print(dim(train)); print(dim(test))
cat("== distribucion train ==\n"); print(table(train$decision))
cat("== distribucion test ==\n");  print(table(test$decision))
cat("== baseline (mayoritaria en test) ==\n")
print(round(max(table(test$decision)) / nrow(test), 3))

## ── Paso 2: arbol legible (maxdepth 2) ──
arbol_2 <- rpart(decision ~ ., data = train, method = "class",
                 control = rpart.control(maxdepth = 2))
cat("\n== arbol maxdepth 2 ==\n")
print(arbol_2)
pred_2 <- predict(arbol_2, newdata = test, type = "class")
cat("metricas test arbol_2:\n"); print(met(test$decision, pred_2))
pred_2_tr <- predict(arbol_2, newdata = train, type = "class")
cat("accuracy train arbol_2:", round(mean(pred_2_tr == train$decision), 3), "\n")

## ── Paso 3: el memorizador (sin frenos) ──
## set.seed ANTES de rpart: su CV interna (xval) usa el RNG, y así
## la cptable del estudiante coincide aunque corra celdas sueltas
set.seed(11)
arbol_memo <- rpart(decision ~ ., data = train, method = "class",
                    control = rpart.control(cp = 0.0001, minsplit = 2, minbucket = 1))
pred_memo_tr <- predict(arbol_memo, newdata = train, type = "class")
pred_memo_te <- predict(arbol_memo, newdata = test,  type = "class")
cat("\n== memorizador ==\n")
cat("hojas:", sum(arbol_memo$frame$var == "<leaf>"), "\n")
cat("accuracy train:", round(mean(pred_memo_tr == train$decision), 3), "\n")
cat("accuracy test :", round(mean(pred_memo_te == test$decision), 3), "\n")

## ── Paso 4: poda con la CV incorporada de rpart ──
cat("\n== cptable (CV interna 10-fold) ==\n")
print(round(arbol_memo$cptable, 4))
tabla_cp <- arbol_memo$cptable
tope     <- min(tabla_cp[, "xerror"]) + tabla_cp[which.min(tabla_cp[, "xerror"]), "xstd"]
cp_opt   <- tabla_cp[which(tabla_cp[, "xerror"] <= tope)[1], "CP"]
cat("tope 1-SE:", round(tope, 4), "| cp optimo (1-SE):", round(cp_opt, 4), "\n")
arbol_podado <- prune(arbol_memo, cp = cp_opt)
cat("hojas tras poda:", sum(arbol_podado$frame$var == "<leaf>"), "\n")
pred_poda <- predict(arbol_podado, newdata = test, type = "class")
cat("metricas test arbol podado:\n"); print(met(test$decision, pred_poda))
pred_poda_tr <- predict(arbol_podado, newdata = train, type = "class")
cat("accuracy train podado:", round(mean(pred_poda_tr == train$decision), 3), "\n")

## ── Paso 5: random forest ──
set.seed(11)
bosque <- randomForest(decision ~ ., data = train, ntree = 500)
pred_rf <- predict(bosque, newdata = test)
cat("\n== random forest (500 arboles) ==\n")
cat("metricas test RF:\n"); print(met(test$decision, pred_rf))
cat("importancia de variables:\n")
print(round(importance(bosque), 1))

## ── Paso 6: umbral con probabilidades del bosque ──
prob_rf <- predict(bosque, newdata = test, type = "prob")[, "Aprobado"]
for (u in c(0.5, 0.8)) {
  pred_u <- ifelse(prob_rf >= u, "Aprobado", "Rechazado")
  cat("\n== umbral", u, "==\n")
  print(met(test$decision, pred_u))
}

## ── comparacion final ──
cat("\n== TABLA COMPARATIVA (accuracy test) ==\n")
cat("baseline      :", round(max(table(test$decision)) / nrow(test), 3), "\n")
cat("arbol prof 2  :", round(mean(pred_2 == test$decision), 3), "\n")
cat("memorizador   :", round(mean(pred_memo_te == test$decision), 3), "\n")
cat("arbol podado  :", round(mean(pred_poda == test$decision), 3), "\n")
cat("random forest :", round(mean(pred_rf == test$decision), 3), "\n")
