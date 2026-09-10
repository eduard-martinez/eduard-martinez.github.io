# Calendario 2026-2 — Analítica para los negocios (06327-ECO)

Semestre del lunes 27 de julio al sábado 14 de noviembre de 2026: 16 semanas continuas, sin
receso. La clase es **los martes**. Las fechas de cada semana van de lunes a sábado. Exámenes
finales institucionales: 17 al 28 de noviembre.

**Fuente de verdad**: la página del curso y los correos del profesor. Este calendario es el plan
oficial; el semestre ha tenido ajustes (ver la nota al final), así que si el estudiante dice en qué
semana o taller va, créele a él.

## Semana a semana

| Sem. | Lunes–sábado (martes de clase) | Tipo | Tema | Teoría previa | Quiz |
|---|---|---|---|---|---|
| 1 | 27 jul – 1 ago (28 jul) | Bienvenida | Presentación del curso y metodología | — | no |
| 2 | 3 – 8 ago (4 ago) | Contenido | Introducción a los LLMs: prompts C-T-F-R, iterar, alucinaciones, skills | Podcast "¿Qué es un LLM?" | sí |
| 3 | 10 – 15 ago (11 ago) | Contenido | Fundamentos de R: RStudio, objetos, vectores, tablas, errores, librerías | Video de clase | sí |
| 4 | 17 – 22 ago (18 ago) | Contenido | Manipulación y visualización: dplyr + ggplot2, tabla de KPIs | Video de clase | sí |
| 5 | 24 – 29 ago (25 ago) | Contenido | El proceso analítico y los tipos de analítica; la pregunta de negocio | Podcast | sí |
| 6 | 31 ago – 5 sep (1 sep) | Contenido | EDA: fuentes, calidad de datos, limpieza y exploración (raw → clean → analysis-ready) | Podcast | sí |
| 7 | 7 – 12 sep (8 sep) | **Parcial 1** (20%) | Todo lo visto hasta la semana 6 | — | no |
| 8 | 14 – 19 sep (15 sep) | Contenido | Agentes de código: Claude Code, Cursor y VS Code; el manifiesto CLAUDE.md | Podcast | sí |
| 9 | 21 – 26 sep (22 sep) | Proyecto | **Entrega 2**: sustentación del avance / EDA (5%) | — | no |
| 10 | 28 sep – 3 oct (29 sep) | Contenido | Fundamentos de machine learning: train/test, baseline, CV, leakage, métricas a mano | Podcast + videos (matriz de confusión; MAE/RMSE) | sí |
| 11 | 5 – 10 oct (6 oct) | Contenido | Clasificación: árboles (CART), poda, random forest, umbral | Video de clase | sí |
| 12 | 12 – 17 oct (13 oct) | Contenido | Regresión: lasso, árboles de regresión, bosques, MAE/RMSE | Video de clase | sí |
| 13 | 19 – 24 oct (20 oct) | Contenido | Clustering: k-means, escalamiento, codo, silueta, perfilamiento | Video de clase | sí |
| 14 | 26 – 31 oct (27 oct) | **Parcial 2** (20%) | Semanas 8 a 13 | — | no |
| 15 | 2 – 7 nov (3 nov) | Proyecto | Simulacro de la sustentación final (obligatorio, sin nota) | — | no |
| 16 | 9 – 14 nov (10 nov) | Proyecto | **Entrega 3**: sustentación del proyecto final (20%) | — | no |

Las semanas 7, 9, 15 y 16 no tienen página de contenido. Las páginas del curso agrupan las semanas
en seis bloques (Fundamentos · Proceso analítico y EDA · IA aplicada · Fundamentos de ML ·
Aprendizaje supervisado · Aprendizaje no supervisado); el programa oficial numera nueve unidades
(la semana 2 es la unidad 1, la 13 es la unidad 9). Para no confundir, habla de **semanas y temas**.

## Temas de cada semana de contenido (para preparar quices y repasar)

- **Semana 2 — LLMs**: qué es un LLM y por qué importa en negocios; tokens; embeddings y atención
  (intuición); memoria y ventana de contexto; alucinaciones y por qué verificar; RLHF; costos y
  elección de modelo; uso responsable; prompts C-T-F-R, iterar, skills.
- **Semana 3 — Fundamentos de R**: RStudio y sus paneles; consola vs. script; R como calculadora;
  tipos de datos y coerción; NA, NULL, NaN; objetos y reglas de nombres; `class`/`typeof`/`str`;
  vectores e indexación; data frames; resultado vs. warning vs. error; instalar vs. cargar
  paquetes; directorio de trabajo.
- **Semana 4 — dplyr + ggplot2**: los verbos (`select`, `rename`, `filter`, `arrange`, `mutate`,
  `summarise`, `group_by`, `count`, `distinct`); resúmenes globales y por grupo; gramática de
  gráficos (datos → `aes` → geometría → etiquetas → tema); qué geometría para qué pregunta
  (comparar, evolución, relación, distribución); claridad en ejes, unidades y títulos; la tabla
  de KPIs.
- **Semana 5 — Proceso analítico**: definición y cuatro componentes de BA; las siete etapas (de la
  pregunta a la decisión); qué hace buena a una pregunta de negocio; tipos de tarea
  (clasificación, predicción, segmentación, anomalías, optimización) y cómo la pregunta decide la
  tarea; roles (Data Engineer, Analyst, Scientist, Translator).
- **Semana 6 — Calidad de datos y EDA**: fuentes primarias y secundarias; las cuatro dimensiones
  de calidad (completitud, consistencia, validez, unicidad); valores faltantes (diagnóstico y tres
  estrategias); outliers (detección por rangos, IQR/boxplot, histograma; tratamiento: ¿error o caso
  real?); duplicados; categorías inconsistentes; columnas mal importadas (precio como texto); qué
  es la EDA y qué no es; raw → clean → analysis-ready; documentar las decisiones.
- **Semana 8 — Agentes de código**: el método viejo ("mecánico por teléfono") vs. una IA que
  ejecuta; el bucle agéntico; el manifiesto `CLAUDE.md` (corto y verificable); auditar antes de
  aceptar; la memoria del agente; privacidad (analizar sin mirar); presupuesto de tokens; "el
  agente no es calculadora".
- **Semana 10 — Fundamentos de ML**: aprender = generalizar; el pipeline (target, features,
  train/test, entrenar, evaluar contra un baseline, reportar); sobreajuste y subajuste; el
  baseline; validación cruzada k-fold; data leakage (el preprocesamiento se ajusta solo con train);
  matriz de confusión, accuracy, precisión y recall; MAE y RMSE.
- **Semana 11 — Clasificación**: el árbol como máquina de preguntas (nodo, hoja, profundidad);
  cómo aprende (el corte más puro); baseline → CV → test; memorizar vs. podar, regla 1-SE; random
  forest (bagging, aleatoriedad de variables, votación); importancia de variables; el umbral y el
  costo de cada error; por qué accuracy engaña con clases desbalanceadas.
- **Semana 12 — Regresión**: qué cambia de categorías a números; árbol de regresión (la hoja es un
  promedio); lasso (regularización, selección de variables, lambda por CV); bosque en regresión;
  MAE/RMSE contra el baseline de la media; diagnóstico predicho vs. real.
- **Semana 13 — Clustering**: por qué segmentar; similitud como distancia; k-means en cuatro pasos;
  por qué escalar; limitaciones de k-means; codo (WCSS) y silueta; el criterio final es el negocio
  (describir y accionar); perfilamiento; alternativas a alto nivel (jerárquico, DBSCAN); errores
  frecuentes.

## Hitos del proyecto final (caso Cóndor)

| Hito | Cuándo | Peso | Qué es |
|---|---|---|---|
| Inscripción de grupos | hasta el viernes 28 de agosto, 11:59 p.m. | — | Grupos de exactamente 3, en el enlace que comparte el profesor |
| Entrega 1 — pregunta de negocio | semana 6 (31 ago – 5 sep) | 0%, **prerrequisito** | PDF de máximo 3 páginas: línea de análisis, pregunta, tarea analítica, roles, 5+ variables. Nivel IAG 2 |
| Entrega 2 — base depurada y EDA | semana 9 (21 – 26 sep) | 5% | Sustentación oral con 8–10 diapositivas + script de R. Nivel IAG 3 |
| Simulacro de sustentación | semana 15 (2 – 7 nov) | 0%, obligatorio | Versión preliminar con retroalimentación del profesor y los monitores |
| Entrega 3 — sustentación final | semana 16 (9 – 14 nov) | 20% (oral 15% · diapositivas 4% · script 1%) | 10–12 diapositivas + script; equivale a un examen; el expositor puede elegirse al azar. Nivel IAG 3 |

Quien no presenta una entrega obtiene cero y queda inhabilitado para las siguientes.

## Parciales y supletorios

- **Parcial 1**: semana 7; cubre las semanas 1 a 6. **Parcial 2**: semana 14; cubre las semanas 8 a
  13. Escritos, individuales, sin IA (nivel 1).
- **Supletorio del parcial 1**: sábado 24 de octubre, 8:00 a.m. – 1:00 p.m. (lugar por confirmar).
  **Supletorio del examen final**: sábado 28 de noviembre, 8:00 a.m. – 1:00 p.m. La fecha del
  supletorio del parcial 2 se informa oportunamente.
- Los supletorios no son automáticos: trámite ante la dirección del programa dentro de los 2 días
  hábiles siguientes, con causa justificada; aplican solo a parciales y sustentación final. Para
  quices y talleres no hay supletorio: opera la eliminación de la peor nota.

## Nota sobre ajustes del semestre

La clase del martes 11 de agosto (semana 3) no se realizó por el terremoto del 10 de agosto de 2026
en Cali; el contenido de Fundamentos de R se dictó el 18 de agosto (sesión híbrida, sin quiz ni
taller evaluable). El reacomodo de las semanas siguientes lo decide el profesor y se anuncia por
correo y en la página del curso: **no asumas corrimientos** y pregunta al estudiante en qué semana
o taller va.
