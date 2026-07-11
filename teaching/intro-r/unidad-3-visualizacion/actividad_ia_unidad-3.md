# Actividad con IA — Unidad 3: "Mejora esta figura"

**Nivel de uso de IA:** N4 (actividad diseñada para usar IA) · **Modalidad:** individual · **Tiempo estimado:** 45 min

## Objetivo

Usar la IA para **iterar el diseño** de un gráfico (títulos, escalas, orden,
anotaciones) manteniendo el control total sobre **qué datos se grafican** — y
aprender a rechazar sugerencias con criterio.

## Punto de partida

Este gráfico es **correcto pero feo e ilegible**. Córralo tal cual (usa la GEIH
del curso):

```r
require(pacman)
p_load(tidyverse, rio)

geih <- import("datos/originales/geih_nivelacion.csv")

ingreso_dpto <- geih %>%
                group_by(departamento) %>%
                summarise(ingreso_mediano = median(ingreso_laboral),
                          n = n(), .groups = "drop")

ggplot(ingreso_dpto, aes(x = departamento, y = ingreso_mediano)) +
  geom_col()
```

Problemas evidentes: nombres de departamentos ilegibles, barras sin ordenar,
eje Y en notación científica, sin título ni fuente, color por defecto.

## Mecánica (mínimo 3 iteraciones con la IA)

1. **Iteración 1 — usted decide qué pedir.** Escriba un prompt específico (no
   "mejóralo": diga QUÉ quiere — p. ej. ordenar las barras, voltear los ejes,
   formato de miles en el eje). Aplique lo que le sirva.
2. **Iteración 2 — pida una crítica.** Pregunte: *"¿Qué le falta a este gráfico
   para estar listo para un informe de economía? [pegar código actual]"*.
   De la lista que le dé, **implemente solo lo que usted justifique** y anote
   qué rechazó y por qué (¿le sugirió un pie chart? ¿colores sin significado?
   ¿truncar el eje Y?).
3. **Iteración 3 — el toque final.** Una mejora puntual a su elección
   (resaltar un departamento, anotar un valor, caption con la fuente).

**Después de CADA iteración, la verificación anti-manipulación:**

```r
## los DATOS graficados no pueden cambiar entre iteraciones:
## la tabla de origen sigue siendo la misma?
nrow(ingreso_dpto)                       # 24 departamentos
summary(ingreso_dpto$ingreso_mediano)    # los mismos valores
## si la IA sugirio filtrar, reordenar niveles, truncar ejes o
## transformar la variable: ¿cambia el MENSAJE del grafico? ¿lo decidio usted?
```

## Entregable

Un script `actividad_ia3_SuCodigo.R` con:

1. El código final del gráfico (que exporta con `ggsave()` a `output/`)
2. El **registro de prompts** como comentarios: los 3+ prompts usados
3. La tabla de decisiones: `## acepte: ... | rechace: ... | porque: ...`
4. La verificación anti-manipulación después de la última iteración

## Qué se evalúa

| Criterio | Peso |
|---|---|
| Calidad final del gráfico (principios de la Unidad 3: ordenado, etiquetado, con fuente, sin eje truncado) | 40% |
| Registro honesto de prompts e iteraciones | 20% |
| Al menos una sugerencia de la IA **rechazada con justificación técnica** | 25% |
| Verificación de que los datos graficados no cambiaron | 15% |

**Regla de oro que deja esta actividad:** la IA es excelente asistente de
*diseño* y pésimo custodio de los *datos*. El mapeo datos→gráfico siempre lo
verifica usted.
