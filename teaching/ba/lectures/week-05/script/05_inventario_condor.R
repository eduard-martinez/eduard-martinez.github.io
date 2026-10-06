##============================================================================##
# 05_inventario_condor.R  —  el inventario de Cóndor: qué datos hay y qué permiten
#------------------------------------------------------------------------------#
# Analítica para los negocios (06327-ECO) · Semana 5 · script de la clase
# Antes de formular una pregunta de negocio hay que saber qué hay en los datos.
# Lee las cuatro tablas publicadas de Cóndor desde la URL del proyecto. Produce
# en output/:
#   - inventario_s05.csv  (grano: target; tabla, qué es una fila, tipo y tarea)
#   - fig_targets_s05.png (la frecuencia de cada target de sí o no)
# El bloque 6, al final, es el taller (la Entrega 1): se resuelve en equipo y se
# entrega este archivo.
# Grupo: _______________
##============================================================================##

##============================================================================##
##=== 0. Configuración inicial                                             ===##
##============================================================================##
rm(list = ls())
## librerías (si falta pacman: install.packages("pacman") en la consola)
require(pacman)
p_load(dplyr, ggplot2)

## color del curso para la figura
naranja <- "#E87722"

## las cuatro tablas de Cóndor (transacciones pesa unos 15 MB: paciencia)
dir.create("output", showWarnings = F)
url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes      <- read.csv(paste0(url, "base_clientes.csv"))
transacciones <- read.csv(paste0(url, "anexo_transacciones.csv"))
creditos      <- read.csv(paste0(url, "anexo_creditos.csv"))
campanas      <- read.csv(paste0(url, "anexo_campanas.csv"))

##============================================================================##
##=== 1. ¿Qué es una fila en cada tabla?                                   ===##
##============================================================================##
## pregunta: la regla cero. si las filas no coinciden con los clientes
## distintos, la tabla tiene varias filas por cliente
c(filas = nrow(clientes),      columnas = ncol(clientes),      clientes = n_distinct(clientes$cliente_id))
c(filas = nrow(transacciones), columnas = ncol(transacciones), clientes = n_distinct(transacciones$cliente_id))
c(filas = nrow(creditos),      columnas = ncol(creditos),      clientes = n_distinct(creditos$cliente_id))
c(filas = nrow(campanas),      columnas = ncol(campanas),      clientes = n_distinct(campanas$cliente_id))
## 🎯 checkpoint: la base tiene 8.000 filas y 8.000 clientes: una fila es un
## cliente. transacciones (185.582), créditos (4.071 de 2.721 clientes) y campañas
## (13.467 de 6.386) tienen varias filas por cliente: todas se unen por cliente_id

##============================================================================##
##=== 2. ¿Qué periodo cubre cada tabla?                                    ===##
##============================================================================##
## pregunta: ¿desde cuándo y hasta cuándo hay datos? el corte es el 31 de marzo
## de 2026: lo que se mide antes sirve para predecir; lo de después, no
range(as.Date(transacciones$timestamp))
range(as.Date(creditos$fecha_solicitud))
range(as.Date(campanas$fecha_envio))
## 🎯 checkpoint: las tres empiezan el 1 de enero de 2025 y terminan antes del
## corte (30 de marzo, 28 de febrero y 15 de marzo de 2026)

##============================================================================##
##=== 3. ¿Qué columna trae la respuesta? Los cinco targets                 ===##
##============================================================================##
## pregunta: un target es la respuesta histórica que un modelo puede aprender.
## de su tipo depende la tarea: sí o no es clasificación; un monto, predicción
table(clientes$abandono)
summary(clientes$gasto_proximo_trim)
table(transacciones$etiqueta_fraude)
table(creditos$default_90d)
table(campanas$convertido)
## 🎯 checkpoint: 1.772 abandonos de 8.000 clientes; gasto con mediana de
## 79.450 pesos; 1.480 fraudes en 185.582 transacciones; 559 créditos en mora de
## 4.071; 1.341 conversiones en 13.467 envíos

## el inventario de targets: dónde vive cada uno y qué tarea abre
inventario <- data.frame(target      = c("abandono", "gasto_proximo_trim", "etiqueta_fraude",
                                         "default_90d", "convertido"),
                         tabla       = c("base_clientes", "base_clientes", "anexo_transacciones",
                                         "anexo_creditos", "anexo_campanas"),
                         una_fila_es = c("un cliente", "un cliente", "una transacción",
                                         "una solicitud de crédito", "un envío de campaña"),
                         tipo        = c("sí o no", "monto en pesos", "sí o no", "sí o no", "sí o no"),
                         tarea       = c("clasificación", "predicción", "clasificación o anomalías",
                                         "clasificación", "clasificación"))
inventario

## export data
write.csv(inventario, "output/inventario_s05.csv", row.names = F)

## la figura: qué tan frecuente es el "sí" de cada target
tasas <- data.frame(target = c("abandono (por cliente)", "default_90d (por crédito)",
                               "convertido (por envío)", "etiqueta_fraude (por transacción)"),
                    tasa   = c(mean(clientes$abandono), mean(creditos$default_90d),
                               mean(campanas$convertido), mean(transacciones$etiqueta_fraude)))

ggplot(tasas, aes(x = reorder(target, tasa), y = tasa)) +
  geom_col(fill = naranja, width = 0.6) +
  geom_text(aes(label = paste0(format(round(100 * tasa, 2), nsmall = 2), " %")), hjust = -0.2, size = 4) +
  coord_flip() +
  scale_y_continuous(limits = c(0, 0.3)) +
  labs(title = "Cuatro targets de sí o no, con frecuencias muy distintas",
       subtitle = "Proporción de casos positivos en cada tabla de Cóndor",
       x = NULL, y = "Proporción de casos positivos") +
  theme_minimal(base_size = 13) +
  theme(plot.title.position = "plot")
ggsave("output/fig_targets_s05.png", width = 7.5, height = 4.2, dpi = 200)
## 🎯 checkpoint: abandono 22,15 %, mora 13,73 %, conversión 9,96 % y fraude 0,80 %.
## cuanto más raro el evento, más difícil encontrarlo (se verá en la semana 10)

##============================================================================##
##=== 4. ¿Y si la pregunta no tiene target?                                ===##
##============================================================================##
## pregunta: segmentar no tiene respuesta correcta: se agrupan clientes que se
## parecen. para eso, Cóndor tiene el RFM de todos sus clientes
summary(clientes$recencia_dias)
summary(clientes$frecuencia_tx)
summary(clientes$monto_total)
## 🎯 checkpoint: la mitad de los clientes transó hace 15 días o menos; la
## mediana del monto total es 416.650 pesos. con esto se arman grupos (semana 13)

##============================================================================##
##=== 5. ¿Qué no se puede usar? Lo que se conoce después                   ===##
##============================================================================##
## pregunta: una pregunta que predice con información del futuro no se puede
## responder de verdad. en créditos, dias_mora se conoce después de prestar
table(default_90d = creditos$default_90d, mora_mayor_90 = creditos$dias_mora >= 90)
## 🎯 checkpoint: coincidencia perfecta (3.512 y 559 en la diagonal): dias_mora ya
## contiene la respuesta. lo mismo pasa en la base con gasto_proximo_trim frente
## al abandono: las dos se conocen después del corte

##============================================================================##
##=== 6. Para entregar: la Entrega 1  (en equipo, responde como comentarios) ===##
##============================================================================##
## guarden este archivo como grupo_apellidos_taller5.R y súbanlo a Intu antes de
## terminar la clase. usen las salidas de este script y el documento del caso.

## punto 1 (1.0). la necesidad: ¿qué le duele a Cóndor y qué decide hoy a ciegas?
## ¿en qué frente trabajará el grupo, por qué es viable con estos datos y quién
## decide en ese frente?
## respuesta:

## punto 2 (1.25). el inventario: para cada tabla que usarán, ¿qué es una fila,
## qué periodo cubre y cuál es el target (o por qué no hay)? nombren al menos
## cinco variables relevantes y digan por qué importa cada una.
## respuesta:

## punto 3 (2.25). de una a tres preguntas de negocio. para cada una: la pregunta
## (específica, accionable y medible), quién decide y qué decisión cambia, la
## tarea analítica con su target, y las tablas y variables que la responden.
## respuesta:

## punto 4 (0.5). el detector: ¿qué pregunta llevan a la Entrega 2 y por qué gana
## a las otras? ¿qué dato les falta para responderla mejor?
## respuesta:

##============================================================================##
## DECLARACIÓN DE USO DE IA (nivel 2, planificación: para entender el caso u
## organizar; no para formular las preguntas)
## Herramienta y modelo usados: _______________ (o "No usamos IA")
## La usamos para: _______________________________
## Verificamos por nuestra cuenta: ____________________
##============================================================================##
