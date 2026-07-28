## ============================================================
##  Introduccion al Business Analytics (06278-ECO)
##  Semana 10 | Script de generacion de predicciones
##  Universidad Icesi | Periodo 2026-01
## ============================================================
##
##  DESCRIPCION
##  La semana 10 ensena a EVALUAR modelos (metricas + baseline)
##  sin entrenarlos todavia. Este script produce los 4 archivos
##  con predicciones de "modelos ya entrenados" que usan la
##  practica y el taller:
##
##  PRACTICA (carpeta ../practice/):
##  - credito_evaluacion.csv : 60 solicitudes de prueba con la
##    decision real y la prediccion de un arbol de clasificacion
##    (rpart) entrenado con el 80% restante. Es el MISMO tipo de
##    modelo que los estudiantes construiran en la semana 11.
##  - notas_evaluacion.csv   : 60 estudiantes de prueba con la
##    nota real y la prediccion de un arbol de regresion (rpart).
##
##  TALLER (carpeta ../task/):
##  - credito_taller10.csv   : 80 solicitudes nuevas evaluadas por
##    el modelo de un proveedor externo ("CreditoYa"). Disenado
##    para que la accuracy supere al baseline PERO la precision
##    revele un problema de negocio (aprueba morosos).
##  - notas_taller10.csv     : 60 estudiantes nuevos con las
##    predicciones de un proveedor ("PronosticaU") que NO logra
##    superar al baseline (predecir el promedio historico).
##
##  Las bases originales provienen de old/week-11/db y
##  old/week-12/db (generadores de Eduard, copiados a esta
##  carpeta). Este script NO las regenera: las lee.
##
##  USO:  cd week-10/input && Rscript _generar_predicciones.R
## ============================================================


##==: Configuracion inicial / Initial setup
rm(list = ls())
library(rpart)

## Redondear probabilidades de forma reproducible
set.seed(2026)

met_clas <- function(real, pred, positivo = "Aprobado") {
  ## matriz y metricas con "Aprobado" como clase positiva
  tp <- sum(real == positivo & pred == positivo)
  fn <- sum(real == positivo & pred != positivo)
  fp <- sum(real != positivo & pred == positivo)
  tn <- sum(real != positivo & pred != positivo)
  c(TP = tp, FN = fn, FP = fp, TN = tn,
    accuracy  = round((tp + tn) / (tp + tn + fp + fn), 4),
    precision = round(tp / (tp + fp), 4),
    recall    = round(tp / (tp + fn), 4))
}

met_reg <- function(real, pred) {
  c(MAE  = round(mean(abs(real - pred)), 4),
    RMSE = round(sqrt(mean((real - pred)^2)), 4))
}


## ============================================================
##  PARTE 1 | PRACTICA - Clasificacion (credito)
## ============================================================

credito <- read.csv("credito_clasificacion.csv")
credito$decision <- factor(credito$decision, levels = c("Aprobado", "Rechazado"))

## Particion 80/20 (240 entrenamiento / 60 prueba)
n_cred     <- nrow(credito)
idx_train  <- sample(1:n_cred, size = round(0.8 * n_cred))
cred_train <- credito[idx_train, ]
cred_test  <- credito[-idx_train, ]

## Entrenar el "modelo misterioso": un arbol de clasificacion.
## NOTA DE DISENO: se entrena solo con las variables debiles
## (historial, edad, antiguedad). Con las 5 variables el arbol
## clasifica casi perfecto (accuracy 98%, FP = 0) y la matriz de
## confusion queda degenerada: sin falsos positivos no hay nada
## que discutir en clase. Con estas 3, el modelo sigue siendo
## bueno (88%) pero comete errores de ambos tipos.
modelo_cred <- rpart(decision ~ historial + edad + antiguedad_lab,
                     data = cred_train, method = "class")

pred_test_cred  <- predict(modelo_cred, newdata = cred_test,  type = "class")
pred_train_cred <- predict(modelo_cred, newdata = cred_train, type = "class")

## Exportar: solo el conjunto de prueba, con real y prediccion
credito_evaluacion <- data.frame(
  cred_test[, c("ingreso_m", "historial", "deuda_actual",
                "antiguedad_lab", "edad")],
  decision_real   = as.character(cred_test$decision),
  decision_modelo = as.character(pred_test_cred)
)
rownames(credito_evaluacion) <- NULL
write.csv(credito_evaluacion, "../practice/credito_evaluacion.csv",
          row.names = FALSE)

cat("\n========== PRACTICA | CREDITO (test, n =", nrow(cred_test), ") ==========\n")
cat("Distribucion real en test:\n"); print(table(cred_test$decision))
cat("Baseline (clase mayoritaria del test):\n")
print(round(max(table(cred_test$decision)) / nrow(cred_test), 4))
cat("Matriz y metricas del modelo en TEST:\n")
print(met_clas(credito_evaluacion$decision_real, credito_evaluacion$decision_modelo))
cat("Accuracy del modelo en TRAIN (evidencia de sobreajuste):\n")
print(round(mean(pred_train_cred == cred_train$decision), 4))


## ============================================================
##  PARTE 2 | PRACTICA - Regresion (notas)
## ============================================================

notas <- read.csv("notas_regresion.csv")

## Particion 80/20 (240 entrenamiento / 60 prueba)
n_not       <- nrow(notas)
idx_train_n <- sample(1:n_not, size = round(0.8 * n_not))
not_train   <- notas[idx_train_n, ]
not_test    <- notas[-idx_train_n, ]

## Entrenar el "modelo misterioso": un arbol de regresion
modelo_not <- rpart(nota_final ~ parcial_1 + parcial_2 + tareas +
                      quices + asistencia,
                    data = not_train, method = "anova")

pred_test_not  <- round(predict(modelo_not, newdata = not_test), 2)
pred_train_not <- predict(modelo_not, newdata = not_train)

## Baseline: el promedio del conjunto de ENTRENAMIENTO
media_train <- round(mean(not_train$nota_final), 2)

## Exportar: solo el conjunto de prueba
notas_evaluacion <- data.frame(
  not_test[, c("parcial_1", "parcial_2", "tareas", "quices", "asistencia")],
  nota_real   = not_test$nota_final,
  nota_modelo = pred_test_not
)
rownames(notas_evaluacion) <- NULL
write.csv(notas_evaluacion, "../practice/notas_evaluacion.csv",
          row.names = FALSE)

cat("\n========== PRACTICA | NOTAS (test, n =", nrow(not_test), ") ==========\n")
cat("Media de nota_final en TRAIN (baseline a usar en la practica):", media_train, "\n")
cat("Metricas del MODELO en test:\n")
print(met_reg(notas_evaluacion$nota_real, notas_evaluacion$nota_modelo))
cat("Metricas del BASELINE (predecir siempre", media_train, ") en test:\n")
print(met_reg(notas_evaluacion$nota_real, media_train))
cat("MAE del modelo en TRAIN (evidencia de sobreajuste):\n")
print(round(mean(abs(not_train$nota_final - pred_train_not)), 4))


## ============================================================
##  PARTE 3 | TALLER - Clasificacion (proveedor "CreditoYa")
## ============================================================
##  80 solicitudes nuevas (mismo proceso generador de la base
##  original) evaluadas por el modelo del proveedor. El modelo
##  aprueba de mas: acierta casi todos los buenos clientes pero
##  deja pasar morosos -> accuracy decente, precision debil.

n_apr_t <- 44
n_rec_t <- 36

taller_apr <- data.frame(
  ingreso_m      = round(rnorm(n_apr_t, mean = 5.5, sd = 1.2), 2),
  historial      = rbinom(n_apr_t, size = 1, prob = 0.85),
  deuda_actual   = round(rnorm(n_apr_t, mean = 8, sd = 3.0), 2),
  antiguedad_lab = round(rnorm(n_apr_t, mean = 6, sd = 3.0), 1),
  edad           = round(rnorm(n_apr_t, mean = 38, sd = 8.0), 0),
  decision_real  = "Aprobado"
)
taller_rec <- data.frame(
  ingreso_m      = round(rnorm(n_rec_t, mean = 2.8, sd = 1.0), 2),
  historial      = rbinom(n_rec_t, size = 1, prob = 0.25),
  deuda_actual   = round(rnorm(n_rec_t, mean = 18, sd = 5.0), 2),
  antiguedad_lab = round(rnorm(n_rec_t, mean = 2, sd = 1.5), 1),
  edad           = round(rnorm(n_rec_t, mean = 30, sd = 7.0), 0),
  decision_real  = "Rechazado"
)
credito_taller <- rbind(taller_apr, taller_rec)

## Limites razonables (mismos del generador original)
credito_taller$ingreso_m      <- pmax(0.5, pmin(15.0, credito_taller$ingreso_m))
credito_taller$deuda_actual   <- pmax(0.0, pmin(50.0, credito_taller$deuda_actual))
credito_taller$antiguedad_lab <- pmax(0.0, pmin(30.0, credito_taller$antiguedad_lab))
credito_taller$edad           <- pmax(18,  pmin(70,   credito_taller$edad))

## Predicciones del proveedor: generoso al aprobar
##  - buen cliente real: casi siempre lo aprueba (pocos FN)
##  - mal cliente real: lo aprueba con prob 0.40 (muchos FP)
pred_prov <- credito_taller$decision_real
es_apr <- credito_taller$decision_real == "Aprobado"
flip_fn <- runif(nrow(credito_taller)) < 0.08   # Aprobado real -> "Rechazado"
flip_fp <- runif(nrow(credito_taller)) < 0.40   # Rechazado real -> "Aprobado"
pred_prov[es_apr  & flip_fn] <- "Rechazado"
pred_prov[!es_apr & flip_fp] <- "Aprobado"
credito_taller$decision_modelo <- pred_prov

## Mezclar filas
credito_taller <- credito_taller[sample(1:nrow(credito_taller)), ]
rownames(credito_taller) <- NULL

write.csv(credito_taller, "../task/credito_taller10.csv", row.names = FALSE)

cat("\n========== TALLER | CREDITO 'CreditoYa' (n =", nrow(credito_taller), ") ==========\n")
cat("Distribucion real:\n"); print(table(credito_taller$decision_real))
cat("Baseline (clase mayoritaria):\n")
print(round(max(table(credito_taller$decision_real)) / nrow(credito_taller), 4))
cat("Matriz y metricas del proveedor:\n")
print(met_clas(credito_taller$decision_real, credito_taller$decision_modelo))


## ============================================================
##  PARTE 4 | TALLER - Regresion (proveedor "PronosticaU")
## ============================================================
##  60 estudiantes nuevos (mismo proceso generador). El proveedor
##  vende un modelo con mucha varianza y poca senal: NO supera al
##  baseline de predecir el promedio historico (3.2).

n_t <- 60
parcial_1  <- round(pmax(0, pmin(5, rnorm(n_t, mean = 3.2, sd = 0.8))), 1)
parcial_2  <- round(pmax(0, pmin(5, rnorm(n_t, mean = 3.1, sd = 0.9))), 1)
tareas     <- round(pmax(0, pmin(5, rnorm(n_t, mean = 3.6, sd = 0.7))), 1)
quices     <- round(pmax(0, pmin(5, rnorm(n_t, mean = 3.3, sd = 0.8))), 1)
asistencia <- round(pmax(30, pmin(100, rnorm(n_t, mean = 75, sd = 15))))

nota_real <- round(pmax(0.5, pmin(5.0,
  0.30 * parcial_2 + 0.25 * parcial_1 + 0.18 * tareas +
  0.12 * quices + 0.008 * asistencia + rnorm(n_t, mean = 0, sd = 0.25))), 2)

## Prediccion del proveedor: poca senal (20%) + mucho ruido
nota_modelo <- round(pmax(1.0, pmin(5.0,
  0.20 * nota_real + 0.80 * 3.2 + rnorm(n_t, mean = 0, sd = 0.55))), 1)

notas_taller <- data.frame(parcial_1, parcial_2, tareas, quices,
                           asistencia, nota_real, nota_modelo)
write.csv(notas_taller, "../task/notas_taller10.csv", row.names = FALSE)

baseline_hist <- 3.2   # promedio historico dado en el enunciado del taller

cat("\n========== TALLER | NOTAS 'PronosticaU' (n =", n_t, ") ==========\n")
cat("Metricas del PROVEEDOR:\n")
print(met_reg(notas_taller$nota_real, notas_taller$nota_modelo))
cat("Metricas del BASELINE (predecir siempre", baseline_hist, "):\n")
print(met_reg(notas_taller$nota_real, baseline_hist))

cat("\nListo: 2 CSV en ../practice/ y 2 CSV en ../task/\n")

## ============================================================
##  FIN DEL SCRIPT
## ============================================================
