# Tiendas Andinas S.A.S. — Diagnóstico de ventas (marzo–abril 2026)

## Contexto del negocio

Tiendas Andinas es una cadena de 6 minimercados de barrio en Cali, Bogotá y
Medellín. La gerente general necesita, para el comité del viernes, un primer
informe sobre las ventas de marzo y abril de 2026.

El problema: la base `data/ventas_tiendas.csv` la armaron las tiendas a mano
(cada una con su propio criterio) y **nadie la ha revisado**. Se sospecha que
tiene errores de digitación, formatos mezclados y registros repetidos.

## Las tres misiones

1. **Diagnóstico de calidad.** Explorar `data/ventas_tiendas.csv` y documentar
   TODOS los problemas de calidad encontrados (con conteos exactos) en
   `output/diagnostico.md`. En esta misión no se modifica ningún dato.

2. **Limpieza documentada.** Escribir `scripts/01_limpieza.R` que corrija los
   problemas y guarde el resultado en `data/ventas_limpias.csv`. Cada decisión
   de limpieza queda comentada en el script (qué se corrigió, cuántas filas
   afectó y por qué se decidió así).

3. **KPIs y gráficos.** Escribir `scripts/02_eda.R` que, a partir de la base
   limpia, calcule el ingreso (precio × unidades) y produzca:
   - una tabla de KPIs por ciudad (ingreso total, ticket promedio, número de
     transacciones) exportada a `output/kpis_ciudad.csv`, y
   - dos gráficos con título y ejes etiquetados, exportados como `.png` a
     `output/` con `ggsave()`.

## Diccionario de datos

| Columna    | Qué debería contener                                  |
|------------|--------------------------------------------------------|
| `fecha`    | Fecha de la venta (marzo–abril 2026)                   |
| `tienda`   | Nombre de la tienda (6 tiendas "Andina ...")           |
| `ciudad`   | Cali, Bogotá o Medellín                                |
| `categoria`| Alimentos, Bebidas, Aseo o Snacks                      |
| `producto` | Nombre del producto                                    |
| `precio`   | Precio unitario en COP (número positivo)               |
| `unidades` | Unidades vendidas (entero positivo)                    |
| `canal`    | Tienda u Online                                        |

## Estructura del proyecto

```
tiendas_andinas/
├── README.md          <- este archivo (la misión)
├── data/
│   └── ventas_tiendas.csv   <- base ORIGINAL (no se modifica nunca)
├── scripts/           <- aquí van los scripts .R
└── output/            <- aquí van diagnóstico, tablas y gráficos
```

## Reglas del proyecto

- La base original `data/ventas_tiendas.csv` **nunca se sobreescribe**: toda
  limpieza produce un archivo nuevo.
- Los scripts deben correr de arriba a abajo sin errores con `Rscript`.
- Librerías disponibles: `dplyr` y `ggplot2` (el equipo trabaja con ellas
  desde la semana 4).
