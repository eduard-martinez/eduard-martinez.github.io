##============================================================================##
# _verificacion_practica11.R  —  cifras de la clase de la semana 11
#------------------------------------------------------------------------------#
# Solo para el profesor: corre el script de la clase (../script/script_clase11.R)
# con la base publicada de Cóndor y comprueba cada checkpoint, cada cifra del
# Beamer (y que esté en el .tex), la práctica interactiva webR (misma
# partición: aquí se recalculan sus números), la teoría (video + aplicaciones,
# sin celdas de R) y que el taller sea resoluble sin estar filtrado.
# Correr desde lectures/week-11/input/:  Rscript _verificacion_practica11.R
##============================================================================##
rm(list = ls())
options(warn = 2)
require(pacman)
p_load(dplyr, rpart)

url      <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
url_s10  <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-10/script/"
clientes <- read.csv(paste0(url, "base_clientes.csv"))

##=== 1. el sobre es el de la semana 10 ======================================##
stopifnot(identical(dim(clientes), c(8000L, 29L)))
set.seed(10)
idx_train <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
pred_a <- read.csv(paste0(url_s10, "predicciones_modelo_a.csv"))
stopifnot(identical(sort(clientes$cliente_id[-idx_train]), sort(pred_a$cliente_id)))
cat("OK 1: el sobre 80/20 con set.seed(10) es el mismo de la semana 10\n")

##=== 2. el script corre de punta a punta y sin advertencias =================##
copia <- file.path(tempdir(), "script_clase11.R")
invisible(file.copy("../script/script_clase11.R", copia, overwrite = T))
salida <- system2("Rscript", shQuote(copia), stdout = T, stderr = T,
                  env = "LC_ALL=en_US.UTF-8")
stopifnot(is.null(attr(salida, "status")),
          !any(grepl("warn", salida, ignore.case = T)))
clase <- new.env()
pdf(NULL)
invisible(capture.output(source(copia, local = clase, encoding = "UTF-8")))
invisible(dev.off())
cat("OK 2: el script corre completo, sin advertencias\n")

##=== 3. checkpoints del script (láminas 5 a 9) ==============================##
test  <- clase$test
train <- clase$train
arbol <- clase$arbol
## variables y sobre
stopifnot(identical(names(clase$clientes),
                    c("cliente_id", "abandono", "recencia_dias",
                      "num_sesiones_ult30d", "frecuencia_tx",
                      "antiguedad_meses", "gasto_promedio_mensual")),
          sum(is.na(clase$clientes)) == 0,
          nrow(train) == 6400, nrow(test) == 1600,
          sum(test$abandono == 1) == 354, sum(test$abandono == 0) == 1246,
          round(mean(train$abandono == 1), 3) == 0.222)
## el árbol (lámina 7): dos nodos de decisión, tres hojas y sus conteos
stopifnot(identical(labels(arbol),
                    c("root", "frecuencia_tx>=8.5", "frecuencia_tx< 8.5",
                      "recencia_dias< 157.5", "recencia_dias>=157.5")),
          sum(arbol$frame$var == "<leaf>") == 3,
          sum(arbol$frame$var != "<leaf>") == 2)
conteos <- data.frame(n = arbol$frame$n, unos = arbol$frame$dev,
                      yval = arbol$frame$yval)
stopifnot(identical(as.integer(arbol$frame$n), c(6400L, 4706L, 1694L, 1331L, 363L)),
          sum(train$abandono == 1) == 1418, sum(train$abandono == 0) == 4982)
hoja_va <- train %>% filter(frecuencia_tx < 8.5, recencia_dias >= 157.5)
stopifnot(sum(hoja_va$abandono == 0) == 94, sum(hoja_va$abandono == 1) == 269)
## la matriz de confusión (bloque 3) y las casillas de las láminas 8 y 9
test <- test %>%
        mutate(resultado = case_when(pred_arbol == 1 & abandono == 1 ~ "TP",
                                     pred_arbol == 1 & abandono == 0 ~ "FP",
                                     pred_arbol == 0 & abandono == 1 ~ "FN",
                                     pred_arbol == 0 & abandono == 0 ~ "TN"))
stopifnot(sum(test$resultado == "TP") == 59, sum(test$resultado == "FP") == 17,
          sum(test$resultado == "FN") == 295, sum(test$resultado == "TN") == 1229)
fila <- function(id) test %>% filter(cliente_id == id)
stopifnot(fila(3000122)$resultado == "TP", fila(3000122)$frecuencia_tx == 1,
          fila(3000122)$recencia_dias == 215,
          fila(3000077)$resultado == "FP", fila(3000077)$recencia_dias == 266,
          fila(3000030)$resultado == "FN", fila(3000030)$frecuencia_tx == 13,
          fila(3000050)$resultado == "FN", fila(3000050)$frecuencia_tx == 22,
          fila(3000027)$resultado == "FN", fila(3000003)$resultado == "TN")
## las métricas de la lámina 9 (las calcula el runner, no el script)
stopifnot(round((59 + 1229) / 1600, 3) == 0.805,
          round(mean(test$abandono == 0), 3) == 0.779,
          round(59 / 76, 3) == 0.776, round(59 / 354, 3) == 0.167)
cat("OK 3: checkpoints del script y láminas 5 a 9\n")

##=== 4. el dinero: láminas 10 y 11 ==========================================##
stopifnot(59 + 17 == 76, 76 * 2250 == 171000, round(171000 / 59) == 2898,
          59 * 4000 == 236000, 236000 - 171000 == 65000,
          59 * 2000 == 118000, 118000 - 171000 == -53000,
          2000 < 171000 / 59, 171000 / 59 < 4000)
cat("OK 4: láminas 10 y 11 (frontera $2.898 entre los dos escenarios)\n")

##=== 5. la teoría interactiva y el taller: misma partición ==================##
base2 <- clientes %>%
         select(cliente_id, abandono, recencia_dias, num_sesiones_ult30d,
                frecuencia_tx, antiguedad_meses, gasto_promedio_mensual) %>%
         mutate(abandono = factor(abandono))
set.seed(10)
idx <- sample(1:nrow(base2), size = round(0.8 * nrow(base2)))
tr <- base2[idx, ]; te <- base2[-idx, ]
f  <- abandono ~ recencia_dias + num_sesiones_ult30d + frecuencia_tx +
                 antiguedad_meses + gasto_promedio_mensual
ctl <- function(d) rpart.control(maxdepth = d, cp = 0, minsplit = 2,
                                 minbucket = 1, xval = 0)
## el árbol inicial (prof. 2) es el de fábrica, el de la clase
inicial <- rpart(f, data = tr, method = "class", control = ctl(2))
stopifnot(identical(predict(inicial, newdata = te, type = "class"),
                    predict(arbol, newdata = te, type = "class")))
## la tabla de profundidades que imprime la página
sweep <- data.frame()
for (d in c(2, 4, 8, 15, 30)) {
  m  <- rpart(f, data = tr, method = "class", control = ctl(d))
  pt <- predict(m, newdata = tr, type = "class")
  pe <- predict(m, newdata = te, type = "class")
  sweep <- rbind(sweep,
                 data.frame(prof = d, hojas = sum(m$frame$var == "<leaf>"),
                            acc_tr = round(mean(pt == tr$abandono), 3),
                            acc_te = round(mean(pe == te$abandono), 3),
                            rec = round(sum(pe == 1 & te$abandono == 1) /
                                        sum(te$abandono == 1), 3)))
}
esperado <- data.frame(prof   = c(2, 4, 8, 15, 30),
                       hojas  = c(3L, 7L, 128L, 739L, 1360L),
                       acc_tr = c(0.806, 0.807, 0.836, 0.930, 1.000),
                       acc_te = c(0.805, 0.811, 0.796, 0.742, 0.693),
                       rec    = c(0.167, 0.370, 0.263, 0.319, 0.359))
stopifnot(identical(sweep, esperado))
## el árbol ajustado (prof. 4): sección 6 de la página y respuesta del taller
ajustado <- rpart(f, data = tr, method = "class", control = ctl(4))
pa <- predict(ajustado, newdata = te, type = "class")
tp <- sum(pa == 1 & te$abandono == 1); fp <- sum(pa == 1 & te$abandono == 0)
stopifnot(tp == 131, fp == 79, tp + fp == 210, (tp + fp) * 2250 == 472500,
          round(472500 / 131) == 3607,
          472500 - 171000 == 301500, 131 - 59 == 72,
          round(301500 / 72) == 4188)
cat("OK 5: práctica webR (fábrica = prof. 2; profundidades) y taller resoluble (prof. 4)\n")

##=== 6. las cifras están en el .tex, la página y el taller ==================##
tex <- paste(readLines("../slides/week-11.tex", encoding = "UTF-8"), collapse = " ")
cifras_tex <- c("13 de octubre de 2026", "0.805", "0.779", "0.776", "0.167",
                "$59 + 17$", "$76 \\times 2.250$", "\\$171.000",
                "$171.000 \\div 59$", "\\$2.898", "\\$3.214", "generalice",
                "2 nodos de decisión y 3 hojas", "94 se quedaron, 269 se fueron",
                "6.400", "1.600", "354", "59 \\times 4.000", "\\$236.000",
                "59 \\times 2.000", "\\$118.000", "\\$65.000", "\\$53.000",
                "\\$40.000", "3000122", "3000030", "295", "1.229", "0.700",
                "22\\,\\%")
faltan <- cifras_tex[!sapply(cifras_tex, grepl, x = tex, fixed = T)]
if (length(faltan) > 0) stop("no están en el .tex: ", paste(faltan, collapse = " · "))
stopifnot(!grepl("bosque|poda|Finanzas|AUC|umbral|memorizador|plata|tonta", tex),
          !grepl("Comprobación a mano|46,9|74,1", tex),
          ## 12 frames: la portada, el roadmap sin número y las láminas 2 a 11
          lengths(regmatches(tex, gregexpr("\\begin{frame}", tex, fixed = T))) == 12)
## la práctica interactiva (webR) trae el recorrido con las cifras de la clase
prac <- paste(readLines("../practice/week-11.qmd", encoding = "UTF-8"), collapse = " ")
cifras_prac <- c("0.805", "0.776", "0.167", "59 TP, 17 FP, 295 FN y 1.229 TN",
                 "2.898", "3.607", "4.188", "301.500", "$3.214", "6.400",
                 "354", "set.seed(10)", "proporcion <- 0.8", "PROFUNDIDAD <- 2",
                 "PROFUNDIDAD_2 <- 4", "extra = 101", "generalice",
                 "4.982 | 1.418", "2 nodos de decisión y 3 hojas",
                 "94 que se quedaron y 269", "128", "739", "1.360", "0.930",
                 "1.000", "0.742", "0.693", "0.811", "0.370", "opcional",
                 "no se entrega")
faltan <- cifras_prac[!sapply(cifras_prac, grepl, x = prac, fixed = T)]
if (length(faltan) > 0) stop("no están en la práctica: ", paste(faltan, collapse = " · "))
stopifnot(lengths(regmatches(prac, gregexpr("{webr-r}", prac, fixed = T))) == 8)
## la teoría: video + aplicaciones interactivas, sin celdas de R
qmd <- paste(readLines("../theory/week-11.qmd", encoding = "UTF-8"), collapse = " ")
cifras_qmd <- c("kqaLlte6P6o", "dt11w", "mlu-explain.github.io/decision-tree",
                "../practice/week-11.html")
faltan <- cifras_qmd[!sapply(cifras_qmd, grepl, x = qmd, fixed = T)]
if (length(faltan) > 0) stop("no están en la teoría: ", paste(faltan, collapse = " · "))
stopifnot(!grepl("{webr-r}", qmd, fixed = T))
task <- paste(readLines("../task/week-11.qmd", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("rpart.control(maxdepth = 4, cp = 0, minsplit = 2, minbucket = 1)", task, fixed = T),
          grepl("extra = 101", task, fixed = T), grepl("Intu", task),
          grepl("apellido_nombre_taller11.R", task, fixed = T),
          grepl("354", task, fixed = T),
          ## el taller no filtra la solución del árbol de profundidad 4
          !grepl("131", task), !grepl("223", task), !grepl("1.167", task, fixed = T))
scr <- paste(readLines("../script/script_clase11.R", encoding = "UTF-8"), collapse = " ")
stopifnot(grepl("extra = 101", scr, fixed = T),
          grepl("rpart.control(maxdepth = 4, cp = 0, minsplit = 2, minbucket = 1)", scr, fixed = T))
cat("OK 6: cifras del Beamer, la práctica, la teoría, el taller y el script\n")
cat("\nTODO OK\n")
