## Curso Nivelatorio de R (CIENFI - Icesi) — Unidad 4
## Practica: Regresiones basicas con la GEIH

## Esta practica acompana la teoria de la Unidad 4. Complete los
## espacios y escriba las interpretaciones como comentarios.

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, fixest, modelsummary)

## load data
geih <- import("datos/originales/geih_nivelacion.csv")

##==: 1. Antes de regresar: MIRE los datos

## el grafico que motiva todo
ggplot(geih, aes(x = anios_educacion, y = log(ingreso_laboral))) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal()

## la correlacion (sin unidades, sin controles)
cor(geih$anios_educacion, log(geih$ingreso_laboral))


##==: 2. lm(): la primera regresion

## y ~ x se lee: "ingreso explicado por educacion"
modelo_1 <- lm(log(ingreso_laboral) ~ anios_educacion, data = geih)

## la salida completa: identifique Estimate, Std. Error, R-squared
summary(modelo_1)

## el modelo es un objeto: extraiga piezas
coef(modelo_1)
nobs(modelo_1)

## interpretacion (complete el comentario):
## un anio adicional de educacion esta asociado a un ingreso
## laboral ___% mayor, en promedio

## ahora usted: estime log(ingreso) ~ horas_semana y compare el R2
# modelo_h <- _______________
# summary(_______________)


##==: 3. Controles

## agregar edad: el retorno a la educacion ahora compara personas
## de la MISMA edad
modelo_2 <- lm(log(ingreso_laboral) ~ anios_educacion + edad, data = geih)
summary(modelo_2)

## Pregunta: ¿el coeficiente de educacion subio o bajo al controlar
## por edad? ¿Se le ocurre por que? (pista: correlacion negativa
## entre edad y educacion en Colombia: las cohortes jovenes estudian mas)
cor(geih$edad, geih$anios_educacion)


##==: 4. Dummies: variables categoricas en la regresion

## sexo es texto: R crea la dummy automaticamente
modelo_3 <- lm(log(ingreso_laboral) ~ anios_educacion + edad + sexo, data = geih)
summary(modelo_3)

## ¿quien es la referencia? mire el NOMBRE del coeficiente
## (sexomujer -> la referencia es hombre)

## para dummies grandes, el % exacto:
exp(coef(modelo_3)["sexomujer"]) - 1

## ahora usted: estime el modelo con nivel_educativo en lugar de
## anios_educacion. ¿Cuantas dummies crea R? ¿Cual es la referencia?
# modelo_niv <- _______________
# summary(_______________)


##==: 5. fixest: el estandar de economia aplicada

## efectos fijos de departamento + errores robustos
modelo_fe <- feols(log(ingreso_laboral) ~ anios_educacion + edad + sexo | departamento,
                   data = geih, vcov = "hetero")
modelo_fe

## compare el coeficiente de educacion con el del modelo_3:
## ¿cambio mucho? ¿que significa eso?

## ahora usted: cambie los errores a agrupados (cluster) por
## departamento con vcov = ~departamento. ¿Que pasa con los
## errores estandar?
# modelo_cl <- _______________
# _______________


##==: 6. La tabla profesional con modelsummary

modelos <- list("(1) Simple"      = modelo_1,
                "(2) + Edad"      = modelo_2,
                "(3) + Sexo"      = modelo_3,
                "(4) + EF depto"  = modelo_fe)

## en el Viewer
msummary(modelos,
         coef_rename = c(anios_educacion = "Años de educación",
                         edad = "Edad", sexomujer = "Mujer"),
         gof_map = c("nobs", "r.squared"),
         stars = TRUE)

## ahora usted: exporte la tabla a output/tabla_practica.docx
## (agregue el argumento output = )
# _______________


##==: 7. Lo que NO dice la regresion (tan importante como lo que dice)

## 1. "asociado a", NUNCA "causa": las personas con mas educacion
##    difieren en cosas que no observamos (habilidad, contexto)
## 2. significancia (las estrellas) NO es magnitud: con N = 21.821
##    casi todo es significativo; la pregunta es ¿cuantos pesos?
## 3. el R2 no valida el modelo: mide ajuste, no correcta especificacion

## ejercicio final: escriba en 3 lineas de comentario la lectura
## COMPLETA del coeficiente de educacion del modelo_fe (magnitud,
## unidades, condicion "controlando por...", y la advertencia causal)
## _______________
## _______________
## _______________
