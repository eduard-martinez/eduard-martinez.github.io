## Curso Nivelatorio de R (CIENFI - Icesi) — Unidad 1
## Practica: Fundamentos de R y flujo de trabajo

## Esta practica acompana la teoria de la Unidad 1. Ejecutela linea
## por linea (Ctrl/Cmd + Enter) y complete los espacios en blanco.

##==: 1. R como calculadora

## ejecute y observe la consola
2 + 2
10 / 3
2^10

## una tasa de crecimiento: (final - inicial) / inicial
(1350000 - 1200000) / 1200000

## comparaciones (devuelven TRUE o FALSE)
100 > 50
"cali" == "Cali"    # ¿por que da FALSE?


##==: 2. Objetos

## crear objetos con <-  (atajo: Alt + -)
salario_hora <- 6200
horas_mes    <- 192

## usar objetos
salario_mes <- salario_hora * horas_mes
salario_mes

## ahora usted: calcule el salario anual (12 meses + 1 prima)
# salario_anual <- _______________


## revise el panel Environment: ¿cuantos objetos hay?


##==: 3. Tipos de datos y las "lupas"

ingreso <- 1200000
ciudad  <- "Cali"
ocupado <- TRUE

class(ingreso)
class(ciudad)
class(ocupado)

## ¿que pasa si "sumamos" texto? (quite el # y ejecute; LEA el error)
# ingreso + ciudad


##==: 4. Vectores

## ingresos de 7 personas (COP)
ingresos <- c(1200000, 950000, 3500000, 800000, 1300000, 2100000, 600000)

## funciones sobre vectores
length(ingresos)
mean(ingresos)
median(ingresos)

## indexacion por posicion
ingresos[1]
ingresos[2:4]

## indexacion logica: la base conceptual del filter() de la Unidad 2
ingresos[ingresos > 1300000]
sum(ingresos < 1300000)

## ahora usted: ¿cual es el ingreso MAXIMO? ¿y el minimo?
# _______________
# _______________


##==: 5. Data frames

personas <- data.frame(
  id      = 1:5,
  sexo    = c("mujer", "hombre", "mujer", "hombre", "mujer"),
  edad    = c(28, 45, 35, 52, 23),
  ingreso = c(1500000, 2200000, 1800000, 3500000, 900000)
)

## la radiografia de toda base
str(personas)
head(personas)
dim(personas)

## columnas con $
personas$ingreso
mean(personas$ingreso)

## filas con [condicion, ]
personas[personas$edad > 40, ]

## ahora usted:
## a) extraiga la columna sexo
# _______________
## b) ¿cuantas mujeres hay? (pista: sum(condicion))
# _______________
## c) muestre las personas con ingreso mayor al promedio
# _______________


##==: 6. NA: el dato faltante

ingresos_na <- c(1200000, 800000, NA, 2500000)

mean(ingresos_na)                 # ¿que devuelve? ¿por que?
mean(ingresos_na, na.rm = TRUE)   # la solucion

sum(is.na(ingresos_na))           # ¿cuantos faltantes hay?


##==: 7. Errores y warnings (aprenda a leerlos)

## ERROR: objeto que no existe (lea el mensaje completo)
# tasa_informalidad

## ERROR: argumento mal escrito
# mean(ingresos, naa.rm = TRUE)

## WARNING: el codigo corre, pero avisa
sqrt(-4)

## la ayuda es su primera fuente (antes que cualquier IA)
?mean


##==: 8. Paquetes

## instalar UNA vez (en la consola, no en el script):
# install.packages("pacman")

## el estandar del curso: p_load carga e instala si falta
require(pacman)
p_load(dplyr)

## verifique en el panel Packages que dplyr quedo cargado


##==: 9. Su proyecto (se hace en RStudio, no con codigo)

## 1. File > New Project > New Directory > nivelacion_r
## 2. Cree las carpetas: datos/originales, datos/procesados,
##    scripts, output
## 3. Guarde este script en scripts/
## 4. Verifique el working directory:
getwd()

## regla de oro: rutas RELATIVAS a la raiz del proyecto
## bien:  read.csv("datos/originales/base.csv")
## mal:   read.csv("C:/Users/minombre/Desktop/base.csv")
