# Diccionario de datos — Curso Nivelatorio de R (CIENFI · Universidad Icesi)

Tres bases acompañan el curso. Las dos primeras (innovación empresarial) se usan
en las Unidades 2 y 3 y en el **proyecto final**; la tercera (GEIH) se usa en las
Unidades 3 y 4 para descriptivas y regresiones.

---

## 1. `innovacion_empresas.csv` — microdatos a nivel de firma

Una fila por empresa (datos ficticios con fines docentes, inspirados en encuestas
tipo EDIT/DANE). **Base "sucia" a propósito**: hay que limpiarla antes de
analizarla (categorías inconsistentes, tipos mal leídos, faltantes, valores
extremos y filas duplicadas).

| Variable | Descripción | Notas de calidad (lo que hay que arreglar) |
|---|---|---|
| `id_empresa` | Identificador de la empresa (E0001…E0500). | Algunos en minúscula o con espacio final; **hay filas duplicadas**. |
| `cod_sector` | Código de sector (C, G, J, M, F, I, H). **Llave para cruzar.** | Limpio y confiable. |
| `sector_nombre` | Nombre del sector. | Mismo sector escrito de varias formas (mayúsculas, espacios, sinónimos). |
| `departamento` | Departamento de la empresa. | Variantes de un mismo departamento (`Bogota`, `BOGOTA`, `Bogota D.C.`…). |
| `anio` | Año de referencia (2022). | Constante (corte transversal). |
| `tamano` | Tamaño: Micro / Pequeña / Mediana / Grande. | Mayúsculas/acentos inconsistentes; algunos vacíos. |
| `num_empleados` | Número de empleados. | Leído como texto; faltantes (`""`, `ND`, `n/d`), negativos y ceros (errores). |
| `ventas_millones` | Ventas anuales (millones COP). | Decimal con coma (`857,3`); faltantes; ceros y outliers altos. |
| `gasto_id_millones` | Gasto en I+D (millones COP). | Muchos faltantes (firmas que no invierten en I+D): NA con sentido. |
| `innova_producto` | ¿Introdujo innovación de producto? | Codificación mixta: `Si/si/SI/No/no/NO/1/0`, espacios, faltantes. |
| `innova_proceso` | ¿Innovación de proceso? | Igual que arriba. |
| `innova_organizacional` | ¿Innovación organizacional? | Igual que arriba. |
| `exporta` | ¿La empresa exporta? | Igual que arriba. |

**Tareas sugeridas:** estandarizar nombres (`janitor::clean_names()`), recodificar
categorías, convertir tipos (texto → número, texto → lógico), tratar faltantes,
detectar y decidir qué hacer con outliers/duplicados, y construir un indicador
`innovadora` (= TRUE si innovó en producto, proceso u organización).

---

## 2. `sectores_agregado.csv` — base agregada por sector

Una fila por sector (7 filas). **Base limpia**, de referencia nacional, para
cruzar con la base de firmas.

| Variable | Descripción |
|---|---|
| `cod_sector` | Código de sector. **Llave para cruzar.** |
| `sector_desc` | Nombre canónico del sector. |
| `num_empresas_sector` | Total nacional de empresas del sector. |
| `valor_agregado_mmcop` | Valor agregado del sector (miles de millones COP). |
| `inversion_id_mmcop` | Inversión total en I+D del sector (miles de millones COP). |
| `tasa_innovacion_sectorial` | Tasa de innovación de referencia del sector (0–1). |
| `crecimiento_anual_pct` | Crecimiento anual del sector (%). |

**Cruce sugerido:** limpiar la base de firmas → construir indicadores por
sector (p. ej. tasa de innovación de la muestra, ventas promedio, empleo total)
con `group_by(cod_sector) |> summarise(...)` → unirlos con esta base mediante
`left_join(..., by = "cod_sector")` y comparar la muestra con el referente
nacional.

---

## 3. `geih_nivelacion.csv` — extracto docente de la GEIH (DANE)

Una fila por **persona ocupada** (21.821 filas). Extracto real de la Gran
Encuesta Integrada de Hogares (GEIH, cabeceras, enero), simplificado con fines
docentes: variables renombradas y muestra restringida a ocupados de 18 a 65 años
con ingreso laboral positivo. **Base limpia**: lista para descriptivas y
regresiones (Unidades 3 y 4).

| Variable | Descripción |
|---|---|
| `id` | Identificador de la persona (1…21821). |
| `sexo` | `hombre` / `mujer`. |
| `edad` | Edad en años (18–65). |
| `anios_educacion` | Años de educación aprobados (0–26). |
| `nivel_educativo` | Máximo nivel alcanzado: `ninguno`, `primaria`, `secundaria`, `media`, `superior`. |
| `departamento` | Departamento de residencia (24 cabeceras GEIH). |
| `ingreso_laboral` | Ingreso laboral mensual (COP). Tiene **outliers reales**: úsela con `log()`. |
| `horas_semana` | Horas normalmente trabajadas por semana. |

**Usos sugeridos:** descriptivas por grupo (brecha de ingresos por sexo y nivel
educativo), histogramas y boxplots de ingreso (en niveles vs. en logs), y la
ecuación de Mincer: `log(ingreso_laboral) ~ anios_educacion + edad`.

*Generado con `_preparar_geih.R` a partir de los microdatos originales del DANE
(módulos "Características generales" y "Ocupados"). El ingreso corresponde a
`INGLABO` y las horas a `P6800`; la llave del cruce es directorio–secuencia–orden.*
