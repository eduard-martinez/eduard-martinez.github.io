---
layout: course
title: Introduction to Business Analytics
description: >
  Undergraduate course on data analysis and machine learning for business decision-making.
  Covers R programming fundamentals, data wrangling with the tidyverse, exploratory data
  analysis, clustering, classification and regression trees, and an introduction to
  AI tools, LLMs and prompt engineering for analytics work.
institution: Universidad ICESI
department: Department of Economics
course_code: 06278-ECO
program: Undergraduate
term: 2026-01
instructor: Eduard F. Martínez-González
year: 2026
---

Original title (in Spanish): **Introducción al Business Analytics**.

All course materials — theory decks, in-class tasks, guided practices, and datasets — are published on this site as each week is released. The slides are built with [Quarto](https://quarto.org/){:target="_blank"} and embed runnable R through [webR](https://docs.r-wasm.org/webr/latest/){:target="_blank"}, so students can execute every example directly in the browser, with no local installation required.

## Course description

The course introduces students to the workflow of an analyst: how to turn raw data into evidence that supports business decisions. Students learn to program in R, manipulate and visualize data with the tidyverse, run exploratory data analysis, and apply foundational machine learning methods (clustering and decision trees) to real business datasets. The last unit covers the practical use of AI tools — large language models, agents, and prompt design — for analytics work.

## Learning outcomes

By the end of the course, students will be able to:

- Program in **R** from the ground up — objects, data types, vectors, data frames, functions, and package management — and organize a reproducible, script-based workflow.
- Manipulate and summarize data with **`dplyr`** (`select`, `filter`, `arrange`, `mutate`, `group_by`/`summarise`) and build clear, layered visualizations with **`ggplot2`**.
- Diagnose and clean messy real-world data — missing values, duplicates, inconsistent categories — and carry an exploratory data analysis through from raw file to insight.
- Explain the core ideas of **machine learning** — supervised vs. unsupervised, the train/test split, overfitting, baselines, cross-validation, and evaluation metrics — and avoid common pitfalls such as data leakage.
- Apply foundational ML methods to business problems: **k-means clustering** for segmentation, and **classification and regression trees** for prediction, reading their results through confusion matrices and error metrics (MAE, RMSE).
- Use **AI tools** (LLMs, skills, agents) critically and write effective prompts for analytics work.

## Schedule

### Unit 2 — Foundations of R and Programming

**Week 3 — Fundamentos de R y Programación.**
The RStudio interface (the four panels and a reproducible workflow); R as a calculator (arithmetic, operator precedence, comparison and logical operators); data types (numeric, character, logical) and special values (`NA`, `NULL`, `Inf`, `NaN`); objects and assignment, naming conventions (`snake_case`), and inspecting an object's class, type and structure; managing the Environment; functions and the help system; installing and loading packages (including `pacman`); vectors (creation, indexing, filtering) and data frames (creation, inspection, row/column indexing, filtering).
[Theory slides](/teaching/ba/week-03/theory/week-03.html) ·
[In-class task](/teaching/ba/week-03/task/week-03.html)

### Unit 3 — Data Wrangling and Visualization

**Week 4 — Transformación de Datos con `dplyr`.**
The dplyr grammar of data manipulation: `select()`, `rename()`, `filter()` (comparison operators and multiple conditions), `arrange()`/`desc()`, `mutate()` (single and multiple columns, conditional labels), and `summarise()` with `group_by()` for grouped descriptives; the pipe-based workflow, working directory, and common errors.
[Theory slides](/teaching/ba/week-04/theory/week-04.html) ·
[Task R script](/teaching/ba/week-04/task/task-week-04.R) ·
[Dataset (`cafeteria.csv`)](/teaching/ba/week-04/task/cafeteria.csv) ·
[Dataset (`ventas.csv`)](/databases/ba/ventas.csv)

**Week 5 — Visualización de Datos con `ggplot2`.**
The grammar of graphics (data, aesthetics, geometries) and building a plot layer by layer; aesthetic mappings inside vs. outside `aes()`; choosing geometries by the question being asked; customization, facets for multi-group comparison, and communication best practices.
[Theory slides](/teaching/ba/week-05/theory/week-05.html)

### Unit 4 — Data Sources, Quality and EDA

**Week 6 — Fuentes, Calidad de Datos y Análisis Exploratorio.**
Data sources; diagnosing data quality with `skimr` on a deliberately "dirty" dataset — missing values, exact duplicates, and inconsistent categories detected with `unique()`, `table()` and `duplicated()`; cleaning each problem step by step; and running an exploratory data analysis on the cleaned data.
[Theory slides](/teaching/ba/week-06/theory/week-06.html) ·
[Dataset (`ventas_raw.csv`)](/databases/ba/ventas_raw.csv)

### Unit 6 — Machine Learning Foundations

**Week 9 — Fundamentos de Machine Learning.**
What machine learning is and the problems it solves; supervised vs. unsupervised learning and classification vs. regression; the vocabulary of target, features and observations; the train/test split and why we separate data; overfitting and underfitting, baselines, cross-validation and data leakage; the modeling pipeline and evaluation metrics, closing with a guided application that compares models.
[Theory slides](/teaching/ba/week-09/theory/week-09.html)

### Unit 7 — Clustering

**Week 10 — Clustering: Fundamentos y Métricas.**
Why segment; the intuition behind k-means (similarity as distance, the four-step algorithm); choosing k with the elbow and silhouette methods and the interpretability criterion; profiling and naming clusters; high-level alternatives to k-means; and the full segmentation pipeline. The guided practice segments songs using Spotify audio features.
[Theory slides](/teaching/ba/week-10/theory/week-10.html) ·
[Practice](/teaching/ba/week-10/practice/week-10.html) ·
[Practice R script](/teaching/ba/week-10/practice/week-10.R)

### Unit 8 — Classification Trees

**Week 11 — Árboles de Clasificación.**
The decision tree as a series of questions (nodes, leaves, depth) and how it learns; the effect of tree depth; reading a classifier with the confusion matrix — the 2×2 table and the metrics derived from it (accuracy, precision, recall); and turning the result into a business decision. The guided practice follows an 11-step pipeline on a credit-classification dataset.
[Theory slides](/teaching/ba/week-11/theory/week-11.html) ·
[Practice](/teaching/ba/week-11/practice/week-11.html) ·
[Dataset (`credito_clasificacion.csv`)](/teaching/ba/week-11/db/credito_clasificacion.csv) ·
[Data prep script](/teaching/ba/week-11/db/credito_clasificacion.R)

### Unit 9 — Regression Trees

**Week 12 — Árboles de Regresión.**
From classification to regression — what changes when the target is a number; how a regression tree predicts through homogeneous groups and their averages; the role of depth; regression metrics (MAE and RMSE, and when to prefer each); and interpreting the metrics for the business. The guided practice predicts student grades on a regression dataset.
[Theory slides](/teaching/ba/week-12/theory/week-12.html) ·
[Practice](/teaching/ba/week-12/practice/week-12.html) ·
[Dataset (`notas_regresion.csv`)](/teaching/ba/week-12/db/notas_regresion.csv) ·
[Data prep script](/teaching/ba/week-12/db/notas_regresion.R)

### Unit 10 — AI, LLMs and Prompting

**Week 15 — Special handouts on AI tools for analytics.**
Three self-contained handouts on using AI in analytics work:

- [Handout 1 — Inteligencia Artificial y Machine Learning](/teaching/ba/week-15/week-15-1.html) — definitions, AI that is *not* ML, the three types of AI, limitations and risks by category, and a decision framework for when to use each.
- [Handout 2 — LLMs, Skills y Agentes](/teaching/ba/week-15/week-15-2.html) — what an LLM is and how it works, critical limitations every analyst should know, skills, agents, and the MCP standard for connecting agents to tools.
- [Handout 3 — Prompts: cómo formular preguntas a una IA](/teaching/ba/week-15/week-15-3.html) — the anatomy of a good prompt, weak-vs-good examples, additional techniques, common beginner mistakes, and a reusable template.

## Methodology

Each unit pairs a **theory deck** — concepts plus runnable R examples that execute in the browser via webR — with a hands-on component: an **in-class task** in the foundational units and a **guided practice** on a real business dataset in the machine-learning units. The clustering and tree practices follow an explicit step-by-step pipeline (load → explore → split → train → evaluate → compare against a baseline → interpret for the business), so students reproduce the full analyst workflow from end to end.

## Datasets and tools

The course is built around a small set of business datasets — `ventas.csv` and the deliberately messy `ventas_raw.csv` for wrangling, cleaning and EDA, plus `cafeteria.csv`, `credito_clasificacion.csv` and `notas_regresion.csv` for the tasks and ML practices — together with a core R toolkit: `dplyr` and `ggplot2` (tidyverse), `skimr` for data-quality diagnostics, and `pacman` for package management, complemented by interactive explainers (a k-means playground and interactive decision-tree explorers).

---

*Additional weeks and materials are added as the semester progresses.*
