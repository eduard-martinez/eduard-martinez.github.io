# Proyecto final — Innovación empresarial

**Curso Nivelatorio de R · CIENFI · Universidad Icesi**
**Modalidad:** parejas · **Nivel de uso de IA:** N3 (IA integrada, con declaración y sustentación sin IA)

El proyecto integra todo el curso: un análisis empírico completo, de la base
cruda a una tabla de regresión, dentro de un proyecto reproducible que se
sustenta oralmente.

---

## Los datos

Dos bases (en `datos/` del curso, descripción completa en el
[diccionario](../datos/diccionario_datos.md)):

- **`innovacion_empresas.csv`** — microdatos a nivel de firma (una fila por
  empresa), *deliberadamente desordenados*: categorías inconsistentes, tipos
  mal leídos, faltantes, valores extremos y filas duplicadas. Datos ficticios
  con fines docentes, inspirados en encuestas tipo EDIT del DANE.
- **`sectores_agregado.csv`** — base agregada por sector (referente nacional,
  limpia), para cruzar con la anterior mediante la llave `cod_sector`.

## Lo que deben hacer

Trabajen sobre una copia de la [plantilla de proyecto](../buenas_practicas/plantilla_proyecto/)
del curso. El análisis se organiza en el pipeline de tres scripts:

**`01_limpieza.R` — Del crudo al análisis (Unidad 2)**

1. Importar y **diagnosticar** la base de firmas (`glimpse`, `skim`).
2. **Limpiar** con decisiones documentadas (el "acta de limpieza" en
   comentarios): duplicados, categorías de texto, tipos (empleados y ventas),
   faltantes, valores imposibles y outliers.
3. Construir el indicador **`innovadora`** (producto, proceso u organizacional).
4. Exportar la base limpia a `datos/procesados/`.

**`02_descriptivas.R` — Los hechos (Unidades 2 y 3)**

5. Construir indicadores **por sector** (`group_by` + `summarise`): número de
   firmas, tasa de innovación, ventas (usen medianas: hay outliers), empleo.
6. **Cruzar** con la base agregada (`left_join` por `cod_sector`) y comparar la
   muestra con el referente nacional.
7. Producir **al menos 2 gráficos** exportados con `ggsave()` (por ejemplo:
   tasa de la muestra vs. referente por sector; distribución de ventas por
   condición de innovadora) y **1 tabla descriptiva** exportada.

**`03_regresiones.R` — La pregunta (Unidad 4)**

8. Estimar al menos **dos especificaciones** de la pregunta *"¿las firmas
   innovadoras venden más?"*:
   - `log(ventas_millones) ~ innovadora`
   - `log(ventas_millones) ~ innovadora + log(num_empleados)` (control de tamaño)
9. Producir la tabla con `msummary()` (nombres legibles, N y R², estrellas)
   exportada a `output/tablas/`.
10. **Interpretar** en comentarios: magnitud en % (`exp(β)−1`), lenguaje de
    asociación (no causal), y una frase sobre por qué cambia el N entre
    modelos.

## Entregables (por pareja)

1. La **carpeta del proyecto** completa (estructura de la plantilla, los tres
   scripts numerados, `datos/procesados/` y `output/` regenerables).
2. El **README.md** diligenciado: qué hace el proyecto, cómo se corre, acta
   resumida de limpieza y **apéndice de uso de IA** (herramientas, prompts
   clave, qué verificaron de cada sugerencia).
3. Una **presentación corta (5–8 min)** con los principales hallazgos.

**Antes de entregar, la prueba de fuego:** `Session → Restart R`, correr
`01 → 02 → 03` en orden. Si algo falla, no está listo.

## La sustentación (sin IA)

Cada pareja presenta sus resultados y **defiende su código en vivo**: el
profesor elige 2–3 bloques de sus scripts y ustedes explican qué hace cada
línea, qué decisión de limpieza hay detrás y qué pasaría si se cambiara. "Eso
lo generó la IA" no es una explicación — declarar el uso de IA es legítimo;
no poder explicar el propio código, no.

## Preguntas guía (para la presentación)

- ¿Qué problemas tenía la base y qué decidieron hacer con cada uno?
- ¿Qué sectores de la muestra innovan más y cómo se comparan con el referente
  nacional?
- ¿Las firmas innovadoras venden más? ¿Cuánto más, controlando por tamaño?
  ¿Por qué NO pueden decir que la innovación *causa* mayores ventas?

La rúbrica de calificación está en [rubrica_proyecto_final.md](rubrica_proyecto_final.md).
