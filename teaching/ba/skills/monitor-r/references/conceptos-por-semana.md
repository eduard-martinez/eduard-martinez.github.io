# Conceptos por semana — qué ha visto el estudiante y qué no

Úsalo para no adelantarte al curso: propón código con lo visto **hasta la semana en que va el
estudiante**. Si algo posterior o ajeno al curso es indispensable, dilo ("esto no lo hemos visto")
y explícalo desde cero. Las funciones aparecen tal como las usan las páginas del curso.

## Semana 3 — Fundamentos de R (RStudio, objetos, vectores, tablas)

- **Entorno**: los cuatro paneles de RStudio; consola vs. script; `Ctrl/Cmd + Enter`; el panel
  Environment como "lo que está cargado"; `getwd()`, `list.files()`; abrir el script desde su
  carpeta fija el directorio de trabajo; comentarios con `#`.
- **R como calculadora**: `+ - * / ^ %%`, paréntesis y orden de operaciones; comparaciones
  `== != > < >= <=`; lógica `& |`.
- **Tipos**: numeric, character, logical; `NA`, `NULL`, `NaN`; `"100" + 5` falla; `class()`,
  `typeof()`, `str()` ("las tres lupas").
- **Objetos**: `<-`, reglas de nombres (minúscula, sin espacios, sin empezar por número, sin
  tildes), R distingue mayúsculas; `ls()`, `rm()`.
- **Vectores**: `c()`, `length()`, `sum()`, `mean()`, `median()`, `max()`, `min()`, `which.max()`,
  `seq()`, `rep()`; indexación por posición `v[3]` y lógica `v[v > mean(v)]`; contar con
  `sum(condicion)`; corregir un dato `v[3] <- 1500`; `na.rm = TRUE`.
- **Tablas**: `data.frame()`, `dim()`, `head()`, `colnames()`, `tabla$columna`, `tabla[fila, col]`,
  filtro por condición `tabla[tabla$unidades < 20, ]`, columna nueva `tabla$inversion <- ...`;
  `matrix()` solo como idea. `summary()` (resumen rápido de un vector o una tabla) aparece en las
  páginas desde la práctica 6, pero es tan básico que puedes usarlo desde aquí.
- **Consola**: tres respuestas (resultado, warning, error); laboratorio de errores: `NA` silencioso
  en `mean()`, `object not found`, `"48000" + 1000`.
- **Paquetes**: instalar ≠ cargar; `install.packages()` una vez, `library()`; el atajo del curso
  `require(pacman); p_load(dplyr, ggplot2)`; ayuda con `?funcion`.

## Semana 4 — Manipulación y visualización (dplyr + ggplot2)

- **Datos**: `read.csv()` desde la URL de la página del curso; radiografía `str()`, `head()`.
- **Verbos dplyr** (con la tabla como primer argumento o con `%>%` en cadenas cortas): `select()`
  (incluido `-columna`), `rename()`, `filter()` con `&` y `|`, `arrange()` y `desc()`, `mutate()`,
  `ifelse()` para etiquetar, `summarise()` con `sum()`, `mean()`, `n()`, `group_by()` +
  `.groups = "drop"`, `count(tabla, col, sort = TRUE)`, `distinct()`, `n_distinct()`, `round()`,
  `nrow()`.
- **ggplot2 por capas**: `ggplot(datos, aes(x, y, color, fill))` + `geom_col()`, `geom_line(group =
  1)`, `geom_point()`, `geom_histogram(bins)` + `labs(title, subtitle, x, y, caption, color)` +
  `theme_minimal()`; `reorder()` para ordenar barras; `facet_wrap()` visto de pasada.
- **Exportar**: `write.csv(tabla, "output/x.csv", row.names = FALSE)`, `ggsave("output/x.png",
  width, height, dpi)`.
- **Hábitos**: la tabla de KPIs antes del gráfico; cada gráfico con una interpretación de una línea;
  "Momento IA": iterar un gráfico con un asistente.

## Semana 5 — El proceso analítico (sin código)

Pregunta de negocio → datos → limpieza → EDA → modelo → comunicación → decisión. Tipos de tarea:
clasificación, predicción/regresión, segmentación, anomalías, optimización. Roles (Data Engineer,
Analyst, Scientist, Translator). Insumo de la Entrega 1 del proyecto.

## Semana 6 — Calidad de datos y EDA (raw → clean → analysis-ready)

- **Diagnóstico**: `skimr::skim()`, `unique()`, `table()`, `sum(duplicated())`, `class()`,
  `summary()`, `sum(is.na())`, mirar una fila completa `tabla[condicion, ]`, histograma como
  detector de outliers.
- **Limpieza** (un paso por línea, verificando después de cada uno): `distinct()`; `toupper()`
  para categorías inconsistentes; `as.numeric(gsub("\\$", "", precio))` para texto con símbolos;
  `filter(cantidad >= 0)` para valores imposibles; `mutate(precio = ifelse(condicion, valor_corregido,
  precio))` para un error de captura confirmado; `select(-columna_vacia)`; `mutate(ingreso = precio *
  cantidad)`; `coord_flip()`.
- **Producto**: `write.csv(ventas_clean, "data/ventas_clean.csv", row.names = FALSE)` y un "acta de
  limpieza" en comentarios (qué se cambió y por qué). Las cuatro dimensiones de calidad:
  completitud, consistencia, validez, unicidad.

## Semana 8 — Agentes de código (Claude Code, Cursor, VS Code)

El mismo R de las semanas 4 y 6, ahora generado y **auditado** con un agente: manifiesto
`CLAUDE.md` con reglas verificables (`set.seed(2026)`, nunca modificar `data/`, exportar con
`ggsave()` a `output/`, comentar en español, preguntar antes de decidir), revisar el código antes
de aceptarlo, verificar los resultados. Los skills pasan a ser archivos.

## Semana 10 — Fundamentos de machine learning (métricas a mano)

- Conceptos: generalizar, train/test, sobreajuste, baseline ("la regla tonta que hay que vencer"),
  validación cruzada, data leakage.
- **Clasificación a mano**: `table(Real = real, Modelo = pred)`; celdas con `tp <- sum(real == "A"
  & pred == "A")` etc.; accuracy, precisión, recall con `round(..., 3)`; baseline de clase
  mayoritaria `max(table(y)) / nrow(datos)`.
- **Regresión a mano**: MAE `mean(abs(real - pred))`, RMSE `sqrt(mean((real - pred)^2))`; baseline
  = predecir el promedio; mejora porcentual frente al baseline.
- Tabla final con `data.frame()` y `write.csv()`.

## Semana 11 — Clasificación: árboles y bosques

- Paquetes: `rpart`, `rpart.plot`, `randomForest` (+ `dplyr`).
- Preparación: `as.factor()` en el target; `set.seed(11)` justo antes de `sample()`;
  `idx_train <- sample(1:nrow(d), size = round(0.8 * nrow(d)))`; `train <- d[idx_train, ]`;
  `test <- d[-idx_train, ]`; verificar con `table()`.
- Árbol: `rpart(y ~ ., data = train, method = "class", control = rpart.control(maxdepth = 2))`;
  `rpart.plot(arbol, type = 4, extra = 104)`; `predict(arbol, newdata = test, type = "class")`;
  "memorizador" con `cp = 0.0001, minsplit = 2, minbucket = 1`; hojas `sum(arbol$frame$var ==
  "<leaf>")`; `arbol$cptable`; regla 1-SE con `which.min()`, `which()`; `prune(arbol, cp = cp_opt)`.
- Bosque: `randomForest(y ~ ., data = train, ntree = 500)`; `importance()`; probabilidades
  `predict(bosque, newdata = test, type = "prob")[, "Aprobado"]`; umbral con `ifelse(prob >= 0.8,
  "Aprobado", "Rechazado")`.
- Lectura de negocio: precisión vs. recall según el costo del error; "torneo" baseline vs. árbol vs.
  bosque en un `data.frame()`.

## Semana 12 — Regresión: Lasso, árboles y bosques

- Paquetes anteriores + `glmnet`, `ggplot2`.
- Baseline: promedio de **train**, MAE/RMSE en test.
- Lasso: `x_train <- model.matrix(y ~ ., data = train)[, -1]`; `y_train <- train$y`;
  `set.seed(12)`; `cv.glmnet(x = x_train, y = y_train, alpha = 1)`; `plot(lasso_cv)`;
  `lambda.1se`; `coef(lasso_cv, s = "lambda.1se")`; `as.numeric(predict(lasso_cv, newx = x_test,
  s = "lambda.1se"))`.
- Árbol de regresión `rpart(y ~ ., data = train, method = "anova")` + poda 1-SE; bosque
  `randomForest(y ~ ., ntree = 500)`; `importance()`.
- Diagnóstico: gráfico predicho vs. real con `geom_point()` + `geom_abline(intercept = 0, slope =
  1, linetype = "dashed")`; tabla del torneo con MAE y RMSE.

## Semana 13 — Clustering: k-means, codo y silueta

- Paquetes: `dplyr`, `ggplot2`, `cluster`.
- Variables: `select()` solo numéricas (nunca el id); escalas con `sapply(audio, sd)`;
  `scale()`; verificar `colMeans()` y `apply(x, 2, sd)`.
- `set.seed(13)` justo antes de `kmeans(x, centers = k, nstart = 25)`; `$cluster`,
  `$tot.withinss`; codo con `sapply(1:8, function(k) kmeans(...)$tot.withinss)` (única función
  anónima del curso: explícala si la usas); silueta con `dist()` y
  `mean(silhouette(km$cluster, distancias)[, 3])`.
- Perfilamiento: pegar `factor(km$cluster)` a la tabla **original** (sin escalar); `summarise(...,
  .by = cluster)` o `group_by()`; `which.max()` para el caso insignia; `geom_point()` coloreado por
  cluster; `geom_boxplot()`; `scale_x_continuous(breaks = 1:8)`; `table(cluster, genero)`.
- Un cluster solo sirve si se puede describir y accionar.

## Proyecto Cóndor (todo el semestre)

Datos en `https://eduard-martinez.github.io/teaching/ba/final_project/data/` (`base_clientes.csv` y tres
anexos unidos por `cliente_id`). La ruta fácil usa solo la base principal. Si un grupo toma la ruta
avanzada y necesita unir tablas, lo mínimo es `left_join()` de dplyr, **agregando antes de unir**
(`group_by` + `summarise` por `cliente_id`): explícalo desde cero, no se enseñó en clase.

## Lo que el curso NO enseña (evítalo salvo necesidad explícita)

Funciones propias (`function`) fuera del `sapply` de la semana 13; `for`, `while`; listas,
`lapply`, `purrr`; `apply` fuera de `apply(x, 2, sd)`; expresiones regulares más allá de
`gsub("\\$", "", x)`; `|>`; `data.table`; `tidyr` (`pivot_*`); fechas con `lubridate`; `caret` o
`tidymodels`; programación orientada a objetos. Extensión aceptable si hace falta: `case_when()` de
dplyr para tres o más categorías (mejor que `ifelse` anidado), explicándola.
