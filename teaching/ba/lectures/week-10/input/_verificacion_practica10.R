##============================================================================##
# _verificacion_practica10.R  —  cifras de la clase de la semana 10
#------------------------------------------------------------------------------#
# Solo para el profesor: corre el script de la clase (../script/script_clase10.R)
# con la base publicada de Cóndor y las predicciones de ../script/, y comprueba
# cada checkpoint del script, cada cifra del Beamer (láminas 4 a 10) y que las
# preguntas del taller se responden con la salida del script. Si las
# predicciones ya están publicadas, comprueba que son las mismas de ../script/.
# Correr desde lectures/week-10/input/:  Rscript _verificacion_practica10.R
##============================================================================##
rm(list = ls())
options(warn = 2)
require(pacman)
p_load(dplyr)

url      <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
url_pred <- "https://eduard-martinez.github.io/teaching/ba/lectures/week-10/script/"
clientes <- read.csv(paste0(url, "base_clientes.csv"))
campanas <- read.csv(paste0(url, "anexo_campanas.csv"))
pred_a   <- read.csv("../script/predicciones_modelo_a.csv")
pred_b   <- read.csv("../script/predicciones_modelo_b.csv")

##=== 1. los archivos de predicciones ========================================##
stopifnot(identical(names(pred_a), c("cliente_id", "pred_a")),
          identical(names(pred_b), c("cliente_id", "pred_b")),
          nrow(pred_a) == 1600, nrow(pred_b) == 1600,
          identical(pred_a$cliente_id, pred_b$cliente_id),
          all(pred_a$pred_a %in% 0:1), all(pred_b$pred_b %in% 0:1))
## los 1.600 son el sobre de siempre (80/20 con set.seed(10))
set.seed(10)
idx_train <- sample(1:nrow(clientes), size = round(0.8 * nrow(clientes)))
stopifnot(identical(sort(pred_a$cliente_id), sort(clientes$cliente_id[-idx_train])))
## el costo de un envío que citan el Beamer y el taller ($2.250)
stopifnot(round(mean(campanas$costo)) == 2248)
## las copias publicadas, si ya están en línea
for (f in c("predicciones_modelo_a.csv", "predicciones_modelo_b.csv")) {
  publicada <- tryCatch(suppressWarnings(read.csv(paste0(url_pred, f))), error = function(e) NULL)
  if (is.null(publicada)) {
    cat("AVISO:", f, "aún no está publicada en", url_pred, "\n")
  } else {
    stopifnot(identical(publicada, read.csv(file.path("../script", f))))
    cat("OK", f, "publicada e idéntica a ../script/\n")
  }
}
cat("OK 1: dos archivos de 1.600 clientes, el sobre de siempre\n")

##=== 2. el script de la clase, de punta a punta y sin advertencias ==========##
codigo <- readLines("../script/script_clase10.R", encoding = "UTF-8")
stopifnot(sum(grepl("^url_pred <- ", codigo)) == 1,
          sum(grepl(url, codigo, fixed = T)) == 1)
codigo <- sub("^url_pred <- .*$", paste0("url_pred <- \"", normalizePath("../script"), "/\""), codigo)
copia  <- file.path(tempdir(), "script_clase10.R")
writeLines(codigo, copia)
salida <- system2("Rscript", shQuote(copia), stdout = T, stderr = T, env = "LC_ALL=en_US.UTF-8")
stopifnot(is.null(attr(salida, "status")), !any(grepl("warn", salida, ignore.case = T)))
clase <- new.env()
invisible(capture.output(source(copia, local = clase, encoding = "UTF-8")))
comparacion <- clase$comparacion
cat("OK 2: el script corre completo, sin advertencias\n")

##=== 3. checkpoints del script y láminas 4 a 7 ==============================##
stopifnot(identical(dim(clase$clientes), c(8000L, 29L)))
stopifnot(round(mean(clientes$abandono), 4) == 0.2215)
## lámina 5: los doce primeros, con la predicción del proveedor A
stopifnot(identical(clase$modelo_a$cliente_id[1:12],
                    c(3000003L, 3000004L, 3000007L, 3000010L, 3000026L, 3000027L,
                      3000029L, 3000030L, 3000035L, 3000050L, 3000075L, 3000077L)),
          identical(clase$modelo_a$resultado[1:12],
                    c("TN","TN","TN","TN","TN","TP","TN","FN","TN","FN","TN","FP")))
## las casillas (bloques 1 a 4; lámina 6)
stopifnot(identical(comparacion$opcion, c("línea base", "proveedor A", "proveedor B")),
          identical(comparacion$TP, c(0L, 77L, 211L)),
          identical(comparacion$FP, c(0L, 33L, 236L)),
          identical(comparacion$FN, c(354L, 277L, 143L)),
          identical(comparacion$TN, c(1246L, 1213L, 1010L)),
          identical(comparacion$envios, c(0L, 110L, 447L)))
## las métricas (bloque 4; lámina 7)
stopifnot(identical(comparacion$accuracy, c(0.779, 0.806, 0.763)),
          is.nan(comparacion$precision[1]),
          identical(comparacion$precision[2:3], c(0.700, 0.472)),
          identical(comparacion$recall, c(0, 0.218, 0.596)))
## lámina 3: «decir que nadie se va ya acierta el 78 %»; lámina 7: «7 de cada 10»
## y «6 de cada 10»
stopifnot(round(100 * comparacion$accuracy[1]) == 78,
          round(10 * comparacion$precision[2]) == 7, round(10 * comparacion$recall[3]) == 6)
cat("OK 3: checkpoints del script y láminas 3 a 7\n")

##=== 4. el dinero: láminas 8 a 10 ===========================================##
costo       <- comparacion$envios * 2250
encontrados <- comparacion$TP
stopifnot(identical(costo, c(0, 247500, 1005750)),
          identical(round(costo[2:3] / encontrados[2:3]), c(3214, 4767)))
## lámina 8: «casi el triple» y «un 48 % más caro»
stopifnot(round(encontrados[3] / encontrados[2], 2) == 2.74,
          round(100 * (4767 / 3214 - 1)) == 48)
## lámina 9: el costo de cada cliente adicional
stopifnot(round(costo[2] / encontrados[2]) == 3214,
          encontrados[3] - encontrados[2] == 134, costo[3] - costo[2] == 758250,
          round((costo[3] - costo[2]) / (encontrados[3] - encontrados[2])) == 5659)
## lámina 10: beneficio neto = encontrados x valor - costo
neto_4 <- encontrados * 4000 - costo
neto_8 <- encontrados * 8000 - costo
stopifnot(identical(neto_4, c(0, 60500, -161750)), identical(neto_8, c(0, 368500, 682250)),
          which.max(neto_4) == 2, which.max(neto_8) == 3,
          0.1 * 40000 == 4000, 0.2 * 40000 == 8000)
cat("OK 4: láminas 8 a 10\n")

##=== 5. el taller se responde con la tabla comparacion ======================##
## costo total = envíos x 2.250 + FN x valor de dejar ir a un cliente
total_5 <- comparacion$envios * 2250 + comparacion$FN * 5000
total_3 <- comparacion$envios * 2250 + comparacion$FN * 3000
stopifnot(identical(total_5, c(1770000, 1632500, 1720750)),
          identical(total_3, c(1062000, 1078500, 1434750)))
## pregunta 1: con $5.000 la más barata es el proveedor A; pregunta 2: con $3.000,
## no enviársela a nadie (no adoptar ningún modelo)
stopifnot(comparacion$opcion[which.min(total_5)] == "proveedor A",
          comparacion$opcion[which.min(total_3)] == "línea base")
## minimizar el costo total es maximizar el beneficio neto de la lámina 10: los
## mismos umbrales ($3.214 para preferir A a nadie, $5.659 para preferir B a A)
umbral <- function(v) comparacion$opcion[which.min(comparacion$envios * 2250 + comparacion$FN * v)]
stopifnot(umbral(3200) == "línea base", umbral(3230) == "proveedor A",
          umbral(5650) == "proveedor A", umbral(5670) == "proveedor B")
cat("OK 5: el taller (A con $5.000; ningún modelo con $3.000)\n")

##=== 6. las cifras del Beamer están en el .tex ==============================##
tex <- paste(readLines("../slides/week-10.tex", encoding = "UTF-8"), collapse = " ")
cifras <- c("6 de octubre de 2026", "22\\,\\%", "78\\,\\%", "0.806", "0.779", "0.763",
            "7 de cada 10", "6 de cada 10", "\\$247.500", "\\$1.005.750", "\\$3.214",
            "\\$4.767", "48\\,\\%", "\\$5.659", "134", "\\$758.250", "\\$60.500",
            "\\$161.750", "\\$368.500", "\\$682.250", "\\$40.000", "\\$2.250")
faltan <- cifras[!sapply(cifras, grepl, x = tex, fixed = T)]
if (length(faltan) > 0) stop("no están en el .tex: ", paste(faltan, collapse = ", "))
stopifnot(!grepl("Finanzas|memorizador|regla del EDA|AUC", tex))
cat("OK 6: las cifras del Beamer están en el .tex, sin Finanzas, regla del EDA, memorizador ni AUC\n")
cat("\nTODO OK\n")
