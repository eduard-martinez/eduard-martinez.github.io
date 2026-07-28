# Guía de calificación — Taller 5: "el proyecto que nadie preguntó" (Andina Cowork)

> **Uso interno del profesor** — no compartir con estudiantes.
> Taller conceptual (sin R). Rúbrica: P1 1.0 · P2 1.0 · P3 1.0 · P4 1.0 · P5 0.5 · P6 0.5 = **5.0**.
> Regla transversal: respuestas que no toman posición ("depende") = no respondidas. Coherencia interna P2↔P4.

## Cifras del caso (para tener a mano)

- Perder un socio (reemplazarlo) cuesta **$80.000**.
- El incentivo de retención (llamada + mes gratis) cuesta **$25.000** y funciona el **50%** de las veces.
- Beneficio esperado de contactar a un socio que SÍ se iba: 0.5 × 80.000 = **$40.000**.
- En el P4d el incentivo cambia a **$210.000** (plan Premium 3 meses).

## P1 — La pregunta (1.0)

- **a (0.3)**: la frase de la gerente falla las tres: no específica (¿qué socios?, ¿cuándo?), no accionable (no hay decisión nombrada), no medible ("entender por qué" no define un output).
- **b (0.4)**: reformulación tipo *"¿Qué socios activos tienen alta probabilidad de cancelar en los próximos 30/60 días?"*. Debe producir una **lista/número/grupos**, no un ensayo. Reformulaciones vagas tipo "¿qué factores influyen…?" NO cumplen (lo advierte el propio enunciado).
- **c (0.3)**: acción literal nombrada: *"la gerente manda al equipo a llamar a esos socios con la oferta de retención"* (o equivalente).

## P2 — La tarea (1.0)

- **a (0.4)**: clasificación (si la reformulación fue "quiénes cancelan") — se acepta segmentación/predicción **solo si es coherente con la pregunta que ellos escribieron**.
- **b (0.4)**: el target existe: `cancelo` (sí/no) → **supervisado**. Si eligieron segmentación deben reconocer que NO usarían `cancelo` como target.
- **c (0.2)**: output concreto (lista de socios en riesgo con probabilidad) + quién lo usa (gerente/equipo de retención) y para qué (priorizar llamadas).

## P3 — El proceso (1.0)

- **a (0.3)**: un dato interno plausible que falta (p. ej., uso de servicios adicionales, asistencia a eventos, canal de venta, encuestas de satisfacción, tickets de soporte) + un externo (competencia cercana a cada sede, precios de mercado, estrato/zona). Con media línea de justificación cada uno.
- **b (0.4)**: dos problemas creíbles PARA ESTA BASE: `plan` escrito de varias formas (categórica capturada a mano), faltantes en `edad` o `reclamos`, duplicados por migración, `check_ins` negativos o imposibles, fechas de pago futuras… Lo importante: ligados al **tipo de variable** de la lista, con su tratamiento.
- **c (0.3)**: dos hallazgos verificables + su gráfico de la semana 4: churn por `plan` o por `sede` (barras), distribución de `check_ins` de quienes cancelan vs. no (histograma/boxplot), `reclamos` vs. `cancelo` (barras/boxplot).

## P4 — La métrica y el costo del error (1.0) ⚠️ el punto fino

- **a (0.2)**: FN = socio que SÍ iba a cancelar y el modelo no señaló → se va sin que nadie lo llame. FP = socio que NO iba a cancelar pero fue señalado → llamada + mes gratis innecesarios.
- **b (0.3)**: costo FN = **$80.000** (hay que reponerlo). Costo FP = **$25.000** (el incentivo regalado). Aceptar refinamiento: el FN cuesta 80.000 "menos lo que igual se habría perdido si la llamada falla" — no exigirlo.
- **c (0.3)**: con FN ($80.000) > FP ($25.000) → **recall**: el error caro es dejarlo escapar. La cuenta que lo respalda: contactar a un churner real tiene valor esperado 0.5×80.000 − 25.000 = **+$15.000**; el sobrecosto de llamar de más es "solo" 25.000.
- **d (0.2) — dos niveles de respuesta:**
  - **Aceptable (puntaje completo)**: con incentivo a $210.000, el FP pasa a costar $210.000 ≫ $80.000 del FN → la asimetría se invierte y se prioriza **precision** (llamar solo a los casi-seguros). Debe venir CON la cuenta.
  - **Excelente (anotar como distinción, vale lo mismo)**: la cuenta completa muestra que la campaña **deja de ser viable del todo**: incluso acertando el 100% de las llamadas, el beneficio esperado por churner contactado es 0.5×80.000 = **$40.000 < $210.000**. Ni la precisión perfecta la salva. La respuesta profesional es **replantear el incentivo** (negociar uno más barato, reservar el Premium solo para socios de altísimo valor — dato que la base no trae — o no lanzar la campaña).
  - **NO aceptar**: "sigo con recall" sin cuenta, o "cambia a precision" sin cuenta.

## P5 — El mensaje de negocio (0.5) ⚠️ hay dos cuentas defendibles

Resultado técnico dado: recall 0.72, precision 0.55, baseline 0.50, **400 socios señalados**.

- **Cuenta esperada (ingenua, con los 4 números de la pista)**: contactar 400 cuesta 400×25.000 = **$10.0M**; si se retiene al 50%, se salvan 200 socios × 80.000 = **$16.0M** → ahorro neto ≈ **$6.0M**. Mensaje tipo: *"Invertir $10M en llamar a 400 socios en riesgo evita $16M en reposiciones: $6M netos. Recomiendo lanzar la campaña este mes."* → **puntaje completo** (tiene número, costo-beneficio y acción).
- **Cuenta rigurosa (usa la precision — anotar como excelente)**: de los 400 señalados solo ~55% (≈220) iban a cancelar de verdad; se retienen ≈110 → beneficio 110×80.000 = **$8.8M** vs. costo **$10.0M** → **neto −$1.2M**. El mensaje cambia: *"tal como está, llamar a los 400 pierde $1.2M; recomiendo contactar solo el tramo de mayor probabilidad o abaratar el incentivo"*. Es MÁS correcta que la esperada — puntaje completo + reconocimiento. (Para que ambas cuentas dieran positivo, el incentivo tendría que costar < 0.55×40.000 = $22.000; si algún semestre quieres esa coherencia, baja la cifra del caso a ~$15.000.)
- **b (0.15)**: la frase técnica es inútil porque el stakeholder no puede traducir recall/AUC a plata, riesgo o tiempo — y la traducción es trabajo del analista.

## P6 — La ficha del proyecto (0.5)

Se evalúa **que esté diligenciada con contenido real** (los 5 espacios, sin muletillas), no la calidad de la pregunta (eso es de la Entrega 1). Ficha con espacios en blanco o rellenos genéricos ("depende", "varios datos") → 0.25 o menos.

## Descuentos transversales

- Respuesta ambigua/sin posición = en blanco (regla 3 del enunciado).
- Cifra citada sin conclusión (regla 2) → ese literal no suma.
- Incoherencia P2↔P4 (p. ej., dijo "segmentación" y luego habla de FN/FP de un clasificador) → −0.2 del P4.
- Uso de IA para formular pregunta/métrica/mensaje (política restringida de la semana): tratar según el reglamento del curso; la declaración final es obligatoria.
