# Un simulacro modelo, con su clave y su verificación

Esta es la vara. Un simulacro de la semana 5 tal como debe verse para el estudiante, luego la
clave tal como se entrega después de que responde, y por último la verificación de calibración
que se hace antes de enviarlo (esa parte nunca se le muestra al estudiante).

---

## Lo que ve el estudiante (mensaje 1)

### Simulacro · Semana 5 · El proceso analítico

**Contexto.** Una clínica odontológica de Cali con seis consultorios pierde cerca del 18 % de sus
citas porque el paciente no llega y nadie avisa. La directora le dice al analista: «quiero
entender el problema de las inasistencias». La clínica guarda tres años de citas con la hora, el
tipo de procedimiento, la antigüedad del paciente, si confirmó por WhatsApp y si asistió o no.
Una silla vacía cuesta la hora del odontólogo; una llamada de recordatorio cuesta dos minutos de
la recepcionista. La directora quiere decidir a quién llamar el día anterior.

**1.** ¿Por qué «entender el problema de las inasistencias» todavía no es una pregunta de negocio?
a) Porque no dice qué haría la clínica distinto mañana con la respuesta: es un tema, no una pregunta.
b) Porque no menciona qué modelo se va a usar, y una pregunta de negocio nombra la técnica del análisis.
c) Porque las inasistencias no se pueden medir con las citas guardadas hasta que pase un año completo.
d) Porque la formuló la directora y no el analista, que es quien conoce los datos de la clínica.

**2.** ¿Qué tarea analítica corresponde a «¿qué pacientes no asistirán a su cita de mañana?», y qué lo confirma?
a) Predicción, porque la salida es el número de citas perdidas que tendrá la clínica cada día del mes.
b) Segmentación, porque agrupa a los pacientes según su riesgo sin necesidad de una etiqueta previa.
c) Clasificación, porque la respuesta es sí o no, y el historial ya trae la columna de si asistió o no.
d) Detección de anomalías, porque quienes faltan son casos raros frente a la mayoría que sí asiste.

**3.** Dado el costo de cada tipo de error, ¿qué métrica conviene y por qué?
a) Accuracy, porque resume en una sola cifra los aciertos sin distinguir el tipo de error que se cometió.
b) Precision, porque lo importante es no molestar con llamadas a quien de todos modos iba a asistir a la cita.
c) No hace falta una métrica: con costos tan distintos la decisión es de la directora, no del modelo.
d) Recall, porque no llamar a quien iba a faltar cuesta una hora de consultorio y llamar de más, dos minutos.

**4.** El analista reporta «el modelo tiene 84 % de accuracy». ¿Qué le falta a esa frase para la directora?
a) El detalle técnico: las variables usadas, la partición entre entrenamiento y prueba y el código con el que se entrenó el modelo.
b) El baseline y la consecuencia: «todos asisten» ya acierta el 82 %, y a la directora se le habla de citas salvadas y costo de llamadas.
c) La validación de las recepcionistas, que conocen a los pacientes que suelen faltar y pueden confirmar si la cifra tiene sentido.
d) La comparación con otras clínicas de la ciudad, para mostrarle a la directora que un 84 % es competitivo en el sector odontológico.

Responde con las cuatro letras, por ejemplo: 1b, 2d, 3a, 4c.

---

## La clave (mensaje 2, solo después de que respondió «1a, 2c, 3b, 4b»)

**1 → a** ✓  Si le entregan la respuesta hoy, nadie sabe qué hacer distinto mañana: es un tema.
*Por qué no las otras:* b confunde pregunta con técnica; c inventa una restricción; d confunde quién pregunta con qué se pregunta.
*Repasa:* «Etapa 1: formular la pregunta» y el test de la pregunta.

**2 → c** ✓  La respuesta es una categoría, asiste o no, y el historial ya trae esa etiqueta: clasificación supervisada.
*Por qué no las otras:* a pide un número, que es otra pregunta; b no tiene target, y aquí sí lo hay; d trata como raro algo que pasa en el 18 % de las citas.
*Repasa:* «Tipos de tareas analíticas» y la pregunta que decide: ¿hay ejemplos históricos con la respuesta?

**3 → d** ✗  Contestaste b. El error caro es dejar de llamar a quien iba a faltar (una hora de consultorio); el barato es llamar de más (dos minutos). Cuando el falso negativo cuesta más, se prefiere recall.
*Por qué no las otras:* a ignora la asimetría; b protege el error barato; c niega que el costo del error decida la métrica.
*Repasa:* «Etapa 5: construir y validar el modelo», el caso churn y la asimetría del costo.

**4 → b** ✓  Sin baseline el 84 % no dice nada: «todos asisten» ya acierta el 82 %. Y a la directora se le habla de citas salvadas y costo de llamadas, no de accuracy.
*Por qué no las otras:* a y d cambian de tema; c no reemplaza la comparación con el baseline.
*Repasa:* «Etapa 6: comunicar los resultados».

**3 de 4.** Fallaste donde el costo del error decide la métrica: vuelve al caso churn de la teoría
antes de seguir. ¿Otro contexto de la semana 5, otra semana o el parcial completo?

---

## Verificación antes de enviar (no se muestra)

- Material abierto: teoría de la semana 5; el contexto usa sus ideas (test de la pregunta, tarea
  analítica, costo asimétrico, baseline y comunicación) y ninguna de otra semana.
- Decisión pendiente: a quién llamar el día anterior. Cifras usadas: 18 % (preguntas 2 y 4), la
  hora contra los dos minutos (pregunta 3), 82 % de asistencia (pregunta 4).
- Interpretación, no definición: ninguna pregunta se responde recitando qué es una tarea analítica
  o qué es recall.
- Largo de las opciones por pregunta (caracteres): 1 → 98/101/99/93 (razón 1,09); 2 → 99/97/100/96 (razón 1,04); 3 → 102/107/98/106 (razón 1,09); 4 → 128/134/128/131 (razón 1,05). La correcta es la más larga en: la 2, por 1 caracteres; la 4, por 3 caracteres.
- Misma forma gramatical dentro de cada pregunta: explicaciones con «porque» en la 1, 2 y 3;
  sustantivos en la 4.
- Clave a c d b: sin tres iguales seguidas, sin escalera, sin alternancia; una letra por opción
  esta vez, lo cual no debe repetirse en el siguiente contexto.
- Dificultad: 1 y 2 de aplicación directa; 3 y 4 exigen decidir entre opciones razonables.
- Sector ficticio (clínica odontológica), sin Cóndor, sin empresas reales.
