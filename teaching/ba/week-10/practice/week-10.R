## ============================================================
## Práctica guiada — Semana 10: Clustering con Spotify
## Introducción al Business Analytics · 06278-ECO
## PhD. Eduard F. Martínez-González
## ============================================================

## Contexto de negocio:
## Una plataforma de streaming quiere crear listas de reproducción
## automáticas con personalidad definida ("para entrenar", "ambiente
## tranquilo", "energía máxima"). Agruparemos canciones según sus
## características de audio y propondremos nombres accionables
## para cada segmento.

##==: Paso 1 — Preparar el entorno ============================

## Limpiar entorno / Clean environment
rm(list = ls())

## Cargar paquetes / Load packages
require(dplyr)    # manipulación de datos / data wrangling
require(ggplot2)  # visualización / visualization
require(skimr)    # diagnóstico rápido / quick diagnostics
require(purrr)    # iteración funcional / functional iteration

##==: Paso 2 — Cargar los datos ===============================

## Cargar datos / Load data
## TODO: reemplazar con URL definitiva del repositorio
source("https://raw.githubusercontent.com/ba-in-r/01-slides/main/week-08/data/prepare-data.R")

## Verificar objetos en memoria / Check objects in memory
ls()

## Dimensiones y nombres de columnas / Dimensions and column names
nrow(spotify)
ncol(spotify)
colnames(spotify)

## Diagnóstico completo / Full diagnostic
skim(spotify)

##==: Paso 3 — Seleccionar variables de clustering ============

## Seleccionar variables de audio / Select audio features
## Excluimos: streams (popularidad, no estilo), artist, track_name (categóricas)
spotify_features <- select(.data = spotify,
                            danceability,
                            energy,
                            acousticness,
                            tempo)

## Verificar subconjunto / Verify subset
head(spotify_features)

##==: Paso 4 — Escalar las variables ==========================

## Escalar: media 0, desviación estándar 1 / Scale: mean 0, sd 1
spotify_scaled <- scale(spotify_features)

## Verificar escalado / Verify scaling
skim(spotify_scaled)

## Dispersión previa al clustering / Pre-clustering scatter
spotify_scaled_df <- as.data.frame(spotify_scaled)

ggplot(spotify_scaled_df, aes(x = tempo, y = danceability)) +
  geom_point(alpha = 0.3, color = "#1F4E79") +
  theme_minimal() +
  labs(title = "Spotify — variables escaladas",
       x = "Tempo", y = "Danceability")

##==: Paso 5 — Método del codo para elegir k =================

## Fijar semilla para reproducibilidad / Set seed for reproducibility
set.seed(2025)

## Calcular WSS para k = 1:8 / Calculate WSS for k = 1:8
valores_k <- 1:8
wss_por_k <- map_dbl(valores_k, ~ kmeans(spotify_scaled,
                                          centers = .x,
                                          nstart  = 20)$tot.withinss)

## Organizar resultados / Organize results
elbow_df <- data.frame(k = valores_k, wss = wss_por_k)
elbow_df

## Gráfico del codo / Elbow plot
ggplot(elbow_df, aes(x = k, y = wss)) +
  geom_line(color = "#1F4E79") +
  geom_point(color = "#E87722", size = 3) +
  scale_x_continuous(breaks = 1:8) +
  theme_minimal() +
  labs(title = "Método del codo — Spotify",
       x = "Número de clusters (k)",
       y = "WSS")

##==: Paso 6 — Ajustar k-means ================================

## Fijar semilla / Set seed
set.seed(2025)

## Ajustar modelo / Fit model
## Reemplaza centers con el k que identificaste en el codo
km_spotify <- kmeans(spotify_scaled, centers = 4, nstart = 30)

## Resumen del modelo / Model summary
km_spotify

##==: Paso 7 — Agregar clusters al dataset original ===========

## Agregar columna de cluster / Add cluster column
spotify_clusters <- mutate(.data = spotify,
                            cluster = factor(km_spotify$cluster))

## Distribución por cluster / Count per cluster
table(spotify_clusters$cluster)

##==: Paso 8 — Visualizar los clusters =======================

## Dispersión coloreada por cluster / Cluster scatterplot
ggplot(spotify_clusters, aes(x = tempo, y = danceability, color = cluster)) +
  geom_point(alpha = 0.4, size = 1.5) +
  theme_minimal() +
  labs(title = "Clusters de canciones — Spotify",
       x = "Tempo (BPM)", y = "Danceability", color = "Cluster")

##==: Paso 9 — Perfilar los clusters ==========================

## Tabla de perfilamiento: promedios por cluster / Profiling table
perfil_clusters <- summarise(.data = spotify_clusters,
                              danceability_prom = mean(danceability),
                              energy_prom       = mean(energy),
                              acousticness_prom = mean(acousticness),
                              tempo_prom        = mean(tempo),
                              streams_prom      = mean(streams),
                              n_canciones       = n(),
                              .by = cluster)
perfil_clusters

## Canción más escuchada por cluster / Top song per cluster
top_por_cluster <- summarise(.data = spotify_clusters,
                              top_cancion = track_name[which.max(streams)],
                              top_artista = artist[which.max(streams)],
                              max_streams = max(streams),
                              .by = cluster)
top_por_cluster

##==: Paso 10 — De números a nombres de negocio ===============

## Con base en perfil_clusters, completa esta tabla:
##
## | Cluster | Característica principal | Nombre sugerido | Momento de uso |
## |---------|--------------------------|-----------------|----------------|
## |    1    |                          |                 |                |
## |    2    |                          |                 |                |
## |    3    |                          |                 |                |
## |    4    |                          |                 |                |
##
## Criterio: nombres específicos y accionables.
## Mal: "Grupo A". Bien: "Tarde acústica de trabajo".
