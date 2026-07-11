# Cuestionario — Unidad 4: Regresiones básicas

Responda después de completar `tarea_unidad-4.R`. Los coeficientes se reportan
con 3 decimales.

**Nombre:** ______________________ **Código:** ______________

---

**Pregunta 1.** En el modelo simple `log(ingreso_laboral) ~ anios_educacion`, ¿cuál es el coeficiente de `anios_educacion`?

Respuesta: ______________

Escriba su interpretación en una frase (con unidades y "asociado a"):

_________________________________________________________________

**Pregunta 2.** En el modelo con controles (educación + edad + sexo), ¿cuál es el coeficiente de `sexomujer`?

Respuesta: ______________

**Pregunta 3.** Usando `exp(coef) - 1`, ¿cuál es la brecha **porcentual exacta** de ingresos de las mujeres frente a los hombres, controlando por educación y edad? (en %, un decimal)

Respuesta: ______________

**Pregunta 4.** Con efectos fijos de departamento y errores robustos (`feols`), ¿cuál es el coeficiente de `anios_educacion`?

Respuesta: ______________

¿Qué concluye de que cambie tan poco frente al modelo sin efectos fijos?

- [ ] La relación educación–ingreso NO está explicada por diferencias entre departamentos
- [ ] Los efectos fijos están mal estimados
- [ ] La educación no importa dentro de los departamentos
- [ ] El modelo sin efectos fijos era incorrecto

**Pregunta 5.** En su tabla de `msummary()`, ¿el número de observaciones (N) cambia entre las tres columnas?

- [ ] No: es 21.821 en las tres, porque ninguna variable del modelo tiene `NA`
- [ ] Sí: cae en el modelo 2 por los `NA` de edad
- [ ] Sí: cae en el modelo 3 porque los efectos fijos eliminan observaciones
- [ ] No se puede saber desde la tabla

**Pregunta 6.** Transcriba aquí (o en su script) los **tres errores** que identificó en la interpretación generada por la IA:

Error 1: _________________________________________________________

Error 2: _________________________________________________________

Error 3: _________________________________________________________

**Pregunta 7 (conceptual).** ¿Por qué en este curso escribimos "un año adicional de educación está **asociado a** un ingreso 9,3% mayor" y no "la educación **aumenta** el ingreso en 9,3%"?

Respuesta breve: _________________________________________________
