# Cuestionario — Unidad 2: Manejo de datos con tidyverse

Responda después de completar `tarea_unidad-2.R`. Cada respuesta numérica sale
de la salida de su código.

**Nombre:** ______________________ **Código:** ______________

---

**Pregunta 1.** ¿Cuántas **filas** tiene la base cruda `firmas_raw`?

Respuesta: ______________

**Pregunta 2.** ¿Cuántas filas **duplicadas** eliminó `distinct()`?

Respuesta: ______________

**Pregunta 3.** Después de estandarizar mayúsculas y espacios, ¿cuántas categorías **quedan** en `sector_nombre`? ¿Por qué no quedan 7?

Número: ______________

- [ ] Porque `toupper()` no funciona con tildes
- [ ] Porque hay **sinónimos** del mismo sector que la estandarización de mayúsculas no resuelve
- [ ] Porque quedaron duplicados sin eliminar
- [ ] Porque el sector J no tiene nombre

**Pregunta 4.** Después de la limpieza, ¿cuántos `NA` tiene `num_empleados`?

Respuesta: ______________

**Pregunta 5.** ¿Cuál es la **mediana** de `ventas_millones` después de la conversión (en millones de COP, un decimal)?

Respuesta: ______________

**Pregunta 6.** ¿Cuál es la **tasa de innovación** de la muestra (en %, un decimal)?

Respuesta: ______________

**Pregunta 7.** ¿Qué sector (código) tiene la **mayor tasa de innovación** en la muestra?

- [ ] C — Industria manufacturera
- [ ] G — Comercio
- [ ] J — Información y comunicaciones
- [ ] M — Actividades profesionales

**Pregunta 8.** ¿En qué sector la muestra **supera por más puntos** al referente nacional (mayor brecha)?

Respuesta (código): ______________

**Pregunta 9 (conceptual).** Su `left_join()` devolvió 7 filas (una por sector). Si hubiera devuelto 14, ¿cuál sería la causa más probable?

- [ ] La base agregada tiene la llave `cod_sector` **duplicada** y el join multiplicó filas
- [ ] `left_join()` siempre duplica las filas
- [ ] Faltó el argumento `.groups = "drop"`
- [ ] La base de firmas tenía sectores de más
