##============================================================================##
# 10_juez_condor.R  —  ¿la regla del EDA aguanta el examen?
#------------------------------------------------------------------------------#
# Analítica para los negocios (06327-ECO) · Semana 10 · el guion de la clase
# (el bloque 10, al final, es el taller: se responde y se entrega este archivo)
# Corre dentro de proyecto_condor. Lee input/base_clientes.csv,
# input/anexo_campanas.csv e input/anexo_creditos.csv. Produce:
#   - output/base_analitica.csv      (grano: cliente; el acta de la semana 6 aplicada)
#   - output/particion_condor.csv    (grano: cliente; el sobre sellado 80/20)
#   - output/fig_encontrados_s10.png (envíos y encontrados de cada estrategia)
#   - output/fig_reglas_s10.png      (accuracy de las tres reglas, train y test)
#   - output/fig_loteria_s10.png     (la nota de la regla en 20 particiones)
#   - output/fig_mae_s10.png         (el error de los dos pronósticos de Finanzas)
#   - output/lider_abandono_s10.csv  (grano: regla; la tabla del líder del abandono)
#   - output/lider_gasto_s10.csv     (grano: regla; la tabla del líder del gasto)
# Nombre(s): _______________
##============================================================================##

##============================================================================##
##=== 0. Configuración inicial                                             ===##
##============================================================================##
rm(list = ls())
## librerías (si falta pacman: install.packages("pacman") en la consola)
require(pacman)
p_load(dplyr, ggplot2)

## colores del curso para las figuras
azul    <- "#1F4E79"
naranja <- "#E87722"
gris    <- "#9AA0A6"

## las tablas de hoy (transacciones no se necesita)
clientes <- read.csv("input/base_clientes.csv")
campanas <- read.csv("input/anexo_campanas.csv")
creditos <- read.csv("input/anexo_creditos.csv")
dim(clientes)
## 🎯 checkpoint: 8000 filas y 29 columnas — una fila por cliente

##============================================================================##
##=== 1. El reloj y la base analítica  (grano: cliente)                    ===##
##============================================================================##
cat("\n== 1 · El reloj y la base analítica ==\n")

## el target: ¿cómo se reparte el abandono?
table(clientes$abandono)
round(mean(clientes$abandono), 3)
## 🎯 checkpoint: 6.228 se quedan y 1.772 se van — tasa de 0.222

## la tentación: el gasto del próximo trimestre "predice" el abandono...
clientes %>%
  group_by(abandono) %>%
  summarise(mediana_gasto_futuro = median(gasto_proximo_trim))
## 🎯 checkpoint: mediana de 105.050 en quienes se quedan y 23.300 en quienes se
## van... pero se conoce DESPUÉS del corte, igual que abandono: nunca es predictora

## el acta de la semana 6, aplicada:
## campañas -> una fila por cliente (quien nunca recibió campañas: cero envíos)
camp_cliente <- campanas %>%
                group_by(cliente_id) %>%
                summarise(n_campanas    = n(),
                          n_convertidas = sum(convertido),
                          .groups = "drop")
nrow(camp_cliente)

## unir a la base y sacar las columnas "no aplica" (las representan
## num_sesiones_ult30d, num_tickets y tiene_credito)
base <- clientes %>%
        left_join(camp_cliente, by = "cliente_id") %>%
        mutate(n_campanas    = ifelse(is.na(n_campanas), 0, n_campanas),
               n_convertidas = ifelse(is.na(n_convertidas), 0, n_convertidas)) %>%
        select(-duracion_sesion_promedio, -csat_promedio, -score_buro)
dim(base)

## el hallazgo 3 de la semana 6, ahora en la base: entre quienes recibieron
## campañas, responder alguna corta la tasa a la mitad
base %>%
  filter(n_campanas > 0) %>%
  group_by(respondio = n_convertidas > 0) %>%
  summarise(clientes = n(), tasa = round(mean(abandono), 3))

## export data: la base analítica que heredan las semanas 11 y 12
write.csv(base, "output/base_analitica.csv", row.names = F)
## 🎯 checkpoint: 6.386 clientes recibieron campañas; la base queda de 8000 x 28
## (una llave + dos targets + 25 predictoras) y la tasa es 12,3 % contra 24,1 %

##============================================================================##
##=== 2. El sobre sellado  (grano: cliente)                                ===##
##============================================================================##
cat("\n== 2 · El sobre sellado ==\n")

## partir 80/20 antes de mirar cualquier regla
set.seed(10)   # en la línea inmediatamente anterior al sample
idx_train <- sample(1:nrow(base), size = round(0.8 * nrow(base)))
train <- base[idx_train, ]
test  <- base[-idx_train, ]
n_test <- nrow(test)

## ¿los dos conjuntos se parecen?
c(train = nrow(train), test = n_test)
c(train = round(mean(train$abandono), 3), test = round(mean(test$abandono), 3))

## guardar el sobre: en qué conjunto quedó cada cliente
particion <- base %>%
             select(cliente_id) %>%
             mutate(conjunto = ifelse(cliente_id %in% train$cliente_id, "train", "test"))
table(particion$conjunto)

## export data
write.csv(particion, "output/particion_condor.csv", row.names = F)
## 🎯 checkpoint: 6.400 en train y 1.600 en test, con tasas 0.222 y 0.221; las
## semanas 11 y 12 abren ESTE mismo sobre — no lo borres

##============================================================================##
##=== 3. Las dos esquinas: a nadie y a todos                               ===##
##============================================================================##
cat("\n== 3 · Las dos esquinas ==\n")

## esquina 1: no enviar a nadie (la clase mayoritaria de train)
table(train$abandono)
test <- test %>%
        mutate(pred_ingenua = 0)

## matriz de confusión: realidad en filas, predicción en columnas
table(Real = test$abandono, Pred = test$pred_ingenua)

## accuracy del baseline y su margen (dos errores estándar)
acc_ingenua    <- mean(test$abandono == test$pred_ingenua)
margen_ingenua <- 2 * sqrt(acc_ingenua * (1 - acc_ingenua) / n_test)
round(c(accuracy = acc_ingenua, margen = margen_ingenua), 3)
## 🎯 checkpoint: accuracy 0.779 ± 0.021 y no encuentra a NINGUNO de los 354

## esquina 2: enviarles a todos (la campaña a ciegas de hoy, a $2.250 el envío)
test <- test %>%
        mutate(pred_todos = 1)
acc_todos    <- mean(test$abandono == test$pred_todos)
margen_todos <- 2 * sqrt(acc_todos * (1 - acc_todos) / n_test)
round(c(accuracy = acc_todos, margen = margen_todos), 3)
c(envios = n_test, encontrados = sum(test$abandono), costo = n_test * 2250)
## 🎯 checkpoint: accuracy 0.221, encuentra a los 354... gastando $3.600.000 en
## el test; toda estrategia útil vive entre estas dos esquinas

##============================================================================##
##=== 4. La regla del EDA, al examen                                       ===##
##============================================================================##
cat("\n== 4 · La regla del EDA ==\n")

## la regla de la semana 6: cero sesiones en 30 días o más de 90 sin transar
## el simulacro: primero en train
train <- train %>%
         mutate(pred_eda = ifelse(num_sesiones_ult30d == 0 | recencia_dias > 90, 1, 0))
acc_eda_train <- mean(train$abandono == train$pred_eda)
round(acc_eda_train, 3)

## el examen: el sobre se abre una sola vez
test <- test %>%
        mutate(pred_eda = ifelse(num_sesiones_ult30d == 0 | recencia_dias > 90, 1, 0))
table(Real = test$abandono, Pred = test$pred_eda)

## las cuatro celdas
tp <- sum(test$abandono == 1 & test$pred_eda == 1)
fn <- sum(test$abandono == 1 & test$pred_eda == 0)
fp <- sum(test$abandono == 0 & test$pred_eda == 1)
tn <- sum(test$abandono == 0 & test$pred_eda == 0)

## accuracy, precisión y recall, con sus márgenes
acc_eda  <- (tp + tn) / (tp + tn + fp + fn)
prec_eda <- tp / (tp + fp)
rec_eda  <- tp / (tp + fn)
margen_acc_eda <- 2 * sqrt(acc_eda * (1 - acc_eda) / n_test)
margen_rec_eda <- 2 * sqrt(rec_eda * (1 - rec_eda) / (tp + fn))
round(c(accuracy = acc_eda, margen = margen_acc_eda), 3)
round(c(precision = prec_eda, recall = rec_eda, margen_recall = margen_rec_eda), 3)

## la cuenta de Growth: envíos y costo
c(envios = tp + fp, encontrados = tp, costo = (tp + fp) * 2250)
## 🎯 checkpoint: simulacro 0.792; en el examen accuracy 0.794 ± 0.020 (empate
## con la esquina de 0.779), precisión 0.543 y recall 0.427 ± 0.053: encuentra a
## 151 de los 354 con 278 envíos — $625.500, el 17 % de lo que cuesta ir a ciegas

## la figura: lo que le llega a Growth con cada estrategia
estrategias <- data.frame(estrategia = rep(c("a nadie", "regla del EDA", "a todos"), times = 2),
                          medida     = rep(c("envíos", "encontrados"), each = 3),
                          clientes   = c(0, tp + fp, n_test, 0, tp, sum(test$abandono)))
estrategias <- estrategias %>%
               mutate(estrategia = factor(estrategia, levels = c("a nadie", "regla del EDA", "a todos")),
                      medida     = factor(medida, levels = c("envíos", "encontrados")))

ggplot(estrategias, aes(x = estrategia, y = clientes, fill = medida)) +
  geom_col(position = position_dodge(width = 0.6), width = 0.55) +
  geom_text(aes(label = clientes), position = position_dodge(width = 0.6),
            vjust = -0.4, size = 3.4) +
  geom_hline(yintercept = 354, linetype = "dashed", color = azul) +
  annotate("text", x = 0.62, y = 420, label = "se van: 354", color = azul, size = 3.4) +
  scale_fill_manual(values = c("envíos" = gris, "encontrados" = naranja)) +
  labs(title = "¿A cuántos les llega — y a cuántos de los que se van encuentra?",
       subtitle = "Test de 1.600 clientes · $2.250 por envío",
       x = NULL, y = "Clientes", fill = NULL) +
  theme_minimal(base_size = 13)
ggsave("output/fig_encontrados_s10.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 5. El memorizador  (grano: combinación exacta)                       ===##
##============================================================================##
cat("\n== 5 · El memorizador ==\n")

## la tasa de abandono de cada combinación exacta de recencia, sesiones y
## frecuencia, aprendida en train
memoria <- train %>%
           group_by(recencia_dias, num_sesiones_ult30d, frecuencia_tx) %>%
           summarise(pred_memo = ifelse(mean(abandono) > 0.5, 1, 0),
                     .groups = "drop")
nrow(memoria)

## el simulacro: el memorizador en train
train <- train %>%
         left_join(memoria, by = c("recencia_dias", "num_sesiones_ult30d", "frecuencia_tx"))
acc_memo_train <- mean(train$abandono == train$pred_memo)
round(acc_memo_train, 3)

## el examen: clientes con una combinación que nunca vio
test <- test %>%
        left_join(memoria, by = c("recencia_dias", "num_sesiones_ult30d", "frecuencia_tx"))
sum(is.na(test$pred_memo))

## a esos no sabe qué decirles: se les aplica la regla ingenua
test <- test %>%
        mutate(pred_memo = ifelse(is.na(pred_memo), 0, pred_memo))
acc_memo    <- mean(test$abandono == test$pred_memo)
margen_memo <- 2 * sqrt(acc_memo * (1 - acc_memo) / n_test)
round(c(accuracy = acc_memo, margen = margen_memo), 3)
## 🎯 checkpoint: 5.411 combinaciones para 6.400 clientes; simulacro 0.959, pero
## 1.149 de los 1.600 del examen traen combinaciones nuevas y saca 0.757 ± 0.021

## la figura: la nota de train contra la de test, con el margen del examen
comparacion <- data.frame(regla    = rep(c("nadie abandona", "regla del EDA", "memorizador"), times = 2),
                          conjunto = rep(c("train", "test"), each = 3),
                          accuracy = c(mean(train$abandono == 0), acc_eda_train, acc_memo_train,
                                       acc_ingenua, acc_eda, acc_memo),
                          margen   = c(0, 0, 0, margen_ingenua, margen_acc_eda, margen_memo))
comparacion <- comparacion %>%
               mutate(regla    = factor(regla, levels = c("nadie abandona", "regla del EDA", "memorizador")),
                      conjunto = factor(conjunto, levels = c("train", "test")))

ggplot(comparacion, aes(x = regla, y = accuracy, color = conjunto)) +
  geom_point(size = 3, position = position_dodge(width = 0.4)) +
  geom_errorbar(aes(ymin = accuracy - margen, ymax = accuracy + margen),
                width = 0.15, position = position_dodge(width = 0.4)) +
  scale_color_manual(values = c("train" = gris, "test" = azul)) +
  labs(title = "El memorizador brilla en train y se cae en test",
       subtitle = "Accuracy con ±2 errores estándar en el examen de 1.600",
       x = NULL, y = "Accuracy", color = NULL) +
  theme_minimal(base_size = 13)
ggsave("output/fig_reglas_s10.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 6. El detector perfecto  (grano: solicitud de crédito)               ===##
##============================================================================##
cat("\n== 6 · El detector perfecto ==\n")

## otra pregunta de Cóndor: ¿qué créditos caerán en mora?
## el "modelo": 90 días o más de mora = default
creditos <- creditos %>%
            mutate(pred_mora = ifelse(dias_mora >= 90, 1, 0))
table(Real = creditos$default_90d, Pred = creditos$pred_mora)
round(mean(creditos$default_90d == creditos$pred_mora), 3)
## 🎯 checkpoint: 3.512 y 559 en la diagonal, cero errores: accuracy de 1. La
## alarma, no la celebración: dias_mora solo existe DESPUÉS de prestar — fuga,
## como gasto_proximo_trim en el bloque 1 (y esa ni siquiera da el 100 %)

##============================================================================##
##=== 7. La lotería de las particiones                                     ===##
##============================================================================##
cat("\n== 7 · La lotería de las particiones ==\n")

## ¿y si el examen me tocó fácil? la misma regla del EDA, 20 sobres distintos
accs <- c()
for (semilla in 1:20) {
  set.seed(semilla)
  idx    <- sample(1:nrow(base), size = round(0.8 * nrow(base)))
  examen <- base[-idx, ]
  pred   <- ifelse(examen$num_sesiones_ult30d == 0 | examen$recencia_dias > 90, 1, 0)
  accs   <- c(accs, mean(examen$abandono == pred))
}
round(accs, 3)
round(c(minimo = min(accs), maximo = max(accs)), 3)

## ¿cuántas de las 20 notas caen dentro del margen anunciado por el sobre?
sum(accs >= acc_eda - margen_acc_eda & accs <= acc_eda + margen_acc_eda)
## 🎯 checkpoint: las notas van de 0.782 a 0.811 y las 20 caen dentro de
## 0.794 ± 0.020 — el margen ya contaba esta lotería; por eso se reporta siempre

## la figura: cada punto es un examen distinto
loteria <- data.frame(semilla = 1:20, accuracy = accs)

ggplot(loteria, aes(x = semilla, y = accuracy)) +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = acc_eda - margen_acc_eda,
           ymax = acc_eda + margen_acc_eda, fill = naranja, alpha = 0.15) +
  geom_hline(yintercept = acc_eda, linetype = "dashed", color = naranja) +
  geom_point(size = 2.6, color = azul) +
  scale_y_continuous(limits = c(0.768, 0.820)) +
  labs(title = "La nota de la regla del EDA en 20 exámenes distintos",
       subtitle = "La banda es 0.794 ± 0.020: el margen anunciado por el sobre sellado",
       x = "Semilla de la partición", y = "Accuracy en el test") +
  theme_minimal(base_size = 13)
ggsave("output/fig_loteria_s10.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 8. La segunda vara: la pregunta de Finanzas  (regresión)             ===##
##============================================================================##
cat("\n== 8 · La segunda vara (Finanzas) ==\n")

## ¿cuánto gastará cada cliente el próximo trimestre? mismo sobre sellado
summary(train$gasto_proximo_trim)

## baseline: a todos se les predice la media de train
media_train <- mean(train$gasto_proximo_trim)
test <- test %>%
        mutate(pred_media = media_train)

## la regla de negocio: el próximo trimestre gasta como tres meses de su historia
test <- test %>%
        mutate(pred_regla = 3 * gasto_promedio_mensual)

## los errores de cada cliente, en pesos
error_media <- abs(test$gasto_proximo_trim - test$pred_media)
error_regla <- abs(test$gasto_proximo_trim - test$pred_regla)

## MAE y su margen
mae_media    <- mean(error_media)
mae_regla    <- mean(error_regla)
margen_media <- 2 * sd(error_media) / sqrt(n_test)
margen_regla <- 2 * sd(error_regla) / sqrt(n_test)
round(c(mae = mae_media, margen = margen_media))
round(c(mae = mae_regla, margen = margen_regla))

## RMSE: castiga más los errores grandes
rmse_media <- sqrt(mean(error_media^2))
rmse_regla <- sqrt(mean(error_regla^2))
round(c(rmse_media = rmse_media, rmse_regla = rmse_regla))
## 🎯 checkpoint: en train, mediana 79.300 y media 292.378 (la cola de la semana
## 6); MAE 328.494 ± 38.496 contra 168.728 ± 31.656 — mejora real, los márgenes
## no se traslapan; RMSE 836.839 contra 655.018

## la figura: el error típico de los dos pronósticos
pronosticos <- data.frame(regla  = c("media de train", "3 x gasto mensual"),
                          mae    = c(mae_media, mae_regla) / 1000,
                          margen = c(margen_media, margen_regla) / 1000)
pronosticos <- pronosticos %>%
               mutate(regla = factor(regla, levels = c("media de train", "3 x gasto mensual")))

ggplot(pronosticos, aes(x = regla, y = mae)) +
  geom_point(size = 3, color = azul) +
  geom_errorbar(aes(ymin = mae - margen, ymax = mae + margen),
                width = 0.12, color = azul) +
  geom_text(aes(label = round(mae)), hjust = -0.45, size = 3.6) +
  labs(title = "La regla de Finanzas reduce el error típico a la mitad",
       subtitle = "MAE en el test, en miles de pesos, con ±2 errores estándar",
       x = NULL, y = "MAE (miles de pesos)") +
  theme_minimal(base_size = 13)
ggsave("output/fig_mae_s10.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 9. La tabla del líder  (lo que vencerán las semanas 11 y 12)         ===##
##============================================================================##
cat("\n== 9 · La tabla del líder ==\n")

## abandono (clasificación): llamadas y encontrados en el test de 1.600
lider_abandono <- data.frame(regla       = c("nadie abandona", "regla del EDA", "memorizador"),
                             llamadas    = c(0, tp + fp, sum(test$pred_memo == 1)),
                             encontrados = c(0, tp, sum(test$pred_memo == 1 & test$abandono == 1)),
                             accuracy    = round(c(acc_ingenua, acc_eda, acc_memo), 3),
                             margen      = round(c(margen_ingenua, margen_acc_eda, margen_memo), 3))
lider_abandono

## gasto del próximo trimestre (regresión)
lider_gasto <- data.frame(regla  = c("media de train", "3 x gasto mensual"),
                          mae    = round(c(mae_media, mae_regla)),
                          margen = round(c(margen_media, margen_regla)),
                          rmse   = round(c(rmse_media, rmse_regla)))
lider_gasto

## export data
write.csv(lider_abandono, "output/lider_abandono_s10.csv", row.names = F)
write.csv(lider_gasto, "output/lider_gasto_s10.csv", row.names = F)
## 🎯 checkpoint: líder del abandono, la regla del EDA (la única que entrega
## clientes que de verdad se van); líder del gasto, la regla de Finanzas. Solo
## desbanca al líder quien le gane por MÁS que el margen

##============================================================================##
##=== 10. Para entregar  (el taller: responde como comentarios, sin código) ===##
##============================================================================##
## guarda este archivo como apellido_nombre_taller10.R, responde debajo de cada
## pregunta con comentarios (##) y súbelo donde indique el profesor. usa las
## cifras que produjo TU corrida: un argumento sin número no es un argumento.

## pregunta 1. gasto_proximo_trim separa muy bien a los que se van y aun así
## quedó prohibida como predictora. ¿por qué? ¿qué otra columna del caso tiene
## el mismo problema y cómo se delató en tu corrida?
## respuesta:

## pregunta 2. la esquina "no enviarle a nadie" acierta el 77,9 % y la regla del
## EDA el 79,4 %, con margen de ±2 puntos: empate. ¿por qué Growth debería usar
## la regla del EDA de todas formas? ¿qué cifras de tu corrida lo sostienen?
## respuesta:

## pregunta 3. con $2.250 por envío: ¿qué error le cuesta más a Growth, los 127
## envíos a clientes que no se iban o los 203 que se fueron sin aviso? di qué
## dato te falta para responder en términos monetarios y no por intuición.
## respuesta:

## pregunta 4. la próxima semana un árbol va a intentar desbancar a la regla
## del EDA en la tabla del líder. ¿qué tendría que mostrar exactamente para que
## lo declares mejor? (pista: no basta con más accuracy)
## respuesta:

##============================================================================##
## DECLARACIÓN DE USO DE IA (nivel 3)
## Herramienta y modelo usados: _______________ (o "No usé IA")
## La usé para: _______________________________
## Verifiqué por mi cuenta: ____________________
##============================================================================##
