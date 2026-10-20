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
tmp <- file.path(tempdir(), "canciones_rehechas.csv")
write.csv(rehecha, tmp, row.names = F)
stopifnot(md5sum(tmp) == md5sum("../script/canciones_urbanas.csv"))
local <- read.csv("../script/canciones_urbanas.csv")
stopifnot(identical(dim(local), c(2427L, 10L)),
          sum(grepl("Bad Bunny", local$artista)) == 24,
          sum(grepl("J Balvin", local$artista)) == 37,
          sum(local$colaboracion) == 258,
          min(local$anio) == 1965, max(local$anio) == 2020)
publicada <- tryCatch({f <- file.path(tempdir(), "canciones_pub.csv")
                       suppressWarnings(download.file(url_pub, f, quiet = T))
                       f}, error = function(e) NULL)
if (is.null(publicada)) {
  cat("AVISO: canciones_urbanas.csv aún no está publicada en la página del curso\n")
} else {
  stopifnot(md5sum(publicada) == md5sum("../script/canciones_urbanas.csv"))
  cat("OK canciones_urbanas.csv publicada e idéntica a ../script/\n")
}
cat("OK 1: el preparador reproduce la base real (2.427 x 10)\n")

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
## el árbol (lámina 6): 4 nodos y 5 hojas, solo anio y duracion_seg
stopifnot(sum(arbol$frame$var == "<leaf>") == 5,
          identical(sort(unique(as.character(arbol$frame$var[arbol$frame$var != "<leaf>"]))),
                    c("anio", "duracion_seg")))
stopifnot(identical(labels(arbol),
                    c("root", "anio< 2018", "duracion_seg< 156.5",
                      "duracion_seg>=156.5", "duracion_seg>=275.5",
                      "duracion_seg< 275.5", "anio>=2018", "anio< 2018",
                      "anio>=2018")))
hojas <- arbol$frame[arbol$frame$var == "<leaf>", ]
stopifnot(identical(as.integer(hojas$n), c(41L, 177L, 975L, 207L, 542L)),
          identical(round(hojas$yval, 1), c(14.0, 26.5, 37.7, 51.9, 63.6)))
## lámina 7: ocho canciones conocidas del test, con las cinco hojas presentes
ocho <- clase$ocho
stopifnot(identical(ocho$cancion,
                    c("Me Gusta", "Con Calma", "Baila Baila Baila",
                      "Felices los 4", "Estamos Bien", "Gasolina",
                      "Bandoleros", "Te Suelto el Pelo")),
          identical(ocho$artista[c(1, 2, 5, 6, 7, 8)],
                    c("Shakira", "Daddy Yankee", "Bad Bunny", "Daddy Yankee",
                      "Don Omar", "Yandel")),
          identical(unname(ocho$pron_arbol),
                    c(63.6, 63.6, 63.6, 51.9, 51.9, 37.7, 26.5, 14.0)),
          identical(unname(ocho$error),
                    c(15.4, 23.4, 1.4, 24.1, 24.1, 38.3, 40.5, 41.0)),
          ocho$popularidad[5] == 76, length(unique(ocho$pron_arbol)) == 5)
cat("OK 3: checkpoints del script y láminas 4 a 7\n")

##=== 4. el MAE y el lote: láminas 8 a 10; el taller no está filtrado ========##
mae_arbol    <- mean(abs(test$pron_arbol - test$popularidad))
mae_promedio <- mean(abs(round(mean(train$popularidad), 1) - test$popularidad))
stopifnot(round(sum(ocho$error), 1) == 208.2,
          round(sum(ocho$error) / 8, 1) == 26.0,
          round(mae_arbol, 1) == 21.0, round(mae_promedio, 1) == 24.4,
          round(mae_promedio - mae_arbol, 1) == 3.4,
          round(100 * (1 - mae_arbol / mae_promedio)) == 14)
## lámina 10: lote de 20 de la hoja top vs al azar ($1 millón por punto real)
hoja_top <- test %>% filter(pron_arbol == max(pron_arbol))
stopifnot(nrow(hoja_top) == 145,
          round(mean(hoja_top$popularidad), 1) == 66.0,
          round(mean(test$popularidad), 1) == 46.6,
          46.6 * 20 == 932, 66.0 * 20 == 1320, 1320 - 932 == 388,
          round(66.0 - 46.6, 1) == 19.4)
## la respuesta esperada del taller (el árbol sin el año) no se publica
arbol2 <- rpart(popularidad ~ duracion_seg + bailabilidad + energia +
                              colaboracion, data = train)
mae2 <- round(mean(abs(round(predict(arbol2, test), 1) - test$popularidad)), 1)
stopifnot(sum(arbol2$frame$var == "<leaf>") == 4, mae2 == 23.3,
          identical(sort(unique(as.character(arbol2$frame$var[arbol2$frame$var != "<leaf>"]))),
                    c("duracion_seg", "energia")))
cat("OK 4: láminas 8 a 10 (208.2 / 8 = 26.0; 21.0 vs 24.4; lote 932 vs 1.320)",
    "y el taller (sin el año: MAE 23.3, sin publicar)\n")

##=== 5. las cifras están en el .tex y nada filtra la solución ===============##
tex <- paste(readLines("../slides/week-12.tex", encoding = "UTF-8"), collapse = " ")
cifras_tex <- c("20 de octubre de 2026", "2.427", "1.942", "485", "44.9",
                "63.6", "51.9", "37.7", "26.5", "157", "276",
                "15.4; 23.4; 1.4; 24.1; 24.1; 38.3; 40.5; 41.0", "208.2",
                "26.0", "21.0 puntos", "24.4", "3.4", "14\\,\\%",
                "Estamos Bien", "Bad Bunny", "Con Calma", "Gasolina",
                "Bandoleros", "cinco pronósticos distintos",
                "SonoUrbano", "popularidad", "TidyTuesday", "generalice",
                "un número", "comprar", "dos variables, cinco hojas",
                "elegir cuáles comprar", "La decisión de compra", "46.6",
                "66.0", "\\$1 millón", "$46.6 \\times 20$", "$66.0 \\times 20$",
                "\\$932 M", "\\$1.320 M", "\\$388 millones más",
                "$1.320 - 932$", "19.4", "la variable que falta")
faltan <- cifras_tex[!sapply(cifras_tex, grepl, x = tex, fixed = T)]
if (length(faltan) > 0) stop("no están en el .tex: ", paste(faltan, collapse = " · "))
stopifnot(!grepl("bosque|Lasso|poda|AUC|umbral|memorizador|plata|tonta", tex),
          ## nada de la base simulada vieja ni la solución del taller
          !grepl("50\\.000|URB0|bpm|36\\.4|24\\.3|346|20\\.6|23\\.3", tex),
          ## 11 frames: la portada, el roadmap sin número y las láminas 2 a 10
          lengths(regmatches(tex, gregexpr("\\begin{frame}", tex, fixed = T))) == 11)
task <- paste(readLines("../task/week-12.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("solo las señales de la canción", task, fixed = T),
          grepl("sin el año", task, fixed = T),
          grepl("como en el paso 2.2", task, fixed = T),
          grepl("paso 3.3", task, fixed = T), grepl("Intu", task),
          grepl("apellido_nombre_taller12.R", task, fixed = T),
          !grepl("millones|23\\.3|20\\.6", task))
scr <- paste(codigo, collapse = " ")
stopifnot(grepl("type=5 , extra=101", scr, fixed = T),
          grepl("digits=3", scr, fixed = T),
          grepl("Estamos Bien", scr, fixed = T),
          grepl("grepl(\"Bad Bunny\"", scr, fixed = T),
          grepl("##==: 4. taller :==##", scr, fixed = T),
          grepl("sin el anio", scr, fixed = T),
          !grepl("23.3", scr, fixed = T))
qmd <- paste(readLines("../theory/week-12.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("2Miw4bjzSF0", qmd, fixed = T),
          grepl("qué tan popular", qmd, fixed = T),
          grepl("2.427", qmd, fixed = T), grepl("un número", qmd, fixed = T),
          !grepl("50.000", qmd, fixed = T), !grepl("{webr-r}", qmd, fixed = T))
cat("OK 5: cifras del Beamer, el taller, el script y la teoría\n")
cat("\nTODO OK\n")
