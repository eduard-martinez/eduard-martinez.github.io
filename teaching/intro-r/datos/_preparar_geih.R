##============================================================================##
# _preparar_geih.R  —  Extracto docente de la GEIH para el curso nivelatorio
#------------------------------------------------------------------------------#
# Que lee y que produce, con el GRANO de cada output:
#   - lee: GEIH cabeceras, enero (Personas y Ocupados, formato DANE crudo)
#          desde recursos/otros/4_data_manipulation_dyplr/input/
#   - produce: geih_nivelacion.csv  (grano: persona ocupada con ingreso > 0;
#              variables renombradas para uso docente en la Unidad 4)
#
# Correr con el working directory en la raiz del repo (r_project/).
# Datos ficticios NO: es un extracto real de la GEIH (DANE) con fines docentes.
##============================================================================##

## configuracion inicial
rm(list = ls())
require(pacman)
p_load(dplyr, rio, janitor)

## path
raw <- "recursos/otros/4_data_manipulation_dyplr/input"
out <- "version_final_curso/datos"

##============================================================================##
##=== 1. Importar personas y ocupados  (grano: persona / persona ocupada)  ===##
##============================================================================##

## caracteristicas generales (una fila por persona)
personas <- import(file.path(raw, "Enero - Cabecera - Caracteristicas generales (Personas).csv"),
                   sep = ";", dec = ",") %>%
            transmute(directorio = DIRECTORIO,
                      secuencia  = SECUENCIA_P,
                      orden      = ORDEN,
                      sexo       = ifelse(P6020 == 1, "hombre", "mujer"),
                      edad       = P6040,
                      anios_educacion = ESC,
                      nivel_educativo = case_when(P6210 == 1 ~ "ninguno",
                                                  P6210 == 2 ~ "preescolar",
                                                  P6210 == 3 ~ "primaria",
                                                  P6210 == 4 ~ "secundaria",
                                                  P6210 == 5 ~ "media",
                                                  P6210 == 6 ~ "superior",
                                                  T ~ NA_character_),
                      dpto = DPTO)

## ocupados (una fila por persona ocupada)
ocupados <- import(file.path(raw, "Enero - Cabecera - Ocupados.csv"),
                   sep = ";", dec = ",") %>%
            transmute(directorio = DIRECTORIO,
                      secuencia  = SECUENCIA_P,
                      orden      = ORDEN,
                      ingreso_laboral = INGLABO,
                      horas_semana    = P6800)

##============================================================================##
##=== 2. Cruzar y filtrar  (grano: persona ocupada, 18-65, ingreso > 0)    ===##
##============================================================================##

## nombres de departamento (codigos divipola de las 24 cabeceras GEIH)
dpto_nombres <- c("05" = "Antioquia",       "08" = "Atlantico",   "11" = "Bogota D.C.",
                  "13" = "Bolivar",         "15" = "Boyaca",      "17" = "Caldas",
                  "18" = "Caqueta",         "19" = "Cauca",       "20" = "Cesar",
                  "23" = "Cordoba",         "25" = "Cundinamarca","27" = "Choco",
                  "41" = "Huila",           "44" = "La Guajira",  "47" = "Magdalena",
                  "50" = "Meta",            "52" = "Narino",      "54" = "N. de Santander",
                  "63" = "Quindio",         "66" = "Risaralda",   "68" = "Santander",
                  "70" = "Sucre",           "73" = "Tolima",      "76" = "Valle del Cauca")

## cruce por llave persona y filtros docentes
geih <- ocupados %>%
        left_join(personas, by = c("directorio", "secuencia", "orden")) %>%
        filter(edad >= 18, edad <= 65,
               !is.na(ingreso_laboral), ingreso_laboral > 0,
               !is.na(anios_educacion)) %>%
        mutate(id = row_number(),
               departamento = dpto_nombres[sprintf("%02d", as.numeric(dpto))]) %>%
        select(id, sexo, edad, anios_educacion, nivel_educativo,
               departamento, ingreso_laboral, horas_semana)

## export data
export(geih, file.path(out, "geih_nivelacion.csv"))

## clean
rm(personas, ocupados)
