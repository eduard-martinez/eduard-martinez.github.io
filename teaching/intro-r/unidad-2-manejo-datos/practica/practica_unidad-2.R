## Curso Nivelatorio de R (CIENFI - Icesi) — Unidad 2
## Practica: Manejo de datos con tidyverse

## Esta practica acompana la teoria de la Unidad 2. Trabajamos con
## la base de firmas del curso. Ejecutela por bloques y complete
## los espacios.

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, janitor, skimr)

##==: 1. Importar y diagnosticar (SIEMPRE el primer paso)

firmas <- import("datos/originales/innovacion_empresas.csv") %>%
          clean_names()

## la radiografia
glimpse(firmas)
skim(firmas)

## Pregunta: ¿que columnas llegaron como texto y deberian ser numero?
## ¿cuantos faltantes tiene gasto_id_millones?


##==: 2. El pipe %>%

## sin pipe (dificil de leer de adentro hacia afuera)
head(arrange(filter(firmas, cod_sector == "C"), departamento))

## con pipe (se lee como una oracion: toma firmas, LUEGO filtra,
## LUEGO ordena, LUEGO muestra)
firmas %>%
  filter(cod_sector == "C") %>%
  arrange(departamento) %>%
  head()


##==: 3. select() — columnas

## solo las columnas del analisis
firmas %>%
  select(id_empresa, cod_sector, ventas_millones, innova_producto) %>%
  head()

## ahora usted: seleccione id_empresa, departamento y tamano
# _______________


##==: 4. filter() — filas

## firmas del sector manufactura (codigo C)
firmas %>% filter(cod_sector == "C") %>% nrow()

## dos condiciones: sector C y departamento Bogota D.C.
firmas %>% filter(cod_sector == "C", departamento == "Bogota D.C.") %>% nrow()

## ahora usted:
## a) ¿cuantas firmas hay del sector J?
# _______________
## b) ¿cuantas firmas son de los sectores C, G o J? (pista: %in%)
# _______________


##==: 5. mutate() — nuevas variables

## OJO: ventas_millones llega como TEXTO con decimales mezclados
## (coma y punto). La conversion correcta: coma -> punto -> numero
firmas <- firmas %>%
          mutate(ventas_num = as.numeric(str_replace(ventas_millones, ",", ".")))

## verifique SIEMPRE una conversion: ¿cuantos NA se crearon?
sum(is.na(firmas$ventas_num))
summary(firmas$ventas_num)

## clasificar con case_when (ramas planas, se lee de arriba a abajo)
firmas <- firmas %>%
          mutate(tamano_ventas = case_when(ventas_num < 500  ~ "chica",
                                           ventas_num < 5000 ~ "media",
                                           ventas_num >= 5000 ~ "grande",
                                           T ~ NA_character_))

table(firmas$tamano_ventas, useNA = "ifany")

## ahora usted: cree ventas_log = log(ventas_num)
# firmas <- firmas %>% mutate(_______________)


##==: 6. group_by() + summarise() — el corazon de las descriptivas

## ventas medianas por sector
firmas %>%
  group_by(cod_sector) %>%
  summarise(n = n(),
            ventas_mediana = median(ventas_num, na.rm = T),
            .groups = "drop")

## ahora usted: mediana de ventas por DEPARTAMENTO, ordenada
## de mayor a menor (pista: arrange(desc(...)))
# _______________
# _______________
# _______________

## Pregunta: ¿por que la tabla de departamentos tiene categorias
## repetidas tipo "Bogota" y "BOGOTA"? ¿Como lo arreglaria?


##==: 7. Estandarizar texto (el arreglo de la pregunta anterior)

firmas <- firmas %>%
          mutate(departamento = str_squish(toupper(departamento)))

n_distinct(firmas$departamento)

## ahora usted: repita la tabla del punto 6 y compare
# _______________


##==: 8. left_join() — cruzar bases

sectores <- import("datos/originales/sectores_agregado.csv")
glimpse(sectores)

## la llave comun es cod_sector; el join trae las columnas del
## referente nacional a cada indicador de la muestra
tasa_sector <- firmas %>%
               group_by(cod_sector) %>%
               summarise(ventas_mediana = median(ventas_num, na.rm = T),
                         .groups = "drop") %>%
               left_join(sectores, by = "cod_sector")

tasa_sector

## verificacion de todo join: ¿cuantas filas antes y despues?
## (si el join multiplica filas, la llave esta duplicada)


##==: 9. Errores comunes (provoque cada uno y LEA el mensaje)

## a) = en vez de == dentro de filter (quite el # y ejecute)
# firmas %>% filter(cod_sector = "C")

## b) olvidar guardar: ¿quedo la columna? ¿por que no?
firmas %>% mutate(prueba = 1)
"prueba" %in% colnames(firmas)

## c) filter descarta los NA en silencio:
firmas %>% filter(ventas_num > 500) %>% nrow()
firmas %>% filter(ventas_num > 500 | is.na(ventas_num)) %>% nrow()
