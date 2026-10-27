##============================================================================##
# _verificacion_practica13.R  —  cifras de la clase de la semana 13 (notas)
#------------------------------------------------------------------------------#
# Solo para el profesor: rehace la base de notas desde los Excel de ../notas/,
# comprueba que es idéntica a la publicada (local y, cuando esté en línea, la
# URL), corre el script de la clase y verifica cada cifra del Beamer (y que
# esté en el .tex), el taller (k = 4 reproducible) y las páginas. El quiz de
# la semana tiene su propio insumo (quiz/_banco/insumos/clusters_week-13.R).
# Correr desde lectures/week-13/input/:  Rscript _verificacion_practica13.R
##============================================================================##
rm(list = ls())
options(warn = 2)
require(pacman)
p_load(dplyr, readxl, cluster, tools)

url_pub <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-13/script/notas_curso.csv"

##=== 1. el preparador reproduce la base publicada ===========================##
promedia_quices <- function(d, id_col) {
  qcols <- names(d)[grepl("^(Quiz s|S)emana", names(d))]
  qcols <- qcols[sapply(qcols, function(c) any(!is.na(d[[c]])))]
  notas <- d[, qcols]
  notas[is.na(notas)] <- 0
  data.frame(codigo = as.character(d[[id_col]]),
             promedio_quices = round(rowMeans(notas), 2))
}
q5 <- suppressMessages(read_excel("../notas/Notas_Analitica_G5.xlsx", sheet = "Quices")) %>%
      filter(!is.na(`Código`))
p5 <- suppressMessages(read_excel("../notas/Notas_Analitica_G5.xlsx", sheet = "Parciales")) %>%
      filter(!is.na(`Código`)) %>%
      transmute(codigo = as.character(`Código`), parcial_1 = `Primer Parcial`)
q7 <- suppressMessages(read_excel("../notas/Notas G7 BA.xlsx", sheet = "Quices G7")) %>%
      filter(!is.na(`Número de ID`))
p7 <- suppressMessages(read_excel("../notas/Notas G7 BA.xlsx", sheet = "Parciales G7")) %>%
      filter(!is.na(`Número de ID`)) %>%
      transmute(codigo = as.character(`Número de ID`), parcial_1 = `1er Parcial`)
rehecha <- bind_rows(promedia_quices(q5, "Código") %>% left_join(p5, by = "codigo") %>% mutate(jornada = "G5"),
                     promedia_quices(q7, "Número de ID") %>% left_join(p7, by = "codigo") %>% mutate(jornada = "G7")) %>%
           mutate(parcial_1 = round(ifelse(is.na(parcial_1), 0, parcial_1), 2)) %>%
           select(codigo, jornada, promedio_quices, parcial_1)
tmp <- file.path(tempdir(), "notas_rehechas.csv")
write.csv(rehecha, tmp, row.names = F)
stopifnot(md5sum(tmp) == md5sum("../script/notas_curso.csv"))
local <- read.csv("../script/notas_curso.csv", colClasses = c(codigo = "character"))
stopifnot(identical(dim(local), c(43L, 4L)),
          sum(local$jornada == "G5") == 30, sum(local$jornada == "G7") == 13,
          !any(duplicated(local$codigo)),
          round(range(local$promedio_quices), 2) == c(2.43, 4.71),
          round(range(local$parcial_1), 2) == c(1.3, 5))
publicada <- tryCatch({f <- file.path(tempdir(), "notas_pub.csv")
                       suppressWarnings(download.file(url_pub, f, quiet = T))
                       f}, error = function(e) NULL)
if (is.null(publicada)) {
  cat("AVISO: notas_curso.csv aún no está publicada en la página del curso\n")
} else if (md5sum(publicada) == md5sum("../script/notas_curso.csv")) {
  cat("OK notas_curso.csv publicada e idéntica a ../script/\n")
} else {
  cat("AVISO: el CSV publicado difiere del local: RESUBIRLO\n")
}
cat("OK 1: el preparador reproduce la base (43 x 4; G5 30, G7 13)\n")

##=== 2. el script corre de punta a punta y sin advertencias =================##
codigo <- readLines("../script/script_clase13.R", encoding = "UTF-8")
codigo <- sub("^url_notas <- .*$",
              paste0("url_notas <- \"", normalizePath("../script/notas_curso.csv"), "\""),
              codigo)
copia <- file.path(tempdir(), "script_clase13.R")
writeLines(codigo, copia)
salida <- system2("Rscript", shQuote(copia), stdout = T, stderr = T,
                  env = "LC_ALL=en_US.UTF-8")
stopifnot(is.null(attr(salida, "status")),
          !any(grepl("warn", salida, ignore.case = T)))
clase <- new.env()
pdf(NULL)
invisible(capture.output(source(copia, local = clase, encoding = "UTF-8")))
invisible(dev.off())
cat("OK 2: el script corre completo, sin advertencias\n")

##=== 3. el codo, la silueta y los tres grupos (láminas 5 a 8) ===============##
notas <- clase$notas
X     <- clase$X
stopifnot(identical(round(clase$wss[1:4], 1), c(40.1, 22.6, 16.4, 11.8)))
silueta <- sapply(2:6, function(k) {
  set.seed(13)
  km_k <- kmeans(X, centers = k, nstart = 25)
  round(mean(silhouette(km_k$cluster, dist(X))[, 3]), 3)
})
stopifnot(identical(silueta, c(0.393, 0.365, 0.368, 0.436, 0.434)),
          which.max(silueta) + 1 == 5)
grupos <- notas %>% group_by(grupo) %>%
          summarise(quices = round(mean(promedio_quices), 1),
                    parcial = round(mean(parcial_1), 1), n = n())
stopifnot(identical(grupos$quices, c(4.1, 3.8, 3.2)),
          identical(grupos$parcial, c(4.5, 3.5, 2.6)),
          identical(grupos$n, c(9L, 21L, 13L)),
          round(cor(notas$promedio_quices, notas$parcial_1), 2) == 0.29)
## el hallazgo: el parcial separa más que los quices
stopifnot(round(4.1 - 3.8, 1) == 0.3, round(4.5 - 3.5, 1) == 1.0,
          round(3.8 - 3.2, 1) == 0.6, round(3.5 - 2.6, 1) == 0.9)
cat("OK 3: codo, silueta, los tres grupos y el hallazgo\n")

##=== 4. el taller: k = 4 reproducible =======================================##
set.seed(13)
km4 <- kmeans(X, centers = 4, nstart = 25)
orden4 <- order(-rowSums(km4$centers))
g4 <- match(km4$cluster, orden4)
tg4 <- data.frame(g = g4, q = notas$promedio_quices, p = notas$parcial_1) %>%
       group_by(g) %>% summarise(q = round(mean(q), 1), p = round(mean(p), 1), n = n())
stopifnot(identical(tg4$n, c(12L, 13L, 16L, 2L)),
          isTRUE(all.equal(tg4$q, c(3.9, 4.1, 3.2, 3.9))),
          isTRUE(all.equal(tg4$p, c(4.3, 3.4, 3.0, 1.4))))
## el cambio de grupo que reporta el taller: el 1 queda intacto, el 2 se parte
## en 3/13/5 y del 3 salen los 2 del grupo nuevo de parcial bajo
cruce <- table(notas$grupo, g4)
stopifnot(sum(notas$grupo != g4) == 10,
          identical(as.integer(cruce[2, ]), c(3L, 13L, 5L, 0L)),
          identical(as.integer(cruce[3, ]), c(0L, 0L, 11L, 2L)))
cat("OK 4: el taller (k = 4: grupos de 12, 13, 16 y 2; 10 de 43 cambian de",
    "grupo) es reproducible\n")

##=== 5. las cifras están en el .tex y en las páginas ========================##
tex <- paste(readLines("../slides/week-13.tex", encoding = "UTF-8"), collapse = " ")
cifras_tex <- c("27 de octubre de 2026", "43", "k = 3", "0.29",
                "4.1", "4.5", "3.8", "3.5", "3.2", "2.6", "21", "13",
                "alto y parejo", "la mitad del curso", "en alerta",
                "el codo orienta", "interpretabilidad", "la silueta",
                "k = 5", "El parcial separa los grupos",
                "sin target y sin sobre", "estructura que encontrar",
                "la foto de hoy", "group\\_by", "promedio\\_quices",
                "parcial 2 (2--7 nov)", "los datos son ustedes")
faltan <- cifras_tex[!sapply(cifras_tex, grepl, x = tex, fixed = T)]
if (length(faltan) > 0) stop("no están en el .tex: ", paste(faltan, collapse = " · "))
stopifnot(!grepl("bosque|Lasso|poda|AUC|umbral|memorizador|plata|tonta", tex),
          ## 9 frames: portada, roadmap sin número y las láminas 2 a 8
          lengths(regmatches(tex, gregexpr("\\begin{frame}", tex, fixed = T))) == 9)
scr <- paste(codigo, collapse = " ")
stopifnot(grepl("centers=3", scr, fixed = T), grepl("centers=4", scr, fixed = T),
          grepl("colClasses=c(codigo=\"character\")", scr, fixed = T),
          grepl("set.seed(13)", scr, fixed = T), grepl("nstart=25", scr, fixed = T),
          grepl("TU-CODIGO", scr, fixed = T),
          grepl("##==: 4. taller :==##", scr, fixed = T),
          grepl("taller individual", scr, fixed = T),
          grepl("grupo4", scr, fixed = T),
          grepl("te clasificaba el algoritmo con k = 3", scr, fixed = T))
task <- paste(readLines("../task/week-13.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("centers=3` por `centers=4", task, fixed = T),
          grepl("filter(codigo == \"TU-CODIGO\")", task, fixed = T),
          grepl("apellido_nombre_taller13.R", task, fixed = T),
          grepl("Intu", task), grepl("grupo4", task, fixed = T),
          grepl("¿Cómo cambió?", task, fixed = T),
          grepl("Trabajo individual", task, fixed = T))
teo <- paste(readLines("../theory/week-13.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("las notas del curso", teo, fixed = T),
          grepl("práctica opcional", teo, fixed = T),
          !grepl("práctica guiada en clase", teo, fixed = T))
cat("OK 5: cifras del Beamer, el script, el taller y la teoría\n")
cat("\nTODO OK\n")
