## ============================================================
##  Curso Nivelatorio de R | CIENFI - Universidad Icesi
##  Unidad 4 | Tarea: La ecuacion de Mincer en la GEIH
## ============================================================
##
##  INSTRUCCIONES GENERALES
##  -  Complete cada seccion escribiendo el codigo que se pide.
##  -  Las INTERPRETACIONES se escriben como comentarios en este
##     mismo script (son parte de la calificacion).
##  -  Responda ademas el cuestionario de la unidad.
##  -  Trabaje de forma individual.
##  -  Uso de IA: en esta tarea hay un punto (P5) que consiste en
##     CRITICAR una interpretacion generada por IA. Para el resto,
##     la IA solo se permite para depurar errores de codigo.
##     Declare el uso al final.
##
##  Nombre:  _______________________________________________
##  Codigo:  _______________________________________________
## ============================================================

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, fixest, modelsummary)

## load data
geih <- import("datos/originales/geih_nivelacion.csv")

## ============================================================
##  PREGUNTA 1 | lm()
##  El retorno a la educacion
## ============================================================
##
##  Estime por MCO el modelo:  log(ingreso_laboral) ~ anios_educacion
##  Guarde en 'modelo_1' y mire summary().
##
##  Escriba su codigo aqui:

# modelo_1 <- lm(_______________ ~ _______________, data = geih)
# summary(modelo_1)

##  Interpretacion (complete la frase en el comentario):
##  ## Un anio adicional de educacion esta asociado a un ingreso
##  ## laboral ____% mayor, en promedio.

##  >> El coeficiente de anios_educacion (con 3 decimales) es la
##     respuesta a la Pregunta 1 del cuestionario.


## ============================================================
##  PREGUNTA 2 | Controles y dummies
##  La brecha de genero condicional
## ============================================================
##
##  Estime 'modelo_2' agregando edad y sexo al modelo anterior.
##
##  Escriba su codigo aqui:


##  a) ¿Cual es la categoria de REFERENCIA de sexo? (mire el nombre
##     del coeficiente en la salida)
##  b) Escriba la interpretacion del coeficiente de sexomujer como
##     comentario. Recuerde: para dummies grandes, el % exacto es
##     exp(coef) - 1.

# exp(coef(modelo_2)["sexomujer"]) - 1

##  >> El coeficiente de sexomujer (3 decimales) es la Pregunta 2,
##     y el % exacto de la brecha es la Pregunta 3 del cuestionario.


## ============================================================
##  PREGUNTA 3 | feols()
##  Efectos fijos de departamento y errores robustos
## ============================================================
##
##  Contexto: ¿y si la relacion educacion-ingreso solo refleja
##  diferencias ENTRE departamentos (Bogota vs. Choco)? Los efectos
##  fijos comparan personas DENTRO del mismo departamento.
##
##  Estime con fixest:
##    log(ingreso_laboral) ~ anios_educacion + edad + sexo,
##    con efectos fijos de departamento (| departamento)
##    y errores robustos (vcov = "hetero").
##  Guarde en 'modelo_3'.
##
##  Escriba su codigo aqui:

# modelo_3 <- feols(_______________ ~ _______________ | _______________,
#                   data = geih, vcov = "_______________")
# modelo_3

##  Interpretacion (comentario): ¿el retorno a la educacion cambia
##  mucho o poco respecto al modelo_2? ¿Que concluye?

##  >> El coeficiente de anios_educacion del modelo_3 (3 decimales)
##     es la respuesta a la Pregunta 4 del cuestionario.


## ============================================================
##  PREGUNTA 4 | msummary()
##  La tabla profesional
## ============================================================
##
##  Construya la tabla con los tres modelos y exportela a Word:
##    - Nombres legibles con coef_rename (Años de educación, Edad, Mujer)
##    - gof_map = c("nobs", "r.squared")
##    - stars = TRUE
##    - output = "output/tabla_mincer.docx"
##
##  Escriba su codigo aqui:

# modelos <- list("(1) Simple"      = modelo_1,
#                 "(2) + Controles" = modelo_2,
#                 "(3) + EF depto"  = modelo_3)
#
# msummary(modelos, ...)

##  >> ¿El numero de observaciones (N) cambia entre columnas?
##     ¿Por que si / por que no? Esa es la Pregunta 5 del cuestionario.


## ============================================================
##  PREGUNTA 5 | Critica a la IA
##  ¿Que esta mal en esta interpretacion?
## ============================================================
##
##  Contexto: le pedimos a un chatbot interpretar el modelo_2 y
##  respondio lo siguiente:
##
##  "El modelo demuestra que la educacion CAUSA un aumento del
##   ingreso del 10,4%. El efecto de ser mujer es -0,41 pesos.
##   Como el p-valor es menor a 0,05, el modelo es correcto y
##   la educacion es la variable mas importante del ingreso."
##
##  Identifique y explique TRES errores de esa interpretacion.
##  Escriba su respuesta como comentarios aqui (use la teoria de
##  la unidad: causalidad, unidades de las dummies, significancia
##  vs. magnitud, que dice y que NO dice un p-valor):

## Error 1: _______________________________________________
## Error 2: _______________________________________________
## Error 3: _______________________________________________

##  >> Esta respuesta se califica en el cuestionario (Pregunta 6).


## ============================================================
##  DECLARACION DE USO DE IA (obligatoria, aunque sea "No use IA")
##  Herramienta usada: ______________________________________
##  ¿Para que la uso?: ______________________________________
##  ¿Que verifico de lo que la IA le dijo?: _________________
## ============================================================

## ============================================================
##  FIN DEL SCRIPT
##  Guarde su archivo .R con el nombre: tarea4_SuCodigo.R
##  Entreguelo junto con el cuestionario resuelto.
## ============================================================
