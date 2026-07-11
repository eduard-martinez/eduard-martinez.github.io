# Cuestionario — Unidad 3: Visualización y descriptivas

Responda después de completar `tarea_unidad-3.R`, mirando sus gráficos y tablas.

**Nombre:** ______________________ **Código:** ______________

---

**Pregunta 1.** ¿Cuál de las dos distribuciones del ingreso es aproximadamente **simétrica**?

- [ ] El ingreso en niveles
- [ ] El logaritmo del ingreso
- [ ] Ninguna de las dos
- [ ] Las dos por igual

**Pregunta 2.** En el boxplot por sexo, ¿qué grupo tiene la **mediana** más alta?

- [ ] Hombres
- [ ] Mujeres
- [ ] Son idénticas

**Pregunta 3.** ¿Cuál es el ingreso **mediano** del nivel educativo `superior` (en COP)?

Respuesta: ______________

**Pregunta 4.** En el diagrama de dispersión educación–ingreso, la relación es:

- [ ] Positiva (la recta sube)
- [ ] Negativa (la recta baja)
- [ ] Nula (recta plana)

**Pregunta 5.** ¿Cuál es la **mediana** del ingreso laboral de las **mujeres** (en COP)?

Respuesta: ______________

**Pregunta 6.** Pegue la **ruta relativa** (dentro de su proyecto) del gráfico que exportó con `ggsave()`:

Respuesta: ______________

**Pregunta 7 (conceptual).** La brecha de ingresos por sexo es mayor si se calcula con la **media** que con la **mediana**. ¿Qué explica esa diferencia?

- [ ] Los outliers de ingresos altos (más frecuentes entre hombres) arrastran la media
- [ ] La mediana está mal calculada cuando hay NA
- [ ] La media siempre es mayor que la mediana
- [ ] Es un error de redondeo

**Pregunta 8 (conceptual).** ¿Por qué usamos `geom_col()` y no `geom_bar()` en la Pregunta 3?

- [ ] Porque la altura de la barra es un valor **ya calculado** (la mediana), no un conteo de filas
- [ ] Porque `geom_bar()` no acepta `fill`
- [ ] Porque `geom_col()` ordena las barras automáticamente
- [ ] Son intercambiables
