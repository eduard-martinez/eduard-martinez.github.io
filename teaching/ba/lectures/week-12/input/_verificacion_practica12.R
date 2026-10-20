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
## el árbol (lámina 6): 4 nodos y 5 hojas con tempo, duración y bailabilidad
stopifnot(sum(arbol$frame$var == "<leaf>") == 5,
          identical(sort(unique(as.character(arbol$frame$var[arbol$frame$var != "<leaf>"]))),
                    c("bailabilidad", "duracion_seg", "tempo")))
stopifnot(identical(labels(arbol),
                    c("root", "tempo< 135.5", "tempo>=120.5",
                      "duracion_seg>=275.5", "duracion_seg< 275.5",
                      "bailabilidad< 72.5", "bailabilidad>=72.5",
                      "tempo< 120.5", "tempo>=135.5")))
hojas <- arbol$frame[arbol$frame$var == "<leaf>", ]
stopifnot(identical(as.integer(hojas$n), c(78L, 141L, 129L, 1156L, 438L)),
          identical(round(hojas$yval, 1), c(15.4, 25.7, 41.6, 46.4, 53.5)))
## lámina 7: ocho canciones conocidas del test, con cuatro hojas presentes
ocho <- clase$ocho
stopifnot(identical(ocho$cancion,
                    c("Si Te Vas", "Atrévete", "Me Gusta", "Aullando",
                      "Con Calma", "Felices los 4", "Zumba", "Taboo")),
          identical(ocho$artista[c(1, 2, 5, 7, 8)],
                    c("Sech", "Nicky Jam", "Daddy Yankee", "Don Omar",
                      "Don Omar")),
          identical(unname(ocho$pron_arbol),
                    c(53.5, 53.5, 46.4, 46.4, 46.4, 46.4, 41.6, 15.4)),
          identical(unname(ocho$error),
                    c(34.5, 27.5, 32.6, 33.6, 40.6, 29.6, 15.4, 14.4)),
          ocho$popularidad[8] == 1, length(unique(ocho$pron_arbol)) == 4)
cat("OK 3: checkpoints del script y láminas 4 a 7\n")

##=== 4. el MAE y el lote: láminas 8 a 10; el taller no está filtrado ========##
mae_arbol    <- mean(abs(test$pron_arbol - test$popularidad))
mae_promedio <- mean(abs(round(mean(train$popularidad), 1) - test$popularidad))
stopifnot(round(sum(ocho$error), 1) == 228.2,
          round(sum(ocho$error) / 8, 1) == 28.5,
          round(mae_arbol, 1) == 22.9, round(mae_promedio, 1) == 24.4,
          round(mae_promedio - mae_arbol, 1) == 1.5,
          round(100 * (1 - mae_arbol / mae_promedio)) == 6)
## lámina 10: lote de 20 de la hoja top vs al azar ($1 millón por punto real)
hoja_top <- test %>% filter(pron_arbol == max(pron_arbol))
stopifnot(nrow(hoja_top) == 96,
          round(mean(hoja_top$popularidad), 1) == 54.3,
          round(mean(test$popularidad), 1) == 46.6,
          46.6 * 20 == 932, 54.3 * 20 == 1086, 1086 - 932 == 154,
          round(54.3 - 46.6, 1) == 7.7)
## la respuesta esperada del taller (agregar el año) no se publica
arbol2 <- rpart(popularidad ~ bailabilidad + energia + tempo + duracion_seg +
                              colaboracion + anio, data = train)
mae2 <- round(mean(abs(round(predict(arbol2, test), 1) - test$popularidad)), 1)
stopifnot(sum(arbol2$frame$var == "<leaf>") == 7, mae2 == 20.3,
          labels(arbol2)[2] == "anio< 2018")
cat("OK 4: láminas 8 a 10 (228.2 / 8 = 28.5; 22.9 vs 24.4; lote 932 vs 1.086)",
    "y el taller (con el año: raíz anio, MAE 20.3, sin publicar)\n")

##=== 5. las cifras están en el .tex y nada filtra la solución ===============##
tex <- paste(readLines("../slides/week-12.tex", encoding = "UTF-8"), collapse = " ")
cifras_tex <- c("20 de octubre de 2026", "2.427", "1.942", "485", "44.9",
                "53.5", "46.4", "41.6", "25.7", "15.4", "136", "121", "276",
                "34.5; 27.5; 32.6; 33.6; 40.6; 29.6; 15.4; 14.4", "228.2",
                "28.5", "22.9 puntos", "24.4", "1.5", "6\\,\\%",
                "Si Te Vas", "Zumba", "Taboo", "Bad Bunny", "Con Calma",
                "Aullando", "cuatro pronósticos distintos", "el tempo manda",
                "SonoUrbano", "popularidad", "TidyTuesday", "generalice",
                "un número", "comprar", "cinco hojas",
                "elegir cuáles comprar", "La decisión de compra", "46.6",
                "54.3", "\\$1 millón", "$46.6 \\times 20$", "$54.3 \\times 20$",
                "\\$932 M", "\\$1.086 M", "\\$154 millones más",
                "$1.086 - 932$", "7.7", "la variable que falta")
faltan <- cifras_tex[!sapply(cifras_tex, grepl, x = tex, fixed = T)]
if (length(faltan) > 0) stop("no están en el .tex: ", paste(faltan, collapse = " · "))
stopifnot(!grepl("bosque|Lasso|poda|AUC|umbral|memorizador|plata|tonta", tex),
          ## nada del árbol viejo del año ni la solución del taller
          !grepl("50\\.000|URB0|bpm|36\\.4|24\\.3|63\\.6|51\\.9|21\\.0|20\\.3", tex),
          ## 11 frames: la portada, el roadmap sin número y las láminas 2 a 10
          lengths(regmatches(tex, gregexpr("\\begin{frame}", tex, fixed = T))) == 11)
task <- paste(readLines("../task/week-12.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("Agrega `anio`", task, fixed = T),
          grepl("paso 2.1", task, fixed = T),
          grepl("como en el paso 2.2", task, fixed = T),
          grepl("paso 3.3", task, fixed = T),
          grepl("se toma la raíz", task, fixed = T),
          grepl("sale esta semana", task, fixed = T), grepl("Intu", task),
          grepl("apellido_nombre_taller12.R", task, fixed = T),
          !grepl("millones|20\\.3", task))
scr <- paste(codigo, collapse = " ")
stopifnot(grepl("type=1 , extra=101", scr, fixed = T),
          grepl("digits=3", scr, fixed = T),
          grepl("tempo + duracion_seg + bailabilidad", scr, fixed = T),
          grepl("Si Te Vas", scr, fixed = T),
          grepl("grepl(\"Bad Bunny\"", scr, fixed = T),
          grepl("##==: 4. taller :==##", scr, fixed = T),
          grepl("agrega anio", scr, fixed = T),
          grepl("toma la raiz", scr, fixed = T),
          !grepl("20.3", scr, fixed = T))
qmd <- paste(readLines("../theory/week-12.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("2Miw4bjzSF0", qmd, fixed = T),
          grepl("qué tan popular", qmd, fixed = T),
          grepl("2.427", qmd, fixed = T), grepl("un número", qmd, fixed = T),
          !grepl("50.000", qmd, fixed = T), !grepl("{webr-r}", qmd, fixed = T))
cat("OK 5: cifras del Beamer, el taller, el script y la teoría\n")
cat("\nTODO OK\n")
