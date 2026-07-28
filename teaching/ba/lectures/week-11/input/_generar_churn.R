## ============================================================
##  Introduccion al Business Analytics (06278-ECO)
##  Semana 11 | Script de generacion de datos
##  clientes_conectatel.csv  (taller 11)
##  Universidad Icesi | Periodo 2026-01
## ============================================================
##
##  DESCRIPCION
##  Genera el dataset sintetico del Taller 11: 350 clientes del
##  proveedor de internet "ConectaTel" con la etiqueta de si el
##  cliente se fue (fuga = Si) o sigue activo (fuga = No).
##
##  VARIABLES
##  - antiguedad_meses : meses como cliente
##  - factura_mensual  : factura promedio (miles de pesos)
##  - reclamos_6m      : reclamos en los ultimos 6 meses
##  - minutos_soporte  : minutos en llamadas a soporte por mes
##  - plan_premium     : 1 = plan premium, 0 = plan basico
##  - fuga             : Si / No (30% / 70%)
##
##  NOTA DE DISENO: las distribuciones se TRASLAPAN a proposito
##  (mas ruido que la base de credito) y las clases estan
##  DESBALANCEADAS (30/70). Historia pedagogica verificada:
##  (1) el baseline "nadie se fuga" da ~0.757 de accuracy con
##      recall CERO — la trampa del accuracy con desbalance;
##  (2) el memorizador (39 hojas) saca train 1.0 y test ~0.77:
##      la brecha gigante es la firma del sobreajuste, y la CV
##      interna (xerror) elige un arbol de 5 hojas;
##  (3) el arbol podado EMPATA en accuracy con el baseline pero
##      detecta ~47% de las fugas (el baseline, 0%) — la metrica
##      correcta aqui es el RECALL de "Si", no la accuracy;
##  (4) el random forest gana claro (acc ~0.84, recall ~0.65) y
##      con umbral 0.3 el recall sube a ~0.71 (retencion).
##
##  USO:  cd week-11/input && Rscript _generar_churn.R
## ============================================================

rm(list = ls())
set.seed(1103)

n_si <- 105   # clientes que se fugaron
n_no <- 245   # clientes activos

## ── Fugados: menos antiguos, factura alta, mas reclamos ─────
fugados <- data.frame(
  antiguedad_meses = round(pmax(1, pmin(72, rnorm(n_si, mean = 16, sd = 10)))),
  factura_mensual  = round(pmax(30, pmin(180, rnorm(n_si, mean = 88, sd = 22))), 1),
  reclamos_6m      = rpois(n_si, lambda = 1.8),
  minutos_soporte  = round(pmax(0, rnorm(n_si, mean = 28, sd = 14))),
  plan_premium     = rbinom(n_si, size = 1, prob = 0.30),
  fuga             = "Si"
)

## ── Activos: mas antiguos, factura media, pocos reclamos ────
activos <- data.frame(
  antiguedad_meses = round(pmax(1, pmin(72, rnorm(n_no, mean = 34, sd = 16)))),
  factura_mensual  = round(pmax(30, pmin(180, rnorm(n_no, mean = 72, sd = 20))), 1),
  reclamos_6m      = rpois(n_no, lambda = 0.7),
  minutos_soporte  = round(pmax(0, rnorm(n_no, mean = 15, sd = 10))),
  plan_premium     = rbinom(n_no, size = 1, prob = 0.42),
  fuga             = "No"
)

clientes <- rbind(fugados, activos)
clientes <- clientes[sample(1:nrow(clientes)), ]
rownames(clientes) <- NULL

write.csv(clientes, "../task/clientes_conectatel.csv", row.names = FALSE)

## ── Verificacion de la historia pedagogica ──────────────────
library(rpart)
library(randomForest)

met <- function(real, pred, positivo = "Si") {
  tp <- sum(real == positivo & pred == positivo)
  fn <- sum(real == positivo & pred != positivo)
  fp <- sum(real != positivo & pred == positivo)
  tn <- sum(real != positivo & pred != positivo)
  c(TP = tp, FN = fn, FP = fp, TN = tn,
    accuracy  = round((tp + tn) / length(real), 3),
    precision = round(tp / (tp + fp), 3),
    recall    = round(tp / (tp + fn), 3))
}

clientes$fuga <- as.factor(clientes$fuga)
set.seed(11)
idx   <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
train <- clientes[idx, ]
test  <- clientes[-idx, ]

cat("== dims ==\n"); print(dim(train)); print(dim(test))
cat("== test distribucion ==\n"); print(table(test$fuga))
cat("baseline (mayoritaria test):", round(max(table(test$fuga)) / nrow(test), 3), "\n")

## memorizador
memo <- rpart(fuga ~ ., data = train, method = "class",
              control = rpart.control(cp = 0.0001, minsplit = 2, minbucket = 1))
cat("\n== memorizador: hojas =", sum(memo$frame$var == "<leaf>"), "==\n")
cat("acc train:", round(mean(predict(memo, train, type = "class") == train$fuga), 3), "\n")
cat("acc test :", round(mean(predict(memo, test,  type = "class") == test$fuga), 3), "\n")

## poda con CV interna
cat("\n== cptable ==\n"); print(round(memo$cptable, 4))
cp_opt <- memo$cptable[which.min(memo$cptable[, "xerror"]), "CP"]
cat("cp optimo:", round(cp_opt, 4), "\n")
podado <- prune(memo, cp = cp_opt)
cat("hojas podado:", sum(podado$frame$var == "<leaf>"), "\n")
cat("metricas test podado (positivo = Si):\n")
print(met(test$fuga, predict(podado, test, type = "class")))
cat("acc train podado:", round(mean(predict(podado, train, type = "class") == train$fuga), 3), "\n")

## random forest
set.seed(11)
rf <- randomForest(fuga ~ ., data = train, ntree = 500)
cat("\n== RF ==\n")
print(met(test$fuga, predict(rf, test)))
cat("importancia:\n"); print(round(importance(rf), 1))

## umbral para retencion (bajar umbral -> mas recall)
prob_si <- predict(rf, test, type = "prob")[, "Si"]
for (u in c(0.5, 0.3)) {
  cat("\n== umbral", u, "==\n")
  print(met(test$fuga, ifelse(prob_si >= u, "Si", "No")))
}
