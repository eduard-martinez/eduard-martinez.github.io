##============================================================================##
# _verificacion_practica11.R  —  cifras de la práctica de la semana 11
#------------------------------------------------------------------------------#
# Solo para el profesor: rehace la partición de la semana 10 sobre la tabla
# publicada de Cóndor, reproduce el código del estudiante y comprueba cada
# checkpoint de practice/week-11.qmd.
# Correr desde cualquier carpeta:  Rscript _verificacion_practica11.R
##============================================================================##
rm(list = ls())
require(pacman)
p_load(dplyr, rpart, randomForest)

## la tabla publicada (idéntica al input/ de proyecto_condor.zip)
url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes <- read.csv(paste0(url, "base_clientes.csv"), stringsAsFactors = T)

##=== semana 10: el sobre sellado, como lo arma el estudiante ================##
set.seed(10)
idx_train <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
particion <- clientes %>%
             select(cliente_id) %>%
             mutate(conjunto = ifelse(cliente_id %in% clientes$cliente_id[idx_train], "train", "test"))

##=== 1. la base del modelo ==================================================##
stopifnot(n_distinct(clientes$ciudad) == 12, nrow(distinct(clientes, ciudad, departamento)) == 12)
modelo <- clientes %>%
          left_join(particion, by = "cliente_id") %>%
          mutate(abandono = as.factor(abandono)) %>%
          select(-gasto_proximo_trim, -departamento,
                 -duracion_sesion_promedio, -csat_promedio, -score_buro)
train <- modelo %>% filter(conjunto == "train") %>% select(-cliente_id, -conjunto)
test  <- modelo %>% filter(conjunto == "test") %>% select(-cliente_id, -conjunto)
stopifnot(nrow(train) == 6400, nrow(test) == 1600, ncol(train) - 1 == 22)
stopifnot(sum(train$abandono == 0) == 4982, sum(train$abandono == 1) == 1418)
stopifnot(sum(test$abandono == 1) == 354)

## la regla del EDA de la semana 10: 278 llamadas, 151 encontrados
pred_eda <- ifelse(test$num_sesiones_ult30d == 0 | test$recencia_dias > 90, 1, 0)
stopifnot(sum(pred_eda) == 278, sum(pred_eda == 1 & test$abandono == 1) == 151)

##=== 2. el árbol de dos preguntas ===========================================##
arbol <- rpart(abandono ~ ., data = train, method = "class",
               control = rpart.control(maxdepth = 2))
stopifnot(identical(as.character(arbol$frame$var), c("frecuencia_tx", "<leaf>", "recencia_dias", "<leaf>", "<leaf>")))
stopifnot(identical(arbol$frame$n, c(6400L, 4706L, 1694L, 1331L, 363L)))
stopifnot(round(arbol$frame$yval2[, 5], 2) == c(0.22, 0.13, 0.47, 0.39, 0.74))
stopifnot(arbol$splits["frecuencia_tx", "index"] == 8.5)
pred_arbol <- predict(arbol, newdata = test, type = "class")
tp <- sum(test$abandono == 1 & pred_arbol == 1)
fn <- sum(test$abandono == 1 & pred_arbol == 0)
fp <- sum(test$abandono == 0 & pred_arbol == 1)
tn <- sum(test$abandono == 0 & pred_arbol == 0)
stopifnot(tp == 59, fn == 295, fp == 17, tn == 1229)
stopifnot(round((tp + tn) / 1600, 3) == 0.805, round(tp / (tp + fp), 3) == 0.776, round(tp / (tp + fn), 3) == 0.167)

##=== 3. el memorizador y la poda ============================================##
set.seed(11)
memorizador <- rpart(abandono ~ ., data = train, method = "class",
                     control = rpart.control(cp = 0.0001, minsplit = 2, minbucket = 1))
stopifnot(sum(memorizador$frame$var == "<leaf>") == 926)
stopifnot(mean(predict(memorizador, newdata = train, type = "class") == train$abandono) == 1)
stopifnot(round(mean(predict(memorizador, newdata = test, type = "class") == test$abandono), 3) == 0.729)
tabla <- memorizador$cptable
stopifnot(round(tabla[1:4, "xerror"], 4) == c(1.0000, 0.8914, 0.8999, 0.9020))
stopifnot(tabla[1:4, "nsplit"] == c(0, 2, 8, 9), tabla[nrow(tabla), "nsplit"] == 925)
stopifnot(round(tabla[nrow(tabla), "xerror"], 4) == 1.3216, round(tabla[2, "xstd"], 4) == 0.0225)
tope   <- min(tabla[, "xerror"]) + tabla[which.min(tabla[, "xerror"]), "xstd"]
cp_opt <- tabla[which(tabla[, "xerror"] <= tope)[1], "CP"]
stopifnot(round(tope, 4) == 0.9139, round(cp_opt, 3) == 0.006)
arbol_podado <- prune(memorizador, cp = cp_opt)
stopifnot(sum(arbol_podado$frame$var == "<leaf>") == 3)
stopifnot(identical(arbol_podado$frame[, c("var", "n", "yval")], arbol$frame[, c("var", "n", "yval")]))

##=== 4. el bosque ===========================================================##
set.seed(11)
bosque <- randomForest(abandono ~ ., data = train, ntree = 500)
prob_rf <- predict(bosque, newdata = test, type = "prob")[, "1"]
pred_rf <- ifelse(prob_rf >= 0.5, 1, 0)
stopifnot(sum(test$abandono == 1 & pred_rf == 1) == 106, sum(test$abandono == 1 & pred_rf == 0) == 248)
stopifnot(sum(test$abandono == 0 & pred_rf == 1) == 58, sum(test$abandono == 0 & pred_rf == 0) == 1188)
stopifnot(round(mean(pred_rf == test$abandono), 3) == 0.809, round(106 / 164, 3) == 0.646)
gini <- sort(importance(bosque)[, 1], decreasing = T)
stopifnot(identical(names(gini)[1:5], c("monto_total", "recencia_dias", "frecuencia_tx", "gasto_promedio_mensual", "ciudad")))
stopifnot(names(gini)[length(gini)] == "os_principal")
stopifnot(round(gini[c("monto_total", "recencia_dias", "frecuencia_tx", "os_principal")], 1) == c(202.6, 192.4, 176.7, 17.6))

##=== 5. la perilla del umbral ===============================================##
prob_rf <- predict(bosque, newdata = test, type = "prob")[, "1"]
pred_04 <- ifelse(prob_rf >= 0.4, 1, 0)
stopifnot(sum(pred_04 == 1) == 288, sum(pred_04 == 1 & test$abandono == 1) == 159)
stopifnot(round(mean(pred_04 == test$abandono), 3) == 0.797)
pred_03 <- ifelse(prob_rf >= 0.3, 1, 0)
stopifnot(sum(pred_03 == 1) == 453, sum(pred_03 == 1 & test$abandono == 1) == 212)
stopifnot(sum(pred_04 == 1 & test$abandono == 0) == 129)
niveles <- table(round(predict(arbol_podado, newdata = test, type = "prob")[, "1"], 3))
stopifnot(identical(names(niveles), c("0.133", "0.394", "0.741")), as.vector(niveles) == c(1182, 342, 76))

##=== reto 1: importancia por permutación ====================================##
set.seed(11)
bosque_perm <- randomForest(abandono ~ ., data = train, ntree = 500, importance = T)
perm <- sort(importance(bosque_perm, type = 1)[, 1], decreasing = T)
stopifnot(identical(names(perm)[1:3], c("recencia_dias", "num_sesiones_ult30d", "frecuencia_tx")))
stopifnot(round(perm[c("recencia_dias", "num_sesiones_ult30d", "frecuencia_tx", "ciudad", "canal_adquisicion")], 1) ==
          c(35.6, 34.2, 33.9, -0.7, -0.5))

##=== molde del 25-sep: a mano, márgenes, OOB, calibración y tabla del líder ==##
margen <- function(p, n) 2 * sqrt(p * (1 - p) / n)
a_mano <- train %>% group_by(frecuencia_tx >= 8.5) %>% summarise(clientes = n(), tasa = round(mean(abandono == 1), 3))
stopifnot(a_mano$clientes == c(1694, 4706), a_mano$tasa == c(0.469, 0.133))
stopifnot(round(margen(0.805, 1600), 3) == 0.020, round(margen(59 / 354, 354), 3) == 0.040)
stopifnot(round(margen(mean(predict(memorizador, newdata = test, type = "class") == test$abandono), 1600), 3) == 0.022)
stopifnot(round(bosque$err.rate[500, "OOB"], 4) == 0.1977)
stopifnot(round(margen(106 / 354, 354), 3) == 0.049, round(margen(159 / 354, 354), 3) == 0.053)
pm <- predict(memorizador, newdata = test, type = "class")
stopifnot(sum(pm == 1) == 344, sum(pm == 1 & test$abandono == 1) == 132)
calib <- test %>%
         mutate(prob_bosque = prob_rf,
                tramo = cut(recencia_dias, c(-1, 7, 30, 60, 90, Inf))) %>%
         group_by(tramo) %>%
         summarise(clientes = n(), tasa_real = round(mean(abandono == 1), 3), prob_bosque = round(mean(prob_bosque), 3))
stopifnot(calib$clientes == c(543, 568, 221, 100, 168))
stopifnot(calib$tasa_real == c(0.122, 0.169, 0.235, 0.390, 0.601), calib$prob_bosque == c(0.154, 0.192, 0.265, 0.371, 0.567))
stopifnot(max(abs(calib$tasa_real - calib$prob_bosque)) < 0.04)
## empate técnico con el cupo: la diferencia de encontrados (159 - 151) cabe en el margen del recall
stopifnot((159 - 151) < margen(151 / 354, 354) * 354)

cat("OK: todas las cifras de practice/week-11.qmd verificadas\n")
