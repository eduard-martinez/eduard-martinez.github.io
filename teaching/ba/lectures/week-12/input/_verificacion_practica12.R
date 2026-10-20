##============================================================================##
# _verificacion_practica12.R  —  cifras de la clase de la semana 12 (canciones)
#------------------------------------------------------------------------------#
# Solo para el profesor: regenera la base de canciones con el generador,
# comprueba que es idéntica a la publicada (local y, cuando esté en línea, la
# URL), corre el script de la clase y verifica cada checkpoint, cada cifra del
# Beamer (y que esté en el .tex), el quiz (sus figuras salen de otro script:
# quiz/_banco/insumos/arboles_week-12.R) y que el taller no esté filtrado.
# Correr desde lectures/week-12/input/:  Rscript _verificacion_practica12.R
##============================================================================##
rm(list = ls())
options(warn = 2)
require(pacman)
p_load(dplyr, rpart)

url_pub <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-12/script/canciones_urbanas.csv"

##=== 1. el generador reproduce la base publicada ============================##
set.seed(2026)
n <- 50000
canciones <- data.frame(
  cancion_id   = sprintf("URB%05d", 1:n),
  bailabilidad = round(pmin(100, pmax(0, rnorm(n, 72, 14)))),
  energia      = round(pmin(100, pmax(0, rnorm(n, 68, 15)))),
  bpm          = round(runif(n, 80, 180)),
  duracion_seg = round(runif(n, 140, 320)),
  colaboracion = rbinom(n, 1, 0.35))
base <- with(canciones,
             ifelse(bailabilidad >= 75 & colaboracion == 1, 95,
             ifelse(bailabilidad >= 75,                     48,
             ifelse(energia >= 70,                          22, 9))))
set.seed(2027)
canciones$reproducciones <- round(pmax(0.1, base + rnorm(n, 0, 9)), 1)
local <- read.csv("../script/canciones_urbanas.csv")
stopifnot(identical(dim(local), c(50000L, 7L)), isTRUE(all.equal(local, canciones)))
publicada <- tryCatch(suppressWarnings(read.csv(url_pub)), error = function(e) NULL)
if (is.null(publicada)) {
  cat("AVISO: canciones_urbanas.csv aún no está publicada en la página del curso\n")
} else {
  stopifnot(isTRUE(all.equal(publicada, local)))
  cat("OK canciones_urbanas.csv publicada e idéntica a ../script/\n")
}
cat("OK 1: el generador reproduce la base (50.000 x 7)\n")

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

##=== 3. checkpoints del script (láminas 6 a 9) ==============================##
train <- clase$train
test  <- clase$test
arbol <- clase$arbol
stopifnot(nrow(train) == 40000, nrow(test) == 10000,
          round(mean(train$reproducciones), 1) == 36.4)
## el árbol (lámina 8): 3 preguntas, 4 hojas; bailabilidad, energia, colaboracion
stopifnot(sum(arbol$frame$var == "<leaf>") == 4,
          identical(sort(unique(as.character(arbol$frame$var[arbol$frame$var != "<leaf>"]))),
                    c("bailabilidad", "colaboracion", "energia")))
stopifnot(identical(labels(arbol),
                    c("root", "bailabilidad< 74.5", "energia< 69.5",
                      "energia>=69.5", "bailabilidad>=74.5",
                      "colaboracion< 0.5", "colaboracion>=0.5")))
hojas <- sort(round(unique(predict(arbol, newdata = train)), 1))
stopifnot(identical(as.numeric(hojas), c(9.7, 21.9, 48.0, 95.0)))
## lámina 9: las ocho primeras canciones del test
ocho <- test %>%
        slice_head(n = 8) %>%
        mutate(error = round(abs(pron_arbol - reproducciones), 1))
stopifnot(identical(ocho$cancion_id,
                    c("URB00002", "URB00007", "URB00008", "URB00010",
                      "URB00011", "URB00016", "URB00022", "URB00026")),
          identical(unname(ocho$pron_arbol),
                    c(9.7, 21.9, 21.9, 9.7, 9.7, 48.0, 21.9, 48.0)),
          identical(unname(ocho$error),
                    c(6.9, 9.7, 5.6, 7.4, 9.6, 11.5, 2.2, 13.2)))
cat("OK 3: checkpoints del script y láminas 6 a 9\n")

##=== 4. el MAE: láminas 10 y 11 =============================================##
stopifnot(round(sum(ocho$error), 1) == 66.1, round(sum(ocho$error) / 8, 1) == 8.3,
          round(clase$mae_arbol, 1) == 7.0, round(clase$mae_promedio, 1) == 24.3,
          round(clase$mae_promedio / clase$mae_arbol, 1) == 3.4)
## las cuentas a mano de las láminas de teoría (4 y 5)
stopifnot((52 + 60 + 58 + 70) / 4 == 60, (8 + 12 + 10 + 18) / 4 == 12,
          (5 + 2 + 2) / 3 == 3)
cat("OK 4: láminas 10 y 11 (66.1 / 8 = 8.3; 7.0 vs 24.3) y las cuentas de teoría\n")

##=== 5. las cifras están en el .tex y el taller no filtra nada ==============##
tex <- paste(readLines("../slides/week-12.tex", encoding = "UTF-8"), collapse = " ")
cifras_tex <- c("20 de octubre de 2026", "50.000", "40.000", "10.000", "36.4",
                "9.7", "21.9", "48", "95", "66.1", "8.3", "7.0", "24.3",
                "3.4", "URB00022", "URB00026", "generalice", "SonoUrbano",
                "bailabilidad", "colaboracion", "n=12e+3", "un número",
                "comprar", "\\$1 millón", "$24.3 \\times 20$", "\\$486 M",
                "\\$140 M", "\\$346 millones más", "$486 - 140$")
## la cuenta del costo de oportunidad (lámina 10)
stopifnot(24.3 * 20 == 486, 7 * 20 == 140, 486 - 140 == 346)
faltan <- cifras_tex[!sapply(cifras_tex, grepl, x = tex, fixed = T)]
if (length(faltan) > 0) stop("no están en el .tex: ", paste(faltan, collapse = " · "))
stopifnot(!grepl("bosque|Lasso|poda|AUC|umbral|memorizador|plata|tonta", tex),
          ## 13 frames: la portada, el roadmap sin número y las láminas 2 a 11
          ## 11 frames: la portada, el roadmap sin número y las láminas 2 a 10
          lengths(regmatches(tex, gregexpr("\\begin{frame}", tex, fixed = T))) == 11)
task <- paste(readLines("../task/week-12.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("rpart.control(maxdepth = 4, cp = 0, minsplit = 2, minbucket = 1)", task, fixed = T),
          grepl("como en el bloque 2", task, fixed = T), grepl("Intu", task),
          grepl("apellido_nombre_taller12.R", task, fixed = T))
scr <- paste(readLines("../script/script_clase12.R", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("type = 5, extra = 101", scr, fixed = T),
          grepl("canciones_urbanas.csv", scr, fixed = T),
          grepl("un número", scr, fixed = T))
qmd <- paste(readLines("../theory/week-12.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("2Miw4bjzSF0", qmd, fixed = T), grepl("canción urbana", qmd, fixed = T),
          grepl("un número", qmd, fixed = T),
          !grepl("{webr-r}", qmd, fixed = T))
cat("OK 5: cifras del Beamer, el taller, el script y la teoría\n")
cat("\nTODO OK\n")
