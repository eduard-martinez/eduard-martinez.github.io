# Pipeline del proyecto — Sesión 3 (GEIH)

Cada carpeta contiene **un script** que hace **una sola tarea**, con la estructura
de la *Guía de estructura interna de un script* (CIENFI): encabezado, `0. setup`,
`1. import`, tareas numeradas y `export` al final.

Es el mismo esqueleto del ejemplo de la sesión 2, ahora sobre **personas**
(`geih_nivelacion.csv`) y cerrando el flujo: **describir → visualizar → estimar**.

```
pipeline/
├── 01_explore/01_explore.R                 Conocer la GEIH (no transforma)
├── 02_clean/02_clean.R                     Dejar la base lista para el analisis
├── 03_descriptives/03_descriptives.R       Tablas descriptivas y figuras
├── 04_models/04_models.R                   Los 4 modelos + tabla de regresiones
├── validaciones/
│   ├── 01_validar_geih.R                   Chequeos sobre la base lista
│   └── 02_validar_modelos.R                Chequeos sobre los modelos estimados
└── run_pipeline.R                          Corre transformacion + validaciones
```

## Flujo de datos

| Etapa | Entrada | Salida |
|-------|---------|--------|
| **01_explore** | `data/raw/geih_nivelacion.csv` | — (solo se mira) |
| **02_clean** | `data/raw/geih_nivelacion.csv` | `data/processed/01_cleaned/geih_lista.rds` |
| **03_descriptives** | `geih_lista.rds` | `output/02_tables/*.csv` + `output/01_graphs/*.png` |
| **04_models** | `geih_lista.rds` | `output/02_tables/tabla_regresiones.csv` + `modelos.rds` |

## Por qué hay un `02_clean` si la GEIH "viene limpia"

Viene limpia de **errores** (no hay tipos rotos, ni texto sucio, ni duplicados),
pero no viene lista para el **análisis**. `02_clean` hace lo que sí falta:

- fija la población de análisis (18–65 años, ingreso positivo),
- **ordena** `nivel_educativo` con `factor(..., levels = ...)` — sin esto R lo
  ordena alfabéticamente y las tablas y figuras salen sin sentido,
- crea las variables derivadas (`log_ingreso`, `ingreso_por_hora`, `mujer`).

Limpiar no es solo reparar: es dejar la base en la forma que el análisis necesita.

## Reglas de estilo (de la guía)

- **Explorar ≠ transformar**: `01_explore` solo mira la base; no cambia ni guarda nada.
- **Transformar y exportar**: los scripts de transformación no llevan comprobaciones
  sueltas (`table`, `summary`, `stopifnot`…). Esos chequeos viven en `validaciones/`.
- Todos los **import** van juntos en la sección `1. Import data`.
- El **export** es siempre la última tarea.
- Librerías y rutas se definen una sola vez en `config/config.R`.
- **Nada de capturas de pantalla**: toda figura y toda tabla se exporta desde el
  código, con dimensiones y resolución explícitas.

## Cómo correrlo

1. Abrir `01_explore/01_explore.R` y ejecutarlo línea por línea para conocer la base.
2. Correr el pipeline completo:
   ```r
   source("pipeline/run_pipeline.R")
   ```
   o cada script por separado (todos cargan `config/config.R` al inicio).
