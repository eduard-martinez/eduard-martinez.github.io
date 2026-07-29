---
layout: course
title: Introduction to Business Analytics
description: >
  Undergraduate course on turning data into evidence for business decisions, with
  generative AI woven through the whole semester: R and the tidyverse, the
  business-analytics process, data quality and EDA, LLMs and AI coding agents,
  machine-learning foundations, classification and regression with trees, random
  forests and the Lasso, and k-means clustering — closing with a group project
  defended orally.
institution: Universidad ICESI
department: Department of Economics
course_code: 06327-ECO
program: Undergraduate
term: July 27 – November 14, 2026 (period 202620)
credits: 3
location: "Room 303C (Group 5) · Room 305C (Group 7)"
time: "Group 5: 14:00–17:00 · Group 7: 17:00–20:00"
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
<a href="/teaching/business-analytics-es/" class="ws-btn"><i class="fas fa-language"></i>Versión en español</a>
<a href="/teaching/ba/syllabus/syllabus.pdf" class="ws-btn"><i class="fas fa-file-pdf"></i>Syllabus (PDF, in Spanish)</a>
<a href="/teaching/ba/syllabus/outline.pdf" class="ws-btn"><i class="fas fa-calendar-days"></i>Week-by-week program (PDF)</a>
<a href="https://open.spotify.com/show/033UvL50nPzm1gIH35udu5" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-spotify"></i>Course podcast · El Dato con Contexto</a>
</p>

Original title (in Spanish): **Analítica para los negocios** (06327-ECO). All materials are in Spanish — a full [Spanish version of this page](/teaching/business-analytics-es/) is available.

The course materials are published on this site as each week is released. The documents are built with [Quarto](https://quarto.org/){:target="_blank"} and embed runnable R through [webR](https://docs.r-wasm.org/webr/latest/){:target="_blank"}, so students can execute every example directly in the browser, with no local installation required.

## Course description

The course introduces the business-analytics process: how to turn raw data into information, knowledge and evidence that supports decisions in private and public organizations. It concentrates on five analytical tasks — summarizing, visualizing, clustering, classifying, and estimating regressions — implemented in R on business datasets. Generative AI runs through the whole semester as a working tool: students learn what LLMs are, how to write effective prompts, and how to direct AI coding agents (Claude Code, Cursor, VS Code) responsibly — the AI accelerates the work, but the student must understand and validate every step of the analysis.

## How each week works

Each content week publishes three materials, in the order students use them:

1. <i class="fas fa-book-open"></i> **Theory** — studied *before* class: the written version of the week's podcast or video, with runnable R examples. The podcast episodes are published on Spotify — [*El Dato con Contexto*](https://open.spotify.com/show/033UvL50nPzm1gIH35udu5){:target="_blank"} — and each one is linked in its week below. The weekly quiz is taken on Intu at the start of class — in the computer lab, with no AI or other aids.
2. <i class="fas fa-laptop-code"></i> **Guided practice** — the in-class application, led step by step.
3. <i class="fas fa-clipboard-check"></i> **Workshop** — the graded activity each student completes during the session and submits on Intu before class ends.

## Learning outcomes

By the end of the course, students will be able to:

- Explain the core concepts of business analytics and identify the analytical task — summarize, visualize, cluster, classify, regress — that answers a given business question.
- Use **R** to import, explore, clean, transform, and describe data, and build clear visualizations with **`ggplot2`**.
- Diagnose data-quality problems and carry an exploratory data analysis from raw file to analysis-ready dataset with documented decisions.
- Train and evaluate machine-learning models in R — **CART**, **random forests**, the **Lasso**, and **k-means** — using train/test splits and cross-validation, comparing against a baseline with the right metrics.
- Interpret and communicate results to support an organizational decision.
- Use **generative-AI tools** — LLMs and coding agents — critically and responsibly: effective prompts, validated outputs, traceable analysis.

## Schedule

### Unit 1 — Course foundations

**Week 1 — Presentación del curso y metodología.**
What business analytics is and the problems it solves; the week-by-week tour; the learning dynamic (theory before class, quiz, guided application); evaluation rules, the final project, and the AI policy — motivated by recent evidence on how AI use affects skill formation.

<p>
<a href="/teaching/ba/lectures/week-01/theory/week-01.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="https://arxiv.org/abs/2601.20245" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-book-open"></i>Reading: Shen &amp; Tamkin (2026)</a>
</p>

**Week 2 — Introducción a los LLMs.**
What a large language model is and why it matters for economics and business; capabilities, limits and hallucinations; the anatomy of an effective prompt (context, task, output format, constraints); reusable *skills* for recurring tasks.

<p>
<a href="/teaching/ba/lectures/week-02/theory/week-02.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="https://open.spotify.com/episode/68vkoezzpxxmBUUsw35zAE" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-spotify"></i>Podcast</a>
<a href="/teaching/ba/lectures/week-02/practice/week-02.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-02/task/week-02.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
</p>

**Week 3 — Fundamentos de R.**
The RStudio interface and the script-based workflow; R as a calculator; data types and special values; objects and assignment; vectors, matrices and data frames; functions, help, and packages; the Environment and projects with relative paths.

<p>
<a href="/teaching/ba/lectures/week-03/theory/week-03.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="/teaching/ba/lectures/week-03/practice/week-03.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-03/task/week-03.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
<a href="https://youtu.be/_UnjI5eTkNc" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · R fundamentals</a>
</p>

**Week 4 — Manipulación y visualización de datos.**
The `dplyr` grammar verb by verb for global and grouped KPIs, and `ggplot2` as a layered system (data, aesthetics, geometries, labels, themes). The week's product: a KPI table and the 2–3 charts that communicate it.

<p>
<a href="/teaching/ba/lectures/week-04/theory/week-04.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="/teaching/ba/lectures/week-04/practice/week-04.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-04/task/week-04.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
<a href="https://youtu.be/MVNvoBbELKs" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · dplyr (part 1)</a>
<a href="https://youtu.be/sCfhUTHA4fQ" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · ggplot2 (part 2)</a>
<small class="ws-data">Data: <a href="/teaching/ba/lectures/week-04/task/cafeteria.csv"><code>cafeteria.csv</code></a></small>
</p>

### Unit 2 — The analytics process and EDA

**Week 5 — Proceso analítico y tipos de analítica.**
Business analytics as a process that turns data into actionable knowledge; translating business questions into analytical tasks; the workflow from question to decision; the roles in an analytics team. The in-class exercise feeds directly into Deliverable 1 of the final project.

<p>
<a href="/teaching/ba/lectures/week-05/theory/week-05.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="https://open.spotify.com/episode/75F2Igpy5LJbRKyyKzIOg8" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-spotify"></i>Podcast</a>
<a href="/teaching/ba/lectures/week-05/practice/week-05.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-05/task/week-05.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
</p>

**Week 6 — EDA: fuentes, limpieza y exploración.**
Data sources and quality; the diagnostic checklist — types, ranges, missing values, duplicates, inconsistent categories, outliers; cleaning with documented decisions; the reproducible **raw → clean → analysis-ready** pipeline.

<p>
<a href="/teaching/ba/lectures/week-06/theory/week-06.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="https://open.spotify.com/episode/1aQ02r039bDtbEbwpumQcq" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-spotify"></i>Podcast</a>
<a href="/teaching/ba/lectures/week-06/practice/week-06.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-06/task/week-06.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
<small class="ws-data">Data: <a href="/teaching/ba/lectures/week-06/task/ferreteria_raw.csv"><code>ferreteria_raw.csv</code></a></small>
</p>

**Week 7 — Examen Parcial 1.** First integrative written exam (20%), covering weeks 1–6. September 7–12.

### Unit 3 — AI applied to data analysis

**Week 8 — Agentes de código: Claude Code, Cursor y VS Code.**
AI assistants for data analysis and programming; redoing with AI what was done "by hand" in the previous weeks (manipulation, cleaning, EDA, visualization); iterating prompts, reviewing generated code, verifying results.

<p>
<a href="/teaching/ba/lectures/week-08/theory/week-08.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="/teaching/ba/lectures/week-08/practice/week-08.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-08/task/week-08.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
<a href="/teaching/ba/lectures/week-08/practice/proyecto_semana8.zip" class="ws-btn"><i class="fas fa-download"></i>Starter project (zip)</a>
</p>

**Week 9 — Presentación Avance del Proyecto (EDA).** Deliverable 2 of the final project (5%): oral presentation of the exploratory analysis, with feedback from the professor and course assistants. September 21–26.

### Unit 4 — Machine learning foundations

**Week 10 — Fundamentos de Machine Learning.**
Machine learning as generalization; the standard pipeline — target and features, train/test split, metrics against a baseline; cross-validation; overfitting, data leakage, and badly chosen metrics. Two complementary videos build the confusion matrix and MAE/RMSE before the supervised weeks.

<p>
<a href="/teaching/ba/lectures/week-10/theory/week-10.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="/teaching/ba/lectures/week-10/practice/week-10.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-10/task/week-10.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
<a href="https://youtu.be/TWDdeKs3org" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · Confusion matrix</a>
<a href="https://youtu.be/bSHrtLHCPvc" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · RMSE &amp; MAE</a>
<small class="ws-data">Data: <a href="/teaching/ba/lectures/week-10/task/credito_taller10.csv"><code>credito_taller10.csv</code></a> · <a href="/teaching/ba/lectures/week-10/task/notas_taller10.csv"><code>notas_taller10.csv</code></a> · <a href="/teaching/ba/lectures/week-10/practice/credito_evaluacion.csv"><code>credito_evaluacion.csv</code></a> · <a href="/teaching/ba/lectures/week-10/practice/notas_evaluacion.csv"><code>notas_evaluacion.csv</code></a></small>
</p>

### Unit 5 — Supervised learning

**Week 11 — Clasificación: árboles y bosques.**
The full classification pipeline; the confusion matrix — why accuracy misleads, and the precision/recall trade-off; **CART** and **random forests**; choosing a model by the cost of its errors. The workshop predicts customer churn.

<p>
<a href="/teaching/ba/lectures/week-11/theory/week-11.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="/teaching/ba/lectures/week-11/practice/week-11.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-11/task/week-11.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
<a href="https://www.youtube.com/watch?v=kqaLlte6P6o" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · Classification trees</a>
<small class="ws-data">Data: <a href="/teaching/ba/lectures/week-11/practice/credito_clasificacion.csv"><code>credito_clasificacion.csv</code></a> · <a href="/teaching/ba/lectures/week-11/task/clientes_conectatel.csv"><code>clientes_conectatel.csv</code></a></small>
</p>

**Week 12 — Regresión: árboles, bosques y la ruta Lasso.**
The regression pipeline with MAE/RMSE against a baseline; regularized linear regression (**Lasso**), regression trees, and ensembles (**random forest / XGBoost**); interpretability vs. performance. The workshop prices apartments in Cali.

<p>
<a href="/teaching/ba/lectures/week-12/theory/week-12.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="/teaching/ba/lectures/week-12/practice/week-12.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-12/task/week-12.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
<a href="https://www.youtube.com/watch?v=2Miw4bjzSF0" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · Regression trees</a>
<small class="ws-data">Data: <a href="/teaching/ba/lectures/week-12/practice/notas_regresion.csv"><code>notas_regresion.csv</code></a> · <a href="/teaching/ba/lectures/week-12/task/apartamentos_cali.csv"><code>apartamentos_cali.csv</code></a></small>
</p>

### Unit 6 — Unsupervised learning

**Week 13 — Clustering: fundamentos y métricas.**
Clustering as segmentation without a target; **k-means** (distance, scaling, centroids); choosing *k* with the elbow and silhouette methods; profiling segments so they are actionable. The practice segments Spotify songs; the workshop segments gym members.

<p>
<a href="/teaching/ba/lectures/week-13/theory/week-13.html" class="ws-btn"><i class="fas fa-book-open"></i>Theory</a>
<a href="/teaching/ba/lectures/week-13/practice/week-13.html" class="ws-btn"><i class="fas fa-laptop-code"></i>Guided practice</a>
<a href="/teaching/ba/lectures/week-13/task/week-13.html" class="ws-btn"><i class="fas fa-clipboard-check"></i>Workshop</a>
<a href="https://www.youtube.com/watch?v=2kfY0R34Dy0" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Video · k-means</a>
<small class="ws-data">Data: <a href="/teaching/ba/lectures/week-13/practice/spotify_canciones.csv"><code>spotify_canciones.csv</code></a> · <a href="/teaching/ba/lectures/week-13/task/socios_califit.csv"><code>socios_califit.csv</code></a></small>
</p>

**Week 14 — Examen Parcial 2.** Second integrative written exam (20%), covering weeks 8–13. October 26–31.

**Week 15 — Simulacro de la presentación final.** Each group presents a preliminary version of its final defense and receives feedback. November 2–7.

**Week 16 — Presentación del Proyecto Final.** Final oral defense of the project (Deliverable 3, 20%). It counts as an exam: attendance is mandatory. November 9–14.

## Evaluation

| Component | Weight | Allowed use of AI |
|---|---|---|
| Weekly concept quizzes (on Intu, in the computer lab, every content week) | 25% | No AI |
| In-class workshops (one per session, submitted on Intu) | 10% | Collaboration with AI — every decision must be explainable |
| Integrative written exam 1 (week 7) | 20% | No AI |
| Integrative written exam 2 (week 14) | 20% | No AI |
| Final project (three deliverables) | 25% | Planning / collaboration with AI, by deliverable |

Quizzes and workshops have no make-ups; the worst quiz grade and the worst workshop grade are dropped once per semester. AI use in graded work follows ICESI's institutional five-level IAG scale — each activity states its maximum allowed level, and every use must be declared, verified, and traceable.

## Final project

Each group of **3 students** receives a **multi-variable business dataset** — this semester, the **Cóndor case**, a fictional Andean payments-and-credit fintech —, formulates its own business question, and answers it with one of the course's analytical tasks — classification, regression, or segmentation. Three deliverables: **(1)** the business question (week 6 — prerequisite for the later deliverables), **(2)** an oral progress presentation of the EDA (week 9, 5%), and **(3)** the final oral defense (week 16, 20%). There is no written document: the defense is the final product, and the presenting group member may be chosen at random.

<p>
<a href="/teaching/ba/final_project/guidelines_final_project.pdf" class="ws-btn"><i class="fas fa-file-pdf"></i>Project guidelines (PDF, in Spanish)</a>
<a href="/teaching/ba/final_project/contexto_caso_condor.pdf" class="ws-btn"><i class="fas fa-file-pdf"></i>Cóndor case · context (PDF, in Spanish)</a>
<small class="ws-data">Data (joined by <code>cliente_id</code>): <a href="/teaching/ba/final_project/data/base_clientes.csv"><code>base_clientes.csv</code></a> · <a href="/teaching/ba/final_project/data/anexo_transacciones.csv"><code>anexo_transacciones.csv</code></a> · <a href="/teaching/ba/final_project/data/anexo_creditos.csv"><code>anexo_creditos.csv</code></a> · <a href="/teaching/ba/final_project/data/anexo_campanas.csv"><code>anexo_campanas.csv</code></a></small>
</p>

## Bibliography and resources

- Wickham, H. & Grolemund, G. (2017). [*R for Data Science*](https://r4ds.hadley.nz/){:target="_blank"}. O'Reilly Media.
- James, G., Witten, D., Hastie, T. & Tibshirani, R. (2021). [*An Introduction to Statistical Learning: with Applications in R*](https://www.statlearning.com){:target="_blank"} (2nd ed.). Springer.
- Perkins, M., Roe, J. & Furze, L. (2025). [Reimagining the Artificial Intelligence Assessment Scale (AIAS)](https://doi.org/10.53761/rrm4y757){:target="_blank"}. *JUTLP, 22*(7).

---

*Materials are released progressively as the semester advances. The course podcast — [El Dato con Contexto](https://open.spotify.com/show/033UvL50nPzm1gIH35udu5){:target="_blank"} — is on Spotify; quizzes are taken on Intu every content week, and workshops are submitted on Intu at the end of each session.*
