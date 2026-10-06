##============================================================================##
# _verificacion_practica13.R  —  cifras de la práctica de la semana 13
#------------------------------------------------------------------------------#
# Solo para el profesor: rehace desde las tablas publicadas de Cóndor el hilo de
# las semanas 10 a 12 (partición, riesgo del bosque de la 11, gasto esperado del
# bosque de la 12 y valor en riesgo), reproduce el código del estudiante y
# comprueba cada checkpoint de practice/week-13.qmd. Correr: Rscript (≈ 2 min).
##============================================================================##
rm(list = ls())
require(pacman)
p_load(dplyr, cluster, randomForest)

url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes <- read.csv(paste0(url, "base_clientes.csv"))
factores <- read.csv(paste0(url, "base_clientes.csv"), stringsAsFactors = T)

##=== semanas 10 a 12: el valor en riesgo de los 1.600 del test ==============##
set.seed(10)
idx_train <- sample(1:nrow(factores), size = round(0.8 * nrow(factores)))
particion <- factores %>% select(cliente_id) %>%
             mutate(conjunto = ifelse(cliente_id %in% factores$cliente_id[idx_train], "train", "test"))
base11 <- factores %>% left_join(particion, by = "cliente_id") %>% mutate(abandono = as.factor(abandono)) %>%
          select(-gasto_proximo_trim, -departamento, -duracion_sesion_promedio, -csat_promedio, -score_buro)
set.seed(11)
bosque11 <- randomForest(abandono ~ ., data = base11 %>% filter(conjunto == "train") %>% select(-cliente_id, -conjunto), ntree = 500)
test11 <- base11 %>% filter(conjunto == "test")
riesgo <- data.frame(cliente_id = test11$cliente_id,
                     prob_abandono = round(predict(bosque11, newdata = select(test11, -cliente_id, -conjunto), type = "prob")[, "1"], 3))
base12 <- factores %>% left_join(particion, by = "cliente_id") %>%
          select(-abandono, -departamento, -duracion_sesion_promedio, -csat_promedio, -score_buro)
set.seed(12)
bosque12 <- randomForest(gasto_proximo_trim ~ ., data = base12 %>% filter(conjunto == "train") %>% select(-cliente_id, -conjunto), ntree = 500)
test12 <- base12 %>% filter(conjunto == "test")
valor <- data.frame(cliente_id = test12$cliente_id,
                    gasto_esperado = predict(bosque12, newdata = select(test12, -cliente_id, -conjunto))) %>%
         left_join(riesgo, by = "cliente_id") %>%
         mutate(valor_en_riesgo = prob_abandono * gasto_esperado)

##=== 1-3. variables, el ingenuo y la escala =================================##
rfm <- clientes %>% select(recencia_dias, frecuencia_tx, monto_total)
stopifnot(round(sapply(rfm, sd), 1) == c(63.4, 21.0, 623353.1))
stopifnot(round(sd(rfm$monto_total) / sd(rfm$recencia_dias)) == 9829, round(sd(rfm$monto_total) / sd(rfm$frecuencia_tx)) == 29702)
set.seed(13)
km_crudo <- kmeans(rfm, centers = 4, nstart = 25)
crudo <- clientes %>% mutate(grupo = km_crudo$cluster) %>% group_by(grupo) %>%
         summarise(clientes = n(), recencia = median(recencia_dias), monto = median(monto_total))
stopifnot(crudo$clientes == c(1009, 4358, 242, 2391), crudo$monto == c(1442800, 202500, 2656750, 700900), crudo$recencia[2] == 30)
dormidos <- table(km_crudo$cluster, clientes$recencia_dias > 90)[, "TRUE"]
stopifnot(sum(dormidos) == 886, dormidos[2] == 872, dormidos[4] == 14)
rfm_esc <- scale(rfm)

##=== 4. codo y silueta ======================================================##
set.seed(13)
wss <- sapply(1:8, function(k) kmeans(rfm_esc, centers = k, nstart = 25)$tot.withinss)
stopifnot(round(wss) == c(23997, 13732, 8112, 5690, 4506, 3508, 3030, 2645))
distancias <- dist(rfm_esc)
set.seed(13)
sil <- sapply(2:8, function(k) { km <- kmeans(rfm_esc, centers = k, nstart = 25); mean(silhouette(km$cluster, distancias)[, 3]) })
stopifnot(round(sil, 3) == c(0.502, 0.545, 0.461, 0.439, 0.408, 0.387, 0.367), which.max(sil) + 1 == 3)
set.seed(13)
km3 <- kmeans(rfm_esc, centers = 3, nstart = 25)
p3 <- clientes %>% mutate(s = km3$cluster) %>% group_by(s) %>% summarise(n = n(), monto = median(monto_total), ab = round(mean(abandono), 3))
stopifnot(p3$n == c(660, 1554, 5786), p3$monto[2] == 1415950, p3$ab[2] == 0.068)

##=== 5. los cuatro segmentos ================================================##
set.seed(13)
km_final <- kmeans(rfm_esc, centers = 4, nstart = 25)
stopifnot(as.vector(table(km_final$cluster)) == c(582, 2261, 4608, 549))
a_mano <- data.frame(rfm_esc) %>% mutate(s = km_final$cluster) %>% group_by(s) %>%
          summarise(r = mean(recencia_dias), f = mean(frecuencia_tx), m = mean(monto_total))
stopifnot(max(abs(as.matrix(a_mano[, 2:4]) - km_final$centers)) < 1e-10)
clientes <- clientes %>% mutate(segmento = km_final$cluster)
perfil <- clientes %>% group_by(segmento) %>%
          summarise(clientes = n(), recencia = median(recencia_dias), frecuencia = median(frecuencia_tx),
                    monto = median(monto_total), abandono = mean(abandono)) %>%
          mutate(margen = round(2 * sqrt(abandono * (1 - abandono) / clientes), 3), abandono = round(abandono, 3))
stopifnot(perfil$recencia == c(203.5, 7, 22, 4), perfil$frecuencia == c(2, 36, 12, 72))
stopifnot(perfil$monto == c(54850, 928800, 276850, 2094800))
stopifnot(perfil$abandono == c(0.687, 0.093, 0.247, 0.046), perfil$margen == c(0.038, 0.012, 0.013, 0.018))

##=== 6. el valor en riesgo por segmento =====================================##
rs <- valor %>% left_join(select(clientes, cliente_id, segmento), by = "cliente_id") %>%
      group_by(segmento) %>%
      summarise(n = n(), riesgo = round(mean(prob_abandono), 3), valor = round(sum(valor_en_riesgo))) %>%
      mutate(parte = round(valor / sum(valor), 3))
stopifnot(rs$n == c(110, 467, 925, 98), rs$riesgo == c(0.637, 0.113, 0.275, 0.067))
stopifnot(rs$valor == c(736440, 32544130, 22690842, 7785733), rs$parte == c(0.012, 0.510, 0.356, 0.122))

cat("OK: todas las cifras de practice/week-13.qmd verificadas\n")
