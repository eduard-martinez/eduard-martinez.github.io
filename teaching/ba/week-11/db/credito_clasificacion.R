## ============================================================
##  Introduccion al Business Analytics (06278-ECO)
##  Semana 11 | Script de generacion de datos
##  credito_clasificacion.csv
##  Universidad Icesi | Periodo 2026-01
## ============================================================
##
##  DESCRIPCION
##  Este script genera el dataset sintetico de solicitudes de
##  credito utilizado en la practica guiada de la Semana 11.
##  El dataset simula 300 solicitudes con caracteristicas del
##  solicitante y una decision final: Aprobado o Rechazado.
##
##  VARIABLES GENERADAS
##  - ingreso_m      : ingreso mensual en millones de pesos
##  - historial      : historial crediticio (1 = positivo, 0 = negativo)
##  - deuda_actual   : deuda vigente en millones de pesos
##  - antiguedad_lab : antiguedad laboral en anos
##  - edad           : edad del solicitante en anos
##  - decision       : variable de resultado (Aprobado / Rechazado)
##
##  LOGICA DE GENERACION
##  Aprobados (160 casos): ingresos altos, historial mayormente
##    positivo, deuda baja, mayor antiguedad laboral.
##  Rechazados (140 casos): ingresos bajos, historial mayormente
##    negativo, deuda alta, poca antiguedad laboral.
##  Se agrega ruido gaussiano para evitar separacion perfecta.
## ============================================================


##==: Configuracion inicial / Initial setup
rm(list = ls())      # limpiar entorno / clean environment
set.seed(2025)       # semilla para reproducibilidad / seed for reproducibility


##==: Parametros del dataset / Dataset parameters
n_aprobados  <- 160
n_rechazados <- 140
n_total      <- n_aprobados + n_rechazados


##==: Generar solicitudes APROBADAS / Generate APPROVED applications
ingreso_apr      <- round(rnorm(n = n_aprobados, mean = 5.5, sd = 1.2), 2)
historial_apr    <- rbinom(n = n_aprobados, size = 1, prob = 0.85)
deuda_apr        <- round(rnorm(n = n_aprobados, mean = 8,   sd = 3.0), 2)
antiguedad_apr   <- round(rnorm(n = n_aprobados, mean = 6,   sd = 3.0), 1)
edad_apr         <- round(rnorm(n = n_aprobados, mean = 38,  sd = 8.0), 0)
decision_apr     <- rep("Aprobado", n_aprobados)


##==: Generar solicitudes RECHAZADAS / Generate REJECTED applications
ingreso_rec      <- round(rnorm(n = n_rechazados, mean = 2.8, sd = 1.0), 2)
historial_rec    <- rbinom(n = n_rechazados, size = 1, prob = 0.25)
deuda_rec        <- round(rnorm(n = n_rechazados, mean = 18,  sd = 5.0), 2)
antiguedad_rec   <- round(rnorm(n = n_rechazados, mean = 2,   sd = 1.5), 1)
edad_rec         <- round(rnorm(n = n_rechazados, mean = 30,  sd = 7.0), 0)
decision_rec     <- rep("Rechazado", n_rechazados)


##==: Combinar en un solo data frame / Combine into one data frame
credito_raw <- data.frame(
  ingreso_m      = c(ingreso_apr,    ingreso_rec),
  historial      = c(historial_apr,  historial_rec),
  deuda_actual   = c(deuda_apr,      deuda_rec),
  antiguedad_lab = c(antiguedad_apr, antiguedad_rec),
  edad           = c(edad_apr,       edad_rec),
  decision       = c(decision_apr,   decision_rec)
)


##==: Aplicar limites razonables (clamp) / Apply reasonable bounds
credito_raw$ingreso_m      <- pmax(0.5,  pmin(15.0, credito_raw$ingreso_m))
credito_raw$deuda_actual   <- pmax(0.0,  pmin(50.0, credito_raw$deuda_actual))
credito_raw$antiguedad_lab <- pmax(0.0,  pmin(30.0, credito_raw$antiguedad_lab))
credito_raw$edad           <- pmax(18,   pmin(70,   credito_raw$edad))


##==: Mezclar filas aleatoriamente / Shuffle rows randomly
idx_shuffle <- sample(x = 1:n_total, size = n_total, replace = FALSE)
credito     <- credito_raw[idx_shuffle, ]

## Resetear indices de fila / Reset row indices
rownames(credito) <- NULL


##==: Verificar el dataset / Verify dataset
nrow(credito)
ncol(credito)
head(credito)

## Distribucion de la variable de resultado / Target variable distribution
table(credito$decision)
prop.table(table(credito$decision))


##==: Exportar a CSV / Export to CSV
## Ajusta la ruta segun tu directorio de trabajo / Adjust path as needed
write.csv(x         = credito,
          file      = "credito_clasificacion.csv",
          row.names = FALSE)

## Verificar que el archivo se genero correctamente / Verify file was created
credito_check <- read.csv("credito_clasificacion.csv")
nrow(credito_check)
colnames(credito_check)

## clean
rm("antiguedad_apr","antiguedad_rec","credito_check","credito_raw","decision_apr","decision_rec","deuda_apr",    
     "deuda_rec","edad_apr","edad_rec","historial_apr","historial_rec","idx_shuffle","ingreso_apr",
     "ingreso_rec","n_aprobados","n_rechazados","n_total")

## ============================================================
##  FIN DEL SCRIPT
##  El archivo credito_clasificacion.csv queda listo para subir
##  a: https://eduard-martinez.github.io/databases/ba/
## ============================================================
