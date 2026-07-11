# Guía de estilo de scripts — Curso Nivelatorio de R

**CIENFI · Universidad Icesi · Prof. Eduard F. Martínez-González**

Esta guía define cómo se escribe un script en este curso. No es cosmética: un
script ordenado se depura en minutos y se puede compartir con un coautor (o con
usted mismo en seis meses) sin explicaciones. El estilo es un **contrato de
lectura**. Las tareas y el proyecto final se califican, en parte, con estas
reglas.

**La regla madre:** código **plano, paso a paso, que se lee de arriba a abajo**
sin saltar entre partes del archivo. Ante la duda entre "elegante/compacto" y
"explícito/simple", siempre explícito/simple.

---

## 1. Anatomía de un script

Todo script del curso tiene estas partes, en este orden:

```r
## ============================================================
##  Curso Nivelatorio de R | Proyecto final
##  01_limpieza.R — De la base cruda a la base de analisis
##  Autor: Nombre Apellido | Fecha: 2026-07-20
##  Lee : datos/originales/innovacion_empresas.csv
##  Deja: datos/procesados/firmas_limpias.rds (una fila por firma)
## ============================================================

## llamar/instalar librerias
require(pacman)
p_load(tidyverse, rio, janitor)

## rutas
datos_orig <- "datos/originales"
datos_proc <- "datos/procesados"

##==: 1. Importar

firmas_raw <- import(file.path(datos_orig, "innovacion_empresas.csv")) %>%
              clean_names()

##==: 2. Limpiar

## duplicados
firmas <- distinct(firmas_raw)

## ... (un bloque por problema, con su comentario)

##==: 3. Exportar

## export data
export(firmas, file.path(datos_proc, "firmas_limpias.rds"))

## clean
rm(firmas_raw)
```

**Elementos obligatorios:**

1. **Encabezado** en caja: curso, nombre del archivo, qué hace, autor, fecha, y
   —clave— **qué lee y qué deja** (con el grano del output: "una fila por firma").
2. **Librerías al inicio**, todas juntas, con `p_load()`. Nunca
   `install.packages()` dentro de un script (se instala una vez, en la consola).
3. **Rutas definidas una sola vez** como objetos cortos (`datos_orig`, `out`),
   siempre **relativas** a la raíz del proyecto.
4. **Secciones numeradas** (`##==: 1. ...`) que se leen en orden.
5. **Exportar al cierre** de cada sección que produce algo (`## export data`), y
   **limpiar** los objetos intermedios que ya no se usan (`## clean` + `rm()`).

## 2. Nombres

- **snake_case**, minúsculas, sin tildes ni espacios: `tasa_desempleo`,
  `ingreso_pc`, `firmas_limpias`.
- **En español y descriptivos, pero cortos:** `capital`, `resumen_sector`,
  `depo_per` — no `x`, `df2`, `tmp`, ni `tabla_final_definitiva_v3`.
- Un objeto por concepto: si calcula el resumen por sector, llámelo
  `resumen_sector`, no reutilice `firmas`.
- No use nombres de funciones existentes (`mean`, `data`, `df`, `T`).
- Archivos: mismas reglas + numerados por orden de ejecución:
  `01_limpieza.R`, `02_descriptivas.R`, `03_regresiones.R`.

## 3. Comentarios

- `##` doble almohadilla, en minúscula, **cortos y en español**. Uno encima de
  cada bloque diciendo **qué es**: `## capital (inversiones)`, `## duplicados`.
- Comentario inline solo cuando una **decisión** lo amerita:
  `ventas_millones = ifelse(ventas_millones == 0, NA, ventas_millones)  ## cero ventas = error de captura`
- **No narre lo obvio** línea por línea (`## sumo 2 + 2`), no deje comentarios
  de "por qué mi cambio es correcto", no deje código muerto comentado.
- Las **decisiones de limpieza** sí se documentan siempre (el "acta de
  limpieza"): qué encontró, qué decidió y por qué. Eso vale nota en el proyecto.

## 4. El código en sí

- **Una operación por línea.** Sin `;`, sin líneas que hagan tres cosas.
- **Pipes `%>%`** para transformaciones: un verbo por línea, el `%>%` cierra la
  línea. La indentación de continuación se alinea:

```r
resumen_sector <- firmas %>%
                  group_by(cod_sector) %>%
                  summarise(n_firmas     = n(),
                            tasa_muestra = mean(innovadora),
                            .groups = "drop")
```

- **`case_when()` de ramas planas** en lugar de `ifelse()` anidados:

```r
## mal: ifelse anidado (ilegible)
tamano = ifelse(v < 500, "chica", ifelse(v < 5000, "media", "grande"))

## bien: case_when plano (se lee de arriba a abajo)
tamano = case_when(v < 500   ~ "chica",
                   v < 5000  ~ "media",
                   v >= 5000 ~ "grande")
```

- **Objetos intermedios con nombre** en vez de un mega-pipe de 15 pasos: si el
  flujo tiene etapas conceptuales (limpiar → agrupar → cruzar), cada etapa
  termina en un objeto con nombre.
- **Pocas funciones propias.** En este curso (y en general en análisis
  aplicado): solo escriba una función si la va a llamar **dos o más veces**.
  La lógica de un solo uso va inline, como pasos planos. Nada de helpers de una
  línea "por organización".
- **No sobre-construya.** Haga exactamente lo que el análisis pide: sin
  parámetros "por si acaso", sin validaciones extra, sin generalizaciones que
  nadie pidió.
- Alinear los `=` de argumentos relacionados cuando quede natural es bienvenido
  (mírelo en el ejemplo de `summarise()` de arriba).
- En los argumentos lógicos puede usar las abreviaturas `T`/`F`
  (`na.rm = T`, estilo del profesor) o `TRUE`/`FALSE` explícito — pero sea
  consistente dentro de un mismo script.

## 5. Anti-patrones (lo que hace "enredado" un script)

- Rutas absolutas (`C:/Users/...`, `/Users/minombre/...`) — rompen la
  reproducibilidad. Siempre relativas al proyecto.
- `install.packages()` o `setwd()` dentro del script.
- `ifelse(ifelse(ifelse(...)))` — use `case_when()`.
- Reutilizar el mismo nombre para cosas distintas (`datos` que primero es la
  base cruda, luego la limpia, luego un resumen).
- Código muerto comentado "por si acaso" — bórrelo, para eso está el original.
- Scripts kilométricos sin secciones: si pasa de ~200 líneas, probablemente son
  dos scripts del pipeline (`01_`, `02_`).
- Guardar el workspace al salir (`.RData`): la memoria de la sesión NO es parte
  del proyecto. Todo lo importante debe poder **regenerarse corriendo los
  scripts**. (En RStudio: Tools → Global Options → "Save workspace: Never").

## 6. Checklist antes de entregar cualquier script

- [ ] Tiene encabezado con qué hace, qué lee y qué deja
- [ ] Todas las librerías arriba con `p_load()`
- [ ] Cero rutas absolutas; rutas definidas una vez como objetos
- [ ] Secciones numeradas y comentarios que dicen *qué* (no narración)
- [ ] Nombres snake_case descriptivos
- [ ] Decisiones de limpieza documentadas
- [ ] Corre completo, de arriba a abajo, en una sesión limpia de R
      (Session → Restart R y ejecutar todo)
