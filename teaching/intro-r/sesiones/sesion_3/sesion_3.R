## R version 4.4.0
## Andrea del Pilar Guerrero
## Sesion 3 — Unidades 3 y 4: Visualizacion, descriptivas y regresiones
## Base: geih_nivelacion.csv (extracto docente de la GEIH - DANE)

## Cambiamos de base: dejamos las firmas y pasamos a PERSONAS.
## geih_nivelacion.csv trae 21.821 ocupados (18-65 anios, ingreso positivo)
## y viene LIMPIA: por eso hoy podemos ir directo a describir, graficar y estimar.
##
## Recorremos el cierre del flujo de trabajo:
## describir -> visualizar -> exportar -> estimar -> reportar.
## Ejecute bloque por bloque (Ctrl/Cmd + Enter), lea la consola y complete
## los espacios "ahora usted".

##=== 0. Configuracion inicial ===##

## limpiamos el entorno para arrancar en blanco (buena practica al iniciar)
rm(list = ls())

## a los paquetes de siempre les sumamos los dos de la Unidad 4:
## - rio          : importar/exportar datos
## - tidyverse    : dplyr + ggplot2 (hoy ggplot2 pasa a primer plano)
## - skimr        : skim() para resumenes rapidos
## - fixest       : feols() -> errores robustos y efectos fijos
## - modelsummary : tablas de regresion y descriptivas listas para publicar
install.packages("pacman") ## correr solo la primera vez
library(pacman)
p_load(rio, tidyverse, skimr, fixest, modelsummary)

## rutas relativas a la raiz del proyecto (regla de oro de la Unidad 1)
raw <- "data/raw/geih_nivelacion.csv"

## carpetas de salida: las figuras y tablas NUNCA se pegan como captura
dir.create("output/01_graphs", recursive = TRUE, showWarnings = FALSE)
dir.create("output/02_tables", recursive = TRUE, showWarnings = FALSE)


##=== 1. Importar y diagnosticar (el primer paso, siempre) ===##

geih <- import(raw)

## la radiografia de la base: hagala ANTES de graficar o estimar
head(geih)        ## primeras filas
dim(geih)         ## 21.821 filas x 8 columnas
glimpse(geih)     ## tipo de cada variable
skim(geih)        ## faltantes, min/max, percentiles

## las variables con las que trabajamos hoy:
## sexo, edad, anios_educacion, nivel_educativo, departamento,
## ingreso_laboral (COP/mes), horas_semana

## un vistazo a las categoricas
table(geih$sexo)
table(geih$nivel_educativo)

## OJO con el ingreso: mire la distancia entre la mediana y el maximo
summary(geih$ingreso_laboral)

## Pregunta para la clase: ¿el promedio del ingreso describe bien a esta
## poblacion? ¿o la mediana es mas honesta?


##=== 2. Descriptivas por grupo (el puente entre la U2 y la U3) ===##

## group_by + summarise: lo mismo de la clase pasada, ahora sobre personas
geih %>%
  group_by(sexo) %>%
  summarise(n              = n(),
            ingreso_prom   = mean(ingreso_laboral),
            ingreso_median = median(ingreso_laboral),
            educacion_prom = mean(anios_educacion),
            .groups = "drop")

## la brecha por sexo, en un solo numero
geih %>%
  group_by(sexo) %>%
  summarise(ingreso_median = median(ingreso_laboral), .groups = "drop") %>%
  pivot_wider(names_from = sexo, values_from = ingreso_median) %>%
  mutate(brecha_pct = (hombre - mujer) / hombre * 100)

## ordenamos el nivel educativo para que las tablas y graficos salgan
## en orden logico y no alfabetico
geih <- geih %>%
  mutate(nivel_educativo = factor(nivel_educativo,
                                  levels = c("ninguno", "primaria", "secundaria",
                                             "media", "superior")))

geih %>%
  group_by(nivel_educativo) %>%
  summarise(n           = n(),
            ingreso_med = median(ingreso_laboral),
            horas_prom  = mean(horas_semana),
            .groups = "drop")

## ahora usted: ingreso mediano por sexo Y nivel educativo a la vez
# geih %>%
#   group_by(_______, _______) %>%
#   summarise(ingreso_med = median(ingreso_laboral), .groups = "drop")


##=== 3. La logica de ggplot2: el grafico se construye por capas ===##

## capa 1: el lienzo. datos + que va en cada eje (aes = estetica).
## si corre solo esto: ejes dibujados, pero NADA adentro.
ggplot(geih, aes(x = anios_educacion, y = log(ingreso_laboral)))

## capa 2: + la geometria (que dibujo: puntos, barras, cajas...)
## las capas se suman con +   (no con %>%)
ggplot(geih, aes(x = anios_educacion, y = log(ingreso_laboral))) +
  geom_point()

## capa 3: + etiquetas y tema. un grafico sin titulo ni fuente esta incompleto.
ggplot(geih, aes(x = anios_educacion, y = log(ingreso_laboral))) +
  geom_point(alpha = 0.2) +          ## alpha = transparencia (son 21.821 puntos)
  geom_smooth(method = "lm") +       ## + la linea de tendencia
  labs(title = "Educacion e ingreso laboral",
       subtitle = "Ocupados de 18 a 65 anios, cabeceras",
       x = "Anios de educacion", y = "Log del ingreso laboral",
       caption = "Fuente: GEIH (DANE), extracto docente") +
  theme_minimal()

## Regla practica: la geometria se elige segun la PREGUNTA.
## distribucion -> histograma  | comparar grupos    -> boxplot
## relacion     -> dispersion  | comparar categorias -> barras


##=== 4. Distribucion de una variable: histograma y logaritmos ===##

## el ingreso en NIVELES: asimetria extrema (una cola larguisima a la derecha)
ggplot(geih, aes(x = ingreso_laboral)) +
  geom_histogram(bins = 50) +
  labs(title = "Ingreso laboral en niveles", x = "Ingreso (COP)", y = "Personas") +
  theme_minimal()

## el mismo ingreso en LOGS: la distribucion se vuelve legible (casi simetrica).
## por eso en economia laboral se trabaja con log(ingreso).
ggplot(geih, aes(x = log(ingreso_laboral))) +
  geom_histogram(bins = 50) +
  labs(title = "Ingreso laboral en logaritmos", x = "Log del ingreso", y = "Personas") +
  theme_minimal()

## ahora usted: haga el histograma de la edad. ¿necesita logs?
# ggplot(geih, aes(x = _______)) +
#   geom_histogram(bins = 30) +
#   theme_minimal()


##=== 5. Comparar grupos: boxplot ===##

## el boxplot resume una distribucion por grupo:
## caja = 50% central (p25-p75), linea = mediana, puntos = outliers
ggplot(geih, aes(x = sexo, y = log(ingreso_laboral))) +
  geom_boxplot() +
  labs(title = "Distribucion del ingreso por sexo",
       x = NULL, y = "Log del ingreso laboral") +
  theme_minimal()

## por nivel educativo: aqui se ve el retorno a la educacion
ggplot(geih, aes(x = nivel_educativo, y = log(ingreso_laboral))) +
  geom_boxplot() +
  labs(title = "Ingreso por nivel educativo",
       x = NULL, y = "Log del ingreso laboral") +
  theme_minimal()

## ahora usted: el mismo boxplot, pero separando ademas por sexo
## (pista: agregue fill = sexo dentro de aes)
# _______________


##=== 6. Estetica: DENTRO vs FUERA de aes() ===##

## FUERA de aes(): un valor fijo para todo el grafico
ggplot(geih, aes(x = nivel_educativo, y = log(ingreso_laboral))) +
  geom_boxplot(fill = "steelblue") +
  theme_minimal()

## DENTRO de aes(): el color MAPEA una variable (y aparece la leyenda)
ggplot(geih, aes(x = nivel_educativo, y = log(ingreso_laboral), fill = sexo)) +
  geom_boxplot() +
  labs(title = "Brecha de ingresos por sexo y nivel educativo",
       x = NULL, y = "Log del ingreso", fill = "Sexo") +
  theme_minimal()

## Error clasico: poner color = "blue" DENTRO de aes(). R lo entiende como
## una variable llamada "blue" y termina pintando todo de rojo. Pruebelo:
# ggplot(geih, aes(x = edad, y = log(ingreso_laboral), color = "blue")) + geom_point()


##=== 7. Comparar categorias: barras ===##

## geom_col() dibuja un valor ya calculado: primero resumo, luego grafico
resumen_dpto <- geih %>%
  group_by(departamento) %>%
  summarise(ingreso_med = median(ingreso_laboral),
            n           = n(),
            .groups = "drop") %>%
  arrange(desc(ingreso_med)) %>%
  slice_head(n = 10)              ## top 10 para que la figura respire

ggplot(resumen_dpto, aes(x = reorder(departamento, ingreso_med), y = ingreso_med)) +
  geom_col(fill = "steelblue") +
  coord_flip() +                  ## barras horizontales: etiquetas legibles
  labs(title = "Ingreso mediano por departamento (top 10)",
       x = NULL, y = "Ingreso mediano (COP)",
       caption = "Fuente: GEIH (DANE), extracto docente") +
  theme_minimal()

## reorder() ordena las barras por su valor. Sin el, R usa orden alfabetico,
## que casi nunca es el orden que uno quiere mostrar.


##=== 8. Facetas: un panel por grupo ===##

## facet_wrap parte el grafico en paneles segun una variable categorica:
## mismo codigo, varios graficos comparables entre si.
ggplot(geih, aes(x = anios_educacion, y = log(ingreso_laboral))) +
  geom_point(alpha = 0.15) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ sexo) +
  labs(title = "Educacion e ingreso, por sexo",
       x = "Anios de educacion", y = "Log del ingreso") +
  theme_minimal()

## ahora usted: histograma de log(ingreso) con un panel por sexo
# _______________


##=== 9. Exportar: la regla del curso es nada de capturas de pantalla ===##

## guardamos el grafico en un objeto...
fig_brecha <- ggplot(geih, aes(x = nivel_educativo, y = log(ingreso_laboral), fill = sexo)) +
  geom_boxplot() +
  labs(title = "Brecha de ingresos por sexo y nivel educativo",
       x = NULL, y = "Log del ingreso", fill = "Sexo",
       caption = "Fuente: GEIH (DANE), extracto docente") +
  theme_minimal()

## ...y lo exportamos con ggsave (dimensiones y resolucion explicitas)
ggsave("output/01_graphs/brecha_sexo_educacion.png",
       plot = fig_brecha, width = 8, height = 5, dpi = 300)

## una tabla descriptiva tambien se exporta (no se copia a mano)
tabla_desc <- geih %>%
  group_by(sexo, nivel_educativo) %>%
  summarise(n           = n(),
            ingreso_med = median(ingreso_laboral),
            educ_prom   = mean(anios_educacion),
            .groups = "drop")

export(tabla_desc, "output/02_tables/descriptivas_sexo_nivel.csv")

## datasummary_skim(): la tabla descriptiva de la base en una sola linea
datasummary_skim(geih %>% select(edad, anios_educacion, ingreso_laboral, horas_semana))


##=== 10. lm(): la primera regresion ===##

## Hasta aca DESCRIBIMOS. Ahora vamos a CUANTIFICAR la relacion que ya
## habiamos visto en el grafico del bloque 3.

## la formula y ~ x se lee: "log del ingreso explicado por educacion"
modelo_1 <- lm(log(ingreso_laboral) ~ anios_educacion, data = geih)

## la salida completa: ubique Estimate, Std. Error, Pr(>|t|) y R-squared
summary(modelo_1)

## el modelo es un OBJETO: se le pueden extraer piezas
coef(modelo_1)
nobs(modelo_1)

## Interpretacion (la dependiente esta en logs -> el coeficiente es un %):
## un anio adicional de educacion esta ASOCIADO a un ingreso laboral
## aproximadamente 100*coef % mayor, en promedio.
round(coef(modelo_1)["anios_educacion"] * 100, 1)   ## en puntos porcentuales

## ahora usted: estime log(ingreso) ~ horas_semana y compare el R2
# modelo_h <- _______________
# summary(_______________)


##=== 11. Controles: comparar personas mas parecidas entre si ===##

## al agregar edad, el retorno a la educacion compara personas de la MISMA edad
modelo_2 <- lm(log(ingreso_laboral) ~ anios_educacion + edad, data = geih)
summary(modelo_2)

## ¿el coeficiente de educacion subio o bajo al controlar por edad?
## pista: en Colombia las cohortes jovenes estudian mas (correlacion negativa)
cor(geih$edad, geih$anios_educacion)


##=== 12. Dummies: variables categoricas dentro de la regresion ===##

## sexo es TEXTO y R crea la dummy automaticamente: no hay que codificar nada
modelo_3 <- lm(log(ingreso_laboral) ~ anios_educacion + edad + sexo, data = geih)
summary(modelo_3)

## ¿cual es la categoria de referencia? mire el NOMBRE del coeficiente:
## "sexomujer" -> la referencia es hombre, y el coeficiente compara mujer vs hombre

## para dummies con efectos grandes, el % exacto se calcula asi:
exp(coef(modelo_3)["sexomujer"]) - 1

## ahora usted: estime el modelo con nivel_educativo en vez de anios_educacion.
## ¿cuantas dummies crea R? ¿cual queda como referencia?
# modelo_niv <- _______________
# summary(_______________)


##=== 13. Por que no basta con lm(): dos problemas y sus soluciones ===##

## -------------------------------------------------------------------
## PROBLEMA 1: los errores estandar de lm() suponen HOMOCEDASTICIDAD
## -------------------------------------------------------------------
## lm() calcula los errores estandar suponiendo que la varianza del termino
## de error es CONSTANTE para todos los individuos (homocedasticidad).
## Con datos de ingresos eso casi nunca se cumple: unos grupos son mucho mas
## dispersos que otros.
##
## Consecuencia: los COEFICIENTES siguen bien estimados (insesgados), pero los
## ERRORES ESTANDAR quedan mal -> los t, los p-valores y las estrellas mienten.
## Solucion: errores estandar ROBUSTOS a heterocedasticidad.

## comprobemoslo con los residuos del modelo_3: si hubiera homocedasticidad,
## esta columna deberia ser practicamente igual en todos los grupos
geih %>%
  mutate(residuo = resid(modelo_3)) %>%
  group_by(nivel_educativo) %>%
  summarise(desv_residuo = sd(residuo), .groups = "drop")

## no lo es: va de 0.72 (media) a 0.85 (ninguno). Ojo con la intuicion:
## aqui la dispersion es MAYOR entre quienes no tienen educacion formal,
## no entre los universitarios. Lo que importa no es la direccion sino
## que la varianza NO sea constante.

## -------------------------------------------------------------------
## PROBLEMA 2: heterogeneidad no observada entre departamentos
## -------------------------------------------------------------------
## Los departamentos difieren en costo de vida, estructura productiva y
## mercado laboral. Todo eso afecta el ingreso y NO esta en la base.
## Si ademas se correlaciona con la educacion (donde hay mas universidades
## tambien se paga mas), el coeficiente de educacion recoge parte de ese
## efecto departamental: queda SESGADO por variable omitida.
##
## Solucion: EFECTOS FIJOS de departamento. Equivale a incluir una dummy por
## departamento: absorbe todo lo que es constante dentro de cada uno y deja
## comparar personas DENTRO del mismo departamento.

## la diferencia entre departamentos es grande (por eso vale la pena absorberla):
## el ingreso mediano va de 700.000 a 1.000.000 segun el departamento...
geih %>%
  group_by(departamento) %>%
  summarise(ingreso_med = median(ingreso_laboral), .groups = "drop") %>%
  summarise(minimo = min(ingreso_med), maximo = max(ingreso_med))

## ...y la educacion promedio tambien varia entre ellos (de 9.7 a 12.3 anios).
## Justo esa correlacion entre educacion y departamento es la que sesga
## el coeficiente si no absorbemos las diferencias departamentales.
geih %>%
  group_by(departamento) %>%
  summarise(educ_prom = mean(anios_educacion), .groups = "drop") %>%
  summarise(minimo = min(educ_prom), maximo = max(educ_prom))


##=== 14. fixest: robustos y efectos fijos en una sola linea ===##

## feols() es el estandar en economia aplicada. Misma formula que lm(), mas:
##   | departamento   -> los efectos fijos van despues de la barra
##   vcov = "hetero"  -> errores estandar robustos
modelo_fe <- feols(log(ingreso_laboral) ~ anios_educacion + edad + sexo | departamento,
                   data = geih, vcov = "hetero")
modelo_fe

## compare el coeficiente de educacion con el del modelo_3 (mismo modelo en lm,
## sin efectos fijos ni robustos):
##   - si el COEFICIENTE casi no cambia -> el sesgo por departamento era menor
##   - el ERROR ESTANDAR si cambia -> esa es la correccion por heterocedasticidad
summary(modelo_3)

## por que no usamos dummies a mano: serian 23 dummies que no queremos ni ver.
## feols las absorbe y reporta abajo "Fixed-effects: departamento: 24"
n_distinct(geih$departamento)

## ahora usted: cambie los errores a agrupados por departamento
## con vcov = ~departamento. ¿que pasa con los errores estandar?
## (pista: agrupar reconoce que las personas de un mismo departamento
## comparten shocks, y suele AGRANDAR los errores)
# modelo_cl <- _______________
# _______________


##=== 15. La tabla profesional con modelsummary ===##

## una lista con los modelos; los nombres son los encabezados de columna
modelos <- list("(1) Simple"     = modelo_1,
                "(2) + Edad"     = modelo_2,
                "(3) + Sexo"     = modelo_3,
                "(4) + EF depto" = modelo_fe)

## la tabla en el Viewer
msummary(modelos,
         coef_rename = c(anios_educacion = "Anios de educacion",
                         edad = "Edad", sexomujer = "Mujer"),
         gof_map = c("nobs", "r.squared"),
         stars = TRUE,
         title = "Determinantes del ingreso laboral (GEIH)")

## y exportada: el argumento output escribe el archivo directamente
msummary(modelos,
         coef_rename = c(anios_educacion = "Anios de educacion",
                         edad = "Edad", sexomujer = "Mujer"),
         gof_map = c("nobs", "r.squared"),
         stars = TRUE,
         output = "output/02_tables/tabla_regresiones.csv")


##=== 16. Lo que la regresion NO dice (tan importante como lo que dice) ===##

## 1. "ASOCIADO A", nunca "causa": las personas con mas educacion difieren
##    en cosas que no observamos (habilidad, contexto familiar, redes).
## 2. Significancia NO es magnitud: con N = 21.821 casi todo sale con
##    estrellas; la pregunta relevante es ¿de cuantos pesos estamos hablando?
## 3. El R2 mide ajuste, NO que el modelo este bien especificado.

## ejercicio de cierre: escriba en 3 lineas la lectura COMPLETA del
## coeficiente de educacion del modelo_fe (magnitud, unidades,
## condicion "controlando por..." y la advertencia causal)
## _______________
## _______________
## _______________


##=== 17. El pipeline: como se conecta esto con el proyecto final ===##

## Lo que hoy hicimos en un solo script, en el proyecto va SEPARADO:
##   01_limpieza.R     -> importar, diagnosticar, limpiar  (guarda la base limpia)
##   02_descriptivas.R -> bloques 2 a 9   (guarda figuras y tablas)
##   03_regresiones.R  -> bloques 10 a 15 (guarda las tablas de regresion)
## Cualquier persona debe poder correr 01 -> 02 -> 03 y obtener los mismos
## resultados. Esa es la definicion de trabajo reproducible del curso.
