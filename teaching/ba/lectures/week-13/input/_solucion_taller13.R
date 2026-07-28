## ============================================================
##  Introducción al Business Analytics (06278-ECO)
##  Semana 13 | SOLUCIÓN DE REFERENCIA del Taller 13 (uso interno)
##  "El mapa de los socios" — CaliFit
##  Reproduce el código esperado del estudiante leyendo el CSV
##  publicado. Sirve para calificar: toda cifra sale de aquí.
## ============================================================

rm(list = ls())

## Librerías / Libraries
pacman::p_load(dplyr, ggplot2, cluster)

## Cargar datos / Load data (el estudiante usa data/socios_califit.csv)
socios <- read.csv("../task/socios_califit.csv")

## ============================================================
## Punto 0 — Radiografía
## ============================================================
cat("== P0 ==\n")
print(dim(socios))          # 280 x 5
print(str(socios))
print(summary(socios))
## 0c: id_socio es numérico pero NO entra al clustering: es un
## identificador administrativo; su "distancia" (1001 vs 1280) no
## mide similitud de comportamiento. Meterlo distorsiona los grupos.

## ============================================================
## Punto 1 — La auditoría del practicante (SIN escalar)
## ============================================================
cat("\n== P1a: reproducir la entrega del practicante ==\n")
vars <- select(.data = socios,
               visitas_mes, antiguedad_meses, gasto_adicional_mes, clases_mes)

set.seed(13)
km_practicante <- kmeans(vars, centers = 4, nstart = 25)

socios_prac <- mutate(.data = socios, cluster = factor(km_practicante$cluster))
perfil_prac <- summarise(.data = socios_prac,
                         visitas    = mean(visitas_mes),
                         antiguedad = mean(antiguedad_meses),
                         gasto      = mean(gasto_adicional_mes),
                         clases     = mean(clases_mes),
                         n_socios   = n(),
                         .by = cluster)
print(arrange(perfil_prac, cluster), digits = 3)

cat("\n== P1b: el porqué — las escalas ==\n")
print(round(sapply(vars, sd), 1))
## Diagnóstico (P1c): el gasto (sd ~69.173 pesos) aplasta a las demás
## variables (sd <= 18). Los 4 "segmentos" del practicante son franjas
## de gasto: dos clusters (los de gasto 164k y 233k) tienen el MISMO
## comportamiento (visitas ~12, clases ~9) y ningún cluster tiene
## visitas ~0: los socios que pagan y no van no aparecen en su entrega.

## ============================================================
## Punto 2 — Escalar y elegir k
## ============================================================
cat("\n== P2a: escalar ==\n")
vars_esc <- scale(vars)
print(round(colMeans(vars_esc), 3))
print(round(apply(vars_esc, 2, sd), 3))

cat("\n== P2b: codo ==\n")
set.seed(13)
wss  <- sapply(1:8, function(k) kmeans(vars_esc, centers = k, nstart = 25)$tot.withinss)
codo <- data.frame(k = 1:8, wss = wss)
print(mutate(codo, wss = round(wss, 1)))

g_codo <- ggplot(codo, aes(x = k, y = wss)) +
  geom_line(color = "#1F4E79") +
  geom_point(color = "#E87722", size = 3) +
  scale_x_continuous(breaks = 1:8) +
  theme_minimal() +
  labs(title = "Método del codo — socios CaliFit",
       x = "Número de clusters (k)", y = "WSS")
## ggsave("output/codo_taller13.png", g_codo, width = 7, height = 4.5) # estudiante

cat("\n== P2c: silueta ==\n")
distancias <- dist(vars_esc)
set.seed(13)
sil <- sapply(2:8, function(k) {
  km <- kmeans(vars_esc, centers = k, nstart = 25)
  mean(silhouette(km$cluster, distancias)[, 3])
})
silueta <- data.frame(k = 2:8, sil_prom = round(sil, 3))
print(silueta)
## Lectura: el codo duda entre 3 y 4 (la caída fuerte termina en 4);
## la silueta rompe el empate: máximo claro en k = 4 (0.653).

## ============================================================
## Punto 3 — Segmentación final y perfilamiento
## ============================================================
cat("\n== P3a: k-means final k=4 ==\n")
set.seed(13)
km_final <- kmeans(vars_esc, centers = 4, nstart = 25)
socios <- mutate(.data = socios, cluster = factor(km_final$cluster))
print(table(socios$cluster))

cat("\n== P3b: perfil ==\n")
perfil <- summarise(.data = socios,
                    visitas    = mean(visitas_mes),
                    antiguedad = mean(antiguedad_meses),
                    gasto      = mean(gasto_adicional_mes),
                    clases     = mean(clases_mes),
                    n_socios   = n(),
                    .by = cluster)
print(arrange(perfil, cluster), digits = 3)

## P3c: gráficos (el estudiante los exporta a output/)
g_disp <- ggplot(socios, aes(x = visitas_mes, y = gasto_adicional_mes / 1000,
                             color = cluster)) +
  geom_point(alpha = 0.6, size = 2) +
  theme_minimal() +
  labs(title = "Socios CaliFit: visitas vs. gasto adicional",
       x = "Visitas al mes", y = "Gasto adicional (miles de $)",
       color = "Segmento")
## ggsave("output/segmentos_dispersion.png", g_disp, width = 7, height = 4.5)

g_box <- ggplot(socios, aes(x = cluster, y = antiguedad_meses, fill = cluster)) +
  geom_boxplot(show.legend = FALSE) +
  theme_minimal() +
  labs(title = "Antigüedad por segmento",
       x = "Segmento", y = "Antigüedad (meses)")
## ggsave("output/segmentos_antiguedad.png", g_box, width = 7, height = 4.5)

## ============================================================
## Punto 4 — Memorando (referencia para calificar)
## ============================================================
## Nombres esperados (u orden equivalente según numeración del cluster):
##  C1 (n=35): visitas 0.9, antig 45.7m, gasto 11k, clases 0.3
##      -> "Fantasmas que pagan" / "Membresía dormida"
##  C2 (n=90): visitas 4.8, antig 10.4m, gasto 31k, clases 1.1
##      -> "Ocasionales en riesgo" / "Visitantes tibios"
##  C3 (n=85): visitas 17.9, antig 38.5m, gasto 66k, clases 2.0
##      -> "Veteranos de rutina" / "Núcleo fiel"
##  C4 (n=70): visitas 12.1, antig 3.6m, gasto 185k, clases 8.9
##      -> "Novatos de clases" / "Recién llegados entusiastas"
##
## Acciones defendibles (una por segmento, con cifra):
##  - Fantasmas (12% de socios): pagan hace ~4 años y van <1 vez/mes.
##    Acción fina: NO bombardearlos con "¡te extrañamos!" masivo (el
##    recordatorio puede detonar la cancelación); mejor contacto suave
##    de valor (invitación a clase con un amigo, chequeo físico gratis).
##    Reconocer el dilema ético/comercial vale puntos.
##  - Ocasionales (32%): 4.8 visitas y ~10 meses; el grupo más grande y
##    el más cerca de la puerta de salida -> plan de hábito (reto 12
##    visitas, acompañamiento de entrenador, recordatorios de horario valle).
##  - Veteranos (30%): 17.9 visitas, 38.5 meses -> programa de referidos
##    y reconocimiento; no necesitan descuento para venir.
##  - Novatos (25%): gastan 185k/mes en clases (6x el promedio de los
##    veteranos) pero llevan 3.6 meses -> convertir entusiasmo en hábito
##    antes del mes 6 (paquete anual, comunidad, metas medibles).
##
## Advertencia esperada (4c): el centroide es un promedio, no un socio
## real; y las asignaciones no son certezas (hay socios en la frontera
## entre ocasional y fantasma). Las acciones se pilotean antes de
## automatizarse.
