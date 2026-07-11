## ============================================================
##  Curso Nivelatorio de R | CIENFI - Universidad Icesi
##  Unidad 1 | Tarea: Primer proyecto y diagnostico inicial
## ============================================================
##
##  INSTRUCCIONES GENERALES
##  -  Antes de empezar, complete el PUNTO 0 (crear su proyecto).
##  -  Complete cada seccion escribiendo el codigo que se pide.
##  -  Observe los resultados y responda el cuestionario de la
##     unidad (cuestionario_unidad-1.md / plataforma del curso).
##  -  No borre los comentarios: son parte del enunciado.
##  -  Trabaje de forma individual.
##  -  Uso de IA: para esta tarea, permitido SOLO para explicar
##     errores despues de intentarlo usted primero (ver la Guia de
##     uso de IA del curso). Declare el uso al final del script.
##
##  Nombre:  _______________________________________________
##  Codigo:  _______________________________________________
## ============================================================

## ============================================================
##  PUNTO 0 | Su proyecto de RStudio (no se entrega, se usa)
## ============================================================
##
##  a) Cree un proyecto nuevo: File > New Project > New Directory,
##     con el nombre: nivelacion_r
##  b) Dentro del proyecto cree las carpetas:
##       datos/originales , datos/procesados , scripts , output
##  c) Copie innovacion_empresas.csv (descargada de la plataforma)
##     en datos/originales/
##  d) Guarde ESTE script en la carpeta scripts/
##
##  Todo el codigo de abajo asume que usted abrio el proyecto
##  (.Rproj) y que las rutas son relativas a su raiz.


## ============================================================
##  PREGUNTA 1 | Vectores
##  Ingresos de 7 personas ocupadas
## ============================================================
##
##  Contexto: estos son los ingresos mensuales (COP) de 7 personas.
##  Antes de trabajar con bases completas, practiquemos con un vector.

ingresos <- c(1200000, 950000, 3500000, 800000, 1300000, 2100000, 600000)

##  a) Calcule la MEDIANA de los ingresos.
##  Escriba su codigo aqui:


##  b) Calcule el PROMEDIO de los ingresos.


##  c) ¿Cuantas personas ganan MAS que el promedio?
##     Pista: sum(vector > valor) cuenta cuantos cumplen la condicion.


##  >> La mediana (a) y el conteo (c) son las respuestas a las
##     Preguntas 1 y 2 del cuestionario. Observe ademas: ¿por que
##     el promedio es mayor que la mediana?


## ============================================================
##  PREGUNTA 2 | Data frames
##  Ingreso per capita de 6 hogares
## ============================================================
##
##  Contexto: una mini encuesta de hogares. Cada fila es un hogar.

hogares <- data.frame(
  id_hogar = 1:6,
  personas = c(4, 2, 1, 5, 3, 2),
  ingreso_hogar = c(2400000, 1800000, 950000, 3000000, 1500000, 4200000)
)

##  a) Cree la columna ingreso_pc = ingreso_hogar / personas
##     (recuerde: hogares$nueva_columna <- ...)
##  Escriba su codigo aqui:


##  b) ¿Cuantos hogares tienen ingreso per capita MENOR a 600000?


##  c) Muestre las filas de esos hogares usando indexacion logica:
##     hogares[condicion, ]


##  >> El conteo (b) es la respuesta a la Pregunta 3 del cuestionario.


## ============================================================
##  PREGUNTA 3 | Importar la base del curso
##  Primer contacto con datos reales (y sucios)
## ============================================================
##
##  Contexto: esta es la base de firmas que limpiaremos en la
##  Unidad 2. Hoy solo la importamos y la diagnosticamos.

firmas <- read.csv("datos/originales/innovacion_empresas.csv")

##  a) ¿Cuantas filas y cuantas columnas tiene la base?
##     Pista: nrow(), ncol() o dim()
##  Escriba su codigo aqui:


##  >> Las dimensiones son la respuesta a la Pregunta 4 del cuestionario.


## ============================================================
##  PREGUNTA 4 | Diagnostico de tipos con str()
##  ¿Que columnas llegaron "mal leidas"?
## ============================================================
##
##  Contexto: en una base recien importada, el primer diagnostico
##  es SIEMPRE revisar los tipos de cada columna.
##
##  a) Aplique str() a la base firmas y observe la salida.
##  Escriba su codigo aqui:


##  b) Verifique con class() el tipo de num_empleados y de
##     gasto_id_millones.


##  >> ¿De que tipo quedo num_empleados? ¿Por que cree que R no la
##     leyo como numero? (mire algunos valores con head()).
##     Esa es la Pregunta 5 del cuestionario.


## ============================================================
##  PREGUNTA 5 | Valores faltantes
##  El NA como protagonista de los datos reales
## ============================================================
##
##  a) ¿Cuantos NA tiene la columna gasto_id_millones?
##     Pista: sum(is.na(columna))
##  Escriba su codigo aqui:


##  b) Calcule el promedio de gasto_id_millones. ¿Que devuelve?
##     Corrijalo con el argumento na.rm = TRUE.


##  >> El numero de NA (a) es la respuesta a la Pregunta 6 del
##     cuestionario. Piense: ¿estos NA son un ERROR de la base o
##     tienen sentido economico? (¿que firmas no reportan gasto en I+D?)


## ============================================================
##  DECLARACION DE USO DE IA (obligatoria, aunque sea "No use IA")
##  Herramienta usada: ______________________________________
##  ¿Para que la uso?: ______________________________________
##  ¿Como verifico lo que le sugirio?: ______________________
## ============================================================

## ============================================================
##  FIN DEL SCRIPT
##  Guarde su archivo .R con el nombre: tarea1_SuCodigo.R
##  Entreguelo junto con el cuestionario resuelto.
## ============================================================
