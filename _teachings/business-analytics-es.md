---
layout: course
title: Analítica para los Negocios
description: >
  Curso de pregrado sobre cómo convertir datos en evidencia para decisiones de negocio,
  con inteligencia artificial generativa transversal a todo el semestre: R y el tidyverse,
  el proceso de business analytics, calidad de datos y EDA, LLMs y agentes de código,
  fundamentos de machine learning, clasificación y regresión con árboles, bosques
  aleatorios y Lasso, y clustering con k-means — cerrando con un proyecto en grupo
  sustentado oralmente.
institution: Universidad ICESI
department: Departamento de Economía
course_code: 06278-ECO
program: Pregrado
term: 27 de julio – 14 de noviembre de 2026 (periodo 202610)
credits: 3
instructor: Eduard F. Martínez-González · Tatiana Mejía Herrera
year: 2026
---

<style>
  .ws-btn {
    display: inline-block;
    font-size: 0.82rem;
    padding: 0.28rem 0.7rem;
    margin: 0.12rem 0.3rem 0.12rem 0;
    border: 1px solid var(--global-divider-color);
    border-radius: 6px;
    color: var(--global-text-color);
  }
  .ws-btn:hover {
    color: var(--global-theme-color);
    border-color: var(--global-theme-color);
    text-decoration: none;
  }
  .ws-btn i { color: var(--global-theme-color); margin-right: 0.35rem; }
  .ws-data { display: block; color: var(--global-text-color-light); font-size: 0.85rem; margin-top: 0.2rem; }
  .ws-data code { font-size: 0.8rem; }
</style>

<p>
<a href="/teaching/business-analytics/" class="ws-btn"><i class="fas fa-language"></i>English version</a>
</p>

Los materiales del curso se publican en este sitio a medida que se libera cada semana. Los documentos están construidos con [Quarto](https://quarto.org/){:target="_blank"} y ejecutan R en el navegador vía [webR](https://docs.r-wasm.org/webr/latest/){:target="_blank"}: puedes correr cada ejemplo directamente en la página, sin instalar nada.

## Descripción del curso

El curso introduce el proceso de *business analytics*: cómo convertir datos crudos en información, conocimiento y evidencia que soporte decisiones en organizaciones privadas y públicas. Se concentra en cinco tareas analíticas — resumir, visualizar, agrupar, clasificar y estimar regresiones — implementadas en R sobre datos de negocio. La inteligencia artificial generativa atraviesa todo el semestre como herramienta de trabajo: qué son los LLMs, cómo escribir buenos *prompts* y cómo dirigir agentes de código (Claude Code, Cursor, VS Code) de forma responsable — la IA acelera el trabajo, pero el estudiante debe entender y validar cada paso del análisis.

## Cómo funciona cada semana

Cada semana de contenido publica tres materiales, en el orden en que se usan:

1. <i class="fas fa-book-open"></i> **Teoría** — se estudia *antes* de clase: la versión escrita del podcast o video de la semana, con ejemplos de R ejecutables. Los episodios del podcast y el quiz semanal están en Intu (plataforma institucional).
2. <i class="fas fa-laptop-code"></i> **Práctica guiada** — la aplicación en clase, paso a paso.
3. <i class="fas fa-clipboard-check"></i> **Taller** — la actividad evaluable que cada estudiante desarrolla durante la sesión.

## Resultados de aprendizaje

Al finalizar el curso, el estudiante estará en capacidad de:

- Explicar los conceptos centrales del business analytics e identificar la tarea analítica — resumir, visualizar, agrupar, clasificar, estimar — que responde una pregunta de negocio.
- Usar **R** para importar, explorar, limpiar, transformar y describir datos, y construir visualizaciones claras con **`ggplot2`**.
- Diagnosticar problemas de calidad de datos y llevar un análisis exploratorio desde el archivo crudo hasta un dataset listo para análisis, con decisiones documentadas.
- Entrenar y evaluar modelos de machine learning en R — **CART**, **bosques aleatorios**, **Lasso** y **k-means** — con particiones train/test y validación cruzada, comparando contra un baseline con las métricas correctas.
- Interpretar y comunicar resultados para soportar una decisión organizacional.
- Usar herramientas de **IA generativa** — LLMs y agentes de código — de forma crítica y responsable: prompts efectivos, salidas validadas y análisis trazable.

## Cronograma

### Unidad 1 — Fundamentos del curso

**Semana 1 — Presentación del curso y metodología.**
Qué es el business analytics y qué problemas resuelve; el recorrido semana a semana; la dinámica de aprendizaje (teoría antes de clase, quiz, aplicación guiada); las reglas de evaluación, el proyecto final y la política de IA — motivada por evidencia reciente sobre cómo el uso de IA afecta la formación de habilidades.

<p>
<a href="/teaching/ba/week-01/theory/week-01.pdf" class="ws-btn"><i class="fas fa-file-pdf"></i>Diapositivas (PDF)</a>
<a href="https://arxiv.org/abs/2601.20245" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-book-open"></i>Lectura: Shen &amp; Tamkin (2026)</a>
</p>

**Semana 2 — Introducción a los LLMs.**
Qué es un modelo de lenguaje y por qué importa en economía y negocios; alcances, límites y alucinaciones; la anatomía de un buen *prompt* (contexto, tarea, formato de salida, restricciones); *skills* reutilizables para tareas recurrentes.

<p>
<a href="/teaching/ba/week-02/theory/week-02.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-02/practice/week-02.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-02/task/week-02.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
</p>

**Semana 3 — Fundamentos de R.**
La interfaz de RStudio y el flujo con scripts; R como calculadora; tipos de datos y valores especiales; objetos y asignación; vectores, matrices y data frames; funciones, ayuda y paquetes; el Environment y los proyectos con rutas relativas.

<p>
<a href="/teaching/ba/week-03/theory/week-03.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-03/practice/week-03.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-03/task/week-03.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
</p>

**Semana 4 — Manipulación y visualización de datos.**
La gramática de `dplyr` verbo a verbo para KPIs globales y por grupo, y `ggplot2` como sistema por capas (datos, estéticas, geometrías, etiquetas, temas). El producto de la semana: una tabla de KPIs y los 2–3 gráficos que la comunican.

<p>
<a href="/teaching/ba/week-04/theory/week-04.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-04/practice/week-04.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-04/task/week-04.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
<small class="ws-data">Datos: <a href="/teaching/ba/week-04/task/cafeteria.csv"><code>cafeteria.csv</code></a></small>
</p>

### Unidad 2 — Proceso analítico y exploración de datos

**Semana 5 — Proceso analítico y tipos de analítica.**
El business analytics como proceso que convierte datos en conocimiento accionable; traducir preguntas de negocio a tareas analíticas; el flujo de la pregunta a la decisión; los roles de un equipo de analítica. El ejercicio en clase es el insumo directo de la Entrega 1 del proyecto final.

<p>
<a href="/teaching/ba/week-05/theory/week-05.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-05/practice/week-05.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-05/task/week-05.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
</p>

**Semana 6 — EDA: fuentes, limpieza y exploración.**
Fuentes y calidad de datos; el checklist de diagnóstico — tipos, rangos, faltantes, duplicados, categorías inconsistentes, outliers; limpieza con decisiones documentadas; el pipeline reproducible **raw → clean → analysis-ready**.

<p>
<a href="/teaching/ba/week-06/theory/week-06.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-06/practice/week-06.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-06/task/week-06.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
<small class="ws-data">Datos: <a href="/teaching/ba/week-06/task/ferreteria_raw.csv"><code>ferreteria_raw.csv</code></a></small>
</p>

**Semana 7 — Examen Parcial 1.** Primera evaluación escrita integradora (20%), cubre las semanas 1–6. Del 7 al 13 de septiembre.

### Unidad 3 — IA aplicada al análisis de datos

**Semana 8 — Agentes de código: Claude Code, Cursor y VS Code.**
Asistentes de IA para el análisis de datos y la programación; rehacer con IA lo que ya se hizo "a mano" en las semanas anteriores (manipulación, limpieza, EDA, visualización); iterar prompts, revisar el código generado y verificar resultados.

<p>
<a href="/teaching/ba/week-08/theory/week-08.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-08/practice/week-08.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-08/task/week-08.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
<a href="/teaching/ba/week-08/practice/proyecto_semana8.zip" class="ws-btn"><i class="fas fa-download"></i>Proyecto inicial (zip)</a>
</p>

**Semana 9 — Presentación Avance del Proyecto (EDA).** Entrega 2 del proyecto final (5%): presentación oral del análisis exploratorio, con retroalimentación del profesor y los monitores. Del 21 al 27 de septiembre.

### Unidad 4 — Fundamentos de Machine Learning

**Semana 10 — Fundamentos de Machine Learning.**
El machine learning como generalización; el pipeline estándar — target y features, partición train/test, métricas contra un baseline; validación cruzada; sobreajuste, data leakage y métricas mal elegidas. Dos videos complementarios construyen la matriz de confusión y MAE/RMSE antes de las semanas supervisadas.

<p>
<a href="/teaching/ba/week-10/theory/week-10.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-10/practice/week-10.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-10/task/week-10.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
<a href="https://youtu.be/TWDdeKs3org" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · Matriz de confusión</a>
<a href="https://youtu.be/bSHrtLHCPvc" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · RMSE y MAE</a>
<small class="ws-data">Datos: <a href="/teaching/ba/week-10/task/credito_taller10.csv"><code>credito_taller10.csv</code></a> · <a href="/teaching/ba/week-10/task/notas_taller10.csv"><code>notas_taller10.csv</code></a> · <a href="/teaching/ba/week-10/practice/credito_evaluacion.csv"><code>credito_evaluacion.csv</code></a> · <a href="/teaching/ba/week-10/practice/notas_evaluacion.csv"><code>notas_evaluacion.csv</code></a></small>
</p>

### Unidad 5 — Aprendizaje supervisado

**Semana 11 — Clasificación: árboles y bosques.**
El pipeline completo de clasificación; la matriz de confusión — por qué el accuracy engaña y el trade-off precision/recall; **CART** y **bosques aleatorios**; elegir modelo según el costo de los errores. El taller predice la fuga de clientes (churn).

<p>
<a href="/teaching/ba/week-11/theory/week-11.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-11/practice/week-11.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-11/task/week-11.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
<a href="https://www.youtube.com/watch?v=kqaLlte6P6o" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · Árboles de clasificación</a>
<small class="ws-data">Datos: <a href="/teaching/ba/week-11/practice/credito_clasificacion.csv"><code>credito_clasificacion.csv</code></a> · <a href="/teaching/ba/week-11/task/clientes_conectatel.csv"><code>clientes_conectatel.csv</code></a></small>
</p>

**Semana 12 — Regresión: árboles, bosques y la ruta Lasso.**
El pipeline de regresión con MAE/RMSE contra un baseline; regresión lineal regularizada (**Lasso**), árboles de regresión y ensambles (**random forest / XGBoost**); interpretabilidad vs. desempeño. El taller avalúa apartamentos en Cali.

<p>
<a href="/teaching/ba/week-12/theory/week-12.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-12/practice/week-12.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-12/task/week-12.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
<a href="https://www.youtube.com/watch?v=2Miw4bjzSF0" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · Árboles de regresión</a>
<small class="ws-data">Datos: <a href="/teaching/ba/week-12/practice/notas_regresion.csv"><code>notas_regresion.csv</code></a> · <a href="/teaching/ba/week-12/task/apartamentos_cali.csv"><code>apartamentos_cali.csv</code></a></small>
</p>

### Unidad 6 — Aprendizaje no supervisado

**Semana 13 — Clustering: fundamentos y métricas.**
El clustering como segmentación sin target; **k-means** (distancia, escalamiento, centroides); elegir *k* con elbow y silhouette; perfilar los segmentos para que sean accionables. La práctica segmenta canciones de Spotify; el taller, los socios de un gimnasio.

<p>
<a href="/teaching/ba/week-13/theory/week-13.html" class="ws-btn"><i class="fas fa-book-open"></i>Teoría</a>
<a href="/teaching/ba/week-13/practice/week-13.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Práctica guiada</a>
<a href="/teaching/ba/week-13/task/week-13.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Taller</a>
<a href="https://www.youtube.com/watch?v=2kfY0R34Dy0" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · k-means</a>
<small class="ws-data">Datos: <a href="/teaching/ba/week-13/practice/spotify_canciones.csv"><code>spotify_canciones.csv</code></a> · <a href="/teaching/ba/week-13/task/socios_califit.csv"><code>socios_califit.csv</code></a></small>
</p>

**Semana 14 — Examen Parcial 2.** Segunda evaluación escrita integradora (20%), cubre las semanas 8–13. Del 26 al 31 de octubre.

**Semana 15 — Simulacro de la presentación final.** Cada grupo presenta una versión preliminar de su sustentación y recibe retroalimentación. Del 2 al 8 de noviembre.

**Semana 16 — Presentación del Proyecto Final.** Sustentación oral del proyecto (Entrega 3, 20%). Equivale a un examen: la asistencia es obligatoria. Del 9 al 14 de noviembre.

## Evaluación

| Componente | Peso | Uso permitido de IA |
|---|---|---|
| Quices conceptuales semanales (cada semana de contenido, en Intu) | 25% | Sin IA |
| Talleres en clase (uno por sesión) | 10% | Colaboración con IA — cada decisión debe poder explicarse |
| Evaluación integradora 1 (semana 7) | 20% | Sin IA |
| Evaluación integradora 2 (semana 14) | 20% | Sin IA |
| Proyecto final (tres entregas) | 25% | Planificación / colaboración con IA, según la entrega |

Los quices y talleres no tienen recuperación; como mitigación, se elimina la peor nota de quices y la peor de talleres una única vez en el semestre. El uso de IA en actividades evaluables sigue la escala institucional de niveles de IAG de ICESI: cada actividad indica su nivel máximo permitido, y todo uso debe declararse, verificarse y ser trazable.

## Proyecto final

Cada grupo recibe una **base de datos empresarial con múltiples variables**, formula su propia pregunta de negocio y la responde con una de las tareas analíticas del curso — clasificación, regresión o segmentación. Tres entregas: **(1)** la pregunta de negocio (semana 6 — requisito para las entregas posteriores), **(2)** la presentación oral del avance/EDA (semana 9, 5%) y **(3)** la sustentación final (semana 16, 20%). No hay documento escrito: la sustentación es el producto final, y el integrante que expone puede elegirse al azar.

## Bibliografía y recursos

- Wickham, H. & Grolemund, G. (2017). [*R for Data Science*](https://r4ds.hadley.nz/){:target="_blank"}. O'Reilly Media.
- James, G., Witten, D., Hastie, T. & Tibshirani, R. (2021). [*An Introduction to Statistical Learning: with Applications in R*](https://www.statlearning.com){:target="_blank"} (2.ª ed.). Springer.
- Perkins, M., Roe, J. & Furze, L. (2025). [Reimagining the Artificial Intelligence Assessment Scale (AIAS)](https://doi.org/10.53761/rrm4y757){:target="_blank"}. *JUTLP, 22*(7).

Handouts de referencia de la edición anterior, disponibles como lectura complementaria:
[IA y Machine Learning](/teaching/ba/week-15/week-15-1.html) ·
[LLMs, Skills y Agentes](/teaching/ba/week-15/week-15-2.html) ·
[Prompts: cómo formular preguntas a una IA](/teaching/ba/week-15/week-15-3.html)

---

*Los materiales se publican progresivamente a lo largo del semestre. Los podcasts y quices semanales están en Intu.*
