## ============================================================
##  Curso Nivelatorio de R | CIENFI - Universidad Icesi
##  Unidad 3 | Tarea: Visualizacion y descriptivas con la GEIH
## ============================================================
##
##  INSTRUCCIONES GENERALES
##  -  Complete cada seccion escribiendo el codigo que se pide.
##  -  Observe cada grafico y responda el cuestionario de la
##     unidad (cuestionario_unidad-3.md / plataforma del curso).
##  -  No borre los comentarios: son parte del enunciado.
##  -  Trabaje de forma individual.
##  -  Uso de IA: permitido para MEJORAR graficos que usted ya
##     construyo (titulos, escalas, colores). Verifique que la IA
##     no cambie los DATOS que se grafican. Declare el uso al final.
##
##  Nombre:  _______________________________________________
##  Codigo:  _______________________________________________
## ============================================================

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, skimr)

## load data (extracto docente de la GEIH: 21.821 ocupados)
geih <- import("datos/originales/geih_nivelacion.csv")
glimpse(geih)

## ============================================================
##  PREGUNTA 1 | geom_histogram()
##  ¿Niveles o logaritmos?
## ============================================================
##
##  Contexto: antes de comparar ingresos entre grupos hay que
##  entender su distribucion.
##
##  Construya DOS histogramas:
##    a) del ingreso_laboral en niveles
##    b) de log(ingreso_laboral)
##  Ambos con: bins = 60, titulo descriptivo y ejes etiquetados.
##
##  Escriba su codigo aqui:


##  >> ¿Cual de las dos distribuciones es aproximadamente simetrica?
##     Esa es la respuesta a la Pregunta 1 del cuestionario.


## ============================================================
##  PREGUNTA 2 | geom_boxplot()
##  Ingresos por sexo
## ============================================================
##
##  Contexto: la brecha de ingresos por sexo es uno de los hechos
##  mas documentados de la economia laboral. Empecemos por verla.
##
##  Construya un boxplot donde:
##    - El eje X sea 'sexo'
##    - El eje Y sea log(ingreso_laboral)
##    - El relleno (fill) cambie segun el sexo
##    - Titulo: "Ingreso laboral por sexo"
##    - Ejes etiquetados: "Sexo" y "Log del ingreso"
##
##  Escriba su codigo aqui:


##  >> ¿Que grupo tiene la mediana (linea central de la caja) mas
##     alta? Esa es la respuesta a la Pregunta 2.


## ============================================================
##  PREGUNTA 3 | group_by() + geom_col()
##  Ingreso mediano por nivel educativo
## ============================================================
##
##  Contexto: ¿cuanto "paga" cada nivel educativo? Como el ingreso
##  tiene outliers, usamos la MEDIANA, no el promedio.
##
##  PASO 1: con dplyr, calcule el ingreso MEDIANO por
##          nivel_educativo. Guarde en 'ingreso_nivel'.
##
##  Escriba su codigo aqui:

# ingreso_nivel <- geih %>%
#                  group_by(_______________) %>%
#                  summarise(ingreso_mediano = median(_______________),
#                            .groups = "drop")

##  PASO 2: grafique con geom_col():
##    - Eje X: nivel_educativo ORDENADO por ingreso (use reorder())
##    - Eje Y: ingreso_mediano
##    - Sin leyenda (show.legend = FALSE si usa fill)
##    - Titulo, ejes y caption con la fuente:
##      "Fuente: GEIH (DANE), extracto docente"
##
##  Escriba su codigo aqui:


##  >> ¿Cual es el ingreso MEDIANO del nivel 'superior' (en COP)?
##     Esa es la respuesta a la Pregunta 3.


## ============================================================
##  PREGUNTA 4 | geom_point() + geom_smooth()
##  Educacion e ingreso
## ============================================================
##
##  Contexto: el grafico que anticipa la Unidad 4.
##
##  Construya un diagrama de dispersion donde:
##    - Eje X: anios_educacion
##    - Eje Y: log(ingreso_laboral)
##    - Puntos con transparencia alta (alpha = 0.05, son 21 mil)
##    - Una recta ajustada: geom_smooth(method = "lm")
##    - Titulo y ejes etiquetados
##
##  Escriba tu codigo aqui:


##  >> ¿La relacion es positiva o negativa? Esa es la Pregunta 4.


## ============================================================
##  PREGUNTA 5 | Tabla de descriptivas por grupo
##  La brecha en numeros
## ============================================================
##
##  Contexto: todo grafico de un informe va acompanado de la tabla.
##
##  Calcule por sexo: media, mediana, horas promedio (horas_semana)
##  y numero de observaciones. Guarde en 'descriptivas_sexo'.
##
##  Escriba su codigo aqui:

# descriptivas_sexo <- geih %>%
#                      group_by(____) %>%
#                      summarise(media   = ____(ingreso_laboral),
#                                mediana = ____(ingreso_laboral),
#                                horas   = mean(____),
#                                n       = _(),
#                                .groups = "drop")

##  >> ¿Cual es la MEDIANA del ingreso de las mujeres (en COP)?
##     Esa es la Pregunta 5 del cuestionario.


## ============================================================
##  PREGUNTA 6 | ggsave()
##  Exportar como en un proyecto real
## ============================================================
##
##  Guarde el grafico de la PREGUNTA 3 en su carpeta output/ del
##  proyecto: output/ingreso_por_nivel.png (ancho 8, alto 5,
##  dpi 300). Pista: guarde el grafico en un objeto y luego
##  ggsave("output/ingreso_por_nivel.png", objeto, ...).
##
##  Escriba su codigo aqui:


##  >> Verifique en el panel Files que el archivo existe. En la
##     Pregunta 6 del cuestionario debe pegar la RUTA del archivo
##     dentro de su proyecto.


## ============================================================
##  DECLARACION DE USO DE IA (obligatoria, aunque sea "No use IA")
##  Herramienta usada: ______________________________________
##  ¿Para que la uso?: ______________________________________
##  ¿Cambio la IA algo de los datos graficados? ¿Como lo verifico?:
##  _________________________________________________________
## ============================================================

## ============================================================
##  FIN DEL SCRIPT
##  Guarde su archivo .R con el nombre: tarea3_SuCodigo.R
##  Entreguelo junto con el cuestionario resuelto.
## ============================================================
