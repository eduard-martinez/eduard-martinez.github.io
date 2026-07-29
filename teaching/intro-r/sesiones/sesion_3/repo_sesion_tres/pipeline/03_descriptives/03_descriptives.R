## R version 4.4.0
## Last run 2026-07-27

## Descriptivas y figuras. Regla del curso: ninguna figura ni tabla se copia
## como captura de pantalla; todas se exportan desde el codigo.

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
geih <- import("data/processed/01_cleaned/geih_lista.rds")

##==: 2. Tabla: descriptivas por sexo :==##
tabla_sexo <- geih %>%
              group_by(sexo) %>%
              summarise(n              = n(),
                        ingreso_prom   = mean(ingreso_laboral),
                        ingreso_median = median(ingreso_laboral),
                        educacion_prom = mean(anios_educacion),
                        horas_prom     = mean(horas_semana),
                        .groups = "drop")

##==: 3. Tabla: descriptivas por sexo y nivel educativo :==##
tabla_sexo_nivel <- geih %>%
                    group_by(sexo, nivel_educativo) %>%
                    summarise(n           = n(),
                              ingreso_med = median(ingreso_laboral),
                              educ_prom   = mean(anios_educacion),
                              .groups = "drop")

##==: 4. Tabla: brecha de ingreso por sexo, en un solo numero :==##
tabla_brecha <- geih %>%
                group_by(sexo) %>%
                summarise(ingreso_median = median(ingreso_laboral), .groups = "drop") %>%
                pivot_wider(names_from = sexo, values_from = ingreso_median) %>%
                mutate(brecha_pct = (hombre - mujer) / hombre * 100)

##==: 5. Tabla: ranking departamental (top 10 por ingreso mediano) :==##
tabla_departamento <- geih %>%
                      group_by(departamento) %>%
                      summarise(n           = n(),
                                ingreso_med = median(ingreso_laboral),
                                educ_prom   = mean(anios_educacion),
                                .groups = "drop") %>%
                      arrange(desc(ingreso_med))

top_departamentos <- tabla_departamento %>% slice_head(n = 10)

##==: 6. Figura: el ingreso en niveles vs. en logaritmos :==##
fig_niveles <- ggplot(geih, aes(x = ingreso_laboral)) +
               geom_histogram(bins = 50, fill = "steelblue") +
               labs(title = "Ingreso laboral en niveles",
                    subtitle = "Cola larga a la derecha: la media se va muy por encima de la mediana",
                    x = "Ingreso (COP/mes)", y = "Personas",
                    caption = "Fuente: GEIH (DANE), extracto docente") +
               theme_minimal()

fig_logs <- ggplot(geih, aes(x = log_ingreso)) +
            geom_histogram(bins = 50, fill = "steelblue") +
            labs(title = "Ingreso laboral en logaritmos",
                 subtitle = "La misma variable, ahora casi simetrica",
                 x = "Log del ingreso laboral", y = "Personas",
                 caption = "Fuente: GEIH (DANE), extracto docente") +
            theme_minimal()

##==: 7. Figura: educacion e ingreso, con panel por sexo :==##
fig_educacion <- ggplot(geih, aes(x = anios_educacion, y = log_ingreso)) +
                 geom_point(alpha = 0.15) +
                 geom_smooth(method = "lm", se = FALSE) +
                 facet_wrap(~ sexo) +
                 labs(title = "Educacion e ingreso laboral, por sexo",
                      subtitle = "Ocupados de 18 a 65 anios, 24 cabeceras",
                      x = "Anios de educacion", y = "Log del ingreso laboral",
                      caption = "Fuente: GEIH (DANE), extracto docente") +
                 theme_minimal()

##==: 8. Figura: brecha por sexo y nivel educativo (boxplot) :==##
fig_brecha <- ggplot(geih, aes(x = nivel_educativo, y = log_ingreso, fill = sexo)) +
              geom_boxplot() +
              labs(title = "Brecha de ingresos por sexo y nivel educativo",
                   x = NULL, y = "Log del ingreso laboral", fill = "Sexo",
                   caption = "Fuente: GEIH (DANE), extracto docente") +
              theme_minimal()

##==: 9. Figura: ingreso mediano por departamento (top 10) :==##
fig_departamento <- ggplot(top_departamentos,
                           aes(x = reorder(departamento, ingreso_med), y = ingreso_med)) +
                    geom_col(fill = "steelblue") +
                    coord_flip() +
                    labs(title = "Ingreso mediano por departamento (top 10)",
                         x = NULL, y = "Ingreso mediano (COP/mes)",
                         caption = "Fuente: GEIH (DANE), extracto docente") +
                    theme_minimal()

##==: 10. Export :==##
export(tabla_sexo,         "output/02_tables/descriptivas_sexo.csv")
export(tabla_sexo_nivel,   "output/02_tables/descriptivas_sexo_nivel.csv")
export(tabla_brecha,       "output/02_tables/brecha_ingreso_sexo.csv")
export(tabla_departamento, "output/02_tables/descriptivas_departamento.csv")

ggsave("output/01_graphs/ingreso_niveles.png",      plot = fig_niveles,      width = 8, height = 5, dpi = 300)
ggsave("output/01_graphs/ingreso_logs.png",         plot = fig_logs,         width = 8, height = 5, dpi = 300)
ggsave("output/01_graphs/educacion_ingreso.png",    plot = fig_educacion,    width = 8, height = 5, dpi = 300)
ggsave("output/01_graphs/brecha_sexo_educacion.png", plot = fig_brecha,      width = 8, height = 5, dpi = 300)
ggsave("output/01_graphs/ingreso_departamento.png", plot = fig_departamento, width = 8, height = 5, dpi = 300)
