##============================================================================##
# _verificacion_practica10.R  —  cifras de la clase de la semana 10
#------------------------------------------------------------------------------#
# Solo para el profesor: rehace, sobre la base publicada de Cóndor y el archivo
# de predicciones (../script/predicciones_s10.csv), cada checkpoint del script
# 10_juez_condor.R y cada cifra del Beamer, y comprueba que lo que heredan las
# semanas 11 y 12 no cambió. Correr desde lectures/week-10/input/:
#   Rscript _verificacion_practica10.R
##============================================================================##
rm(list = ls())
require(pacman)
p_load(dplyr)

url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes     <- read.csv(paste0(url, "base_clientes.csv"))
predicciones <- read.csv("../script/predicciones_s10.csv")
campanas     <- read.csv(paste0(url, "anexo_campanas.csv"))

##=== 0-1. el archivo, la realidad y el sobre ================================##
stopifnot(identical(dim(clientes), c(8000L, 29L)), identical(dim(predicciones), c(1600L, 10L)))
set.seed(10)
idx_train <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
stopifnot(identical(sort(predicciones$cliente_id), sort(clientes$cliente_id[-idx_train])))
ev <- predicciones %>% left_join(clientes %>% select(cliente_id, abandono, gasto_proximo_trim), by = "cliente_id")
stopifnot(sum(ev$abandono == 0) == 1246, sum(ev$abandono == 1) == 354)
## costos de la campaña que cita el Beamer
stopifnot(round(mean(campanas$costo)) == 2248)
trim <- paste0(substr(campanas$fecha_envio, 1, 4), "-", ceiling(as.numeric(substr(campanas$fecha_envio, 6, 7)) / 3))
stopifnot(all(table(trim)[c("2025-1", "2025-2", "2025-3", "2025-4")] %in% 2767:2866))
cat("OK bloques 0-1: 1.600 del test (el sobre de siempre), 354 se fueron\n")

##=== 2. cliente por cliente =================================================##
tipo <- ifelse(ev$lista_regla_eda == 1 & ev$abandono == 1, "TP",
        ifelse(ev$lista_regla_eda == 1, "FP", ifelse(ev$abandono == 1, "FN", "TN")))
stopifnot(identical(tipo[1:12], c("TN","TN","TN","TN","TN","TP","TN","FN","TN","FN","TN","FP")))
stopifnot(identical(ev$cliente_id[c(6, 8, 10, 12)], c(3000027L, 3000030L, 3000050L, 3000077L)))
stopifnot(sum(tipo == "TP") == 151, sum(tipo == "FP") == 127, sum(tipo == "FN") == 203, sum(tipo == "TN") == 1119)
cat("OK bloque 2: los doce primeros y los cuatro totales\n")

##=== 3-4. matrices y métricas ===============================================##
celdas <- function(pred) c(tp = sum(pred == 1 & ev$abandono == 1), fp = sum(pred == 1 & ev$abandono == 0),
                           fn = sum(pred == 0 & ev$abandono == 1), tn = sum(pred == 0 & ev$abandono == 0))
m_memo <- celdas(ev$lista_memorizador); m_a <- celdas(ev$lista_proveedor_a); m_b <- celdas(ev$lista_proveedor_b)
stopifnot(identical(unname(m_memo), c(26L, 60L, 328L, 1186L)),
          identical(unname(m_a),    c(77L, 33L, 277L, 1213L)),
          identical(unname(m_b),    c(211L, 236L, 143L, 1010L)))
acc  <- function(m) unname((m["tp"] + m["tn"]) / 1600)
prec <- function(m) unname(m["tp"] / (m["tp"] + m["fp"]))
rec  <- function(m) unname(m["tp"] / (m["tp"] + m["fn"]))
mrg  <- function(p, n) 2 * sqrt(p * (1 - p) / n)
m_regla <- celdas(ev$lista_regla_eda)
stopifnot(round(acc(m_regla), 3) == 0.794, round(prec(m_regla), 3) == 0.543, round(rec(m_regla), 3) == 0.427,
          round(mrg(rec(m_regla), 354), 3) == 0.053)
stopifnot(round(acc(m_memo), 3) == 0.757, round(prec(m_memo), 3) == 0.302, round(rec(m_memo), 3) == 0.073)
stopifnot(round(acc(m_a), 3) == 0.806, round(prec(m_a), 3) == 0.700, round(rec(m_a), 3) == 0.218,
          round(mrg(rec(m_a), 354), 3) == 0.044)
stopifnot(round(acc(m_b), 3) == 0.763, round(prec(m_b), 3) == 0.472, round(rec(m_b), 3) == 0.596,
          round(mrg(rec(m_b), 354), 3) == 0.052)
acc_nadie <- mean(ev$abandono == 0)
stopifnot(round(acc_nadie, 3) == 0.779, round(mrg(acc_nadie, 1600), 3) == 0.021)
## "ninguna lista se separa de no hacer nada más allá del margen" (intervalos que se tocan)
for (m in list(m_regla, m_memo, m_a, m_b)) {
  stopifnot(abs(acc(m) - acc_nadie) <= mrg(acc(m), 1600) + mrg(acc_nadie, 1600))
}
## B le gana a la regla en recall por más que los márgenes
stopifnot(rec(m_b) - rec(m_regla) > mrg(rec(m_b), 354) + mrg(rec(m_regla), 354))
cat("OK bloques 3-4: matrices, accuracy, precisión, recall y márgenes\n")

##=== 5. umbral, AUC y mismo presupuesto =====================================##
stopifnot(all(ev$lista_proveedor_a == (ev$prob_proveedor_a >= 0.5)),
          all(ev$lista_proveedor_b == (ev$prob_proveedor_b >= 0.3)))
stopifnot(sum(ev$lista_proveedor_a) == 110, sum(ev$lista_proveedor_b) == 447)
auc <- function(p) { d <- outer(p[ev$abandono == 1], p[ev$abandono == 0], "-"); mean(d > 0) + 0.5 * mean(d == 0) }
stopifnot(round(auc(ev$prob_proveedor_a), 3) == 0.780, round(auc(ev$prob_proveedor_b), 3) == 0.763)
stopifnot(354 * 1246 == 441084)
cat("OK bloque 9 (opcional): umbrales 0.5 y 0.3, AUC 0.780 y 0.763\n")

##=== 6. la cuenta de Growth =================================================##
stopifnot(278 * 2250 == 625500, 86 * 2250 == 193500, 110 * 2250 == 247500, 447 * 2250 == 1005750)
stopifnot(round(625500 / 151) == 4142, round(193500 / 26) == 7442,
          round(247500 / 77) == 3214, round(1005750 / 211) == 4767)
stopifnot(211 - 151 == 60, 1005750 - 625500 == 380250)
## el costo marginal: nadie -> A -> regla -> B (el memorizador queda por debajo)
stopifnot(round(247500 / 77) == 3214,
          round((625500 - 247500) / (151 - 77)) == 5108,
          round((1005750 - 625500) / (211 - 151)) == 6338)
stopifnot(110 - 86 == 24, 77 - 26 == 51)
cat("OK bloque 5: envíos, costos, costo por encontrado y costo marginal (3.214, 5.108, 6.338)\n")

##=== 6. los escenarios de la recomendación ==================================##
encontrados <- c(a = 77, regla = 151, b = 211, memo = 26, nadie = 0)
costos      <- c(a = 247500, regla = 625500, b = 1005750, memo = 193500, nadie = 0)
neto1 <- encontrados * (0.10 * 40000) - costos
neto2 <- encontrados * (0.20 * 40000) - costos
stopifnot(identical(unname(neto1), c(60500, -21500, -161750, -89500, 0)),
          identical(unname(neto2), c(368500, 582500, 682250, 14500, 0)),
          names(which.max(neto1)) == "a", names(which.max(neto2)) == "b")
cat("OK bloque 6: escenario 1 gana A ($60.500); escenario 2 gana B ($682.250)\n")

##=== Beamer: el ejemplo ilustrativo de MAE y RMSE ==========================##
real <- c(120, 80, 200, 150, 400); pron <- c(120, 90, 190, 120, 270)
stopifnot(mean(abs(real - pron)) == 36, sqrt(mean((real - pron)^2)) == 60)
cat("OK ejemplo ilustrativo: MAE 36 mil, RMSE 60 mil\n")

##=== 7. el pronóstico de Finanzas ===========================================##
stopifnot(sum(ev$pron_proveedor_a < 0) == 413, min(ev$pron_proveedor_a) == -204192,
          min(ev$pron_regla_finanzas) == 0, min(ev$pron_proveedor_b) == 3329)
stopifnot(round(median(ev$pron_regla_finanzas)) == 78021, round(mean(ev$pron_regla_finanzas)) == 162185,
          round(median(ev$pron_proveedor_a)) == 105494, round(mean(ev$pron_proveedor_a)) == 301423,
          round(median(ev$pron_proveedor_b)) == 115448, round(mean(ev$pron_proveedor_b)) == 298206,
          max(ev$pron_regla_finanzas) == 4477500, max(ev$pron_proveedor_a) == 10027051,
          max(ev$pron_proveedor_b) == 12684627)
media_train <- mean(clientes$gasto_proximo_trim[idx_train])
stopifnot(round(media_train) == 292378)
err <- list(media = abs(ev$gasto_proximo_trim - media_train),
            regla = abs(ev$gasto_proximo_trim - ev$pron_regla_finanzas),
            a     = abs(ev$gasto_proximo_trim - ev$pron_proveedor_a),
            b     = abs(ev$gasto_proximo_trim - ev$pron_proveedor_b))
mae  <- sapply(err, mean)
mmae <- sapply(err, function(e) 2 * sd(e) / sqrt(1600))
rmse <- sapply(err, function(e) sqrt(mean(e^2)))
stopifnot(identical(unname(round(mae)),  c(328494, 168728, 201363, 165540)),
          identical(unname(round(mmae)), c(38496, 31656, 28408, 29485)),
          identical(unname(round(rmse)), c(836839, 655018, 602617, 612315)))
## la regla y B empatan en MAE; A tiene el mejor RMSE y el peor MAE de los tres
stopifnot(abs(mae["regla"] - mae["b"]) < mmae["regla"] + mmae["b"],
          which.min(rmse) == 3, which.max(mae[2:4]) == 2)
cat("OK bloque 7: 413 negativos, MAE, márgenes y RMSE\n")

##=== 8. lo que heredan las semanas 11 y 12 ==================================##
lider_abandono <- data.frame(regla       = c("nadie abandona", "regla del EDA", "memorizador"),
                             llamadas    = c(0, 278, 86),
                             encontrados = c(0, 151, 26),
                             accuracy    = c(0.779, 0.794, 0.757),
                             margen      = c(0.021, 0.020, 0.021))
lider_gasto    <- data.frame(regla  = c("media de train", "3 x gasto mensual"),
                             mae    = c(328494, 168728),
                             margen = c(38496, 31656),
                             rmse   = c(836839, 655018))
stopifnot(round(mrg(acc(m_regla), 1600), 3) == 0.020, round(mrg(acc(m_memo), 1600), 3) == 0.021)
cat("OK bloque 8: las tablas del líder (los valores que leen las semanas 11 y 12)\n")
print(lider_abandono); print(lider_gasto)

cat("\nVERIFICACIÓN COMPLETA: todas las cifras del script y del Beamer de la semana 10.\n")
