##============================================================================##
# _verificacion_practica12.R  —  cifras de la práctica de la semana 12
#------------------------------------------------------------------------------#
# Solo para el profesor: rehace desde las tablas publicadas de Cóndor la
# partición de la semana 10 y el riesgo del bosque de la semana 11, reproduce el
# código del estudiante y comprueba cada checkpoint de practice/week-12.qmd.
# Correr desde cualquier carpeta:  Rscript _verificacion_practica12.R  (≈ 2 min)
##============================================================================##
rm(list = ls())
require(pacman)
p_load(dplyr, rpart, randomForest, glmnet)

url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes <- read.csv(paste0(url, "base_clientes.csv"), stringsAsFactors = T)

##=== semana 10: el sobre sellado ============================================##
set.seed(10)
idx_train <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
particion <- clientes %>%
             select(cliente_id) %>%
             mutate(conjunto = ifelse(cliente_id %in% clientes$cliente_id[idx_train], "train", "test"))

##=== semana 11: el riesgo de cada cliente del test ==========================##
base11 <- clientes %>%
          left_join(particion, by = "cliente_id") %>%
          mutate(abandono = as.factor(abandono)) %>%
          select(-gasto_proximo_trim, -departamento, -duracion_sesion_promedio, -csat_promedio, -score_buro)
train11 <- base11 %>% filter(conjunto == "train") %>% select(-cliente_id, -conjunto)
test11  <- base11 %>% filter(conjunto == "test") %>% select(-cliente_id, -conjunto)
set.seed(11)
bosque11 <- randomForest(abandono ~ ., data = train11, ntree = 500)
riesgo <- data.frame(cliente_id    = base11 %>% filter(conjunto == "test") %>% pull(cliente_id),
                     prob_abandono = round(predict(bosque11, newdata = test11, type = "prob")[, "1"], 3))

##=== 1. la base del modelo ==================================================##
modelo <- clientes %>%
          left_join(particion, by = "cliente_id") %>%
          select(-abandono, -departamento, -duracion_sesion_promedio, -csat_promedio, -score_buro)
train <- modelo %>% filter(conjunto == "train") %>% select(-cliente_id, -conjunto)
test  <- modelo %>% filter(conjunto == "test") %>% select(-cliente_id, -conjunto)
n_test   <- nrow(test)
ids_test <- modelo %>% filter(conjunto == "test") %>% pull(cliente_id)
stopifnot(nrow(train) == 6400, n_test == 1600, ncol(train) - 1 == 22)
stopifnot(min(train$gasto_proximo_trim) == 800, max(train$gasto_proximo_trim) == 44083300)
stopifnot(median(train$gasto_proximo_trim) == 79300, round(mean(train$gasto_proximo_trim)) == 292378)
error_media <- abs(test$gasto_proximo_trim - mean(train$gasto_proximo_trim))
error_regla <- abs(test$gasto_proximo_trim - 3 * test$gasto_promedio_mensual)
margen <- function(e) 2 * sd(e) / sqrt(n_test)
stopifnot(round(mean(error_media)) == 328494, round(margen(error_media)) == 38496)
stopifnot(round(mean(error_regla)) == 168728, round(margen(error_regla)) == 31656)
stopifnot(round(sqrt(mean(error_regla^2))) == 655018, round(sqrt(mean(error_media^2))) == 836839)

##=== 2. el Lasso ============================================================##
x_train <- model.matrix(gasto_proximo_trim ~ ., data = train)[, -1]
x_test  <- model.matrix(gasto_proximo_trim ~ ., data = test)[, -1]
stopifnot(ncol(x_train) == 41)
set.seed(12)
lasso_cv <- cv.glmnet(x = x_train, y = train$gasto_proximo_trim, alpha = 1)
stopifnot(round(lasso_cv$lambda.1se) == 420267)
coefs <- as.matrix(coef(lasso_cv, s = "lambda.1se"))
stopifnot(sum(coefs[-1, 1] != 0) == 1, rownames(coefs)[-1][coefs[-1, 1] != 0] == "gasto_promedio_mensual")
stopifnot(round(coefs[1, 1]) == 141070, round(coefs["gasto_promedio_mensual", 1], 3) == 2.888)
pred_lasso <- as.numeric(predict(lasso_cv, newx = x_test, s = "lambda.1se"))
stopifnot(test$gasto_promedio_mensual[1] == 11020, round(pred_lasso[1]) == 172898, test$gasto_proximo_trim[1] == 40300)
stopifnot(round(141070 + 2.888 * 11020) == 172896)
error_lasso <- abs(test$gasto_proximo_trim - pred_lasso)
stopifnot(round(mean(error_lasso)) == 228481, round(margen(error_lasso)) == 30386, round(sqrt(mean(error_lasso^2))) == 649069)
d_lasso <- error_lasso - error_regla
stopifnot(mean(d_lasso) - margen(d_lasso) > 0)
p_min <- as.numeric(predict(lasso_cv, newx = x_test, s = "lambda.min"))
stopifnot(sum(as.matrix(coef(lasso_cv, s = "lambda.min"))[-1, 1] != 0) == 29)
stopifnot(round(mean(abs(test$gasto_proximo_trim - p_min))) == 204921, round(sqrt(mean((test$gasto_proximo_trim - p_min)^2))) == 606020)

##=== 3. el árbol de regresión ===============================================##
set.seed(12)
arbol <- rpart(gasto_proximo_trim ~ ., data = train, method = "anova")
stopifnot(all(arbol$frame$var[arbol$frame$var != "<leaf>"] %in% c("gasto_promedio_mensual", "ciudad")))
stopifnot(sum(arbol$frame$var == "ciudad") == 1)
hoja <- train %>% filter(gasto_promedio_mensual >= 882593.5)
stopifnot(nrow(hoja) == 22, round(mean(hoja$gasto_proximo_trim)) == 10768641)
error_libre <- abs(test$gasto_proximo_trim - predict(arbol, newdata = test))
stopifnot(round(mean(error_libre)) == 229997, round(sqrt(mean(error_libre^2))) == 869870)
tabla  <- arbol$cptable
stopifnot(round(min(tabla[, "xerror"]), 4) == 0.7904, round(tabla[which.min(tabla[, "xerror"]), "xstd"], 4) == 0.2464)
stopifnot(round(tabla[1, "xerror"], 4) == 1.0002)
tope   <- min(tabla[, "xerror"]) + tabla[which.min(tabla[, "xerror"]), "xstd"]
cp_opt <- tabla[which(tabla[, "xerror"] <= tope)[1], "CP"]
stopifnot(round(tope, 4) == 1.0369, round(cp_opt, 4) == 0.3226)
podado <- prune(arbol, cp = cp_opt)
stopifnot(sum(podado$frame$var == "<leaf>") == 1)
error_arbol <- abs(test$gasto_proximo_trim - predict(podado, newdata = test))
stopifnot(round(mean(error_arbol)) == 328494)

##=== 4. el bosque ===========================================================##
set.seed(12)
bosque <- randomForest(gasto_proximo_trim ~ ., data = train, ntree = 500)
pred_rf  <- predict(bosque, newdata = test)
error_rf <- abs(test$gasto_proximo_trim - pred_rf)
stopifnot(round(mean(error_rf)) == 162654, round(margen(error_rf)) == 29017, round(sqrt(mean(error_rf^2))) == 602535)
imp <- sort(importance(bosque)[, 1], decreasing = T)
stopifnot(identical(names(imp)[1:3], c("gasto_promedio_mensual", "antiguedad_meses", "monto_total")))

##=== 5. ¿real o ruido? ======================================================##
d1 <- error_regla - error_rf
d2 <- error_media - error_regla
stopifnot(round(mean(d1)) == 6074, round(margen(d1)) == 14429, mean(d1) - margen(d1) < 0)
stopifnot(round(mean(d2)) == 159766, round(margen(d2)) == 13679, mean(d2) - margen(d2) > 0)

##=== 6. el diagnóstico ======================================================##
error2 <- (test$gasto_proximo_trim - pred_rf)^2
stopifnot(round(100 * sum(head(sort(error2, decreasing = T), 10)) / sum(error2), 1) == 78)
mayor <- which.max(test$gasto_proximo_trim)
stopifnot(test$gasto_proximo_trim[mayor] == 21305900, pred_rf[mayor] > 3.5e6, pred_rf[mayor] < 4.5e6)

##=== 7. el valor en riesgo ==================================================##
cartera <- data.frame(cliente_id = ids_test, gasto_esperado = pred_rf) %>%
           left_join(riesgo, by = "cliente_id") %>%
           left_join(select(clientes, cliente_id, abandono, gasto_promedio_mensual), by = "cliente_id") %>%
           mutate(valor_en_riesgo = prob_abandono * gasto_esperado)
por_riesgo <- cartera %>% arrange(desc(prob_abandono)) %>% head(278)
por_valor  <- cartera %>% arrange(desc(valor_en_riesgo)) %>% head(278)
stopifnot(sum(por_riesgo$abandono == 1) == 156, sum(por_valor$abandono == 1) == 22)
stopifnot(sum(3 * por_riesgo$gasto_promedio_mensual[por_riesgo$abandono == 1]) == 3144540)
stopifnot(round(sum(3 * por_valor$gasto_promedio_mensual[por_valor$abandono == 1])) == 9221343)
stopifnot(round(median(por_riesgo$gasto_esperado)) == 11762, round(median(por_valor$gasto_esperado)) == 632493)
stopifnot(length(intersect(por_riesgo$cliente_id, por_valor$cliente_id)) == 8)

cat("OK: todas las cifras de practice/week-12.qmd verificadas\n")
