##============================================================================##
# _generar_predicciones_s10.R  —  las predicciones que califica la semana 10
#------------------------------------------------------------------------------#
# Solo para el profesor. Entrena, sobre el sobre sellado de siempre (80/20 con
# set.seed(10)), los modelos cuyas predicciones reciben los estudiantes; ellos
# NO entrenan nada: solo califican. Lee las tablas publicadas de Cóndor y produce:
#   - ../script/predicciones_s10.csv  (grano: cliente del test; 1.600 filas)
#       lista_*  = la lista de cada modelo (1 = enviarle la campaña)
#       prob_*   = la probabilidad de abandono (solo los proveedores la entregan)
#       pron_*   = el pronóstico del gasto del próximo trimestre, en pesos
# Correr desde lectures/week-10/input/:  Rscript _generar_predicciones_s10.R
##============================================================================##
rm(list = ls())
require(pacman)
p_load(dplyr, randomForest)

## la base publicada (texto como categorías: el bosque lo exige)
url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes <- read.csv(paste0(url, "base_clientes.csv"), stringsAsFactors = T)

##============================================================================##
##=== 1. El sobre sellado  (el mismo de las semanas 10 a 12)               ===##
##============================================================================##
set.seed(10)
idx_train <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
train <- clientes[idx_train, ]
test  <- clientes[-idx_train, ]

##============================================================================##
##=== 2. Las cuatro listas para Growth  (clasificación)                    ===##
##============================================================================##

## la regla del EDA (semana 6): cero sesiones o más de 90 días sin transar
lista_regla <- ifelse(test$num_sesiones_ult30d == 0 | test$recencia_dias > 90, 1, 0)

## el memorizador del practicante: la tasa de cada combinación exacta
memoria <- train %>%
           group_by(recencia_dias, num_sesiones_ult30d, frecuencia_tx) %>%
           summarise(lista = ifelse(mean(abandono) > 0.5, 1, 0), .groups = "drop")
memo_train <- train %>%
              left_join(memoria, by = c("recencia_dias", "num_sesiones_ult30d", "frecuencia_tx"))
memo_test  <- test %>%
              left_join(memoria, by = c("recencia_dias", "num_sesiones_ult30d", "frecuencia_tx")) %>%
              mutate(lista = ifelse(is.na(lista), 0, lista))

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

##============================================================================##
##=== 3. Los tres pronósticos para Finanzas  (regresión)                   ===##
##============================================================================##

## proveedor A: regresión lineal con cinco variables
lineal_a <- lm(gasto_proximo_trim ~ gasto_promedio_mensual + frecuencia_tx + recencia_dias +
                 num_sesiones_ult30d + antiguedad_meses, data = train)

## proveedor B: bosque de regresión con todas las predictoras
g_train <- train %>%
           select(-cliente_id, -abandono, -departamento,
                  -duracion_sesion_promedio, -csat_promedio, -score_buro)
g_test  <- test %>%
           select(-cliente_id, -abandono, -departamento,
                  -duracion_sesion_promedio, -csat_promedio, -score_buro)
set.seed(2026)
bosque_g <- randomForest(gasto_proximo_trim ~ ., data = g_train, ntree = 500)

##============================================================================##
##=== 4. El archivo para los estudiantes  (grano: cliente del test)        ===##
##============================================================================##
predicciones <- data.frame(cliente_id          = test$cliente_id,
                           lista_regla_eda     = lista_regla,
                           lista_memorizador   = memo_test$lista,
                           prob_proveedor_a    = prob_a,
                           lista_proveedor_a   = ifelse(prob_a >= 0.5, 1, 0),
                           prob_proveedor_b    = prob_b,
                           lista_proveedor_b   = ifelse(prob_b >= 0.3, 1, 0),
                           pron_regla_finanzas = 3 * test$gasto_promedio_mensual,
                           pron_proveedor_a    = round(predict(lineal_a, newdata = test)),
                           pron_proveedor_b    = round(predict(bosque_g, newdata = g_test)))

## lo que "reporta" el practicante: su acierto en los datos con que lo armó
round(mean(memo_train$abandono == memo_train$lista), 3)

## export data
write.csv(predicciones, "../script/predicciones_s10.csv", row.names = F)
dim(predicciones)
