---
layout: course
title: R Programming Leveling Course
description: >
  Short, intensive R leveling course for students entering the Master's programs in
  Economics and in Management Sciences (Econometría I). Covers R and RStudio fundamentals,
  reproducible project workflows, data wrangling with the tidyverse, visualization with
  ggplot2 and descriptive statistics on real GEIH microdata, and basic regressions
  (Mincer equation with lm, fixest, and modelsummary) — with a critical, verified use
  of generative AI built into every unit.
institution: Universidad ICESI
department: CIENFI — Centro de Investigaciones en Economía y Finanzas
program: Master's in Economics and in Management Sciences
term: July 2026
instructor: Eduard F. Martínez-González
year: 2026
---

Original title (in Spanish): **Curso Nivelatorio de Programación en R — Manejo y análisis de datos para investigación aplicada**.

All course materials — theory documents with runnable R in the browser (via webR), guided practices, assignments, quizzes, AI activities, and the course datasets — are published on the course website:

<a href="/teaching/intro-r/" class="btn btn-sm z-depth-0" role="button" style="font-size: 12px;">
  <i class="fas fa-globe"></i> &nbsp; Course website
</a>
<a href="/teaching/intro-r/programa/programa_curso.html" class="btn btn-sm z-depth-0" role="button" style="font-size: 12px;">
  <i class="fas fa-file-alt"></i> &nbsp; Full program (syllabus)
</a>

## Course description

A brief, intensive leveling course so that incoming Master's students arrive with a common base in R: importing, cleaning, transforming, merging, describing, and visualizing data, estimating basic regressions, and — above all — working in an **organized and reproducible** way, as applied research demands. No prior programming experience is required.

The course runs on a **see → replicate → apply** cycle: students first watch the theory (documents embed executable R code in the browser, so no installation is needed to start experimenting) and the support video, then replicate the guided practice in RStudio inside their own project, and finally apply what they learned in an assignment with its quiz and an AI activity. Synchronous sessions open each block; most of the learning happens by doing.

## The four units

1. **Fundamentals of R and a reproducible workflow.** What R does when code runs, how to read errors and warnings, vectors and data frames, and the foundation of the whole course: RStudio projects, organized folders, and well-styled scripts.
2. **Data wrangling with the tidyverse.** The 80% of real empirical work: importing and diagnosing, cleaning a dirty dataset with documented decisions, transforming with `dplyr`, grouping, and merging datasets with joins.
3. **Visualization and descriptive statistics.** From clean data to a communicable finding with `ggplot2` and descriptive tables, working on a real extract of Colombia's GEIH household survey (DANE).
4. **Basic regressions and the empirical workflow.** The Mincer equation on the GEIH: `lm`, interpretation in units (and without unjustified causal claims), `fixest`, tables with `modelsummary`, and the full reproducible pipeline.

## Course materials

| Unit | Theory | Video | Practice | Assignment | Quiz | AI activity |
|---|---|---|---|---|---|---|
| **1. Fundamentals** | [Theory](/teaching/intro-r/unidad-1-fundamentos/teoria/teoria_unidad-1.html) | [Video](https://www.youtube.com/watch?v=_UnjI5eTkNc&t=963s){:target="_blank"} | [Practice 1](/teaching/intro-r/unidad-1-fundamentos/practica/practica_unidad-1.html) | [Assignment 1](/teaching/intro-r/unidad-1-fundamentos/tarea/tarea_unidad-1.html) | [Quiz 1](/teaching/intro-r/unidad-1-fundamentos/tarea/cuestionario_unidad-1.html) | [Activity 1](/teaching/intro-r/unidad-1-fundamentos/actividad_ia_unidad-1.html) |
| **2. Data wrangling** | [Theory](/teaching/intro-r/unidad-2-manejo-datos/teoria/teoria_unidad-2.html) | [Video](https://www.youtube.com/watch?v=MVNvoBbELKs&t=1801s){:target="_blank"} | [Practice 2](/teaching/intro-r/unidad-2-manejo-datos/practica/practica_unidad-2.html) | [Assignment 2](/teaching/intro-r/unidad-2-manejo-datos/tarea/tarea_unidad-2.html) | [Quiz 2](/teaching/intro-r/unidad-2-manejo-datos/tarea/cuestionario_unidad-2.html) | [Activity 2](/teaching/intro-r/unidad-2-manejo-datos/actividad_ia_unidad-2.html) |
| **3. Visualization** | [Theory](/teaching/intro-r/unidad-3-visualizacion/teoria/teoria_unidad-3.html) | [Video](https://www.youtube.com/watch?v=sCfhUTHA4fQ){:target="_blank"} | [Practice 3](/teaching/intro-r/unidad-3-visualizacion/practica/practica_unidad-3.html) | [Assignment 3](/teaching/intro-r/unidad-3-visualizacion/tarea/tarea_unidad-3.html) | [Quiz 3](/teaching/intro-r/unidad-3-visualizacion/tarea/cuestionario_unidad-3.html) | [Activity 3](/teaching/intro-r/unidad-3-visualizacion/actividad_ia_unidad-3.html) |
| **4. Regressions** | [Theory](/teaching/intro-r/unidad-4-regresiones/teoria/teoria_unidad-4.html) | — | [Practice 4](/teaching/intro-r/unidad-4-regresiones/practica/practica_unidad-4.html) | [Assignment 4](/teaching/intro-r/unidad-4-regresiones/tarea/tarea_unidad-4.html) | [Quiz 4](/teaching/intro-r/unidad-4-regresiones/tarea/cuestionario_unidad-4.html) | [Activity 4](/teaching/intro-r/unidad-4-regresiones/actividad_ia_unidad-4.html) |

## Evaluation

| Component | Weight | Allowed use of AI |
|---|---|---|
| Assignments 1–4 (script + quiz) | 40% | To understand and debug, declared |
| AI activities | 10% | Designed to use AI with verification |
| Final project (reproducible pipeline + report) | 35% | Integrated, with a usage appendix |
| Oral defense of the code | 15% | **No AI** |

The AI policy in one sentence: *your brain first, then the AI; everything the AI produces gets **verified**; and every use is **declared**.* Levels and the verification checklist are in the [AI usage guide](/teaching/intro-r/ia/guia_uso_ia.html).

## Final project

A complete empirical analysis, in pairs, on the **firm innovation** dataset: clean with documented decisions, build sector-level indicators and compare them against the national benchmark, plot, estimate the innovation–sales relationship and interpret it — all inside a reproducible project defended orally.
[Project statement](/teaching/intro-r/proyecto_final/enunciado_proyecto_final.html) ·
[Rubric](/teaching/intro-r/proyecto_final/rubrica_proyecto_final.html)

## Datasets

| Dataset | Unit of observation | Used in |
|---|---|---|
| [innovacion_empresas.csv](/teaching/intro-r/datos/innovacion_empresas.csv) | Firm (506, *deliberately dirty*) | Units 1–2 and final project |
| [sectores_agregado.csv](/teaching/intro-r/datos/sectores_agregado.csv) | Sector (7, clean benchmark) | Unit 2 and final project |
| [geih_nivelacion.csv](/teaching/intro-r/datos/geih_nivelacion.csv) | Employed person (21,821, **real GEIH**) | Units 3–4 |

Variable-by-variable description: [data dictionary](/teaching/intro-r/datos/diccionario_datos.html).

## Course guides

- [Full course program](/teaching/intro-r/programa/programa_curso.html) — objectives, methodology, bibliography
- [Script style guide](/teaching/intro-r/buenas_practicas/guia_estilo_scripts.html) — how scripts are written in this course
- [Project organization guide](/teaching/intro-r/buenas_practicas/guia_organizacion_proyecto.html) — folders, rules, and the reproducibility test
- [Project template](/teaching/intro-r/buenas_practicas/plantilla_proyecto.html) — ready-to-copy structure (downloadable)
- [AI usage guide](/teaching/intro-r/ia/guia_uso_ia.html) — rules, levels, prompts, and the verification checklist

## Calendar

Four synchronous sessions (10:00–12:00) in July 2026 — July 14, 21, 27, and 31 — each opening a block of asynchronous work: theory and practice, assignments, AI activities, and the final project in pairs, which is presented in the last session.
