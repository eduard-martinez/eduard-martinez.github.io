##============================================================================##
# _verificacion_practica12.R  —  cifras de la clase de la semana 12 (canciones)
#------------------------------------------------------------------------------#
# Solo para el profesor: rehace la base real con el filtro del preparador
# (desde la fuente pública de TidyTuesday), comprueba que es idéntica a la
# publicada (local y, cuando esté en línea, la URL del curso), corre el script
# de la clase y verifica cada checkpoint, cada cifra del Beamer (y que esté en
# el .tex), el taller (que su respuesta no esté filtrada) y la teoría. Las
# figuras del quiz salen de otro script: quiz/_banco/insumos/arboles_week-12.R.
# Correr desde lectures/week-12/input/:  Rscript _verificacion_practica12.R
##============================================================================##
rm(list = ls())
options(warn = 2)
require(pacman)
p_load(dplyr, rpart, tools)

url_fuente <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv"
url_pub    <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-12/script/canciones_urbanas.csv"

##=== 1. el preparador reproduce la base publicada ===========================##
spotify <- read.csv(url_fuente)
rehecha <- spotify %>%
           filter(playlist_genre == "latin",
                  playlist_subgenre %in% c("reggaeton", "latin hip hop"),
                  !is.na(track_artist), !is.na(track_popularity)) %>%
           distinct(track_id, .keep_all = TRUE) %>%
           transmute(cancion      = track_name,
                     artista      = track_artist,
                     subgenero    = playlist_subgenre,
                     popularidad  = track_popularity,
                     anio         = as.integer(substr(track_album_release_date, 1, 4)),
                     bailabilidad = round(100 * danceability),
                     energia      = round(100 * energy),
                     tempo        = round(tempo),
                     duracion_seg = round(duration_ms / 1000),
                     colaboracion = as.integer(grepl("feat|ft\\.| x ", tolower(track_name))))
prom_catalogo <- round(mean(rehecha$popularidad), 1)
rehecha <- rehecha %>%
           group_by(artista) %>%
           mutate(pop_artista = ifelse(n() > 1,
                    round((sum(popularidad) - popularidad) / (n() - 1), 1),
                    prom_catalogo)) %>%
           ungroup()
tmp <- file.path(tempdir(), "canciones_rehechas.csv")
write.csv(rehecha, tmp, row.names = F)
stopifnot(md5sum(tmp) == md5sum("../script/canciones_urbanas.csv"))
local <- read.csv("../script/canciones_urbanas.csv")
stopifnot(identical(dim(local), c(2427L, 11L)), prom_catalogo == 45.3,
          sum(grepl("Bad Bunny", local$artista)) == 24,
          sum(grepl("J Balvin", local$artista)) == 37,
          sum(local$colaboracion) == 258,
          min(local$anio) == 1965, max(local$anio) == 2020)
publicada <- tryCatch({f <- file.path(tempdir(), "canciones_pub.csv")
                       suppressWarnings(download.file(url_pub, f, quiet = T))
                       f}, error = function(e) NULL)
if (is.null(publicada)) {
  cat("AVISO: canciones_urbanas.csv aún no está publicada en la página del curso\n")
} else if (md5sum(publicada) == md5sum("../script/canciones_urbanas.csv")) {
  cat("OK canciones_urbanas.csv publicada e idéntica a ../script/\n")
} else {
  cat("AVISO: el CSV publicado es una versión anterior (sin pop_artista): RESUBIRLO\n")
}
cat("OK 1: el preparador reproduce la base real (2.427 x 11)\n")

##=== 2. el script corre de punta a punta y sin advertencias =================##
codigo <- readLines("../script/script_clase12.R", encoding = "UTF-8")
codigo <- sub("^url_canciones <- .*$",
              paste0("url_canciones <- \"", normalizePath("../script/canciones_urbanas.csv"), "\""),
              codigo)
copia <- file.path(tempdir(), "script_clase12.R")
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

##=== 3. checkpoints del script (láminas 4 a 7) ==============================##
train <- clase$train
test  <- clase$test
arbol <- clase$arbol
stopifnot(nrow(train) == 1942, nrow(test) == 485,
          round(mean(train$popularidad), 1) == 44.9)
## el árbol (lámina 6): 4 nodos y 5 hojas con una sola variable, pop_artista
stopifnot(sum(arbol$frame$var == "<leaf>") == 5,
          identical(sort(unique(as.character(arbol$frame$var[arbol$frame$var != "<leaf>"]))),
                    "pop_artista"))
stopifnot(identical(labels(arbol),
                    c("root", "pop_artista< 47.2", "pop_artista< 28.4",
                      "pop_artista< 6.85", "pop_artista>=6.85",
                      "pop_artista>=28.4", "pop_artista>=47.2",
                      "pop_artista< 61.5", "pop_artista>=61.5")))
hojas <- arbol$frame[arbol$frame$var == "<leaf>", ]
stopifnot(identical(as.integer(hojas$n), c(90L, 179L, 1027L, 296L, 350L)),
          identical(round(hojas$yval, 1), c(5.9, 21.8, 40.3, 55.6, 71.4)))
## lámina 7: ocho canciones conocidas del test, con cuatro hojas presentes
ocho <- clase$ocho
stopifnot(identical(ocho$cancion,
                    c("Me Gusta", "Estamos Bien", "Si Te Vas",
                      "Felices los 4", "Aullando", "Con Calma", "Gasolina",
                      "Amor De Pobre")),
          identical(ocho$artista[c(1, 2, 6, 8)],
                    c("Shakira", "Bad Bunny", "Daddy Yankee", "Zion")),
          identical(unname(ocho$pron_arbol),
                    c(71.4, 71.4, 55.6, 55.6, 40.3, 40.3, 40.3, 21.8)),
          identical(unname(ocho$error),
                    c(7.6, 4.6, 32.4, 20.4, 39.7, 46.7, 35.7, 21.8)),
          ocho$popularidad[8] == 0, length(unique(ocho$pron_arbol)) == 4)
cat("OK 3: checkpoints del script y láminas 4 a 7\n")

##=== 4. el MAE y el lote: láminas 8 a 10; el taller no está filtrado ========##
mae_arbol    <- mean(abs(test$pron_arbol - test$popularidad))
mae_promedio <- mean(abs(round(mean(train$popularidad), 1) - test$popularidad))
stopifnot(round(sum(ocho$error), 1) == 208.9,
          round(sum(ocho$error) / 8, 1) == 26.1,
          round(mae_arbol, 1) == 17.0, round(mae_promedio, 1) == 24.4,
          round(mae_promedio - mae_arbol, 1) == 7.4,
          round(100 * (1 - mae_arbol / mae_promedio)) == 30)
## lámina 10: lote de 20 de la hoja top vs al azar ($1 millón por punto real)
hoja_top <- test %>% filter(pron_arbol == max(pron_arbol))
stopifnot(nrow(hoja_top) == 90,
          round(mean(hoja_top$popularidad), 1) == 72.3,
          round(mean(test$popularidad), 1) == 46.6,
          46.6 * 20 == 932, 72.3 * 20 == 1446, 1446 - 932 == 514,
          round(72.3 - 46.6, 1) == 25.7)
## la respuesta esperada del taller (sin la trayectoria) no se publica
arbol2 <- rpart(popularidad ~ tempo + duracion_seg + bailabilidad + energia +
                              colaboracion, data = train)
mae2 <- round(mean(abs(round(predict(arbol2, test), 1) - test$popularidad)), 1)
stopifnot(sum(arbol2$frame$var == "<leaf>") == 5, mae2 == 22.9,
          identical(sort(unique(as.character(arbol2$frame$var[arbol2$frame$var != "<leaf>"]))),
                    c("bailabilidad", "duracion_seg", "tempo")))
cat("OK 4: láminas 8 a 10 (208.9 / 8 = 26.1; 17.0 vs 24.4; lote 932 vs 1.446)",
    "y el taller (sin la trayectoria: MAE 22.9, sin publicar)\n")

##=== 5. las cifras están en el .tex y nada filtra la solución ===============##
tex <- paste(readLines("../slides/week-12.tex", encoding = "UTF-8"), collapse = " ")
cifras_tex <- c("20 de octubre de 2026", "2.427", "1.942", "485", "44.9",
                "71.4", "55.6", "40.3", "21.8", "5.9", "45.3",
                "7.6; 4.6; 32.4; 20.4; 39.7; 46.7; 35.7; 21.8", "208.9",
                "26.1", "17.0 puntos", "24.4", "7.4", "30\\,\\%",
                "Si Te Vas", "Estamos Bien", "Amor De Pobre", "Bad Bunny",
                "Con Calma", "Gasolina", "cuatro pronósticos distintos",
                "el artista manda", "trayectoria del artista",
                "quién canta pesa más que cómo suena",
                "SonoUrbano", "popularidad", "TidyTuesday", "generalice",
                "un número", "comprar", "cinco", "11 columnas",
                "elegir cuáles comprar", "La decisión de compra", "46.6",
                "72.3", "\\$1 millón", "$46.6 \\times 20$", "$72.3 \\times 20$",
                "\\$932 M", "\\$1.446 M", "\\$514 millones más",
                "$1.446 - 932$", "25.7", "Ningún modelo pronostica un hit")
faltan <- cifras_tex[!sapply(cifras_tex, grepl, x = tex, fixed = T)]
if (length(faltan) > 0) stop("no están en el .tex: ", paste(faltan, collapse = " · "))
stopifnot(!grepl("bosque|Lasso|poda|AUC|umbral|memorizador|plata|tonta", tex),
          ## nada de los árboles descartados ni la solución del taller
          !grepl("50\\.000|URB0|bpm|36\\.4|24\\.3|63\\.6|51\\.9|22\\.9|20\\.3", tex),
          ## 11 frames: la portada, el roadmap sin número y las láminas 2 a 10
          lengths(regmatches(tex, gregexpr("\\begin{frame}", tex, fixed = T))) == 11)
task <- paste(readLines("../task/week-12.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("Quita `pop_artista`", task, fixed = T),
          grepl("paso 2.1", task, fixed = T),
          grepl("como en el paso 2.2", task, fixed = T),
          grepl("paso 3.3", task, fixed = T),
          grepl("trayectoria del artista", task, fixed = T),
          grepl("Intu", task),
          grepl("apellido_nombre_taller12.R", task, fixed = T),
          !grepl("millones|22\\.9", task))
scr <- paste(codigo, collapse = " ")
stopifnot(grepl("type=4 , extra=101", scr, fixed = T),
          grepl("digits=3", scr, fixed = T),
          grepl("pop_artista + tempo + duracion_seg", scr, fixed = T),
          grepl("Estamos Bien", scr, fixed = T),
          grepl("Amor De Pobre", scr, fixed = T),
          grepl("grepl(\"Bad Bunny\"", scr, fixed = T),
          grepl("##==: 4. taller :==##", scr, fixed = T),
          grepl("quita pop_artista", scr, fixed = T),
          !grepl("22.9", scr, fixed = T))
qmd <- paste(readLines("../theory/week-12.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("2Miw4bjzSF0", qmd, fixed = T),
          grepl("qué tan popular", qmd, fixed = T),
          grepl("2.427", qmd, fixed = T), grepl("un número", qmd, fixed = T),
          !grepl("50.000", qmd, fixed = T), !grepl("{webr-r}", qmd, fixed = T))
cat("OK 5: cifras del Beamer, el taller, el script y la teoría\n")
cat("\nTODO OK\n")
