# Actividad con IA — Unidad 2: "El código corre… pero está mal"

**Nivel de uso de IA:** N4 (actividad diseñada para usar IA) · **Modalidad:** parejas · **Tiempo estimado:** 60 min

## Objetivo

Entrenar la habilidad más importante al trabajar con código generado por IA (o
heredado de cualquier persona): detectar **bugs silenciosos** — código que corre
sin errores y produce resultados incorrectos.

## Contexto

Un asistente le pidió a un chatbot "un script que limpie la base de innovación
y calcule la tasa de innovación por sector". El chatbot entregó el script de
abajo. **Corre sin errores.** Pero contiene **tres bugs silenciosos** que
cambian los resultados.

```r
## script generado por IA — NO lo corrija todavia
require(pacman)
p_load(tidyverse, rio, janitor)

firmas <- import("datos/originales/innovacion_empresas.csv") %>%
          clean_names()

## limpiar ventas (bug 1 en esta zona)
firmas <- firmas %>%
          mutate(ventas_millones = parse_number(ventas_millones,
                                                locale = locale(decimal_mark = ",")))

## quedarnos con firmas "validas" (bug 2 en esta zona)
firmas <- firmas %>%
          filter(ventas_millones > 0)

## indicador de innovacion (bug 3 en esta zona)
firmas <- firmas %>%
          mutate(innovadora = innova_producto %in% c("Si", "SI", "si", "1"))

## tasa por sector
tasa_sector <- firmas %>%
               group_by(cod_sector) %>%
               summarise(tasa = mean(innovadora), n = n(), .groups = "drop")

tasa_sector
```

## Parte A — Encuentre los bugs SIN la IA (30 min)

Corra el script por bloques y **audítelo con código**, comparando contra lo que
sabe de la base (Tarea 2). Pistas de auditoría — cada verificación apunta a un
bug:

1. **¿La conversión de ventas es correcta?** Mire valores concretos:
   `firmas_raw %>% select(ventas_millones) %>% head(10)` vs. el resultado
   convertido. ¿Qué pasa con los valores que traían **punto** decimal
   (`"1166.2"`) cuando se declara la coma como separador decimal?
2. **¿Cuántas filas sobrevivieron al `filter()`?** ¿Dónde quedaron las firmas
   con ventas `NA`? ¿Eso lo decidió usted o lo decidió el código?
3. **¿La definición de innovadora está completa?** Compare con la definición
   del curso (producto **o** proceso **o** organizacional) y revise qué pasa
   con valores como `"Si "` (con espacio) — `table(firmas_raw$innova_producto)`.
4. Además: ¿el script eliminó los **duplicados**? (bug de omisión que cuenta
   como parte del bug 2 o como hallazgo extra).

**Entregable A:** una tabla de auditoría en comentarios:

```r
## BUG 1: [donde esta] | [que produce] | [verificacion que lo demuestra]
## BUG 2: ...
## BUG 3: ...
```

## Parte B — Ahora sí, la IA (20 min)

1. Pídale al chatbot que **audite su propio script**: *"Este script de R corre
   sin errores pero sospecho que tiene bugs silenciosos. Enuméralos con una
   verificación en R para demostrar cada uno: [pegar script]"*.
2. Compare la auditoría de la IA con la suya: ¿encontró los tres? ¿inventó
   problemas que no existen? ¿propuso verificaciones o solo afirmaciones?

## Parte C — La versión correcta (10 min)

Escriba la versión corregida (la Tarea 2 ya se la sabe) y demuestre con dos
números que los bugs importaban: la **tasa de innovación global** y el **N**
del script bugueado vs. el corregido.

## Qué se evalúa

| Criterio | Peso |
|---|---|
| Bugs detectados con verificación propia (Parte A) | 50% |
| Calidad de la comparación con la auditoría de la IA (Parte B) | 25% |
| Versión corregida + cuantificación del daño (Parte C) | 25% |

**Regla de oro que deja esta actividad:** "corre sin errores" no significa
"está bien". El N y el `summary()` son el detector de mentiras del código —
propio, ajeno o de la IA.
