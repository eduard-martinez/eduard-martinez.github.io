## ============================================================
##  Introducción al Business Analytics (06278-ECO)
##  Semana 13 | Generador del dataset del TALLER:
##             socios_califit.csv (cadena de gimnasios CaliFit)
##  Universidad Icesi | Periodo 2026-01
## ============================================================
##
##  USO INTERNO DEL PROFESOR — no compartir con estudiantes.
##
##  Genera 280 socios activos de CaliFit con 4 segmentos LATENTES
##  (la etiqueta no viaja en el CSV):
##
##    S1 "Veteranos constantes"  n=85  visitas 18  antig 40m  gasto  65k  clases 2
##    S2 "Novatos de clases"     n=70  visitas 12  antig  4m  gasto 185k  clases 9
##    S3 "Ocasionales"           n=90  visitas  5  antig 14m  gasto  30k  clases 1
##    S4 "Fantasmas"             n=35  visitas  1  antig 36m  gasto   8k  clases 0
##
##  Trampas pedagógicas verificadas (ver sección de verificación):
##   - `id_socio` es numérico: meterlo al k-means es el error de
##     "variable irrelevante" (P0 del taller lo pregunta).
##   - `gasto_adicional_mes` está en PESOS (sd ~70.000 vs sd ≤ 13 del
##     resto): SIN escalar, k-means devuelve franjas de gasto y "pierde"
##     a los fantasmas — la segmentación del "practicante" que el
##     estudiante debe auditar en P1.
##   - Escalado: codo ambiguo entre 3 y 4; la silueta y la
##     interpretabilidad (los fantasmas son oro para el negocio)
##     deciden k=4.
##   - Fantasmas: pagan hace años y no van — la acción NO es obvia
##     (¿reactivarlos o no despertarlos?): carne del memorando.
## ============================================================

rm(list = ls())

set.seed(1302)

## ------------------------------------------------------------
## 1. Segmentos latentes
## ------------------------------------------------------------

seg <- data.frame(
  segmento = c("veterano", "novato", "ocasional", "fantasma"),
  n        = c(85, 70, 90, 35),
  v_mu = c(18, 12, 5, 1),      v_sd = c(2.5, 2.5, 1.8, 0.7),
  a_mu = c(40, 4, 10, 46),     a_sd = c(9, 2, 4, 7),
  g_mu = c(65000, 185000, 30000, 8000),
  g_sd = c(20000, 45000, 15000, 7000),
  c_mu = c(2, 9, 1, 0.2),      c_sd = c(1.2, 2, 1, 0.5)
)

filas <- list()
for (i in seq_len(nrow(seg))) {
  s <- seg[i, ]
  n <- s$n
  filas[[i]] <- data.frame(
    visitas_mes          = round(pmin(26, pmax(0, rnorm(n, s$v_mu, s$v_sd)))),
    antiguedad_meses     = round(pmin(60, pmax(1, rnorm(n, s$a_mu, s$a_sd)))),
    gasto_adicional_mes  = round(pmax(0, rnorm(n, s$g_mu, s$g_sd)) / 100) * 100,
    clases_mes           = round(pmin(15, pmax(0, rnorm(n, s$c_mu, s$c_sd)))),
    .segmento            = s$segmento
  )
}
socios <- do.call(rbind, filas)

## mezclar, asignar id y soltar la etiqueta latente
socios <- socios[sample(nrow(socios)), ]
verdad <- socios$.segmento
socios$.segmento <- NULL
socios <- cbind(id_socio = 1001:(1000 + nrow(socios)), socios)
rownames(socios) <- NULL

## ------------------------------------------------------------
## 2. Exportar (viaja JUNTO al HTML del taller)
## ------------------------------------------------------------

write.csv(socios, "../task/socios_califit.csv", row.names = FALSE)
cat("Exportado: ../task/socios_califit.csv |", nrow(socios), "filas\n\n")

## ============================================================
##  VERIFICACIÓN DEL DISEÑO (correr tras generar)
## ============================================================

vars <- socios[, c("visitas_mes", "antiguedad_meses",
                   "gasto_adicional_mes", "clases_mes")]

cat("== Radiografía ==\n")
print(dim(socios)); print(summary(vars))
cat("\nsd de cada variable (la trampa):\n"); print(round(sapply(vars, sd), 1))

cat("\n== 1) La segmentación del practicante: SIN escalar, k=4 ==\n")
set.seed(13)
km_raw <- kmeans(vars, centers = 4, nstart = 25)
perfil_raw <- aggregate(vars, by = list(cluster = km_raw$cluster), FUN = mean)
perfil_raw$n <- as.vector(table(km_raw$cluster))
print(round(perfil_raw, 1))
cat("¿A quién agarra cada cluster crudo? (mezcla de segmentos reales):\n")
print(table(km_raw$cluster, verdad))

cat("\n== 2) Escalado ==\n")
vars_esc <- scale(vars)
print(round(apply(vars_esc, 2, sd), 3))

cat("\n== 3) Codo (k=1..8) ==\n")
set.seed(13)
wss <- sapply(1:8, function(k) kmeans(vars_esc, centers = k, nstart = 25)$tot.withinss)
print(data.frame(k = 1:8, wss = round(wss, 1)))

cat("\n== 4) Silueta promedio (k=2..8) ==\n")
library(cluster)
d <- dist(vars_esc)
set.seed(13)
sil <- sapply(2:8, function(k) {
  km <- kmeans(vars_esc, centers = k, nstart = 25)
  mean(silhouette(km$cluster, d)[, 3])
})
print(data.frame(k = 2:8, silueta = round(sil, 3)))
cat("k con silueta máxima:", (2:8)[which.max(sil)], "\n")

cat("\n== 5) k-means final k=4 (escalado) ==\n")
set.seed(13)
km4 <- kmeans(vars_esc, centers = 4, nstart = 25)
socios$cluster <- factor(km4$cluster)
perfil <- aggregate(vars, by = list(cluster = km4$cluster), FUN = mean)
perfil$n <- as.vector(table(km4$cluster))
print(round(perfil, 1))

cat("\n== 6) Pureza: cluster vs segmento latente ==\n")
print(table(km4$cluster, verdad))
