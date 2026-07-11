# [Nombre del proyecto]

**Autor(es):** [Nombre Apellido] · [correo]
**Curso:** Nivelatorio de R — CIENFI, Universidad Icesi
**Última actualización:** [AAAA-MM-DD]

## ¿Qué hace este proyecto?

[Dos o tres frases: la pregunta que responde el análisis y con qué datos.]

## Datos

| Archivo (en `datos/originales/`) | Fuente | Grano |
|---|---|---|
| `innovacion_empresas.csv` | Plataforma del curso (datos docentes tipo EDIT) | Una fila por firma |
| `sectores_agregado.csv` | Plataforma del curso | Una fila por sector |

Los datos originales **no se modifican**. Las bases limpias que generan los
scripts quedan en `datos/procesados/`.

## ¿Cómo se corre?

Abrir `*.Rproj` y ejecutar los scripts en orden:

1. `scripts/01_limpieza.R` — limpia la base cruda → `datos/procesados/firmas_limpias.rds`
2. `scripts/02_descriptivas.R` — figuras y tablas descriptivas → `output/`
3. `scripts/03_regresiones.R` — modelos y tabla de regresión → `output/tablas/`

## Decisiones de limpieza

[El "acta": qué problemas encontró en los datos y qué decidió hacer con cada
uno. Ejemplo: "ceros de ventas tratados como NA por ser errores de captura".]

## Uso de IA

[Declare aquí las herramientas de IA usadas, para qué, y cómo verificó sus
sugerencias — ver la Guía de uso de IA del curso.]
