## ============================================================
##  Introducción al Business Analytics (06278-ECO)
##  Semana 13 | Verificación de la PRÁCTICA (uso interno)
##  Reproduce EXACTAMENTE el código que corre el estudiante,
##  leyendo el CSV publicado. Toda cifra citada en la página
##  de la práctica sale de este script.
## ============================================================

rm(list = ls())

## Librerías / Libraries (las del estudiante)
pacman::p_load(dplyr, ggplot2, cluster)

## Cargar datos / Load data (el estudiante usa data/spotify_canciones.csv)
canciones <- read.csv("../practice/spotify_canciones.csv")

cat("== M0: radiografía ==\n")
print(dim(canciones))
print(str(canciones))
print(summary(select(canciones, danceability, energy, acousticness, tempo)))
print(round(sapply(select(canciones, danceability, energy, acousticness, tempo), sd), 3))

## ------------------------------------------------------------
cat("\n== M1: selección de variables ==\n")
audio <- select(.data = canciones,
                danceability, energy, acousticness, tempo)
print(head(audio, 3))

## ------------------------------------------------------------
cat("\n== M2: el experimento SIN escalar ==\n")
set.seed(13)
km_crudo <- kmeans(audio, centers = 4, nstart = 25)

canciones_crudo <- mutate(.data = canciones, cluster = factor(km_crudo$cluster))
perfil_crudo <- summarise(.data = canciones_crudo,
                          danceability = mean(danceability),
                          energy       = mean(energy),
                          acousticness = mean(acousticness),
                          tempo        = mean(tempo),
                          n_canciones  = n(),
                          .by = cluster)
print(arrange(perfil_crudo, cluster), digits = 3)

## ------------------------------------------------------------
cat("\n== M3: escalar ==\n")
audio_esc <- scale(audio)
print(round(colMeans(audio_esc), 3))
print(round(apply(audio_esc, 2, sd), 3))

## ------------------------------------------------------------
cat("\n== M4: el codo ==\n")
set.seed(13)
wss  <- sapply(1:8, function(k) kmeans(audio_esc, centers = k, nstart = 25)$tot.withinss)
codo <- data.frame(k = 1:8, wss = wss)
print(mutate(codo, wss = round(wss, 1)))

## ------------------------------------------------------------
cat("\n== M5: la silueta ==\n")
distancias <- dist(audio_esc)
set.seed(13)
sil <- sapply(2:8, function(k) {
  km <- kmeans(audio_esc, centers = k, nstart = 25)
  mean(silhouette(km$cluster, distancias)[, 3])
})
silueta <- data.frame(k = 2:8, sil_prom = round(sil, 3))
print(silueta)

## ------------------------------------------------------------
cat("\n== M6: k-means final (k = 4) ==\n")
set.seed(13)
km_final <- kmeans(audio_esc, centers = 4, nstart = 25)
canciones <- mutate(.data = canciones, cluster = factor(km_final$cluster))
print(table(canciones$cluster))

## ------------------------------------------------------------
cat("\n== M7: perfilamiento ==\n")
perfil <- summarise(.data = canciones,
                    danceability = mean(danceability),
                    energy       = mean(energy),
                    acousticness = mean(acousticness),
                    tempo        = mean(tempo),
                    streams_prom = mean(streams),
                    n_canciones  = n(),
                    .by = cluster)
print(arrange(perfil, cluster), digits = 3)

top_por_cluster <- summarise(.data = canciones,
                             top_cancion = cancion[which.max(streams)],
                             top_artista = artista[which.max(streams)],
                             max_streams = max(streams),
                             .by = cluster)
print(arrange(top_por_cluster, cluster))

## ------------------------------------------------------------
cat("\n== M8 (reto): cluster vs género declarado ==\n")
print(table(canciones$cluster, canciones$genero))
