# Errores frecuentes del curso — traducción, causa y corrección

Los mensajes más comunes que traen los estudiantes, con lo que de verdad dicen, la causa más
probable y cómo corregirlos. Cita siempre el mensaje tal cual (en inglés) y tradúcelo: leer errores
es una habilidad que el curso evalúa.

## Objetos y nombres

### 1. `Error: object 'ventas' not found`
- **Qué dice**: "no encuentro ningún objeto llamado `ventas`".
- **Causas, de la más común a la menos**: (1) el nombre está mal escrito o con otra mayúscula
  (`Ventas`, `venta`); (2) la línea que lo crea (`ventas <- read.csv(...)`) no se ejecutó, o R se
  reinició y el Environment quedó vacío; (3) el objeto se llama distinto en el código de arriba.
- **Confírmalo**: mira el panel Environment o ejecuta `ls()`: ¿aparece `ventas`?
- **Corrección**: corrige el nombre o ejecuta el script desde la primera línea (`Ctrl/Cmd + Shift +
  Enter` corre todo).
- **Para que no vuelva a pasar**: nombres en minúscula y siempre iguales; cuando algo falle, primero
  mira el Environment.

### 2. `Error in ventas$precio : $ operator is invalid for atomic vectors`
- **Qué dice**: "el `$` no sirve sobre un vector".
- **Causa**: `ventas` no es una tabla sino un vector (por ejemplo, ya habías hecho `ventas <-
  ventas$precio`). El `$` solo saca columnas de tablas.
- **Confírmalo**: `class(ventas)`.
- **Corrección**: vuelve a crear la tabla desde los datos; usa otro nombre para el vector.

### 3. `Error: unexpected symbol in "ventas totales"`
- **Qué dice**: "me encontré un símbolo donde no lo esperaba".
- **Causa**: un nombre con espacio (`ventas totales <- 5000`), una coma faltante entre argumentos,
  dos instrucciones pegadas en una línea o una comilla sin cerrar.
- **Corrección**: `ventas_totales <- 5000`; revisa comas y comillas de la línea señalada.
- **Parientes**: `unexpected ')'` (paréntesis de más), `unexpected ','`, `unexpected string
  constant` (falta un operador o una coma antes de un texto).

### 4. La consola se queda en `+` y no pasa nada
- **Qué dice**: "la instrucción está incompleta, sigo esperando".
- **Causa**: un paréntesis o una comilla sin cerrar.
- **Corrección**: pulsa `Esc` en la consola, cierra el paréntesis o la comilla y vuelve a correr.
  RStudio marca el sitio con una x roja en el margen.

## Archivos y directorio de trabajo

### 5. `Error in file(file, "rt") : cannot open the connection` + `Warning: cannot open file 'ventas.csv': No such file or directory`
- **Qué dice**: "no puedo abrir el archivo: no existe en la carpeta donde estoy parado".
- **Causa**: R busca el archivo en el directorio de trabajo y el archivo está en otra carpeta
  (Descargas, el Escritorio...). Es el problema número uno al empezar.
- **Confírmalo**: `getwd()` (dónde está R) y `list.files()` (qué ve ahí).
- **Corrección**: una carpeta para el taller con `input/` dentro; el csv va a `input/`; el script se
  guarda en la carpeta y se abre desde ahí (doble clic); luego `read.csv("input/ventas.csv")`.
  Si los datos están en la web del curso, usa la URL completa.
- **Para que no vuelva a pasar**: nunca `setwd("C:/Users/...")` (se rompe en otro computador);
  siempre abrir el script desde su carpeta.

### 6. `Error in setwd("C:\Users\ana\Desktop") : cannot change working directory` o `'\U' used without hex digits`
- **Causa**: la ruta no existe, tiene un error de escritura o usa barras invertidas de Windows.
- **Corrección**: no uses `setwd()`; abre el script desde su carpeta. Si insistes, barras normales
  `/`.

### 7. Caracteres raros en los nombres o textos (`Ã±`, `Ã³`, `regiÃ³n`)
- **Causa**: el archivo está en una codificación distinta a la que R asume (tildes y eñes).
- **Corrección**: `read.csv("input/ventas.csv", encoding = "UTF-8")`; si sigue mal, prueba
  `fileEncoding = "latin1"`. Verifica con `head()`.

## Paquetes

### 8. `Error in filter(...) : could not find function "filter"` (o `"%>%"`, `"ggplot"`, `"skim"`)
- **Qué dice**: "no conozco ninguna función con ese nombre".
- **Causa**: el paquete no está cargado en esta sesión (`dplyr`, `ggplot2`, `skimr`...). Instalar
  es comprar el libro; cargar es sacarlo del estante: hay que hacerlo en cada sesión. Segunda
  causa: el nombre está mal escrito (`sumarise`).
- **Confírmalo**: escribe el nombre de la función en la consola sin paréntesis: si dice `not
  found`, no está cargada.
- **Corrección**: al inicio del script `require(pacman)` y `p_load(dplyr, ggplot2)`; vuelve a
  ejecutar desde arriba.
- **Ojo**: sin `dplyr` cargado, `filter()` puede existir igual (es también una función de R base
  para series de tiempo) y dar un error distinto y confuso (`'filter' is not a valid ...`): la causa
  es la misma.

### 9. `Error in library(dplyr) : there is no package called 'dplyr'` / `Warning: there is no package called 'pacman'`
- **Qué dice**: "ese paquete no está instalado en este computador".
- **Corrección**: si falta `pacman`, una sola vez en la consola `install.packages("pacman")`; los
  demás los instala `p_load()` solo. Nunca dejes `install.packages()` dentro del script.

## Tipos de datos y NA

### 10. `Error in "48000" + 1000 : non-numeric argument to binary operator`
- **Qué dice**: "intentas operar con algo que no es un número".
- **Causa**: la columna o el valor es texto (`character`), muchas veces porque el archivo trae
  `$`, puntos de miles o espacios y R lo importó como texto.
- **Confírmalo**: `class(ventas$precio)`, `unique(ventas$precio)`.
- **Corrección**: limpia y convierte: `ventas <- mutate(ventas, precio = as.numeric(gsub("\\$",
  "", precio)))`; verifica con `class()` y `summary()`.

### 11. `Warning message: NAs introduced by coercion`
- **Qué dice**: "convertí a número, pero algunos valores no pude y quedaron como NA".
- **Causa**: `as.numeric()` sobre textos con símbolos (`"$48.000"`, `"N/A"`, `"12 "`).
- **Corrección**: mira `unique()` de los valores problemáticos y límpialos con `gsub()` antes de
  convertir. Compara `sum(is.na())` antes y después: no deben aparecer NA nuevos.

### 12. `mean()` (o `sum()`, `max()`) devuelve `NA` sin error
- **Qué dice**: nada, y ese es el problema: es el caso más traicionero.
- **Causa**: hay al menos un `NA` en la columna y R no se atreve a inventar un promedio.
- **Confírmalo**: `sum(is.na(ventas$precio))`.
- **Corrección**: `mean(ventas$precio, na.rm = TRUE)`, y decide conscientemente qué hacer con los
  faltantes (documéntalo en el acta de limpieza).

### 13. `Error in mean(x, naa.rm = TRUE) : unused argument (naa.rm = TRUE)` / `argument "x" is missing, with no default`
- **Qué dice**: "me pasaste un argumento que no existe" / "te faltó el argumento principal".
- **Causa**: argumento mal escrito; o se te olvidó poner la tabla o el vector.
- **Corrección**: revisa la escritura (`?mean` muestra los argumentos reales); pon los datos como
  primer argumento.

## dplyr y ggplot2

### 14. `Error in filter(): ! We detected a named input. ℹ This usually means that you've used = instead of ==`
- **Qué dice**: exactamente eso: usaste `=` (asignar un nombre) en vez de `==` (comparar).
- **Corrección**: `filter(ventas, region == "Sur")`.

### 15. `Error: object 'region' not found` dentro de un verbo o de `aes()`
- **Causa**: (1) la columna está mal escrita o con otra mayúscula; (2) la columna todavía no existe
  porque el `mutate()` que la crea no se ejecutó o no se guardó con `<-`; (3) se te olvidó la tabla:
  `group_by(region)` en vez de `group_by(ventas, region)` (sin pipe, la tabla va primero).
- **Confírmalo**: `colnames(ventas)`.
- **Corrección**: corrige el nombre, ejecuta el `mutate()` guardando el resultado, o pon la tabla.

### 16. `Error in ggplot(...) + geom_col() : Cannot add ggproto objects together` / un gráfico vacío
- **Causa**: el `+` quedó al inicio de la línea siguiente (R ejecutó la primera línea sola) o se
  usó `%>%` entre capas.
- **Corrección**: el `+` cierra la línea; entre capas de ggplot siempre `+`, nunca `%>%`.

### 17. `Warning: Removed 3 rows containing missing values (geom_point)`
- **Qué dice**: "dibujé el gráfico, pero dejé por fuera 3 filas con NA".
- **Corrección**: no es un error; decide si esos NA se tratan antes (semana 6) y menciónalo en la
  interpretación.

### 18. `Error in count(ventas, producto, sort = TRUE) : unused argument (sort = TRUE)` u otros errores raros en verbos comunes
- **Causa**: otro paquete cargado después tapó la función de dplyr (por ejemplo `plyr`).
- **Corrección**: usa el nombre completo `dplyr::count(...)` o reinicia R y carga solo los paquetes
  del curso.

## Modelos (semanas 10 a 13)

### 19. `Error in sample.int(length(x), size, replace, prob) : cannot take a sample larger than the population when 'replace = FALSE'`
- **Causa**: pediste más filas de las que hay (`size` mal calculado o la tabla no es la que crees).
- **Confírmalo**: `nrow(datos)`.
- **Corrección**: `size = round(0.8 * nrow(datos))` sobre la tabla correcta.

### 20. `predict()` devuelve una matriz de probabilidades en vez de "Si"/"No" (o la matriz de confusión sale rara)
- **Causa**: falta `type = "class"` en `predict()`; o el target no es factor y `rpart` lo trató
  como regresión.
- **Confírmalo**: `class(train$fuga)` debe ser `"factor"`.
- **Corrección**: `datos$fuga <- as.factor(datos$fuga)` **antes** de partir en train/test;
  `predict(arbol, newdata = test, type = "class")`.

### 21. `Error in predict.randomForest(...) : New factor levels not present in the training data` / `Type of predictors in new data do not match that of the training data`
- **Causa**: las columnas de `test` no tienen los mismos tipos o niveles que las de `train` (una
  conversión hecha solo en una de las dos).
- **Corrección**: convierte tipos (`as.factor()`, `as.numeric()`) en la tabla completa antes de
  partirla.

### 22. `Error in cv.glmnet(...) : x should be a matrix with 2 or more columns` / `number of observations in y (80) not equal to the number of rows of x (100)`
- **Causa**: `glmnet` no acepta tablas: necesita una matriz numérica; o `x` e `y` salen de tablas
  distintas.
- **Corrección**: `x_train <- model.matrix(nota_final ~ ., data = train)[, -1]` y
  `y_train <- train$nota_final` (misma tabla `train`).

### 23. `Error in do_one(nmeth) : NA/NaN/Inf in foreign function call (arg 1)` / `Error: 'x' must be numeric` en `kmeans()` o `scale()`
- **Causa**: hay `NA` en las variables, o una columna no numérica (el id, una categoría).
- **Corrección**: `select()` solo las variables numéricas del clustering (sin id); trata los NA
  antes (`filter(!is.na(...))`); luego `scale()` y `kmeans()`.

### 24. Los resultados cambian cada vez que corro el código (sin error)
- **Causa**: `sample()`, `rpart()`, `randomForest()`, `cv.glmnet()` y `kmeans()` usan el azar y no
  fijaste la semilla.
- **Corrección**: `set.seed(<semilla del enunciado>)` en la línea inmediatamente anterior a cada
  uno de esos pasos.
