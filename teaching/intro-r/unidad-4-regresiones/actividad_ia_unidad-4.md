# Actividad con IA — Unidad 4: "Crítica al econometrista artificial"

**Nivel de uso de IA:** N4 (actividad diseñada para usar IA) · **Modalidad:** parejas · **Tiempo estimado:** 60 min

## Objetivo

Auditar interpretaciones de regresiones generadas por IA. La evidencia muestra
que los LLMs interpretan resultados con **exceso de confianza**: lenguaje
causal injustificado, unidades incorrectas con variables en logaritmo y
confusión entre significancia y magnitud. Quien no sabe detectarlo, firma
informes con errores; quien sabe, tiene un asistente útil.

## Mecánica

**Paso 1 — Genere el material (10 min).**
Estime el modelo de la Tarea 4:

```r
modelo_2 <- lm(log(ingreso_laboral) ~ anios_educacion + edad + sexo, data = geih)
summary(modelo_2)
```

Copie la salida completa de `summary()` y pídale a su chatbot:

> "Interpreta estos resultados de una regresión para un informe de política
> pública. Datos: encuesta de hogares de Colombia, corte transversal.
> [pegar salida]"

**Paso 2 — Audite con la rúbrica (25 min).**
Califique la respuesta de la IA punto por punto (1 = mal, 3 = bien):

| # | Criterio de auditoría | 1–3 | Evidencia (cita textual de la IA) |
|---|---|---|---|
| 1 | ¿Evita lenguaje causal ("causa", "efecto de", "aumenta el ingreso") o lo usa sin justificación? | | |
| 2 | ¿Interpreta las unidades correctamente? (dependiente en **log** → puntos log/%; ¿usó `exp(β)−1` para la dummy grande?) | | |
| 3 | ¿Lee la dummy contra su **categoría de referencia** explícita? | | |
| 4 | ¿Distingue significancia estadística de **magnitud económica**? | | |
| 5 | ¿Dice algo válido (y prudente) sobre el R² y lo que el modelo NO explica? | | |
| 6 | ¿Menciona limitaciones de identificación (variables omitidas, selección) o vende el resultado como definitivo? | | |

**Paso 3 — Contrainterrogue (10 min).**
Donde la IA falló, presiónela: *"¿Puedes afirmar causalidad con un corte
transversal? ¿Qué supuestos necesitas?"*, *"La dependiente está en logaritmo:
¿en qué unidades está el −0.41 de la dummy?"*. Anote si corrige bien cuando se
le confronta (típicamente sí — lo cual confirma que **la primera respuesta no
era su mejor respuesta**, y que el auditor era usted).

**Paso 4 — Escriba la versión buena (15 min).**
Redacte la interpretación correcta en ≤ 6 líneas: magnitudes con unidades,
"asociado a", referencia de la dummy, una frase sobre lo que estos datos no
permiten afirmar.

**Variante opcional (para curiosos):** repita el Paso 1 con el paquete
`statlingua` (`explain(modelo_2, audience = "student")`) y compare qué hace
mejor y qué hace peor que el chat.

## Entregable

Un documento corto (script con comentarios o .md) con: la respuesta original de
la IA, la rúbrica diligenciada con citas, el contrainterrogatorio, y su versión
corregida.

## Qué se evalúa

| Criterio | Peso |
|---|---|
| Rúbrica bien aplicada, con citas textuales como evidencia | 40% |
| Calidad del contrainterrogatorio (preguntas que van al punto débil) | 20% |
| Versión corregida: unidades, referencia, sin causalidad, magnitud vs. significancia | 40% |

**Regla de oro que deja esta actividad:** la IA redacta rápido; el criterio
econométrico lo pone usted. En la Maestría (y en el trabajo), usted es quien
firma.
