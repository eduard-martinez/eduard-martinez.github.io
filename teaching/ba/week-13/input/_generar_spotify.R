## ============================================================
##  Introducción al Business Analytics (06278-ECO)
##  Semana 13 | Generador del dataset de la PRÁCTICA:
##             spotify_canciones.csv (catálogo urbano sintético)
##  Universidad Icesi | Periodo 2026-01
## ============================================================
##
##  USO INTERNO DEL PROFESOR — no compartir con estudiantes.
##
##  Genera 320 canciones sintéticas tipo Spotify con 4 perfiles
##  de sonido LATENTES (el "cluster verdadero" no viaja en el CSV):
##
##    P1 "Reggaetón clásico"  n=95  dance .82  energy .78  acoust .08  tempo  97
##    P2 "Dembow fiestero"    n=75  dance .88  energy .88  acoust .05  tempo 130
##    P3 "Trap lento"         n=80  dance .60  energy .52  acoust .15  tempo  77
##    P4 "Acústico / chill"   n=70  dance .45  energy .30  acoust .75  tempo  90
##
##  Diseño pedagógico verificado (ver sección de verificación):
##   - SIN escalar, k-means agrupa casi solo por tempo (sd ~20 vs ~0.1
##     de las variables 0-1): la demo de la trampa de la escala.
##   - Escalado, el codo se dobla en k=3-4 (ambiguo a propósito) y la
##     silueta promedio tiene su máximo claro en k=4.
##   - Los 4 perfiles quedan nombrables como listas de reproducción.
##   - `genero` es la etiqueta DECLARADA (con ~22% de canciones
##     etiquetadas "fuera" de su sonido): insumo del reto final
##     (el cluster de sonido no coincide 1:1 con el género declarado).
##
##  Adaptado del generador viejo del curso (ba-in-r/01-slides,
##  week-08/data/prepare-data.R) a base R sin dependencias.
## ============================================================

rm(list = ls())

set.seed(1301)

## ------------------------------------------------------------
## 1. Catálogos
## ------------------------------------------------------------

artistas <- c("Bad Bunny", "Karol G", "Feid", "J Balvin", "Maluma",
              "Rauw Alejandro", "Ozuna", "Myke Towers", "Daddy Yankee",
              "Natti Natasha", "Sech", "Becky G", "Anuel AA", "Farruko",
              "Nicky Jam", "Wisin & Yandel", "Tego Calderón", "Ryan Castro")

## Piezas para armar títulos por perfil (títulos inventados)
tit <- list(
  p1 = list(a = c("Perreo", "Noche", "Fuego", "Baila", "Calle", "Ritmo",
                  "Luna", "Fiesta", "Vibra", "Sudor"),
            b = c("en la 66", "de Cali", "sin Reloj", "Prohibido", "Eterno",
                  "de Barrio", "Caliente", "en la Terraza", "Clandestino", "VIP")),
  p2 = list(a = c("Dembow", "Turbo", "Presión", "Candela", "Full",
                  "Alto Voltaje", "Modo", "Zumba", "Descontrol", "Pique"),
            b = c("Total", "hasta Abajo", "de Verano", "24/7", "Extremo",
                  "Fiesta", "sin Frenos", "en el Malecón", "Nivel Dios", "Turbo")),
  p3 = list(a = c("Cicatriz", "Humo", "Medianoche", "Deja Vu", "Frío",
                  "Silencio", "Neblina", "Marea", "Insomnio", "Eclipse"),
            b = c("en el Alma", "Lento", "Gris", "de Invierno", "Interior",
                  "Nocturno", "de Cristal", "sin Ti", "Profundo", "Callado")),
  p4 = list(a = c("Café", "Acústico", "Brisa", "Domingo", "Amanecer",
                  "Balcón", "Guitarra", "Carta", "Tarde", "Raíces"),
            b = c("y Vinilo", "Descalzo", "de Mar", "en Casa", "Contigo",
                  "al Sol", "Vieja", "a Mano", "de Abril", "del Pacífico"))
)

## ------------------------------------------------------------
## 2. Perfiles de sonido latentes
## ------------------------------------------------------------

clamp01 <- function(x) pmin(0.99, pmax(0.01, x))

## media dance, sd; media energy, sd; media acoust, sd; media tempo, sd; n
perfiles <- data.frame(
  perfil = c("p1", "p2", "p3", "p4"),
  n      = c(95, 75, 80, 70),
  d_mu   = c(0.82, 0.88, 0.60, 0.45), d_sd = c(0.06, 0.05, 0.08, 0.08),
  e_mu   = c(0.78, 0.88, 0.52, 0.30), e_sd = c(0.07, 0.05, 0.09, 0.08),
  a_mu   = c(0.08, 0.05, 0.15, 0.75), a_sd = c(0.05, 0.03, 0.08, 0.10),
  t_mu   = c(97, 130, 77, 90),        t_sd = c(6, 7, 6, 8)
)

## género declarado "correcto" por perfil + ruido de etiquetado
genero_de <- c(p1 = "reggaeton", p2 = "dembow", p3 = "trap latino", p4 = "urbano acustico")
generos   <- unname(genero_de)

filas <- list()
for (i in seq_len(nrow(perfiles))) {
  p <- perfiles[i, ]
  n <- p$n
  pool_a <- tit[[p$perfil]]$a
  pool_b <- tit[[p$perfil]]$b
  nombres <- paste(sample(pool_a, n, replace = TRUE),
                   sample(pool_b, n, replace = TRUE))
  ## etiqueta declarada: 78% la "correcta", 22% otra cualquiera
  gen <- ifelse(runif(n) < 0.78, genero_de[p$perfil],
                sample(generos, n, replace = TRUE))
  filas[[i]] <- data.frame(
    cancion       = nombres,
    artista       = sample(artistas, n, replace = TRUE),
    genero        = gen,
    danceability  = round(clamp01(rnorm(n, p$d_mu, p$d_sd)), 3),
    energy        = round(clamp01(rnorm(n, p$e_mu, p$e_sd)), 3),
    acousticness  = round(clamp01(rnorm(n, p$a_mu, p$a_sd)), 3),
    tempo         = round(pmin(180, pmax(60, rnorm(n, p$t_mu, p$t_sd))), 1),
    .perfil       = p$perfil
  )
}
spotify <- do.call(rbind, filas)

## desduplicar títulos repetidos agregando "(feat.)" o "(remix)"
dup <- duplicated(paste(spotify$cancion, spotify$artista))
spotify$cancion[dup] <- paste0(spotify$cancion[dup],
                               sample(c(" (Remix)", " (En Vivo)", " (feat. DJ Icesi)"),
                                      sum(dup), replace = TRUE))

## ------------------------------------------------------------
## 3. Streams (lognormal + boost por artista famoso)
## ------------------------------------------------------------

boost <- ifelse(spotify$artista %in% c("Bad Bunny", "Karol G", "Feid"), 1.9,
         ifelse(spotify$artista %in% c("J Balvin", "Maluma", "Rauw Alejandro"), 1.4, 1.0))
spotify$streams <- round(rlnorm(nrow(spotify), meanlog = log(2.4e6), sdlog = 0.9) * boost)

## mezclar filas y soltar la etiqueta latente
spotify <- spotify[sample(nrow(spotify)), ]
verdad  <- spotify$.perfil                # se conserva SOLO en este script
spotify$.perfil <- NULL
rownames(spotify) <- NULL

## ------------------------------------------------------------
## 4. Exportar (viaja JUNTO al HTML de la práctica)
## ------------------------------------------------------------

write.csv(spotify, "../practice/spotify_canciones.csv", row.names = FALSE)
cat("Exportado: ../practice/spotify_canciones.csv |", nrow(spotify), "filas\n\n")

## ============================================================
##  VERIFICACIÓN DEL DISEÑO (correr tras generar)
## ============================================================

audio <- spotify[, c("danceability", "energy", "acousticness", "tempo")]

cat("== Radiografía ==\n")
print(dim(spotify)); print(summary(audio))

cat("\n== 1) Trampa de la escala: k-means SIN escalar (k=4) ==\n")
set.seed(13)
km_raw <- kmeans(audio, centers = 4, nstart = 25)
perfil_raw <- aggregate(audio, by = list(cluster = km_raw$cluster), FUN = mean)
print(round(perfil_raw, 2))
cat("sd de cada variable (el porqué):\n"); print(round(sapply(audio, sd), 3))

cat("\n== 2) Escalado ==\n")
audio_esc <- scale(audio)
print(round(colMeans(audio_esc), 4)); print(round(apply(audio_esc, 2, sd), 4))

cat("\n== 3) Codo (k=1..8) ==\n")
set.seed(13)
wss <- sapply(1:8, function(k) kmeans(audio_esc, centers = k, nstart = 25)$tot.withinss)
print(data.frame(k = 1:8, wss = round(wss, 1)))

cat("\n== 4) Silueta promedio (k=2..8) ==\n")
library(cluster)
d <- dist(audio_esc)
set.seed(13)
sil <- sapply(2:8, function(k) {
  km <- kmeans(audio_esc, centers = k, nstart = 25)
  mean(silhouette(km$cluster, d)[, 3])
})
print(data.frame(k = 2:8, silueta = round(sil, 3)))
cat("k con silueta máxima:", (2:8)[which.max(sil)], "\n")

cat("\n== 5) k-means final k=4 ==\n")
set.seed(13)
km4 <- kmeans(audio_esc, centers = 4, nstart = 25)
print(km4$size)
spotify$cluster <- factor(km4$cluster)
perfil <- aggregate(cbind(danceability, energy, acousticness, tempo, streams) ~ cluster,
                    data = spotify, FUN = mean)
perfil$n <- as.vector(table(spotify$cluster))
print(round(perfil[, -1], 2))

cat("\n== 6) Pureza: cluster vs perfil latente ==\n")
print(table(km4$cluster, verdad))

cat("\n== 7) Top canción por cluster ==\n")
for (cl in levels(spotify$cluster)) {
  s <- spotify[spotify$cluster == cl, ]
  t <- s[which.max(s$streams), c("cancion", "artista", "streams")]
  cat("C", cl, ": ", t$cancion, " — ", t$artista, " (", format(t$streams, big.mark = ","), ")\n", sep = "")
}

cat("\n== 8) Reto: cluster vs género declarado ==\n")
print(table(spotify$cluster, spotify$genero))
