##============================================================================##
# _verificacion_semana06.R  —  cifras del Beamer y del script de la semana 6
#------------------------------------------------------------------------------#
# Solo para el profesor: rehace, desde las tablas publicadas de Cóndor, cada
# cifra que citan slides/week-06.tex y los checkpoints de script/06_eda_condor.R.
# Correr desde lectures/week-06/input/:  Rscript _verificacion_semana06.R
##============================================================================##
rm(list = ls())
require(pacman)
p_load(dplyr)

url <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes      <- read.csv(paste0(url, "base_clientes.csv"))
transacciones <- read.csv(paste0(url, "anexo_transacciones.csv"))
creditos      <- read.csv(paste0(url, "anexo_creditos.csv"))
campanas      <- read.csv(paste0(url, "anexo_campanas.csv"))
pct <- function(x) round(100 * x, 1)

##=== paso 1: filas y faltantes ===============================================##
stopifnot(nrow(clientes) == 8000, n_distinct(clientes$cliente_id) == 8000, sum(duplicated(clientes)) == 0,
          nrow(transacciones) == 185582, nrow(creditos) == 4071, n_distinct(creditos$cliente_id) == 2721,
          nrow(campanas) == 13467, n_distinct(campanas$cliente_id) == 6386)
conteo <- transacciones %>% count(cliente_id)
chk <- inner_join(clientes, conteo, by = "cliente_id")
stopifnot(mean(chk$frecuencia_tx == chk$n) == 1)
stopifnot(sum(is.na(clientes$duracion_sesion_promedio)) == 855, sum(is.na(clientes$csat_promedio)) == 5279,
          sum(is.na(clientes$score_buro)) == 5279,
          all(is.na(clientes$duracion_sesion_promedio) == (clientes$num_sesiones_ult30d == 0)),
          all(is.na(clientes$csat_promedio) == (clientes$num_tickets == 0)),
          all(is.na(clientes$score_buro) == (clientes$tiene_credito == 0)))
cat("OK paso 1: filas, frecuencia al 100 % y faltantes = no aplica\n")

##=== pasos 2 y 3: target y distribuciones ====================================##
stopifnot(sum(clientes$abandono) == 1772, round(mean(clientes$abandono), 4) == 0.2215)
viejos <- clientes$abandono[clientes$recencia_dias > 90]
stopifnot(length(viejos) == 886, pct(mean(viejos)) == 59.7)
stopifnot(median(clientes$recencia_dias) == 15, round(mean(clientes$recencia_dias), 1) == 38.6,
          round(mean(clientes$recencia_dias)) == 39,
          median(clientes$monto_total) == 416650, round(mean(clientes$monto_total)) == 609632)
cat("OK pasos 2 y 3: 22,15 %, 886 con 59,7 %, medianas y medias\n")

##=== pasos 4 y 5: tramos y lo plano ==========================================##
rec <- clientes %>% mutate(t = cut(recencia_dias, c(-1, 7, 30, 60, 90, Inf))) %>% group_by(t) %>% summarise(r = mean(abandono))
ses <- clientes %>% mutate(t = cut(num_sesiones_ult30d, c(-1, 0, 3, 10, 20, Inf))) %>% group_by(t) %>% summarise(r = mean(abandono))
stopifnot(pct(rec$r[1]) == 12.4, pct(rec$r[5]) == 59.7, pct(ses$r[1]) == 56.5, pct(ses$r[5]) == 2.2)
rango <- function(v) { t <- clientes %>% group_by(.data[[v]]) %>% summarise(r = mean(abandono)); pct(range(t$r)) }
stopifnot(identical(rango("canal_adquisicion"), c(21.1, 23.9)), identical(rango("ciudad"), c(20.3, 23.6)))
todos <- unlist(lapply(c("canal_adquisicion", "ciudad", "genero", "os_principal", "kyc_nivel", "ocupacion"), rango))
stopifnot(round(min(todos)) == 20, round(max(todos)) == 25)
cat("OK pasos 4 y 5: 12,4 → 59,7; 56,5 → 2,2; canal y ciudad planos; demografía entre 20 y 25 %\n")

##=== paso 6: el cruce =========================================================##
stopifnot(round(cor(clientes$recencia_dias, clientes$num_sesiones_ult30d), 2) == -0.35)
cruce <- clientes %>%
         mutate(rec = cut(recencia_dias, c(-1, 7, 30, 90, Inf)), ses = cut(num_sesiones_ult30d, c(-1, 0, 3, 10, Inf))) %>%
         group_by(rec, ses) %>% summarise(n = n(), r = mean(abandono), .groups = "drop")
stopifnot(round(100 * cruce$r[1]) == 35, round(100 * cruce$r[13]) == 74, cruce$n[13] == 352,
          max(cruce$r[cruce$ses == levels(cruce$ses)[4]]) < 0.07, round(100 * min(cruce$r)) == 5)
## la hipótesis: cero sesiones y más de 30 días (31-90 y más de 90)
cero <- cruce %>% filter(ses == levels(cruce$ses)[1], rec %in% levels(cruce$rec)[3:4])
stopifnot(sum(cero$n) == 587, round(100 * min(cero$r)) == 46, round(100 * max(cero$r)) == 74)
cat("OK paso 6: -0,35; 35 % y 74 %; nunca más del 7 %; 587 clientes entre 46 y 74 %\n")

##=== paso 7: el anexo de campañas =============================================##
stopifnot(nrow(left_join(clientes, campanas, by = "cliente_id")) == 15081)
camp <- campanas %>% group_by(cliente_id) %>% summarise(nc = n(), nv = sum(convertido))
base <- left_join(clientes, camp, by = "cliente_id")
stopifnot(nrow(base) == 8000)
stopifnot(pct(mean(base$abandono[!is.na(base$nv) & base$nv > 0])) == 12.3,
          pct(mean(base$abandono[!is.na(base$nv) & base$nv == 0])) == 24.1)
cat("OK paso 7: 15.081 sin agregar, 8.000 agregando, 12,3 % frente a 24,1 %\n")

##=== paso 8: atípicos y fuga ==================================================##
g <- clientes$gasto_proximo_trim
lim <- quantile(g, 0.75) + 1.5 * (quantile(g, 0.75) - quantile(g, 0.25))
stopifnot(sum(g > lim) == 886, pct(mean(g > lim)) == 11.1, max(g) == 44083300)
fila <- clientes[which.max(g), ]
stopifnot(fila$antiguedad_meses == 1, fila$recencia_dias == 1, fila$frecuencia_tx == 72)
med <- clientes %>% group_by(abandono) %>% summarise(m = median(gasto_proximo_trim))
stopifnot(med$m[1] == 105050, med$m[2] == 23300)
cat("OK paso 8: 886 (11,1 %), el máximo de $44,1 M y la fuga (105.050 frente a 23.300)\n")

cat("\nVERIFICACIÓN COMPLETA: todas las cifras de la semana 6.\n")
