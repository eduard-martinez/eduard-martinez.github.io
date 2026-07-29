## R version 4.4.0
## Andrea del Pilar Guerrero
## Sesion 2 — Unidad 2: Manejo de datos con tidyverse
## Base: innovacion_empresas.csv (firmas)  +  sectores_agregado.csv

## Recorremos el ciclo completo del manejo de datos:
## importar -> diagnosticar -> limpiar -> transformar -> agrupar/resumir -> cruzar.
## Ejecute bloque por bloque (Ctrl/Cmd + Enter), lea la consola y complete
## los espacios "ahora usted".

##=== 0. Configuracion inicial ===##

## limpiamos el entorno para arrancar en blanco (buena practica al iniciar)
rm(list = ls())

## pacman instala lo que falte y carga todo de una:
## - rio      : importar/exportar datos
## - tidyverse: dplyr, stringr, tidyr, ... (mutate, filter, case_when, pipe)
## - janitor  : clean_names() para estandarizar nombres de columnas
## - skimr    : skim() para resumenes rapidos
install.packages("pacman") ## correr solo la primera vez
library(pacman)
p_load(rio, tidyverse, janitor, skimr)

## rutas relativas a la raiz del proyecto (regla de oro de la Unidad 1)
raw <- "data/raw/innovacion_empresas.csv"
sectores <- import("data/raw/sectores_agregado.csv")

##=== 1. Importar y diagnosticar (SIEMPRE el primer paso) ===##

## import() detecta el formato por la extension (.csv) y lo lee en un data.frame.
## clean_names() deja todos los nombres en snake_case, ordenado y sin sorpresas.
df <- import(raw) %>% clean_names()

## la radiografia de la base: hagala ANTES de tocar nada
head(df)          ## primeras filas
dim(df)           ## cuantas filas y columnas
glimpse(df)       ## tipo de cada variable y primeros valores (str mejorado)
skim(df)          ## resumen por variable: faltantes, n_unique, min/max, percentiles

## Diagnostico a ojo clinico (lea el skim de arriba a abajo buscando lo raro):
sum(duplicated(df))              ## hay filas duplicadas?
class(df$ventas_millones)        ## ventas llego como texto? (deberia ser numero)
class(df$num_empleados)          ## empleados tambien?
unique(df$tamano)                ## misma categoria escrita distinto?
unique(df$innova_producto)       ## codificacion mixta: Si/si/SI/1/0/No...

## Pregunta para la clase: ¿que columnas hay que arreglar y por que?


##=== 2. El pipe %>% (el conector que une los verbos) ===##

## sin pipe: se lee de adentro hacia afuera (incomodo)
head(arrange(filter(df, cod_sector == "C"), departamento))

## con pipe: se lee como una oracion -> "toma df, LUEGO filtra, LUEGO ordena,
## LUEGO muestra las primeras filas". Atajo en RStudio: Ctrl + Shift + M
df %>%
  filter(cod_sector == "C") %>%
  arrange(departamento) %>%
  head()


##=== 3. select() y rename() — elegir y renombrar columnas ===##

## quedarnos solo con las columnas del analisis (en el orden pedido)
df %>% select(id_empresa, cod_sector, ventas_millones, innova_producto) %>% head()

## todas EXCEPTO algunas (con el signo -)
df %>% select(-anio) %>% head()

## renombrar: nuevo_nombre = nombre_viejo (no cambia el contenido)
df %>% rename(ventas = ventas_millones, gasto_id = gasto_id_millones) %>% names()

## ahora usted: seleccione id_empresa, departamento y tamano
# df %>% select(_______________) %>% head()


##=== 4. filter() — quedarse con ciertas filas ===##

## OJO: comparar es SIEMPRE con == (un solo = asigna y da error)
df %>% filter(cod_sector == "C") %>% nrow()      ## firmas del sector C
df %>% filter(departamento == "Bogota D.C.") %>% nrow()

## combinar condiciones: & (ambas), | (al menos una), %in% (pertenece a un conjunto)
df %>% filter(cod_sector == "C" & departamento == "Bogota D.C.") %>% nrow()
df %>% filter(cod_sector %in% c("C", "G", "J")) %>% nrow()

## ahora usted:
## a) ¿cuantas firmas hay del sector I?
# _______________
## b) ¿cuantas firmas son de Atlantico O Cundinamarca? (pista: %in%)
# _______________


##=== 5. mutate() — crear/transformar columnas + limpieza de tipos ===##

## Aca juntamos transformacion y limpieza. Recordemos de la clase pasada:
## - num_empleados y ventas_millones llegaron como TEXTO
## - ventas_millones mezcla coma decimal ("857,3") y punto ("1166.2")
## - innova_* mezclan grafias (Si, si, SI, 1, 0, No, NO)

## los verbos NO modifican el original: hay que GUARDAR con <-
df <- df %>%
  mutate(## empleados: as.numeric convierte y deja NA lo que no es numero
         num_empleados = as.numeric(num_empleados),
         ## ventas: coma -> punto y luego a numero (lo que no convierta -> NA + warning)
         ventas_millones = as.numeric(str_replace(ventas_millones, ",", ".")),
         ## innova_producto normalizado a 1/0 con case_when (ramas planas, en orden)
         inn_prod = str_to_lower(str_trim(innova_producto)),
         inn_prod = case_when(inn_prod %in% c("1", "si") ~ 1,
                              inn_prod %in% c("0", "no") ~ 0,
                              TRUE ~ NA_real_))

## verificar SIEMPRE una conversion: ¿quedaron numericas? ¿cuantos NA se crearon?
class(df$ventas_millones)
sum(is.na(df$ventas_millones))
table(df$inn_prod, useNA = "ifany")

## clasificar en categorias con case_when
df <- df %>%
  mutate(tamano_ventas = case_when(ventas_millones <  500  ~ "chica",
                                   ventas_millones <  5000 ~ "media",
                                   ventas_millones >= 5000 ~ "grande",
                                   TRUE ~ NA_character_))
table(df$tamano_ventas, useNA = "ifany")

## clasificar en DOS categorias con ifelse
df <- df %>% mutate(exporta_bin = ifelse(str_to_lower(str_trim(exporta)) %in% c("si", "1"),
                                         "exporta", "no exporta"))
table(df$exporta_bin)

## ahora usted: cree ventas_log = log(ventas_millones)
# df <- df %>% mutate(_______________)


##=== 6. Limpieza fina: texto, faltantes y outliers ===##

## texto: estandarizar departamento (mayus/minus y espacios) para no inflar grupos
df <- df %>% mutate(departamento = str_squish(str_to_lower(departamento)))
n_distinct(df$departamento)   ## ¿cuantos departamentos distintos quedan?

## faltantes con sentido economico: gasto_id NA = la firma no invierte en I+D -> 0
## (decision defendible; documentada aqui en el script)
df <- df %>% mutate(gasto_id_millones = ifelse(is.na(gasto_id_millones), 0, gasto_id_millones))
sum(is.na(df$gasto_id_millones))   ## debe ser 0

## outliers: empleados implausibles (negativos o gigantes) -> NA
## ACTA DE LIMPIEZA: num_empleados <= 0 o > 5000 es implausible; sin evidencia
## para corregir el valor, se convierte en NA.
summary(df$num_empleados)
df <- df %>% mutate(num_empleados = ifelse(num_empleados <= 0 | num_empleados > 5000,
                                           NA, num_empleados))
summary(df$num_empleados)


##=== 7. group_by() + summarise() — el corazon de las descriptivas ===##

## resumen global (colapsa toda la base en una fila)
df %>% summarise(n_firmas    = n(),
                 ventas_prom = mean(ventas_millones, na.rm = TRUE),
                 tasa_innova = mean(inn_prod, na.rm = TRUE))

## resumen POR sector: una fila por grupo (aqui vive la heterogeneidad)
df %>%
  group_by(cod_sector) %>%
  summarise(n_firmas       = n(),
            ventas_mediana = median(ventas_millones, na.rm = TRUE),
            tasa_innova    = mean(inn_prod, na.rm = TRUE),   ## una proporcion
            .groups = "drop")

## atajos de conteo
df %>% count(departamento, sort = TRUE)                      ## frecuencias
df %>% group_by(cod_sector) %>%                               ## valores distintos
  summarise(n_dptos = n_distinct(departamento), .groups = "drop")

## ahora usted: ventas mediana por DEPARTAMENTO, ordenada de mayor a menor
# df %>%
#   group_by(_______) %>%
#   summarise(ventas_mediana = median(ventas_millones, na.rm = TRUE), .groups = "drop") %>%
#   arrange(desc(_______))


##=== 8. left_join() — cruzar la muestra con el referente nacional ===##

## segunda base: caracteristicas agregadas por sector (base limpia)
glimpse(sectores)

## tabla izquierda: indicadores de NUESTRA muestra por sector
resumen_sector <- df %>%
  group_by(cod_sector) %>%
  summarise(n_firmas       = n(),
            tasa_innova     = mean(inn_prod, na.rm = TRUE),
            ventas_mediana  = median(ventas_millones, na.rm = TRUE),
            .groups = "drop")

## la llave comun es cod_sector; left_join conserva TODAS las filas de la izquierda
cruce <- resumen_sector %>% left_join(sectores, by = "cod_sector")
cruce

## VERIFICACION OBLIGATORIA de todo join: ¿cambio el numero de filas?
nrow(resumen_sector)          ## antes
nrow(cruce)                   ## despues (deben ser iguales; si crece, llave duplicada)
nrow(resumen_sector) == nrow(cruce)

## el premio: comparar la tasa de innovacion de la muestra con la de referencia
cruce %>% select(cod_sector, tasa_innova, tasa_innovacion_sectorial)

## ahora usted: ¿algun sector quedo con NA tras el cruce? ¿por que?
# _______________


##=== 9. Errores comunes (provoque cada uno y LEA el mensaje) ===##

## a) = en vez de == dentro de filter (quite el # y ejecute)
# df %>% filter(cod_sector = "C")

## b) olvidar guardar con <- : la columna no queda
df %>% mutate(prueba = 1)
"prueba" %in% names(df)        ## FALSE: no se guardo

## c) filter descarta los NA en silencio (las firmas con NA en ventas desaparecen)
df %>% filter(ventas_millones > 500) %>% nrow()
df %>% filter(ventas_millones > 500 | is.na(ventas_millones)) %>% nrow()


##=== 10. (Opcional) Reorganizar la forma con tidyr ===##

## de largo a ancho: tabla compacta de tasa de innovacion por sector y tamano
tabla_ancha <- df %>%
  group_by(cod_sector, tamano_ventas) %>%
  summarise(tasa = mean(inn_prod, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(names_from = tamano_ventas, values_from = tasa)
tabla_ancha

## regla practica: largo para analizar/graficar; ancho para presentar.


##=== 11. Guardar la base limpia (nunca sobre el original) ===##

## la base procesada va en otra carpeta; el original queda intocable
# export(df, "data/processed/firmas_limpia.rds")
