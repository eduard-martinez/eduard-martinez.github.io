##============================================================================##
# 10_juez_condor.R  —  ¿qué modelo le sirve a Cóndor? de la predicción a la decisión
#------------------------------------------------------------------------------#
# Analítica para los negocios (06327-ECO) · Semana 10 · script de la clase
# Hoy no se entrena ningún modelo: se califican predicciones que ya existen.
# Antes de correr, guarda predicciones_s10.csv (página del curso, semana 10) en
# la carpeta input/ de tu proyecto_condor. Lee:
#   - input/base_clientes.csv    (grano: cliente; lo que de verdad pasó)
#   - input/predicciones_s10.csv (grano: cliente del test; lo que se predijo)
# Produce:
#   - output/particion_condor.csv       (grano: cliente; train o test)
#   - output/fig_tipos_error_s10.png    (encontrados, escapados y envíos de más)
#   - output/fig_metricas_s10.png       (accuracy, precisión y recall por lista)
#   - output/fig_envios_s10.png         (envíos y clientes encontrados por lista)
#   - output/fig_frontera_s10.png       (costo y clientes encontrados: el costo adicional)
#   - output/fig_errores_s10.png        (MAE y RMSE por pronóstico)
#   - output/fig_probabilidades_s10.png (opcional: las probabilidades de los proveedores)
#   - output/lider_abandono_s10.csv     (grano: lista; las listas de la casa)
#   - output/lider_gasto_s10.csv        (grano: pronóstico; los de la casa)
# El bloque 10, al final, es el taller: se responde y se entrega este archivo.
# Nombre: _______________
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

## lo que pasó (la base de Cóndor) y lo que se predijo el 31 de marzo
clientes     <- read.csv("input/base_clientes.csv")
predicciones <- read.csv("input/predicciones_s10.csv")
dim(clientes)
dim(predicciones)
## 🎯 checkpoint: 8000 x 29 y 1600 x 10. hay predicciones solo para 1.600
## clientes: los modelos se construyeron con los otros 6.400 y nunca vieron estos

##============================================================================##
##=== 1. Lo que se predijo y lo que pasó  (grano: cliente)                 ===##
##============================================================================##
## pregunta: ¿qué se predijo para cada cliente y qué hizo de verdad?

## lista_* dice a quién enviarle la campaña (1 = sí); prob_* es la probabilidad
## de abandono que entregan los proveedores; pron_* es el gasto pronosticado
names(predicciones)

## la realidad sale de la base: se une por cliente_id
evaluacion <- predicciones %>%
              left_join(clientes %>% select(cliente_id, abandono, gasto_proximo_trim),
                        by = "cliente_id")
table(evaluacion$abandono)
## 🎯 checkpoint: 1.246 se quedaron y 354 se fueron (22,1 %)

## quién quedó en cada conjunto (las semanas 11 y 12 lo reabren)
particion <- clientes %>%
             select(cliente_id) %>%
             mutate(conjunto = ifelse(cliente_id %in% predicciones$cliente_id, "test", "train"))
table(particion$conjunto)

## export data
write.csv(particion, "output/particion_condor.csv", row.names = F)

##============================================================================##
##=== 2. Cliente por cliente: los cuatro resultados posibles               ===##
##============================================================================##
## pregunta: cuando la regla del EDA incluye a un cliente en la lista, ¿acierta?
## la clase positiva es abandono = 1: lo que Growth quiere encontrar

## cada predicción, comparada con la realidad
tipos <- evaluacion %>%
         mutate(resultado = case_when(lista_regla_eda == 1 & abandono == 1 ~ "TP: en la lista y se fue",
                                      lista_regla_eda == 1 & abandono == 0 ~ "FP: en la lista y se quedó",
                                      lista_regla_eda == 0 & abandono == 1 ~ "FN: fuera de la lista y se fue",
                                      lista_regla_eda == 0 & abandono == 0 ~ "TN: fuera de la lista y se quedó"))

## los doce primeros clientes, uno por uno
tipos %>%
  select(cliente_id, lista_regla_eda, abandono, resultado) %>%
  head(12)

## los 1.600: ¿cuántos de cada tipo?
table(tipos$resultado)
## 🎯 checkpoint: en los doce primeros aparecen los cuatro tipos (8 TN, 2 FN, 1 TP
## y 1 FP); en los 1.600, 151 TP, 127 FP, 203 FN y 1.119 TN. un FP es un envío que
## no hacía falta; un FN, un cliente que se fue sin que la campaña lo buscara

##============================================================================##
##=== 3. Los errores de cada modelo  (grano: lista)                        ===##
##============================================================================##
## pregunta: ¿cuántos encuentra cada modelo, cuántos se le escapan y cuántos
## envíos le sobran? realidad en filas, predicción en columnas
table(Real = evaluacion$abandono, Pred = evaluacion$lista_regla_eda)
table(Real = evaluacion$abandono, Pred = evaluacion$lista_memorizador)
table(Real = evaluacion$abandono, Pred = evaluacion$lista_proveedor_a)
table(Real = evaluacion$abandono, Pred = evaluacion$lista_proveedor_b)

## las cinco listas en formato largo (una fila por cliente y lista). la primera
## es la referencia: no enviarle la campaña a nadie
listas <- bind_rows(evaluacion %>% transmute(lista = "nadie abandona", real = abandono, pred = 0),
                    evaluacion %>% transmute(lista = "regla del EDA",  real = abandono, pred = lista_regla_eda),
                    evaluacion %>% transmute(lista = "memorizador",    real = abandono, pred = lista_memorizador),
                    evaluacion %>% transmute(lista = "proveedor A",    real = abandono, pred = lista_proveedor_a),
                    evaluacion %>% transmute(lista = "proveedor B",    real = abandono, pred = lista_proveedor_b)) %>%
          mutate(lista = factor(lista, levels = c("nadie abandona", "regla del EDA", "memorizador",
                                                  "proveedor A", "proveedor B")))

## las cuatro celdas de cada lista
celdas <- listas %>%
          group_by(lista) %>%
          summarise(tp = sum(pred == 1 & real == 1),
                    fp = sum(pred == 1 & real == 0),
                    fn = sum(pred == 0 & real == 1),
                    tn = sum(pred == 0 & real == 0))
celdas
## 🎯 checkpoint: el proveedor A encuentra a 77 y se le escapan 277; el B encuentra
## a 211, pero le envía la campaña a 236 clientes que se quedaban

## la figura: de los 354 que se fueron, cuántos encuentra cada lista y cuántos se
## le escapan; y cuántos envíos van a clientes que se quedaban
errores_lista <- bind_rows(celdas %>% transmute(lista, panel = "De los 354 que se fueron", tipo = "encontrados (TP)",   clientes = tp),
                           celdas %>% transmute(lista, panel = "De los 354 que se fueron", tipo = "se escaparon (FN)",  clientes = fn),
                           celdas %>% transmute(lista, panel = "Envíos a quien se quedaba", tipo = "envíos de más (FP)", clientes = fp)) %>%
                 mutate(tipo = factor(tipo, levels = c("encontrados (TP)", "se escaparon (FN)", "envíos de más (FP)")))

ggplot(errores_lista, aes(x = clientes, y = lista, fill = tipo)) +
  geom_col(width = 0.6, position = position_stack(reverse = T)) +
  geom_text(data = errores_lista %>% filter(clientes > 0), aes(label = clientes),
            position = position_stack(vjust = 0.5, reverse = T), size = 3.2, color = "white") +
  facet_wrap(~ panel, scales = "free_x") +
  scale_fill_manual(values = c("encontrados (TP)" = naranja, "se escaparon (FN)" = azul,
                               "envíos de más (FP)" = gris)) +
  scale_y_discrete(limits = rev) +
  labs(title = "Cada modelo comete errores distintos",
       subtitle = "Clientes que ningún modelo vio · cada envío cuesta $2.250",
       x = "Clientes", y = NULL, fill = NULL) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "bottom")
ggsave("output/fig_tipos_error_s10.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 4. Tres métricas, tres preguntas  (grano: lista)                     ===##
##============================================================================##
## accuracy:  ¿qué fracción de todos los clientes clasificó bien?
## precisión: de los que reciben la campaña, ¿qué fracción se iba de verdad?
## recall:    de los que se iban, ¿a qué fracción encontró?
metricas <- celdas %>%
            mutate(accuracy  = (tp + tn) / (tp + fp + fn + tn),
                   precision = tp / (tp + fp),
                   recall    = tp / (tp + fn))
metricas %>%
  transmute(lista,
            accuracy  = round(accuracy, 3),
            precision = round(precision, 3),
            recall    = round(recall, 3))
## 🎯 checkpoint: el proveedor A tiene la mejor accuracy (0.806) y precisión
## (0.700); el B, el mejor recall (0.596). no hacer nada acierta 0.779 sin
## encontrar a nadie: con 22 % de abandono, la accuracy casi no distingue. la
## precisión de "nadie abandona" sale NaN: no le envió la campaña a nadie

## la figura: las tres métricas de cada lista
grafico <- bind_rows(metricas %>% transmute(lista, metrica = "accuracy",  valor = accuracy),
                     metricas %>% transmute(lista, metrica = "precisión", valor = precision),
                     metricas %>% transmute(lista, metrica = "recall",    valor = recall)) %>%
           filter(!is.na(valor))

ggplot(grafico, aes(x = valor, y = lista, color = metrica)) +
  geom_point(size = 3.2) +
  scale_color_manual(values = c("accuracy" = azul, "precisión" = gris, "recall" = naranja)) +
  scale_y_discrete(limits = rev) +
  labs(title = "Ninguna lista gana en todas las métricas",
       subtitle = "Clientes que ningún modelo vio · la clase positiva es abandonar",
       x = NULL, y = NULL, color = NULL) +
  theme_minimal(base_size = 13)
ggsave("output/fig_metricas_s10.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 5. La cuenta de Growth: envíos, costo y clientes encontrados         ===##
##============================================================================##
## pregunta: ¿cuánto cuesta cada lista y a cuántos de los que se van encuentra?
## cada envío cuesta unos $2.250 (anexo de campañas)
campana <- metricas %>%
           transmute(lista,
                     envios      = tp + fp,
                     encontrados = tp,
                     costo       = envios * 2250,
                     costo_por_encontrado = round(costo / encontrados))
campana
## 🎯 checkpoint: el proveedor B encuentra 211 con 447 envíos ($1.005.750); la
## regla del EDA, 151 con 278 ($625.500); el proveedor A, 77 con 110 ($247.500),
## el menor costo por cliente encontrado ($3.214). el memorizador cuesta $7.442
## por cada uno de los 26 que encuentra

## la figura: lo que le llega a Growth con cada lista
envios <- bind_rows(campana %>% transmute(lista, medida = "envíos",      clientes = envios),
                    campana %>% transmute(lista, medida = "encontrados", clientes = encontrados)) %>%
          mutate(medida = factor(medida, levels = c("envíos", "encontrados")))

ggplot(envios, aes(x = lista, y = clientes, fill = medida)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.65) +
  geom_text(aes(label = clientes), position = position_dodge(width = 0.7),
            vjust = -0.4, size = 3.4) +
  geom_hline(yintercept = 354, linetype = "dashed", color = azul) +
  annotate("text", x = 1, y = 380, label = "se fueron: 354", color = azul, size = 3.4) +
  scale_fill_manual(values = c("envíos" = gris, "encontrados" = naranja)) +
  labs(title = "¿A cuántos les llega la campaña y a cuántos encuentra?",
       subtitle = "Clientes que ningún modelo vio · cada envío cuesta $2.250",
       x = NULL, y = "Clientes", fill = NULL) +
  theme_minimal(base_size = 13)
ggsave("output/fig_envios_s10.png", width = 7.5, height = 4.6, dpi = 200)

## el costo adicional: al pasar a una lista más grande, ¿cuánto se paga por cada
## cliente adicional que se encuentra? el memorizador queda fuera: el proveedor A,
## con 24 envíos más, encuentra 51 clientes más
marginal <- campana %>%
            filter(lista != "memorizador") %>%
            arrange(envios) %>%
            mutate(costo_extra       = costo - lag(costo),
                   encontrados_extra = encontrados - lag(encontrados),
                   costo_marginal    = round(costo_extra / encontrados_extra))
marginal %>%
  select(lista, envios, encontrados, costo_extra, encontrados_extra, costo_marginal)
## 🎯 checkpoint: pasar de no enviar nada al proveedor A cuesta $3.214 por cliente
## encontrado; del proveedor A a la regla del EDA, $5.108 por cliente adicional;
## de la regla al proveedor B, $6.338. cada cliente adicional sale más caro

## la figura: costo y clientes encontrados; la pendiente de cada tramo es el
## costo de cada cliente adicional (el memorizador queda por debajo de la línea)
tramos <- marginal %>%
          filter(!is.na(costo_marginal)) %>%
          mutate(x = (costo - costo_extra / 2) / 1000,
                 y = encontrados - encontrados_extra / 2,
                 etiqueta = paste0("$", format(costo_marginal, big.mark = ".", decimal.mark = ","), " c/u"))

ggplot(campana, aes(x = costo / 1000, y = encontrados)) +
  geom_path(data = marginal, color = azul, linewidth = 1) +
  geom_point(size = 3, color = ifelse(campana$lista == "memorizador", gris, azul)) +
  geom_text(aes(label = lista), vjust = -1, size = 3.4) +
  geom_text(data = tramos, aes(x = x, y = y, label = etiqueta),
            hjust = 1.1, vjust = -0.6, size = 3.3, color = naranja, fontface = "bold") +
  scale_x_continuous(limits = c(-60, 1100)) +
  scale_y_continuous(limits = c(0, 240)) +
  labs(title = "Cada cliente adicional cuesta más que el anterior",
       subtitle = "Costo de la campaña y clientes encontrados · en naranja, el costo de cada adicional",
       x = "Costo de la campaña (miles de pesos)", y = "Clientes encontrados (de 354)") +
  theme_minimal(base_size = 13)
ggsave("output/fig_frontera_s10.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 6. La recomendación: un escenario de valor  (grano: lista)           ===##
##============================================================================##
## pregunta: ¿qué lista le deja más a Cóndor? encontrar a un cliente que se iba
## no es retenerlo: vale lo que la campaña retiene por lo que deja cada cliente.
## estas dos cifras son supuestos: cámbialas y vuelve a correr el bloque
retencion     <- 0.10    # fracción de los clientes encontrados que la campaña retiene
valor_cliente <- 40000   # lo que le deja a Cóndor un cliente retenido, en pesos
valor_encontrado <- retencion * valor_cliente
valor_encontrado

## el beneficio neto de cada lista: lo que valen los encontrados menos lo que cuesta
beneficio <- campana %>%
             transmute(lista,
                       encontrados,
                       costo,
                       beneficio_neto = encontrados * valor_encontrado - costo) %>%
             arrange(desc(beneficio_neto))
beneficio
## 🎯 checkpoint: con 1 de cada 10 retenidos y $40.000 por cliente, encontrar a
## uno vale $4.000 y gana el proveedor A ($60.500): sus clientes pagan su costo,
## pero los adicionales de la regla ($5.108 cada uno) ya no. cambia retencion a
## 0.20 y vuelve a correr: encontrar a uno vale $8.000 y gana el proveedor B ($682.250)

##============================================================================##
##=== 7. El pronóstico de Finanzas: cuando la predicción es un monto       ===##
##============================================================================##
## pregunta: ¿cuánto gastará cada cliente el próximo trimestre? ya no hay acierto
## o error: hay distancia, en pesos, entre el pronóstico y la realidad

## antes de las métricas, mira los pronósticos: ¿son siquiera posibles?
summary(evaluacion$pron_regla_finanzas)
summary(evaluacion$pron_proveedor_a)
summary(evaluacion$pron_proveedor_b)
sum(evaluacion$pron_proveedor_a < 0)
## 🎯 checkpoint: el proveedor A le pronostica gasto negativo a 413 clientes. es
## imposible, y ninguna métrica lo señala por sí sola: hay que mirar

## la referencia: el gasto promedio de train, el mismo pronóstico para todos
train       <- clientes %>%
               filter(!cliente_id %in% predicciones$cliente_id)
media_train <- mean(train$gasto_proximo_trim)
round(media_train)

## el error de cada cliente, en pesos
error_media <- abs(evaluacion$gasto_proximo_trim - media_train)
error_regla <- abs(evaluacion$gasto_proximo_trim - evaluacion$pron_regla_finanzas)
error_a     <- abs(evaluacion$gasto_proximo_trim - evaluacion$pron_proveedor_a)
error_b     <- abs(evaluacion$gasto_proximo_trim - evaluacion$pron_proveedor_b)

## MAE: el error típico por cliente; RMSE: castiga más los errores grandes
errores <- data.frame(pronostico = c("media de train", "3 x gasto mensual", "proveedor A", "proveedor B"),
                      mae        = c(mean(error_media), mean(error_regla), mean(error_a), mean(error_b)),
                      rmse       = sqrt(c(mean(error_media^2), mean(error_regla^2), mean(error_a^2), mean(error_b^2))))
errores %>%
  mutate(mae = round(mae), rmse = round(rmse))
## 🎯 checkpoint: la regla de Finanzas (168.728) y el proveedor B (165.540) casi
## empatan en MAE; B tiene errores grandes menores (RMSE 612.315 frente a 655.018).
## el proveedor A tiene el mejor RMSE (602.617), pero el peor MAE de los tres
## (201.363) y pronósticos imposibles

## la figura: el error típico y los errores grandes, en miles de pesos
grafico_errores <- bind_rows(errores %>% transmute(pronostico, metrica = "MAE",  valor = mae / 1000),
                             errores %>% transmute(pronostico, metrica = "RMSE", valor = rmse / 1000)) %>%
                   mutate(pronostico = factor(pronostico, levels = c("media de train", "3 x gasto mensual",
                                                                     "proveedor A", "proveedor B")))

ggplot(grafico_errores, aes(x = pronostico, y = valor)) +
  geom_col(fill = azul, width = 0.6) +
  geom_text(aes(y = 0, label = round(valor)), vjust = -0.6, color = "white", size = 3.3) +
  facet_wrap(~ metrica, scales = "free_y") +
  labs(title = "El mejor en MAE no es el mejor en RMSE",
       subtitle = "Clientes que ningún modelo vio · en miles de pesos",
       x = NULL, y = "Miles de pesos") +
  theme_minimal(base_size = 13) +
  theme(axis.text.x = element_text(angle = 25, hjust = 1))
ggsave("output/fig_errores_s10.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 8. Lo que heredan las semanas 11 y 12: las tablas del líder          ===##
##============================================================================##
## las listas y pronósticos de la casa (los proveedores no: sus modelos no son
## de Cóndor) pasan a las tablas que tus propios modelos tendrán que vencer. las
## tablas guardan también el margen de ±2 errores estándar que usan esas semanas
lider_abandono <- metricas %>%
                  filter(lista %in% c("nadie abandona", "regla del EDA", "memorizador")) %>%
                  mutate(margen = 2 * sqrt(accuracy * (1 - accuracy) / (tp + fp + fn + tn))) %>%
                  transmute(regla       = lista,
                            llamadas    = tp + fp,
                            encontrados = tp,
                            accuracy    = round(accuracy, 3),
                            margen      = round(margen, 3))
lider_gasto    <- data.frame(regla  = c("media de train", "3 x gasto mensual"),
                             mae    = round(c(mean(error_media), mean(error_regla))),
                             margen = round(2 * c(sd(error_media), sd(error_regla)) / sqrt(nrow(evaluacion))),
                             rmse   = round(sqrt(c(mean(error_media^2), mean(error_regla^2)))))

## export data
write.csv(lider_abandono, "output/lider_abandono_s10.csv", row.names = F)
write.csv(lider_gasto, "output/lider_gasto_s10.csv", row.names = F)

##============================================================================##
##=== 9. Opcional: el AUC  (no entra en la decisión de hoy)                ===##
##============================================================================##
## los proveedores entregan, además de su lista, una probabilidad por cliente; su
## lista es esa probabilidad pasada por un umbral (A usó 0.5 y B usó 0.3)
table(lista = evaluacion$lista_proveedor_a, prob_mayor_05 = evaluacion$prob_proveedor_a >= 0.5)
table(lista = evaluacion$lista_proveedor_b, prob_mayor_03 = evaluacion$prob_proveedor_b >= 0.3)

## el AUC: de cada par (uno que se fue, uno que se quedó), ¿en qué fracción le
## dio más probabilidad al que se fue? 0.5 es ordenar al azar; 1, ordenar perfecto.
## outer() resta cada probabilidad de los que se fueron menos cada una de los
## que se quedaron: 354 x 1.246 restas. un empate (resta igual a 0) cuenta media
se_van    <- evaluacion %>% filter(abandono == 1)
se_quedan <- evaluacion %>% filter(abandono == 0)

pares_a <- outer(se_van$prob_proveedor_a, se_quedan$prob_proveedor_a, "-")
auc_a   <- mean(pares_a > 0) + 0.5 * mean(pares_a == 0)
pares_b <- outer(se_van$prob_proveedor_b, se_quedan$prob_proveedor_b, "-")
auc_b   <- mean(pares_b > 0) + 0.5 * mean(pares_b == 0)
round(c(auc_a = auc_a, auc_b = auc_b), 3)
## 🎯 checkpoint: 0.780 y 0.763. el AUC califica el orden de las probabilidades,
## no la lista que llega a Growth; por eso hoy no cambia la decisión

## la figura: la probabilidad que cada proveedor le asignó a quien se fue y a
## quien se quedó; a la derecha de la línea, su lista
probabilidades <- bind_rows(evaluacion %>% transmute(proveedor = "proveedor A (umbral 0.5)", prob = prob_proveedor_a, abandono),
                            evaluacion %>% transmute(proveedor = "proveedor B (umbral 0.3)", prob = prob_proveedor_b, abandono)) %>%
                  mutate(realidad = ifelse(abandono == 1, "se fue", "se quedó"))
umbrales <- data.frame(proveedor = c("proveedor A (umbral 0.5)", "proveedor B (umbral 0.3)"),
                       umbral    = c(0.5, 0.3))

ggplot(probabilidades, aes(x = prob, fill = realidad)) +
  geom_histogram(binwidth = 0.05, boundary = 0, position = "identity", alpha = 0.6) +
  geom_vline(data = umbrales, aes(xintercept = umbral), linetype = "dashed") +
  facet_wrap(~ proveedor) +
  scale_fill_manual(values = c("se fue" = naranja, "se quedó" = gris)) +
  labs(title = "Quien se fue recibe más probabilidad, pero hay traslapo",
       subtitle = paste0("AUC: proveedor A ", format(round(auc_a, 3), nsmall = 3),
                         " · proveedor B ", format(round(auc_b, 3), nsmall = 3)),
       x = "Probabilidad de abandono entregada por el proveedor", y = "Clientes", fill = NULL) +
  theme_minimal(base_size = 13)
ggsave("output/fig_probabilidades_s10.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 10. Para entregar: tu recomendación  (responde como comentarios)     ===##
##============================================================================##
## guarda este archivo como apellido_nombre_taller10.R y súbelo a Intu. usa las
## cifras de TU corrida: una recomendación sin números no es una recomendación

## pregunta 1 (Growth, clasificación). elige tu escenario: ¿qué fracción de los
## clientes encontrados crees que retiene la campaña y cuánto le deja a Cóndor un
## cliente retenido? córrelo en el bloque 6 y, con ese resultado y tus métricas,
## ¿qué lista le recomiendas a Growth? explica por qué descartas cada una de las otras.
## respuesta:

## pregunta 2 (Finanzas, regresión). ¿qué pronóstico del gasto le recomiendas a
## Finanzas? justifícalo con el MAE y el RMSE y explica por qué descartas los demás.
## respuesta:

##============================================================================##
## DECLARACIÓN DE USO DE IA (nivel 3)
## Herramienta y modelo usados: _______________ (o "No usé IA")
## La usé para: _______________________________
## Verifiqué por mi cuenta: ____________________
##============================================================================##
