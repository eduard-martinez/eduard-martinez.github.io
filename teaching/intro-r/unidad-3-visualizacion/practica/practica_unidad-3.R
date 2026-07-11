## Curso Nivelatorio de R (CIENFI - Icesi) — Unidad 3
## Practica: Visualizacion y descriptivas con ggplot2

## Esta practica acompana la teoria de la Unidad 3. Trabajamos con
## el extracto docente de la GEIH. Complete los espacios.

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, skimr, janitor)

## load data
geih <- import("datos/originales/geih_nivelacion.csv")
glimpse(geih)
skim(geih)

##==: 1. La logica de ggplot2: capas

## capa 1: el lienzo (datos + ejes) — todavia vacio
ggplot(geih, aes(x = anios_educacion, y = log(ingreso_laboral)))

## capa 2: + la geometria
ggplot(geih, aes(x = anios_educacion, y = log(ingreso_laboral))) +
  geom_point()

## capa 3: + etiquetas y tema
ggplot(geih, aes(x = anios_educacion, y = log(ingreso_laboral))) +
  geom_point() +
  labs(title = "Educacion e ingreso laboral",
       x = "Anios de educacion", y = "Log del ingreso",
       caption = "Fuente: GEIH (DANE), extracto docente") +
  theme_minimal()

## galerias de referencia (¿que grafico responde mi pregunta?)
browseURL("https://www.data-to-viz.com/")
browseURL("https://rstudio.github.io/cheatsheets/data-visualization.pdf")


##==: 2. Distribucion de UNA variable: histograma

## el ingreso en niveles: asimetria extrema (tipico de ingresos)
ggplot(geih, aes(x = ingreso_laboral)) +
  geom_histogram(bins = 60)

## ahora usted: repitalo con log(ingreso_laboral) y compare
# _______________


## cambie bins a 15 y observe que pasa con el detalle
# _______________


##==: 3. Comparar grupos: boxplot

ggplot(geih, aes(x = sexo, y = log(ingreso_laboral), fill = sexo)) +
  geom_boxplot()

## ahora usted: boxplot de log(ingreso) por nivel_educativo
## Pista: los niveles salen en orden alfabetico; ordenelos por
## ingreso con reorder(nivel_educativo, ingreso_laboral, FUN = median)
# _______________
# _______________


##==: 4. Comparar categorias: barras con geom_col()

## PASO 1: la tabla (dplyr) — geom_col grafica valores YA calculados
ingreso_nivel <- geih %>%
                 group_by(nivel_educativo) %>%
                 summarise(ingreso_mediano = median(ingreso_laboral),
                           .groups = "drop")

## PASO 2: el grafico, con las barras ordenadas
ggplot(ingreso_nivel,
       aes(x = reorder(nivel_educativo, ingreso_mediano),
           y = ingreso_mediano)) +
  geom_col(fill = "steelblue") +
  labs(x = "Nivel educativo", y = "Ingreso mediano (COP)") +
  theme_minimal()

## ahora usted: haga la misma barra pero por DEPARTAMENTO (solo los
## 10 de mayor ingreso mediano). Pistas: slice_max(n = 10) y
## coord_flip() para leer los nombres
# _______________
# _______________
# _______________


##==: 5. Estetica: dentro vs fuera de aes()

## DENTRO de aes(): mapear una VARIABLE (el color informa algo)
ggplot(geih, aes(x = log(ingreso_laboral), fill = sexo)) +
  geom_density()

## FUERA de aes(): fijar un VALOR (decoracion, no informacion)
ggplot(geih, aes(x = log(ingreso_laboral))) +
  geom_density(fill = "steelblue")

## el error clasico (ejecutelo y explique que salio "raro"):
ggplot(geih, aes(x = log(ingreso_laboral), fill = "steelblue")) +
  geom_density()


##==: 6. Facetas: un panel por grupo

ggplot(geih, aes(x = log(ingreso_laboral))) +
  geom_histogram(bins = 40) +
  facet_wrap(~ nivel_educativo)

## ahora usted: densidad del log del ingreso por sexo, en facetas
## por nivel educativo (combine fill = sexo y facet_wrap)
# _______________
# _______________


##==: 7. Descriptivas que acompanan a los graficos

## resumen global rapido
summary(geih$ingreso_laboral)

## tabla de frecuencias con janitor
geih %>% tabyl(nivel_educativo) %>% adorn_pct_formatting()

## descriptivas por grupo (la tabla del informe)
geih %>%
  group_by(sexo) %>%
  summarise(media   = mean(ingreso_laboral),
            mediana = median(ingreso_laboral),
            sd      = sd(ingreso_laboral),
            n       = n(),
            .groups = "drop")

## ahora usted: la misma tabla por nivel_educativo
# _______________


##==: 8. Exportar (la regla del curso: nada de capturas de pantalla)

grafico_final <- ggplot(ingreso_nivel,
                        aes(x = reorder(nivel_educativo, ingreso_mediano),
                            y = ingreso_mediano)) +
                 geom_col(fill = "steelblue") +
                 labs(title = "Ingreso laboral mediano por nivel educativo",
                      x = NULL, y = "Ingreso mediano (COP)",
                      caption = "Fuente: GEIH (DANE), extracto docente") +
                 theme_minimal()

ggsave("output/ingreso_por_nivel.png", grafico_final,
       width = 8, height = 5, dpi = 300)

## verifique en el panel Files que output/ tiene el .png
