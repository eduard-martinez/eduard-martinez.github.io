# Cuestionario — Unidad 1: Fundamentos de R

Responda después de completar `tarea_unidad-1.R`. Cada respuesta sale de la
salida de su código: no se responde "de memoria".

**Nombre:** ______________________ **Código:** ______________

---

**Pregunta 1.** ¿Cuál es la **mediana** del vector `ingresos` (en COP)?

Respuesta: ______________

**Pregunta 2.** ¿Cuántas personas ganan **más que el promedio** del vector?

Respuesta: ______________

**Pregunta 3.** ¿Cuántos hogares tienen un ingreso per cápita **menor a 600.000**?

Respuesta: ______________

**Pregunta 4.** ¿Cuántas **filas** y **columnas** tiene `innovacion_empresas.csv` tal como se importa (sin limpiar)?

Filas: ______________ Columnas: ______________

**Pregunta 5.** ¿De qué tipo quedó la columna `num_empleados` al importar y por qué?

- [ ] `numeric`, porque contiene números de empleados
- [ ] `character`, porque contiene valores como `"ND"` que impiden leerla como número
- [ ] `logical`, porque tiene valores faltantes
- [ ] `factor`, porque es una variable categórica

**Pregunta 6.** ¿Cuántos `NA` tiene `gasto_id_millones`?

Respuesta: ______________

¿Esos faltantes son un error de la base o pueden tener sentido económico?

- [ ] Son un error: toda firma debe reportar gasto en I+D
- [ ] Tienen sentido: muchas firmas simplemente no invierten en I+D y no reportan
- [ ] Son un error de importación de R

**Pregunta 7 (conceptual).** Un compañero ejecuta `mean(firmas$gasto_id_millones)` y obtiene `NA`. ¿Cuál es la explicación y la solución?

Respuesta breve: _________________________________________________
