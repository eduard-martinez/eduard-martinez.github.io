# Curso Nivelatorio de Programación en R

**Manejo y análisis de datos para investigación aplicada**

Maestría en Economía y en Ciencias Administrativas | Econometría I (Pregrado)
CIENFI — Universidad Icesi | Julio de 2026
**Profesor:** Eduard F. Martínez-González | [efmartinez@icesi.edu.co](mailto:efmartinez@icesi.edu.co)

---

## 1. Presentación

Este es un **curso nivelatorio de programación en R** pensado para que los
estudiantes lleguen con una base común y suficiente para trabajar con datos.
No es un curso exhaustivo ni un curso de programación en abstracto: el objetivo
es **nivelar** — entregar lo necesario, ni más ni menos, para importar, limpiar,
transformar, cruzar, describir, visualizar y **estimar regresiones básicas**
sobre datos reales, de manera **reproducible**, y así llegar listos a los
cursos de análisis y econometría.

El curso es **breve e intensivo**: sesiones sincrónicas que abren cada bloque y
un fuerte componente **asincrónico** de práctica guiada. La lógica es *manos a
la obra*: para cada tema se sigue el ciclo **ver → replicar → aplicar** (ver un
recurso breve, replicar el código con datos de ejemplo, aplicarlo a una base
real). El curso cierra con un **proyecto final en parejas** con sustentación.

Dos rasgos distinguen esta versión del curso:

1. **Trabajo reproducible desde el día uno:** proyectos de RStudio, carpetas
   ordenadas, scripts numerados con estilo, datos originales intocables. No es
   un tema al final: es la forma de trabajar en todas las unidades.
2. **IA con reglas:** el curso integra la IA generativa como herramienta de
   aprendizaje (depurar, explicar errores, mejorar gráficos, criticar
   interpretaciones) con validación crítica obligatoria — ver la
   [Guía de uso de IA](../ia/guia_uso_ia.html).

## 2. Dirigido a / objetivos de aprendizaje

**Dirigido a:** estudiantes admitidos a la Maestría en Economía y la Maestría
en Ciencias Administrativas, y estudiantes de Econometría I, **con o sin
experiencia previa en programación**.

**Al finalizar el curso, el estudiante será capaz de:**

- **Importar** datos (CSV/Excel) y **diagnosticar** su estructura, tipos,
  dimensiones y datos faltantes.
- **Limpiar** bases desordenadas: estandarizar nombres y categorías, corregir
  tipos, tratar faltantes, duplicados y valores extremos — documentando cada
  decisión.
- **Transformar** datos con `dplyr` y construir indicadores por grupo
  (`group_by` + `summarise`); **cruzar** bases con `left_join`.
- **Visualizar** con `ggplot2` y construir **tablas descriptivas** exportables.
- **Estimar e interpretar** regresiones lineales básicas (`lm`, `fixest`),
  con unidades correctas y sin lenguaje causal injustificado, y producir
  tablas de regresión profesionales (`modelsummary`).
- Trabajar dentro de un **proyecto reproducible** (RStudio Projects, rutas
  relativas, scripts numerados, estilo de código) y **sustentarlo** oralmente.
- Usar **IA generativa con criterio**: depurar y mejorar con ayuda de la IA,
  verificando siempre paquetes, resultados e interpretaciones.

## 3. Requisitos e instalación

**No se requiere experiencia previa en programación.** Antes de la primera
sesión, instalar:

1. **R** — [cran.r-project.org](https://cran.r-project.org/)
2. **RStudio Desktop** — [posit.co/download/rstudio-desktop](https://posit.co/download/rstudio-desktop/)
3. Los paquetes del curso (en la consola de RStudio):

```r
install.packages(c(
  "tidyverse",     # dplyr, ggplot2, tidyr, readr, stringr...
  "rio",           # importar/exportar cualquier formato
  "readxl",        # leer Excel
  "janitor",       # limpiar nombres y tablas de frecuencia
  "skimr",         # resumen rapido de una base
  "pacman",        # gestion de librerias (p_load)
  "fixest",        # regresiones con efectos fijos y errores robustos
  "modelsummary"   # tablas de regresion y descriptivas
))
```

Solo se necesita un computador con permisos para instalar software y
familiaridad básica con hojas de cálculo (fila, columna, celda).

## 4. Metodología

- **Sesiones sincrónicas (4, de 2 horas):** abren cada unidad — se muestra el
  código en vivo, se resuelven dudas y se dejan planteadas las actividades. No
  se cubre todo en clase: la sesión *abre* el tema.
- **Trabajo asincrónico (la mayor parte):** por cada unidad, el estudiante
  sigue el ciclo **ver → replicar → aplicar**: (1) *ver* el documento de
  teoría (con código ejecutable en el navegador) y el video; (2) *replicar*
  la **práctica guiada** en RStudio; (3) *aplicar* en la **tarea** con su
  cuestionario y en la **actividad con IA**.
- **Proyecto final en parejas** con sustentación oral (ver
  [enunciado](../proyecto_final/enunciado_proyecto_final.html)).

## 5. Estructura del curso: cuatro unidades

| | Unidad 1 | Unidad 2 | Unidad 3 | Unidad 4 |
|---|---|---|---|---|
| **Tema** | Fundamentos de R y flujo de trabajo reproducible | Manejo de datos con tidyverse | Visualización y estadísticas descriptivas | Regresiones básicas y flujo de trabajo empírico |
| **Contenidos** | RStudio; objetos, vectores y data frames; errores y warnings; paquetes; proyectos, rutas relativas y estilo de scripts | Importar y diagnosticar; pipe; verbos dplyr; limpieza (duplicados, texto, tipos, NA, outliers); group_by + summarise; joins; tidyr | Gramática de ggplot2; geometrías según la pregunta; personalización y facetas; ggsave; descriptivas por grupo; tablas exportables; niveles vs. logs | lm y fórmulas; interpretación (niveles, logs, dummies); fixest (robustos y efectos fijos); modelsummary; el pipeline 01→02→03 |
| **Base de datos** | `innovacion_empresas.csv` (primer contacto) | `innovacion_empresas.csv` + `sectores_agregado.csv` | `geih_nivelacion.csv` (GEIH real) | `geih_nivelacion.csv` |
| **Teoría** | `unidad-1-fundamentos/teoria/` | `unidad-2-manejo-datos/teoria/` | `unidad-3-visualizacion/teoria/` | `unidad-4-regresiones/teoria/` |
| **Práctica** | `practica_unidad-1.R` | `practica_unidad-2.R` | `practica_unidad-3.R` | `practica_unidad-4.R` |
| **Evaluación** | Tarea 1 + cuestionario | Tarea 2 + cuestionario | Tarea 3 + cuestionario | Tarea 4 + cuestionario |
| **Actividad IA** | Primero tú, luego la IA | El código corre… pero está mal | Mejora esta figura | Crítica al econometrista artificial |

Las guías transversales acompañan todas las unidades:
[estilo de scripts](../buenas_practicas/guia_estilo_scripts.html) ·
[organización de proyectos](../buenas_practicas/guia_organizacion_proyecto.html) ·
[uso de IA](../ia/guia_uso_ia.html) ·
[plantilla de proyecto](../buenas_practicas/plantilla_proyecto.html).

## 6. Calendario sugerido (julio de 2026)

Sesiones sincrónicas de 10:00 a 12:00. Ajustable según programación de CIENFI.

| Ses. | Fecha | Modalidad | Contenido / hito |
|---|---|---|---|
| 1 | Lunes 13 jul | Sincrónica | **Unidad 1**: R, RStudio, proyectos; arranque de la Unidad 2 (importar y diagnosticar) |
| — | 13–16 jul | Asincrónica | Teoría y práctica U1; Tarea 1; actividad IA 1 |
| 2 | Jueves 16 jul | Sincrónica | **Unidad 2**: limpieza, dplyr, joins (en vivo sobre la base de firmas) |
| — | 16–20 jul | Asincrónica | Práctica U2; Tarea 2; actividad IA 2; teoría U3 |
| 3 | Lunes 20 jul | Sincrónica | **Unidades 3 y 4**: ggplot2, descriptivas y regresiones; **lanzamiento del proyecto final** |
| — | 20–29 jul | Asincrónica | Tareas 3 y 4; actividades IA 3 y 4; desarrollo del proyecto en parejas |
| 4 | Jueves 30 jul | Sincrónica | **Sustentación** de proyectos finales |

## 7. Evaluación

| Componente | Peso | Nivel de IA permitido |
|---|---|---|
| Tareas 1–4 (script + cuestionario, 10% c/u) | 40% | N1 (T1) / N2 (T2–T4) |
| Actividades con IA (4, 2.5% c/u) | 10% | N4 |
| Proyecto final (pipeline + informe + README) | 35% | N3 con declaración |
| Sustentación oral (defensa del código, **sin IA**) | 15% | N0 |

Los niveles de uso de IA (N0–N4) están definidos en la
[Guía de uso de IA](../ia/guia_uso_ia.html). La rúbrica detallada del proyecto:
[rubrica_proyecto_final.md](../proyecto_final/rubrica_proyecto_final.html).
Aprobar la sustentación (explicar el propio código) es **condición necesaria**
para aprobar el proyecto.

## 8. Datos del curso

| Base | Contenido | Se usa en |
|---|---|---|
| `innovacion_empresas.csv` | 506 firmas (ficticias, tipo EDIT), deliberadamente sucia | U1, U2, proyecto |
| `sectores_agregado.csv` | 7 sectores, referente nacional limpio | U2, proyecto |
| `geih_nivelacion.csv` | 21.821 ocupados — extracto real de la GEIH (DANE) | U3, U4 |

Descripción variable a variable: [diccionario de datos](../datos/diccionario_datos.html).

## 9. Bibliografía y recursos

**Recursos audiovisuales (asincrónicos):**

1. [Fundamentos de R](https://www.youtube.com/watch?v=_UnjI5eTkNc&t=963s) — Eduard Martínez
2. [Transformación de datos con dplyr](https://www.youtube.com/watch?v=MVNvoBbELKs&t=1801s) — Eduard Martínez
3. [Visualización de datos](https://www.youtube.com/watch?v=sCfhUTHA4fQ) — Eduard Martínez

**Curso de Business Analytics (material ampliado del profesor):**

- [Semana 3 — Fundamentos de R y Programación](https://eduard-martinez.github.io/teaching/ba/week-03/theory/week-03.html)
- [Semana 4 — Transformación de Datos con dplyr](https://eduard-martinez.github.io/teaching/ba/week-04/theory/week-04.html)
- [Semana 5 — Visualización de Datos con ggplot2](https://eduard-martinez.github.io/teaching/ba/week-05/theory/week-05.html)
- [Semana 6 — Fuentes, Calidad de Datos y Análisis Exploratorio](https://eduard-martinez.github.io/teaching/ba/week-06/theory/week-06.html)

**Bibliografía base:**

- Wickham, H., Çetinkaya-Rundel, M. & Grolemund, G. (2023). *R for Data
  Science* (2.ª ed.). O'Reilly. [r4ds.hadley.nz](https://r4ds.hadley.nz/) —
  [versión en español (1.ª ed.)](https://es.r4ds.hadley.nz/)
- Huntington-Klein, N. *The Effect: An Introduction to Research Design and
  Causality*. [theeffectbook.net](https://theeffectbook.net/) (caps. de
  regresión, para la Unidad 4)
- Wooldridge, J. *Introducción a la econometría* — caps. 2–4 (referencia de
  Econometría I)
- [Cheatsheets de Posit](https://posit.co/resources/cheatsheets/) (`dplyr`,
  `ggplot2`, `tidyr`)
- Contexto temático: [EDIT — DANE](https://www.dane.gov.co/index.php/estadisticas-por-tema/tecnologia-e-innovacion)
  y [GEIH — DANE](https://www.dane.gov.co/index.php/estadisticas-por-tema/mercado-laboral)

## 10. Contacto

Dudas, bloqueos o ajustes de cronograma:
[efmartinez@icesi.edu.co](mailto:efmartinez@icesi.edu.co)
