## R version 4.4.0
## Last run 2026-07-21

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
firmas <- import("data/raw/innovacion_empresas.csv") %>%
          clean_names()

##==: 2. Eliminar filas duplicadas :==##
firmas <- firmas %>% distinct()

##==: 3. Corregir tipos (texto -> numero) :==##
firmas <- firmas %>%
          mutate(num_empleados   = as.numeric(num_empleados),
                 ventas_millones = str_replace(ventas_millones, ",", "."),
                 ventas_millones = as.numeric(ventas_millones))

##==: 4. Estandarizar texto (minusculas, sin espacios, vacios -> NA) :==##
firmas <- firmas %>%
          mutate(sector_nombre = str_to_lower(str_trim(sector_nombre)),
                 departamento  = str_to_lower(str_trim(departamento)),
                 tamano        = str_to_lower(str_trim(tamano)),
                 tamano        = ifelse(tamano == "", NA, tamano))

##==: 5. Normalizar texto de innovacion y exportacion :==##
firmas <- firmas %>%
          mutate(innova_producto       = str_to_lower(str_trim(innova_producto)),
                 innova_proceso        = str_to_lower(str_trim(innova_proceso)),
                 innova_organizacional = str_to_lower(str_trim(innova_organizacional)),
                 exporta               = str_to_lower(str_trim(exporta)))

##==: 6. Recodificar si/no -> 1/0 :==##
firmas <- firmas %>%
          mutate(innova_producto       = case_when(innova_producto       %in% c("1", "si") ~ 1,
                                                    innova_producto       %in% c("0", "no") ~ 0,
                                                    TRUE ~ NA_real_),
                 innova_proceso        = case_when(innova_proceso        %in% c("1", "si") ~ 1,
                                                    innova_proceso        %in% c("0", "no") ~ 0,
                                                    TRUE ~ NA_real_),
                 innova_organizacional = case_when(innova_organizacional %in% c("1", "si") ~ 1,
                                                    innova_organizacional %in% c("0", "no") ~ 0,
                                                    TRUE ~ NA_real_),
                 exporta               = case_when(exporta               %in% c("1", "si") ~ 1,
                                                    exporta               %in% c("0", "no") ~ 0,
                                                    TRUE ~ NA_real_))

##==: 7. Crear indicador 'innovadora' :==##
firmas <- firmas %>%
          mutate(innovadora = ifelse(innova_producto == 1 |
                                      innova_proceso == 1 |
                                      innova_organizacional == 1, 1, 0))

##==: 8. Tratar faltantes (gasto_id NA = no invierte -> 0) :==##
firmas <- firmas %>%
          mutate(gasto_id_millones = ifelse(is.na(gasto_id_millones), 0, gasto_id_millones))

##==: 9. Corregir empleados implausibles -> NA :==##
firmas <- firmas %>%
          mutate(num_empleados = ifelse(num_empleados <= 0 | num_empleados > 5000, NA, num_empleados))

##==: 10. Export :==##
export(firmas, "data/processed/01_cleaned/firmas_limpia.rds")
