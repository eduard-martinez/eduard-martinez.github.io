## R version 4.4.0
## Last run 2026-07-21

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
firmas <- import("data/processed/02_joined/firmas_sector.rds")

##==: 2. Tabla por sector: muestra vs. referente nacional :==##
tabla_sector <- firmas %>%
                group_by(cod_sector, sector_desc) %>%
                summarise(n_firmas       = n(),
                          ventas_mediana = median(ventas_millones, na.rm = TRUE),
                          tasa_muestra   = mean(innovadora, na.rm = TRUE),
                          tasa_nacional  = first(tasa_innovacion_sectorial),
                          .groups = "drop") %>%
                mutate(brecha = tasa_muestra - tasa_nacional) %>%
                arrange(desc(tasa_muestra))

##==: 3. Tabla por departamento :==##
tabla_departamento <- firmas %>%
                      count(departamento, sort = TRUE)

##==: 4. Tabla por tamano: ventas y empleo :==##
tabla_tamano <- firmas %>%
                group_by(tamano) %>%
                summarise(n_firmas     = n(),
                          ventas_prom  = mean(ventas_millones, na.rm = TRUE),
                          empleo_total = sum(num_empleados, na.rm = TRUE),
                          .groups = "drop") %>%
                arrange(desc(ventas_prom))


##==: 6. Export :==##
export(tabla_sector,       "output/02_tables/tabla_por_sector.csv")
export(tabla_departamento, "output/02_tables/tabla_por_departamento.csv")
export(tabla_tamano,       "output/02_tables/tabla_por_tamano.csv")
