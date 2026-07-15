# Guía de uso de Inteligencia Artificial — Curso Nivelatorio de R

**CIENFI · Universidad Icesi · Prof. Eduard F. Martínez-González**

La IA generativa (ChatGPT, Claude, Gemini, GitHub Copilot) ya hace parte del
trabajo real con datos: los economistas la usan para escribir código, depurar
errores y redactar. Este curso **no la prohíbe: enseña a usarla bien**. Pero la
evidencia es clara — usarla como muleta desde el día uno *daña* el aprendizaje
(quien practica con la respuesta servida rinde peor cuando la IA no está), y
usarla con reglas lo *acelera*. Estas son las reglas.

---

## 1. Las tres reglas del curso

**Regla 1 — Primero su cerebro, luego la IA.**
Antes de consultar cualquier IA, intente resolver el problema usted: lea el
mensaje de error completo, consulte `?funcion`, revise la teoría de la unidad.
Solo después pregunte — y pregunte bien: describa lo que intentó. Su cerebro
sigue siendo la herramienta más poderosa que tiene; la IA es una versión
interactiva de buscar en Google, no un sustituto de pensar.

**Regla 2 — Todo lo que la IA produzca se verifica.**
La IA responde con la misma seguridad cuando acierta y cuando inventa. Usted es
responsable del 100% de lo que entrega. La sección 4 da la lista de
verificación mínima.

**Regla 3 — Todo uso se declara.**
Cada tarea y el proyecto final incluyen una **declaración de uso de IA**
(aunque sea "no usé"). Declarar el uso permitido no baja la nota; ocultarlo es
fraude académico.

## 2. Qué se permite en cada entrega (niveles de uso)

Adaptamos la escala internacional AIAS a cinco niveles. Cada entregable del
curso está etiquetado con su nivel:

| Nivel | Qué permite | Entregables del curso |
|---|---|---|
| **N0 — Sin IA** | Nada de IA | Quiz de cierre y sustentación oral del proyecto |
| **N1 — IA para entender** | Explicar conceptos y errores; NO escribir código por usted | Tarea 1 |
| **N2 — IA colaboradora** | Depurar su código, sugerir mejoras a algo que usted ya escribió | Tareas 2, 3 y 4 |
| **N3 — IA integrada** | Generar borradores de código que usted revisa, corrige y explica | Proyecto final |
| **N4 — Exploración** | Actividades diseñadas PARA usar IA | Actividades de IA de cada unidad |

**La condición del nivel 3:** en la sustentación usted debe poder **explicar
línea por línea** cualquier código de su proyecto. "Lo hizo la IA" no es una
explicación; es una confesión.

## 3. La declaración de uso de IA

Al final de cada script (las tareas ya traen el espacio):

```
## DECLARACION DE USO DE IA
## Herramienta usada: [ChatGPT / Claude / Copilot / ninguna]
## ¿Para que la uso?: [ej. "explicar el error de filter() en P3"]
## ¿Que verifico?: [ej. "compare nrow() antes y despues; consulte ?na_if"]
```

En el proyecto final, la declaración es un **apéndice** del README con los
prompts más importantes y qué se verificó de cada respuesta.

## 4. Lista de verificación: qué revisar SIEMPRE de una respuesta de IA

**Si le sugirió un paquete o función:**
- [ ] ¿Existe? Búsquelo en CRAN (https://cran.r-project.org) o corra
  `?funcion`. Los LLMs **inventan paquetes y argumentos** con total confianza
  (en estudios recientes, ~1 de cada 5 paquetes sugeridos en código generado
  no existía). Nunca `install.packages()` de algo que no verificó.

**Si le escribió o corrigió código:**
- [ ] ¿Corre? (eso es lo de menos)
- [ ] ¿Hace lo correcto? Compare **N antes y después** (`nrow()`), revise
  `summary()` de las variables creadas, cuente categorías con `table()`.
  El código que corre pero está mal es el error más caro: un join que duplica
  filas, un `filter()` que bota los `NA` sin avisar, un `na.rm = TRUE` que
  esconde un problema de datos.
- [ ] ¿Cambió la muestra? Si el N cambió y usted no lo decidió, la IA decidió
  por usted.

**Si le interpretó un resultado estadístico:**
- [ ] ¿Usó lenguaje causal ("el efecto de", "causa", "aumenta") sin un diseño
  causal? Córtelo: aquí decimos "está asociado a".
- [ ] ¿Las unidades son correctas? (¿pesos o puntos log? ¿la dependiente estaba
  en logaritmo?)
- [ ] ¿Confundió significancia (las estrellas) con magnitud/importancia?

## 5. Cómo preguntar bien (plantillas de prompts)

**Para entender un error (nivel 1):**
> Estoy aprendiendo R. Ejecuté este código: `[código]` y obtuve este error:
> `[mensaje completo]`. Ya intenté `[lo que intentó]`. **No me des el código
> corregido**: explícame qué significa el error y dame una pista de dónde
> mirar.

**Para depurar (nivel 2):**
> Este código corre pero el resultado no cuadra: espero ~500 filas y obtengo
> 7.000. `[código]`. ¿Qué hipótesis revisarías, en orden? Dame verificaciones
> en R para cada una, no la solución directa.

**Para revisar estilo (nivel 2/3):**
> Revisa este script según estas reglas: [pegar la sección 4 de la Guía de
> estilo del curso]. Señala incumplimientos, no reescribas todo.

**El anti-prompt (prohibido en N1/N2):**
> "Hazme la tarea 2" / "Escribe el código que limpia esta base" — pedir la
> solución completa le roba a usted la práctica que vino a buscar (y se nota
> en el quiz sin IA).

## 6. Herramientas recomendadas

| Herramienta | Para qué | Costo |
|---|---|---|
| Chat (Claude / ChatGPT / Gemini) | Explicar errores, revisar código, criticar interpretaciones | Capa gratuita suficiente |
| **GitHub Copilot** en RStudio | Autocompletado mientras escribe (Tools → Global Options → Copilot) | **Gratis para estudiantes** (GitHub Education) |
| `statlingua` (paquete R) | `explain(modelo)`: interpreta salidas de `lm()` — la usamos para criticarla en la Unidad 4 | Requiere API key |
| `ellmer` / `chattr` / `gander` | Chat y asistentes dentro de RStudio (opcional, para curiosos) | Requiere API key |

Si el chat ofrece un "modo aprendizaje/estudio" (p. ej. Claude Learning Mode),
actívelo: guía con preguntas en vez de entregar la respuesta.

## 7. Por qué estas reglas (la evidencia, en corto)

- En un experimento aleatorizado con ~1.000 estudiantes, practicar con GPT
  libre mejoró la tarea un 48%… y al quitarles el acceso rindieron **17% peor**
  que quienes nunca lo usaron. Con un tutor IA con reglas (no da la respuesta,
  exige intentar), el daño desapareció (Bastani et al., 2024).
- Los novatos que más dependen de la IA desarrollan una **ilusión de
  competencia**: creen que avanzan, hasta que hay que programar sin ayuda
  (Prather et al., 2024).
- Los LLMs interpretan regresiones con exceso de confianza: lenguaje causal
  injustificado y confusión entre significancia y magnitud (DeLuca y Brown,
  2025). Por eso la Unidad 4 los pone a **corregir a la IA**.

Referencias completas y más recursos: [investigacion_ia_recursos.md](investigacion_ia_recursos.md).

## 8. Las actividades con IA del curso

| Unidad | Actividad | Habilidad que entrena |
|---|---|---|
| 1 | [Primero tú, luego la IA](../unidad-1-fundamentos/actividad_ia_unidad-1.md) | Leer errores; usar la IA como tutor, no como oráculo |
| 2 | [El código corre… pero está mal](../unidad-2-manejo-datos/actividad_ia_unidad-2.md) | Detectar bugs silenciosos; verificar código ajeno |
| 3 | [Mejora esta figura](../unidad-3-visualizacion/actividad_ia_unidad-3.md) | Iterar con IA sin que cambie los datos |
| 4 | [Crítica al econometrista artificial](../unidad-4-regresiones/actividad_ia_unidad-4.md) | Auditar interpretaciones estadísticas de la IA |
