##============================================================================##
# 06_eda_condor.R  —  el EDA de Cóndor: conocer los datos antes de modelar
#------------------------------------------------------------------------------#
# Analítica para los negocios (06327-ECO) · Semana 6 · script de la clase
# La pregunta de Growth: ¿qué clientes activos se volverán inactivos el próximo
# trimestre? Hoy no se responde: se prepara. Lee las tablas publicadas de Cóndor
# desde la URL del proyecto. Produce en output/:
#   - fig_target_s06.png, fig_recencia_s06.png, fig_monto_s06.png       (pasos 2 y 3)
#   - fig_abandono_recencia_s06.png, fig_abandono_sesiones_s06.png      (paso 4)
#   - fig_abandono_canal_s06.png, fig_abandono_ciudad_s06.png           (paso 5)
#   - fig_cruce_s06.png, fig_campanas_s06.png, fig_gasto_cola_s06.png   (pasos 6 a 8)
#   - base_analitica_s06.csv  (grano: cliente; lo que la pregunta necesita)
# El bloque 10, al final, es el taller: se resuelve y se entrega este archivo.
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

## las cuatro tablas de Cóndor (transacciones pesa unos 15 MB: paciencia)
dir.create("output", showWarnings = F)
url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes      <- read.csv(paste0(url, "base_clientes.csv"))
transacciones <- read.csv(paste0(url, "anexo_transacciones.csv"))
creditos      <- read.csv(paste0(url, "anexo_creditos.csv"))
campanas      <- read.csv(paste0(url, "anexo_campanas.csv"))

##============================================================================##
##=== 1. ¿Qué es una fila y qué falta?                                     ===##
##============================================================================##
## pregunta: antes de cualquier cálculo, ¿qué representa una fila en cada tabla?
## si las filas no coinciden con los clientes distintos, hay varias por cliente
c(filas = nrow(clientes),      clientes = n_distinct(clientes$cliente_id))
c(filas = nrow(transacciones), clientes = n_distinct(transacciones$cliente_id))
c(filas = nrow(creditos),      clientes = n_distinct(creditos$cliente_id))
c(filas = nrow(campanas),      clientes = n_distinct(campanas$cliente_id))
sum(duplicated(clientes))
## 🎯 checkpoint: 8.000 clientes en la base (una fila cada uno, 0 duplicadas);
## 185.582 transacciones, 4.071 solicitudes de crédito y 13.467 envíos de campaña

## no creer: verificar. la frecuencia de la base debería salir del anexo
conteo_tx <- transacciones %>%
             group_by(cliente_id) %>%
             summarise(n_tx = n())
chequeo <- clientes %>%
           select(cliente_id, frecuencia_tx) %>%
           inner_join(conteo_tx, by = "cliente_id")
mean(chequeo$frecuencia_tx == chequeo$n_tx)
## 🎯 checkpoint: 1, coincide en el 100 % de los clientes

## ¿qué falta? y, sobre todo, ¿a quién le falta?
colSums(is.na(clientes))[colSums(is.na(clientes)) > 0]
c(sin_sesiones = sum(clientes$num_sesiones_ult30d == 0),
  sin_tickets  = sum(clientes$num_tickets == 0),
  sin_credito  = sum(clientes$tiene_credito == 0))

## ¿son los mismos clientes? si todo cae en la diagonal, el faltante es "no aplica"
table(falta_csat = is.na(clientes$csat_promedio), sin_tickets = clientes$num_tickets == 0)
## 🎯 checkpoint: 855, 5.279 y 5.279 faltantes, exactamente los clientes sin
## sesiones, sin tickets y sin crédito: no son huecos, son "no aplica". la
## decisión: no se imputa (una satisfacción inventada es una opinión que nadie dio)

##============================================================================##
##=== 2. ¿Cómo se ve el target?                                            ===##
##============================================================================##
## pregunta: ¿cuántos se vuelven inactivos? esa tasa es la vara de todo lo demás
table(clientes$abandono)
round(mean(clientes$abandono), 4)

## ¿son "activos" los que llevan más de 90 días sin transar?
viejos <- clientes %>%
          filter(recencia_dias > 90)
c(clientes = nrow(viejos), tasa_abandono = round(mean(viejos$abandono), 3))
## 🎯 checkpoint: 1.772 de 8.000 (0.2215); 886 clientes llevan más de 90 días sin
## transar y el 59,7 % ya figura como abandono. qué es "activo" se acuerda con
## Growth antes de modelar

## la figura: la tasa base
target <- clientes %>%
          count(abandono) %>%
          mutate(estado = ifelse(abandono == 1, "se vuelve inactivo", "sigue activo"),
                 p      = n / sum(n))

ggplot(target, aes(x = estado, y = p, fill = estado)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0(round(100 * p, 1), " %\n", n, " clientes")), vjust = -0.3, size = 4) +
  scale_fill_manual(values = c("sigue activo" = gris, "se vuelve inactivo" = naranja), guide = "none") +
  scale_y_continuous(limits = c(0, 1)) +
  labs(title = "Uno de cada cinco clientes se vuelve inactivo",
       subtitle = "abandono en base_clientes (8.000 clientes)",
       x = NULL, y = "Proporción de clientes") +
  theme_minimal(base_size = 13)
ggsave("output/fig_target_s06.png", width = 6, height = 4.4, dpi = 200)

##============================================================================##
##=== 3. ¿Cómo se distribuyen las candidatas?                              ===##
##============================================================================##
## pregunta: ¿el cliente "promedio" describe a alguien? se compara media y mediana
c(mediana = median(clientes$recencia_dias), media = round(mean(clientes$recencia_dias), 1))
c(mediana = median(clientes$monto_total), media = round(mean(clientes$monto_total)))
## 🎯 checkpoint: recencia, mediana 15 días y media 38,6; monto total, mediana
## 416.650 y media 609.632. con colas largas se describe con medianas y tramos

## las figuras: dos colas largas a la derecha
ggplot(clientes, aes(x = recencia_dias)) +
  geom_histogram(binwidth = 15, boundary = 0, fill = azul, color = "white") +
  geom_vline(xintercept = median(clientes$recencia_dias), color = naranja, linewidth = 1) +
  geom_vline(xintercept = mean(clientes$recencia_dias), color = "grey30", linetype = "dashed", linewidth = 0.9) +
  labs(title = "Días desde la última transacción: una cola larga",
       subtitle = "naranja: la mediana (15 días); punteada: la media (39 días)",
       x = "recencia_dias", y = "Clientes") +
  theme_minimal(base_size = 13)
ggsave("output/fig_recencia_s06.png", width = 7.5, height = 4.6, dpi = 200)

ggplot(clientes, aes(x = monto_total / 1e6)) +
  geom_histogram(binwidth = 0.1, boundary = 0, fill = azul, color = "white") +
  geom_vline(xintercept = median(clientes$monto_total) / 1e6, color = naranja, linewidth = 1) +
  geom_vline(xintercept = mean(clientes$monto_total) / 1e6, color = "grey30", linetype = "dashed", linewidth = 0.9) +
  labs(title = "Monto total transado: la media queda arrastrada",
       subtitle = "naranja: la mediana ($417 mil); punteada: la media ($610 mil)",
       x = "monto_total (millones de pesos)", y = "Clientes") +
  theme_minimal(base_size = 13)
ggsave("output/fig_monto_s06.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 4. ¿Quiénes abandonan más?  (grano: tramo)                           ===##
##============================================================================##
## pregunta: ¿cambia la tasa de abandono con el comportamiento reciente? las
## numéricas se comparan por tramos (cut), como decidió el paso anterior
por_recencia <- clientes %>%
                mutate(tramo = cut(recencia_dias, breaks = c(-1, 7, 30, 60, 90, Inf),
                                   labels = c("1-7 días", "8-30", "31-60", "61-90", "más de 90"))) %>%
                group_by(tramo) %>%
                summarise(clientes = n(), tasa = mean(abandono))
por_recencia

por_sesiones <- clientes %>%
                mutate(tramo = cut(num_sesiones_ult30d, breaks = c(-1, 0, 3, 10, 20, Inf),
                                   labels = c("0 sesiones", "1-3", "4-10", "11-20", "más de 20"))) %>%
                group_by(tramo) %>%
                summarise(clientes = n(), tasa = mean(abandono))
por_sesiones
## 🎯 checkpoint: por recencia, del 12,4 % (esta semana) al 59,7 % (más de 90
## días); por sesiones, del 56,5 % (cero) al 2,2 % (más de 20). el "faltante" del
## paso 1, cero sesiones, es el grupo de mayor riesgo

## las figuras: la tasa por tramo contra la tasa global (línea punteada)
ggplot(por_recencia, aes(x = tramo, y = tasa)) +
  geom_col(fill = naranja, width = 0.7) +
  geom_hline(yintercept = mean(clientes$abandono), linetype = "dashed", color = "grey30") +
  geom_text(aes(label = paste0(round(100 * tasa, 1), " %")), vjust = -0.4, size = 4) +
  scale_y_continuous(limits = c(0, 0.72)) +
  labs(title = "A más días sin transar, más abandono",
       subtitle = "tasa de abandono por tramo de recencia · punteada: tasa global",
       x = "Días desde la última transacción", y = "Tasa de abandono") +
  theme_minimal(base_size = 13)
ggsave("output/fig_abandono_recencia_s06.png", width = 6.2, height = 4.6, dpi = 200)

ggplot(por_sesiones, aes(x = tramo, y = tasa)) +
  geom_col(fill = naranja, width = 0.7) +
  geom_hline(yintercept = mean(clientes$abandono), linetype = "dashed", color = "grey30") +
  geom_text(aes(label = paste0(round(100 * tasa, 1), " %")), vjust = -0.4, size = 4) +
  scale_y_continuous(limits = c(0, 0.72)) +
  labs(title = "Quien no abre la app ya casi se fue",
       subtitle = "tasa de abandono por tramo de sesiones · punteada: tasa global",
       x = "Sesiones en la app en los últimos 30 días", y = "Tasa de abandono") +
  theme_minimal(base_size = 13)
ggsave("output/fig_abandono_sesiones_s06.png", width = 6.2, height = 4.6, dpi = 200)

##============================================================================##
##=== 5. ¿Y lo que "debería" importar?  (grano: grupo)                     ===##
##============================================================================##
## pregunta: canal y ciudad parecen obvios. ¿discriminan, o salen planos?
por_canal <- clientes %>%
             group_by(canal_adquisicion) %>%
             summarise(clientes = n(), tasa = mean(abandono))
por_canal

por_ciudad <- clientes %>%
              group_by(ciudad) %>%
              summarise(clientes = n(), tasa = mean(abandono)) %>%
              arrange(desc(tasa))
por_ciudad
## 🎯 checkpoint: canal, del 21,1 % al 23,9 %; ciudad, del 20,3 % al 23,6 %:
## ruido alrededor de la tasa global. un gráfico plano también es un hallazgo

## las figuras: la misma escala de la figura anterior, a propósito
ggplot(por_canal, aes(x = reorder(canal_adquisicion, -tasa), y = tasa)) +
  geom_col(fill = gris, width = 0.7) +
  geom_hline(yintercept = mean(clientes$abandono), linetype = "dashed", color = naranja, linewidth = 0.9) +
  geom_text(aes(label = paste0(round(100 * tasa, 1), " %")), vjust = 1.6, color = "white", size = 3.8) +
  scale_y_continuous(limits = c(0, 0.72)) +
  labs(title = "El canal de llegada no cambia casi nada",
       subtitle = "misma escala que la figura de recencia · punteada: tasa global",
       x = "Canal de adquisición", y = "Tasa de abandono") +
  theme_minimal(base_size = 13)
ggsave("output/fig_abandono_canal_s06.png", width = 6.2, height = 4.6, dpi = 200)

ggplot(por_ciudad, aes(x = reorder(ciudad, -tasa), y = tasa)) +
  geom_col(fill = gris, width = 0.7) +
  geom_hline(yintercept = mean(clientes$abandono), linetype = "dashed", color = naranja, linewidth = 0.9) +
  geom_text(aes(label = paste0(round(100 * tasa), " %")), vjust = 1.6, color = "white", size = 3.3) +
  scale_y_continuous(limits = c(0, 0.72)) +
  labs(title = "Tampoco la ciudad: todas entre 20 % y 24 %",
       subtitle = "misma escala que la figura de recencia · punteada: tasa global",
       x = NULL, y = "Tasa de abandono") +
  theme_minimal(base_size = 13) +
  theme(axis.text.x = element_text(angle = 35, hjust = 1))
ggsave("output/fig_abandono_ciudad_s06.png", width = 6.2, height = 4.6, dpi = 200)

##============================================================================##
##=== 6. ¿Las dos señales miden lo mismo?  (grano: tramo x tramo)          ===##
##============================================================================##
## pregunta: si recencia y sesiones dijeran lo mismo, bastaría una
round(cor(clientes$recencia_dias, clientes$num_sesiones_ult30d), 2)

cruce <- clientes %>%
         mutate(recencia = cut(recencia_dias, breaks = c(-1, 7, 30, 90, Inf),
                               labels = c("1-7 días", "8-30", "31-90", "más de 90")),
                sesiones = cut(num_sesiones_ult30d, breaks = c(-1, 0, 3, 10, Inf),
                               labels = c("0", "1-3", "4-10", "más de 10"))) %>%
         group_by(recencia, sesiones) %>%
         summarise(clientes = n(), tasa = mean(abandono), .groups = "drop")
cruce
## 🎯 checkpoint: correlación de -0.35: se parecen, pero no son lo mismo. con
## transacción esta semana y cero sesiones ya se va el 35 %; sin transar en 90
## días y sin sesiones, el 74 %; con más de 10 sesiones nunca pasa del 7 %

## la figura: el mapa de calor del cruce
ggplot(cruce, aes(x = sesiones, y = recencia, fill = tasa)) +
  geom_tile(color = "white", linewidth = 1) +
  geom_text(aes(label = paste0(round(100 * tasa), " %\nn = ", clientes)), size = 3.4, lineheight = 0.9) +
  scale_fill_gradient(low = "#FDEBDD", high = naranja, name = "Tasa de\nabandono") +
  labs(title = "Recencia y sesiones no miden lo mismo: se refuerzan",
       subtitle = "sin transar ni abrir la app, 3 de cada 4 se van",
       x = "Sesiones en la app (últimos 30 días)", y = "Días desde la última transacción") +
  theme_minimal(base_size = 13)
ggsave("output/fig_cruce_s06.png", width = 7.8, height = 4.6, dpi = 200)

##============================================================================##
##=== 7. ¿Qué aporta un anexo? Agregar y luego unir  (grano: cliente)      ===##
##============================================================================##
## pregunta: las campañas vienen en otra tabla, con una fila por envío. ¿cómo
## se llevan al cliente sin duplicarlo? primero el error, para verlo
nrow(left_join(clientes, campanas, by = "cliente_id"))
## 🎯 checkpoint: 15.081 filas: unir sin agregar duplica clientes, y R no avisa

## lo correcto: agregar por cliente y después unir
camp_cliente <- campanas %>%
                group_by(cliente_id) %>%
                summarise(n_campanas    = n(),
                          n_convertidas = sum(convertido))
base <- clientes %>%
        left_join(camp_cliente, by = "cliente_id") %>%
        mutate(n_campanas    = ifelse(is.na(n_campanas), 0, n_campanas),
               n_convertidas = ifelse(is.na(n_convertidas), 0, n_convertidas),
               grupo_campana = case_when(n_campanas == 0    ~ "sin campañas",
                                         n_convertidas == 0 ~ "recibió y no respondió",
                                         T                  ~ "respondió al menos una"))
nrow(base)

por_campana <- base %>%
               group_by(grupo_campana) %>%
               summarise(clientes = n(), tasa = mean(abandono))
por_campana
## 🎯 checkpoint: siguen 8.000 filas; quien respondió alguna campaña abandona el
## 12,3 % y quien la recibió sin responder, el 24,1 %. ojo: es correlación (¿la
## campaña retiene o los fieles responden más?): hipótesis, no conclusión

## la figura: el anexo, ya al nivel del cliente
ggplot(por_campana, aes(x = factor(grupo_campana, levels = c("sin campañas", "recibió y no respondió",
                                                              "respondió al menos una")), y = tasa)) +
  geom_col(fill = azul, width = 0.62) +
  geom_hline(yintercept = mean(clientes$abandono), linetype = "dashed", color = "grey30") +
  geom_text(aes(label = paste0(round(100 * tasa, 1), " %")), vjust = -0.4, size = 4) +
  scale_y_continuous(limits = c(0, 0.32)) +
  labs(title = "Quien respondió alguna campaña abandona la mitad",
       subtitle = "anexo_campanas agregado por cliente y unido a la base",
       x = NULL, y = "Tasa de abandono") +
  theme_minimal(base_size = 13)
ggsave("output/fig_campanas_s06.png", width = 7, height = 4.4, dpi = 200)

##============================================================================##
##=== 8. ¿Qué raro quedó y qué no se puede usar?                           ===##
##============================================================================##
## pregunta: ¿los valores extremos son errores? se mira la fila completa
q1     <- quantile(clientes$gasto_proximo_trim, 0.25)
q3     <- quantile(clientes$gasto_proximo_trim, 0.75)
limite <- q3 + 1.5 * (q3 - q1)
c(por_encima = sum(clientes$gasto_proximo_trim > limite),
  porcentaje = round(100 * mean(clientes$gasto_proximo_trim > limite), 1))
clientes %>%
  filter(gasto_proximo_trim == max(gasto_proximo_trim)) %>%
  select(antiguedad_meses, recencia_dias, frecuencia_tx, num_sesiones_ult30d, gasto_proximo_trim)
## 🎯 checkpoint: la regla del IQR marca a 886 clientes (11,1 %). el máximo,
## $44,1 millones, es un cliente de un mes con 72 transacciones que transó ayer:
## no es un error, es un cliente que despegó. se conserva y se reporta

## la fuga: gasto_proximo_trim "separa" muy bien a quienes se van...
clientes %>%
  group_by(abandono) %>%
  summarise(mediana_gasto_futuro = median(gasto_proximo_trim))
## 🎯 checkpoint: 105.050 contra 23.300. claro: es del futuro, se conoce después
## del corte, igual que el abandono. nunca entra como predictora

## la figura: la cola larga en escala logarítmica
ggplot(clientes, aes(x = gasto_proximo_trim)) +
  geom_histogram(bins = 40, fill = azul, color = "white") +
  geom_vline(xintercept = limite, color = naranja, linewidth = 1) +
  scale_x_log10(breaks = c(1e3, 1e4, 1e5, 1e6, 1e7),
                labels = c("$1 mil", "$10 mil", "$100 mil", "$1 M", "$10 M")) +
  labs(title = "Con colas largas, la regla del IQR marca al 11 % de la base",
       subtitle = "gasto_proximo_trim en escala logarítmica · naranja: el límite del IQR",
       x = "gasto_proximo_trim (escala log)", y = "Clientes") +
  theme_minimal(base_size = 13)
ggsave("output/fig_gasto_cola_s06.png", width = 7.5, height = 4.6, dpi = 200)

##============================================================================##
##=== 9. Lo que sale del EDA: la base analítica  (grano: cliente)          ===##
##============================================================================##
## el acta en código: sin el futuro, con las señales marcadas y las campañas
## agregadas. los "no aplica" quedan como están y se documentan
base_analitica <- base %>%
                  mutate(sin_sesiones = ifelse(num_sesiones_ult30d == 0, 1, 0),
                         abrio_ticket = ifelse(num_tickets > 0, 1, 0)) %>%
                  select(-gasto_proximo_trim, -grupo_campana)
dim(base_analitica)

## export data
write.csv(base_analitica, "output/base_analitica_s06.csv", row.names = F)
## 🎯 checkpoint: 8.000 filas y 32 columnas: una fila por cliente, sin el gasto
## del próximo trimestre y con las campañas e indicadores nuevos

##============================================================================##
##=== 10. Para entregar: el EDA de tu pregunta  (escribe código y comentarios) ##
##============================================================================##
## individual, sobre la pregunta de negocio de tu equipo (la de la Entrega 1).
## guarda este archivo como apellido_nombre_taller6.R y súbelo a Intu.

## 1. encabezado (comentarios): la pregunta del equipo, su variable objetivo (o
##    "segmentación, sin target") y qué es una fila en la base de tu pregunta.

## 2. la base de tu pregunta: carga solo las tablas que necesitas y constrúyela
##    al grano de la pregunta (agregar primero, unir después). confirma las filas.

## 3. dos exploraciones de las de hoy aplicadas a tu pregunta (la distribución del
##    target, una comparación por tramos, un cruce, un extremo en su fila completa).
##    debajo de cada salida escribe:
##    ## HALLAZGO: qué muestra, con su número
##    ## POR QUÉ IMPORTA: qué aporta para responder la pregunta

## 4. ¿qué columna no puedes usar como predictora en tu pregunta y por qué?

##============================================================================##
## DECLARACIÓN DE USO DE IA (nivel 3)
## Herramienta y modelo usados: _______________ (o "No usé IA")
## La usé para: _______________________________
## Verifiqué por mi cuenta: ____________________
##============================================================================##
