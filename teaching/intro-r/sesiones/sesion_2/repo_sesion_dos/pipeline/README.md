# Pipeline del proyecto

Cada carpeta contiene **un script** que hace **una sola tarea**, con la estructura
de la *Guía de estructura interna de un script* (CIENFI): encabezado, `0. setup`,
`1. import`, tareas numeradas y `export` al final.

```
pipeline/
├── 01_explore/01_explore.R                 Conocer las bases (no transforma)
├── 02_clean/02_clean.R                     Limpiar la base de firmas
├── 03_join/03_join.R                       Cruzar firmas con el referente sectorial
├── 04_tables/04_tables.R                   Construir las tablas descriptivas
├── validaciones/
│   ├── 01_validar_firmas.R                 Chequeos sobre la base limpia
│   └── 02_validar_firmas_sector.R          Chequeos sobre la base cruzada
└── run_pipeline.R                          Corre transformacion + validaciones
```

## Flujo de datos

| Etapa | Entrada | Salida |
|-------|---------|--------|
| **01_explore** | `data/raw/*.csv` | — (solo se mira) |
| **02_clean** | `data/raw/innovacion_empresas.csv` | `data/processed/01_cleaned/firmas_limpia.rds` |
| **03_join** | `firmas_limpia.rds` + `data/raw/sectores_agregado.csv` | `data/processed/02_joined/firmas_sector.rds` |
| **04_tables** | `firmas_sector.rds` | `output/02_tables/*.csv` |

## Reglas de estilo (de la guía)

- **Explorar ≠ transformar**: `01_explore` solo mira la base; no cambia ni guarda nada.
- **Transformar y exportar**: los scripts de transformación no llevan comprobaciones
  sueltas (`table`, `summary`, `stopifnot`…). Esos chequeos viven en `validaciones/`.
- Todos los **import** van juntos en la sección `1. Import data`.
- El **export** es siempre la última tarea.
- Librerías y rutas se definen una sola vez en `config/config.R`.

## Cómo correrlo

1. Abrir `01_explore/01_explore.R` y ejecutarlo línea por línea para conocer la base.
2. Correr el pipeline completo:
   ```r
   source("pipeline/run_pipeline.R")
   ```
   o cada script por separado (todos cargan `config/config.R` al inicio).
