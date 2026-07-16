---
layout: course
title: Introduction to Business Analytics
description: >
  Undergraduate course on turning data into evidence for business decisions, with
  generative AI woven through the whole semester. Covers R programming and the tidyverse,
  data visualization, the business-analytics process, data quality and exploratory data
  analysis, LLMs and prompting, AI coding agents (Claude Code, Cursor, VS Code),
  machine-learning foundations, classification and regression with trees, random forests
  and the Lasso, and k-means clustering — closing with a group project defended orally.
institution: Universidad ICESI
department: Department of Economics
course_code: 06278-ECO
program: Undergraduate
term: July 27 – November 14, 2026 (period 202610)
credits: 3
instructor: Eduard F. Martínez-González · Tatiana Mejía Herrera
year: 2026
---

Original title (in Spanish): **Analítica para los Negocios**. All materials are in Spanish.

All course materials — theory documents, guided practices, in-class workshops, and datasets — are published on this site as each week is released. The documents are built with [Quarto](https://quarto.org/){:target="_blank"} and embed runnable R through [webR](https://docs.r-wasm.org/webr/latest/){:target="_blank"}, so students can execute every example directly in the browser, with no local installation required.

## Course description

The course introduces the business-analytics process: how to turn raw data into information, knowledge and evidence that supports decisions in private and public organizations. It concentrates on five analytical tasks — summarizing, visualizing, clustering, classifying, and estimating regressions — implemented in R on business datasets. Generative AI runs through the whole semester as a working tool: students learn what LLMs are, how to write effective prompts, and how to direct AI coding agents (Claude Code, Cursor, VS Code) responsibly — the AI accelerates the work, but the student must understand and validate every step of the analysis.

## How each week works

The course follows ICESI's active-learning model, organized in four recurring moments:

1. **Theory before class.** Each content week publishes a mandatory theory resource (podcast or video plus a companion document with runnable R); definitions and concepts are *not* re-explained in class.
2. **Weekly quiz.** Preparation is verified with a concept quiz (on Intu) in every content week.
3. **Guided practice.** The class session operationalizes the theory step by step, making the analytical decisions explicit.
4. **In-class workshop.** Each session closes with an individual, graded application activity.

## Learning outcomes

By the end of the course, students will be able to:

- Explain the core concepts of business analytics and the process that turns data into decisions, and identify the analytical task — summarize, visualize, cluster, classify, regress — that answers a given business question.
- Use **R** to import, explore, clean, transform, and describe data, and build clear visualizations with **`ggplot2`** following good communication practices.
- Diagnose data-quality problems — missing values, duplicates, inconsistent categories, outliers — and carry an exploratory data analysis from raw file to analysis-ready dataset with documented decisions.
- Train and evaluate machine-learning models in R — **CART**, **random forests**, the **Lasso**, and **k-means** — using train/test splits and cross-validation, and comparing them against a baseline with the right metrics (confusion matrix, precision/recall, MAE/RMSE, silhouette).
- Interpret and communicate results to support an organizational decision.
- Use **generative-AI tools** — LLMs and coding agents — critically and responsibly: writing effective prompts, validating every output, and keeping the analysis traceable.

## Schedule

### Unit 1 — Course foundations

**Week 1 — Presentación del curso y metodología.**
What business analytics is and the problems it solves; the week-by-week tour of the course; the learning dynamic (theory before class, quiz, guided application); evaluation rules and the final project; and the course's AI policy, motivated by recent evidence on how AI use affects skill formation.
[Slides (PDF)](/teaching/ba/week-01/theory/week-01.pdf) ·
[Reading: Shen & Tamkin (2026), *How AI Impacts Skill Formation*](https://arxiv.org/abs/2601.20245){:target="_blank"}

**Week 2 — Introducción a los LLMs.**
What a large language model is and why it matters for economics and business; capabilities, limits and hallucinations, and why every output must be verified; the anatomy of an effective prompt (context, task, output format, constraints) and iterating on responses; reusable *skills* for recurring tasks.
[Theory](/teaching/ba/week-02/theory/week-02.html) ·
[Guided practice](/teaching/ba/week-02/practice/week-02.html) ·
[Workshop](/teaching/ba/week-02/task/week-02.html)

**Week 3 — Fundamentos de R.**
The RStudio interface and the script-based workflow; R as a calculator; data types and special values (`NA`, `NULL`); objects and assignment; vectors, matrices and data frames (creation, indexing, filtering); functions, the help system, and installing vs. loading packages; the Environment, and projects with relative paths for reproducibility.
[Theory](/teaching/ba/week-03/theory/week-03.html) ·
[Guided practice](/teaching/ba/week-03/practice/week-03.html) ·
[Workshop](/teaching/ba/week-03/task/week-03.html)

**Week 4 — Manipulación y visualización de datos.**
The `dplyr` grammar verb by verb — `select()`, `rename()`, `filter()`, `arrange()`, `mutate()`, `summarise()`, `group_by()`, `count()` — for global and grouped KPIs, and `ggplot2` as a layered system (data, aesthetics, geometries, labels, themes). The week's product: a KPI table and the 2–3 charts that communicate it.
[Theory](/teaching/ba/week-04/theory/week-04.html) ·
[Guided practice](/teaching/ba/week-04/practice/week-04.html) ·
[Workshop](/teaching/ba/week-04/task/week-04.html) ·
[Dataset (`cafeteria.csv`)](/teaching/ba/week-04/task/cafeteria.csv)

### Unit 2 — The analytics process and EDA

**Week 5 — Proceso analítico y tipos de analítica.**
Business analytics as a process that turns data into actionable knowledge; translating business questions into analytical tasks (classification, prediction, segmentation, anomaly detection, optimization); the analytics workflow from question to decision; and the roles in an analytics team (data engineer, data analyst, data scientist, business analyst). The in-class exercise evaluates business questions and feeds directly into Deliverable 1 of the final project.
[Theory](/teaching/ba/week-05/theory/week-05.html) ·
[Guided practice](/teaching/ba/week-05/practice/week-05.html) ·
[Workshop](/teaching/ba/week-05/task/week-05.html)

**Week 6 — EDA: fuentes, limpieza y exploración.**
Data sources and data quality in real contexts; the diagnostic checklist — types, plausible ranges, missing values, duplicates, inconsistent categories, outliers; cleaning with transparent, documented decisions; and a minimal EDA. The product: a reproducible **raw → clean → analysis-ready** pipeline with a decision log.
[Theory](/teaching/ba/week-06/theory/week-06.html) ·
[Guided practice](/teaching/ba/week-06/practice/week-06.html) ·
[Workshop](/teaching/ba/week-06/task/week-06.html) ·
[Dataset (`ferreteria_raw.csv`)](/teaching/ba/week-06/task/ferreteria_raw.csv)

**Week 7 — Examen Parcial 1.** First integrative written exam (20%), covering weeks 1–6. September 7–13.

### Unit 3 — AI applied to data analysis

**Week 8 — Agentes de código: Claude Code, Cursor y VS Code.**
AI assistants for data analysis and programming: what these tools are and their typical workflows; redoing with AI what was done "by hand" in the previous weeks (manipulation, cleaning, EDA, visualization); and responsible use — iterating prompts, reviewing generated code, and verifying results against expectations.
[Theory](/teaching/ba/week-08/theory/week-08.html) ·
[Guided practice](/teaching/ba/week-08/practice/week-08.html) ·
[Workshop](/teaching/ba/week-08/task/week-08.html) ·
[Starter project (`proyecto_semana8.zip`)](/teaching/ba/week-08/practice/proyecto_semana8.zip)

**Week 9 — Presentación Avance del Proyecto (EDA).** Deliverable 2 of the final project (5%): oral presentation of the exploratory analysis — given the business question, how it will be answered and what the EDA shows — with feedback from the professor and course assistants. September 21–27.

### Unit 4 — Machine learning foundations

**Week 10 — Fundamentos de Machine Learning.**
Machine learning as generalization; the standard pipeline — target and features, train/test split, training and hyperparameters, metrics against a baseline; cross-validation; and the classic failure modes: overfitting, data leakage, and badly chosen metrics. Complementary videos build the confusion matrix and MAE/RMSE so the metrics are in place before the supervised weeks.
[Theory](/teaching/ba/week-10/theory/week-10.html) ·
[Guided practice](/teaching/ba/week-10/practice/week-10.html) ·
[Workshop](/teaching/ba/week-10/task/week-10.html) ·
Datasets: [`credito_taller10.csv`](/teaching/ba/week-10/task/credito_taller10.csv) ·
[`notas_taller10.csv`](/teaching/ba/week-10/task/notas_taller10.csv) ·
[`credito_evaluacion.csv`](/teaching/ba/week-10/practice/credito_evaluacion.csv) ·
[`notas_evaluacion.csv`](/teaching/ba/week-10/practice/notas_evaluacion.csv)

### Unit 5 — Supervised learning

**Week 11 — Clasificación: árboles y bosques.**
The full classification pipeline; reading a classifier through the confusion matrix — why accuracy misleads, and the precision/recall trade-off; **CART** (partitions, depth, pruning, interpretability vs. overfitting) and **random forests** (bagging and why ensembles generalize better); choosing a model by the cost of its errors. The workshop predicts customer churn.
[Theory](/teaching/ba/week-11/theory/week-11.html) ·
[Guided practice](/teaching/ba/week-11/practice/week-11.html) ·
[Workshop](/teaching/ba/week-11/task/week-11.html) ·
Datasets: [`credito_clasificacion.csv`](/teaching/ba/week-11/practice/credito_clasificacion.csv) ·
[`clientes_conectatel.csv`](/teaching/ba/week-11/task/clientes_conectatel.csv)

**Week 12 — Regresión: árboles, bosques y la ruta Lasso.**
The regression pipeline with MAE/RMSE against a mean/median baseline; regularized linear regression (**Lasso**, with Ridge as an aside) and variable selection; regression trees and ensembles (**random forest / XGBoost**); and the trade-off between interpretability, performance and overfitting risk. The workshop prices apartments in Cali.
[Theory](/teaching/ba/week-12/theory/week-12.html) ·
[Guided practice](/teaching/ba/week-12/practice/week-12.html) ·
[Workshop](/teaching/ba/week-12/task/week-12.html) ·
Datasets: [`notas_regresion.csv`](/teaching/ba/week-12/practice/notas_regresion.csv) ·
[`apartamentos_cali.csv`](/teaching/ba/week-12/task/apartamentos_cali.csv)

### Unit 6 — Unsupervised learning

**Week 13 — Clustering: fundamentos y métricas.**
Clustering as segmentation without a target; **k-means** (similarity as distance, why scaling matters, centroids); choosing *k* with the elbow and silhouette methods plus the interpretability criterion; profiling and naming segments so they are actionable; and high-level alternatives (hierarchical clustering, DBSCAN). The guided practice segments songs with Spotify audio features; the workshop segments the members of a gym chain.
[Theory](/teaching/ba/week-13/theory/week-13.html) ·
[Guided practice](/teaching/ba/week-13/practice/week-13.html) ·
[Workshop](/teaching/ba/week-13/task/week-13.html) ·
Datasets: [`spotify_canciones.csv`](/teaching/ba/week-13/practice/spotify_canciones.csv) ·
[`socios_califit.csv`](/teaching/ba/week-13/task/socios_califit.csv)

**Week 14 — Examen Parcial 2.** Second integrative written exam (20%), covering weeks 8–13. October 26–31.

**Week 15 — Simulacro de la presentación final.** Each group presents a preliminary version of its final defense and receives feedback on substance and form. November 2–8.

**Week 16 — Presentación del Proyecto Final.** Final oral defense of the project (Deliverable 3, 20%). It counts as an exam: attendance is mandatory. November 9–14.

## Evaluation

| Component | Weight | Allowed use of AI |
|---|---|---|
| Weekly concept quizzes (every content week, on Intu) | 25% | No AI |
| In-class workshops (one per session) | 10% | Collaboration with AI — every decision must be explainable; the business conclusion is written without AI |
| Integrative written exam 1 (week 7) | 20% | No AI |
| Integrative written exam 2 (week 14) | 20% | No AI |
| Final project (three deliverables) | 25% | Planning / collaboration with AI, depending on the deliverable |

Quizzes and workshops have no make-ups; as a mitigation mechanism, the worst quiz grade and the worst workshop grade are dropped once per semester. AI use in graded work follows ICESI's institutional five-level IAG scale — each activity states its maximum allowed level, and every use must be declared, verified, and traceable.

## Final project

The course assigns no closed cases: each group receives a **multi-variable business dataset**, formulates its own business question, and answers it with one of the course's analytical tasks — classification, regression, or segmentation. Three deliverables: **(1)** the business question (week 6 — a prerequisite for the later deliverables), **(2)** an oral progress presentation of the EDA (week 9, 5%), and **(3)** the final oral defense (week 16, 20%). There is no written document: the defense is the final product, the presenting group member may be chosen at random, and attendance follows the same rules as an exam.

## Bibliography and resources

- Wickham, H. & Grolemund, G. (2017). [*R for Data Science*](https://r4ds.hadley.nz/){:target="_blank"}. O'Reilly Media. — data manipulation, visualization, and workflow.
- James, G., Witten, D., Hastie, T. & Tibshirani, R. (2021). [*An Introduction to Statistical Learning: with Applications in R*](https://www.statlearning.com){:target="_blank"} (2nd ed.). Springer. — ML foundations, classification, regularization, trees, unsupervised learning.
- Perkins, M., Roe, J. & Furze, L. (2025). [Reimagining the Artificial Intelligence Assessment Scale (AIAS)](https://doi.org/10.53761/rrm4y757){:target="_blank"}. *Journal of University Teaching and Learning Practice, 22*(7). — the framework behind the course's AI-use levels.

Reference handouts from the previous edition of the course, still available as complementary reading (in Spanish):
[IA y Machine Learning](/teaching/ba/week-15/week-15-1.html) ·
[LLMs, Skills y Agentes](/teaching/ba/week-15/week-15-2.html) ·
[Prompts: cómo formular preguntas a una IA](/teaching/ba/week-15/week-15-3.html)

---

*Materials are released progressively as the semester advances.*
