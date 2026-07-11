## ============================================================
##  Curso Nivelatorio de R | CIENFI - Universidad Icesi
##  Unidad 2 | Tarea: Limpieza de la base de innovacion
## ============================================================
##
##  INSTRUCCIONES GENERALES
##  -  Complete cada seccion escribiendo el codigo que se pide.
##  -  Observe los resultados y responda el cuestionario de la
##     unidad (cuestionario_unidad-2.md / plataforma del curso).
##  -  No borre los comentarios: son parte del enunciado.
##  -  Trabaje de forma individual.
##  -  Uso de IA: permitido para DEPURAR su codigo despues de
##     intentarlo (nivel "colaboracion" de la guia del curso).
##     Todo lo que la IA le sugiera debe VERIFICARLO con codigo
##     (nrow, table, summary). Declare el uso al final.
##
##  Nombre:  _______________________________________________
##  Codigo:  _______________________________________________
## ============================================================

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, janitor, skimr)

## load data (desde su proyecto: datos/originales/)
firmas_raw <- import("datos/originales/innovacion_empresas.csv") %>%
              clean_names()

## ============================================================
##  PREGUNTA 1 | skim()
##  Radiografia inicial de la base
## ============================================================
##
##  Contexto: nunca limpie a ciegas. Primero el diagnostico:
##  ¿cuantas filas? ¿que tipos? ¿cuantos faltantes por columna?
##
##  Aplique glimpse() y skim() a firmas_raw y observe la salida.
##
##  Escriba su codigo aqui:


##  >> ¿Cuantas filas tiene la base cruda? Esa es la respuesta a
##     la Pregunta 1 del cuestionario.


## ============================================================
##  PREGUNTA 2 | distinct()
##  Filas duplicadas
## ============================================================
##
##  Contexto: el sistema registro algunas firmas mas de una vez.
##  Si no las elimina, contaran doble en todos los indicadores.
##
##  PASO 1: aplique distinct() a firmas_raw y guarde en firmas.
##  PASO 2: calcule cuantas filas se eliminaron.
##
##  Escriba su codigo aqui:

# firmas <- _______________
# nrow(firmas_raw) - nrow(_______________)

##  >> La diferencia de filas es la respuesta a la Pregunta 2.


## ============================================================
##  PREGUNTA 3 | toupper() + str_squish()
##  Estandarizar categorias de texto
## ============================================================
##
##  Contexto: sector_nombre tiene el mismo sector escrito de varias
##  formas (mayusculas, espacios, sinonimos). Cuente las variantes,
##  estandarice mayusculas y espacios, y vuelva a contar.
##
##  PASO 1: cuente las categorias de sector_nombre en firmas
##          (pista: n_distinct()).
##  PASO 2: estandarice con mutate(): toupper() y str_squish()
##          sobre sector_nombre, departamento y tamano (tamano
##          en minusculas con tolower()).
##  PASO 3: vuelva a contar las categorias de sector_nombre.
##
##  Escriba su codigo aqui:

# n_distinct(firmas$_______________)
#
# firmas <- firmas %>%
#           mutate(sector_nombre = str_squish(toupper(_______________)),
#                  departamento  = _______________,
#                  tamano        = _______________)
#
# n_distinct(firmas$sector_nombre)

##  >> ¿Cuantas categorias QUEDAN despues de estandarizar? Esa es
##     la Pregunta 3. Observe que NO llegan a 7: los SINONIMOS
##     ("MANUFACTURA" vs "INDUSTRIA MANUFACTURERA") no se arreglan
##     con mayusculas. Por eso, de aqui en adelante agrupamos por
##     la llave limpia cod_sector (Pregunta 6).


## ============================================================
##  PREGUNTA 4 | Corregir tipos de datos
##  Texto que deberia ser numero
## ============================================================
##
##  Contexto: num_empleados llega como texto (trae "ND", "N/D",
##  separador de miles "1.200", negativos y ceros imposibles).
##  ventas_millones mezcla decimales con coma ("857,3") y con
##  punto ("1166.2"), y trae ceros sospechosos.
##
##  PASO 1: limpie num_empleados:
##          - toupper() + str_squish()
##          - "ND" y "N/D" -> NA (pista: na_if())
##          - quite el punto de miles (str_replace(x, "\\.", ""))
##          - convierta con as.numeric()
##          - valores <= 0 -> NA (imposibles)
##  PASO 2: limpie ventas_millones:
##          - reemplace la coma por punto (str_replace(x, ",", "."))
##          - convierta con as.numeric()
##          - ceros -> NA (una firma sin ventas es un error de captura)
##  PASO 3: cuente los NA de num_empleados y calcule la MEDIANA
##          de ventas_millones (con na.rm = TRUE).
##
##  Escriba su codigo aqui:

# firmas <- firmas %>%
#           mutate(num_empleados = str_squish(toupper(num_empleados)),
#                  num_empleados = na_if(na_if(num_empleados, "__"), "___"),
#                  num_empleados = as.numeric(str_replace(num_empleados, "\\.", "")),
#                  num_empleados = ifelse(num_empleados <= 0, ___, num_empleados),
#                  ventas_millones = as.numeric(str_replace(ventas_millones, ",", ".")),
#                  ventas_millones = ifelse(ventas_millones == 0, ___, ventas_millones))
#
# sum(is.na(firmas$_______________))
# median(firmas$ventas_millones, na.rm = ___)

##  >> El numero de NA de num_empleados es la Pregunta 4, y la
##     mediana de ventas es la Pregunta 5 del cuestionario.


## ============================================================
##  PREGUNTA 5 | case_when / %in%
##  El indicador 'innovadora'
## ============================================================
##
##  Contexto: las tres columnas innova_* mezclan "Si/si/SI/1" y
##  "No/no/NO/0" con espacios. Una firma es innovadora si innovo
##  en producto O en proceso O en lo organizacional.
##
##  PASO 1: estandarice las tres columnas innova_* con
##          str_squish(toupper()).
##  PASO 2: cree innovadora = TRUE si alguna de las tres esta en
##          c("SI", "1")  (pista: %in% y el operador |).
##  PASO 3: calcule la tasa de innovacion de la muestra
##          (pista: mean() de una columna logica).
##
##  Escriba su codigo aqui:


##  >> La tasa de innovacion (en %) es la Pregunta 6 del cuestionario.


## ============================================================
##  PREGUNTA 6 | group_by() + summarise()
##  Indicadores por sector
## ============================================================
##
##  Contexto: la pregunta del area de politica: ¿que sectores de la
##  muestra innovan mas?
##
##  Calcule por cod_sector: numero de firmas (n()), tasa de
##  innovacion (mean(innovadora)) y mediana de ventas. Use
##  .groups = "drop" y ordene de mayor a menor tasa.
##
##  Escriba su codigo aqui:

# resumen_sector <- firmas %>%
#                   group_by(_______________) %>%
#                   summarise(n_firmas     = ___(),
#                             tasa_muestra = mean(_______________),
#                             ventas_med   = median(ventas_millones, na.rm = T),
#                             .groups = "drop") %>%
#                   arrange(desc(_______________))

##  >> ¿Que sector (codigo) tiene la MAYOR tasa de innovacion?
##     Esa es la Pregunta 7 del cuestionario.


## ============================================================
##  PREGUNTA 7 | left_join()
##  La muestra frente al referente nacional
## ============================================================
##
##  Contexto: sectores_agregado.csv trae la tasa de innovacion de
##  REFERENCIA de cada sector. Cruce sus indicadores con esa base
##  y compare.
##
##  PASO 1: importe datos/originales/sectores_agregado.csv.
##  PASO 2: una resumen_sector con esa base por cod_sector
##          (left_join) y cree brecha = tasa_muestra -
##          tasa_innovacion_sectorial.
##  PASO 3: ordene por la brecha.
##
##  Escriba su codigo aqui:


##  >> ¿En que sector la muestra SUPERA por mas al referente
##     nacional? Esa es la Pregunta 8 del cuestionario.
##     Verificacion importante: ¿cuantas filas tiene el resultado
##     del join? ¿Por que debe seguir siendo 7?


## ============================================================
##  DECLARACION DE USO DE IA (obligatoria, aunque sea "No use IA")
##  Herramienta usada: ______________________________________
##  ¿Para que la uso?: ______________________________________
##  ¿Que le sugirio y como lo VERIFICO?: ____________________
## ============================================================

## ============================================================
##  FIN DEL SCRIPT
##  Guarde su archivo .R con el nombre: tarea2_SuCodigo.R
##  Entreguelo junto con el cuestionario resuelto.
## ============================================================
