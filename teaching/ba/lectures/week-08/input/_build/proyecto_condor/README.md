# Caso Cóndor — EDA del proyecto final

## El caso

Cóndor es una fintech colombiana de pagos y crédito. Entregó a cada equipo del curso
**Analítica para los negocios** (Universidad Icesi) una foto de sus datos con corte al
**31 de marzo de 2026**, para que respondan una pregunta de negocio con datos: retención,
gasto futuro, segmentación, fraude, riesgo de crédito o respuesta a campañas.

Cada equipo ya tiene **su propia pregunta de negocio** (la de la Entrega 1). Todo el
trabajo en esta carpeta gira alrededor de esa pregunta: no hay una única respuesta correcta.

## Los datos (`input/`)

Una base principal y tres anexos, conectados por `cliente_id`:

| Archivo                   | Una fila es…            | Filas   | Variables objetivo               |
|---------------------------|-------------------------|---------|----------------------------------|
| `base_clientes.csv`       | un cliente              | 8.000   | `abandono`, `gasto_proximo_trim` |
| `anexo_transacciones.csv` | una transacción         | 185.582 | `etiqueta_fraude`                |
| `anexo_creditos.csv`      | una solicitud de crédito| 4.071   | `default_90d`, `monto_recuperado`|
| `anexo_campanas.csv`      | un envío de campaña     | 13.467  | `convertido`                     |

- La base principal alcanza por sí sola para muchas preguntas; los anexos agregan detalle.
- Un mismo cliente puede tener **varias filas** en los anexos: antes de unir un anexo a la
  base, hay que **agregarlo a nivel de cliente**.
- Algunos vacíos significan "no aplica", no "dato perdido": `score_buro` está vacía para
  quien nunca pidió crédito, `csat_promedio` para quien no abrió tickets y
  `duracion_sesion_promedio` para quien no tuvo sesiones recientes.
- El detalle variable por variable está en **`input/diccionario_datos.md`**.
- Estos archivos son copia exacta (verificada) de los publicados en
  `https://eduard-martinez.github.io/teaching/ba/final_project/data/`.

## El propósito de este proyecto

Producir, dirigiendo un agente de código, **3 o 4 resultados bien escogidos** —descriptivas
o gráficos— que ayuden a responder la pregunta de negocio del equipo. Es el avance del
análisis exploratorio que se presenta en la Entrega 2 del proyecto. No se trata de hacer
el EDA completo ni de modelar: eso viene después.

## Reglas para el agente

Estas reglas aplican a TODO el trabajo en esta carpeta:

1. Responde y comenta el código **en español**, en frases cortas.
2. Escribe código **R** usando `dplyr` y `ggplot2`, con `read.csv` para leer los datos
   **desde `input/`**. Nada de `data.table`, `tidymodels` ni paquetes que el curso no ha
   visto. El código debe ser sencillo y legible: si el estudiante no lo entiende, no sirve.
3. Haz **solo la tarea que se te pide** en cada prompt. No te adelantes a pasos siguientes
   ni agregues análisis, limpiezas o validaciones que nadie pidió.
4. Cada resultado va en **un script corto e independiente** dentro de `scripts/`, numerado
   (`01_cargar.R`, `02_...`), que corre completo de arriba a abajo con `Rscript`.
5. Los gráficos se guardan con `ggsave()` en `output/` (PNG) y las tablas con
   `write.csv()` en `output/`. Los archivos de `input/` **no se modifican nunca**.
6. Explica en una o dos líneas qué hace cada bloque antes de escribirlo.
7. **Nunca afirmes una cifra** que no salga de una salida de R que se acaba de correr.
8. Si una decisión de análisis es discutible (qué hacer con faltantes, cómo partir tramos),
   **pregunta antes de aplicarla**.

## Estructura

```
proyecto_condor/
├── README.md               ← este archivo
├── input/                  ← los datos y su diccionario (no se tocan)
├── scripts/                ← un script de R por resultado
└── output/                 ← gráficos y tablas producidos
```
