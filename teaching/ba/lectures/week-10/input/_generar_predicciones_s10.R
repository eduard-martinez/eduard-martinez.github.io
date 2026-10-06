##============================================================================##
# _generar_predicciones_s10.R  —  las predicciones de los dos proveedores
#------------------------------------------------------------------------------#
# Solo para el profesor. Entrena, sobre el sobre de siempre (80/20 con
# set.seed(10)), los modelos de los dos proveedores; los estudiantes NO entrenan
# nada: solo califican sus predicciones. Lee la base publicada de Cóndor y produce:
#   - ../script/predicciones_modelo_a.csv  (grano: cliente evaluado; cliente_id, pred_a)
#   - ../script/predicciones_modelo_b.csv  (grano: cliente evaluado; cliente_id, pred_b)
#   pred = 1: el proveedor dice que el cliente se va (enviarle la campaña)
# Correr desde lectures/week-10/input/:  Rscript _generar_predicciones_s10.R
##============================================================================##
rm(list = ls())
require(pacman)
p_load(dplyr, randomForest)

## la base publicada (texto como categorías: el bosque lo exige)
url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes <- read.csv(paste0(url, "base_clientes.csv"), stringsAsFactors = T)

## el sobre sellado: los modelos se entrenan con train y predicen el test
set.seed(10)
idx_train <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
train <- clientes[idx_train, ]
test  <- clientes[-idx_train, ]

## proveedor A: logística con cuatro variables; su lista, probabilidad >= 0.5
logit_a <- glm(abandono ~ recencia_dias + num_sesiones_ult30d + frecuencia_tx + antiguedad_meses,
               data = train, family = binomial)
prob_a  <- round(predict(logit_a, newdata = test, type = "response"), 3)

## proveedor B: bosque con todas las predictoras; su lista, probabilidad >= 0.3
x_train <- train %>%
           select(-cliente_id, -gasto_proximo_trim, -departamento,
                  -duracion_sesion_promedio, -csat_promedio, -score_buro) %>%
           mutate(abandono = factor(abandono))
x_test  <- test %>%
           select(-cliente_id, -gasto_proximo_trim, -departamento,
                  -duracion_sesion_promedio, -csat_promedio, -score_buro)
set.seed(2026)
bosque_b <- randomForest(abandono ~ ., data = x_train, ntree = 500)
prob_b   <- round(predict(bosque_b, newdata = x_test, type = "prob")[, "1"], 3)

## los dos archivos que reciben los estudiantes
modelo_a <- data.frame(cliente_id = test$cliente_id, pred_a = ifelse(prob_a >= 0.5, 1, 0))
modelo_b <- data.frame(cliente_id = test$cliente_id, pred_b = ifelse(prob_b >= 0.3, 1, 0))

## export data
write.csv(modelo_a, "../script/predicciones_modelo_a.csv", row.names = F)
write.csv(modelo_b, "../script/predicciones_modelo_b.csv", row.names = F)
c(a = sum(modelo_a$pred_a), b = sum(modelo_b$pred_b))
