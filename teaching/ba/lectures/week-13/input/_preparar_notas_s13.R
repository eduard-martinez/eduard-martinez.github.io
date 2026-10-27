##============================================================================##
# _preparar_notas_s13.R  —  la base de notas del curso para la clase 13
#------------------------------------------------------------------------------#
# Solo para el profesor. Lee los dos Excel de notas (../notas/, NO se publican),
# calcula por estudiante el promedio de quices (0 donde falte una nota; las
# columnas de quices sin aplicar —todas vacías— no entran) y la nota del
# parcial 1 (0 si falta), y arma una sola base con la jornada. Escribe
# ../script/notas_curso.csv (grano: estudiante), que la clase lee por URL.
# Correr desde lectures/week-13/input/:  Rscript _preparar_notas_s13.R
##============================================================================##
rm(list = ls())
options(warn = 2)
suppressMessages({library(readxl); library(dplyr)})

promedia_quices <- function(d, id_col) {
  qcols <- names(d)[grepl("^(Quiz s|S)emana", names(d))]
  qcols <- qcols[sapply(qcols, function(c) any(!is.na(d[[c]])))]
  notas <- d[, qcols]
  notas[is.na(notas)] <- 0
  data.frame(codigo = as.character(d[[id_col]]),
             promedio_quices = round(rowMeans(notas), 2))
}

## grupo 5
q5 <- suppressMessages(read_excel("../notas/Notas_Analitica_G5.xlsx", sheet = "Quices")) %>%
      filter(!is.na(`Código`))
p5 <- suppressMessages(read_excel("../notas/Notas_Analitica_G5.xlsx", sheet = "Parciales")) %>%
      filter(!is.na(`Código`)) %>%
      transmute(codigo = as.character(`Código`), parcial_1 = `Primer Parcial`)
g5 <- promedia_quices(q5, "Código") %>%
      left_join(p5, by = "codigo") %>%
      mutate(jornada = "G5")

## grupo 7
q7 <- suppressMessages(read_excel("../notas/Notas G7 BA.xlsx", sheet = "Quices G7")) %>%
      filter(!is.na(`Número de ID`))
p7 <- suppressMessages(read_excel("../notas/Notas G7 BA.xlsx", sheet = "Parciales G7")) %>%
      filter(!is.na(`Número de ID`)) %>%
      transmute(codigo = as.character(`Número de ID`), parcial_1 = `1er Parcial`)
g7 <- promedia_quices(q7, "Número de ID") %>%
      left_join(p7, by = "codigo") %>%
      mutate(jornada = "G7")

## una sola base; 0 donde falte el parcial
notas <- bind_rows(g5, g7) %>%
         mutate(parcial_1 = round(ifelse(is.na(parcial_1), 0, parcial_1), 2)) %>%
         select(codigo, jornada, promedio_quices, parcial_1)

## export data
write.csv(notas, "../script/notas_curso.csv", row.names = F)
cat("notas_curso.csv:", nrow(notas), "estudiantes (G5:", sum(notas$jornada == "G5"),
    "· G7:", sum(notas$jornada == "G7"), ")\n")
