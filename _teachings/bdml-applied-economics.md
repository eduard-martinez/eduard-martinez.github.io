---
layout: course
title: Big Data and Machine Learning for Applied Economics
description: >
  Graduate course on statistical learning for applied economics and finance:
  the predict-vs-explain distinction, regression and classification as prediction
  machines, cross-validation and regularization, trees, random forests and
  boosting, model interpretation (variable importance, partial dependence, SHAP),
  and representation with PCA, k-means and neural networks — following ISL and
  applied in R on one running case: predicting the vote of every Colombian
  polling station.
institution: Universidad ICESI
department: Department of Economics
course_code: "60-121 · NRC 10-993"
program: Master's in Economics (ME)
term: "September 15 – November 24, 2026"
instructor: Eduard F. Martínez-González
year: 2026
credits: 3
weekly_hours: 3
location: "Room 406-E (Block E)"
time: "Tuesdays, 8:00–11:00 a.m."
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
  .ws-soon {
    border-style: dashed;
    color: var(--global-text-color-light);
    cursor: default;
  }
  .ws-soon i { color: var(--global-text-color-light); }
  .ws-data { display: block; color: var(--global-text-color-light); font-size: 0.85rem; margin-top: 0.2rem; }
  .ws-data code { font-size: 0.8rem; }
</style>

Original title (in Spanish): **Big Data y Machine Learning para Economía Aplicada** (60-121, NRC 10-993). Lectures and materials are in Spanish. *Prerequisites:* Econometrics I & II (or equivalent); basic R is recommended, not required.

All course materials — syllabus, lecture slides, R applications and problem sets — are hosted on GitHub:

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-github"></i>github.com/eduard-martinez/bdml-applied-economics</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/syllabus/syllabus.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Full syllabus (PDF, in Spanish)</a>
<span class="ws-btn ws-soon"><i class="fas fa-graduation-cap"></i>Final project guidelines · soon</span>
<a href="https://www.statlearning.com" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-book"></i>Course text — ISL, 2nd ed. (free online)</a>
</p>

## Course description

In causal inference the goal is to identify a parameter correctly: the effect β of an intervention on an outcome. In this course the goal changes place — the interest is Y: building models that **predict the variable of interest well** on data the model has not seen, **evaluating** that predictive performance honestly, and **opening the model** to understand what the prediction depends on. That distinction between explaining and predicting organizes the whole semester and is drawn from the very first session.

The course introduces Master's students to the statistical-learning framework and to the machine-learning tools most used today in applied economics and finance: regression as a prediction machine, cross-validation and the honest pipeline, regularization (Ridge, Lasso, Elastic Net), classification and the threshold as a decision with costs, trees, random forests and boosting, interpretation tools (permutation importance, partial dependence, SHAP) and representation with PCA, k-means and neural networks. The progression follows *An Introduction to Statistical Learning* (James, Witten, Hastie & Tibshirani, 2nd ed.), the course textbook.

The treatment combines **sufficient formality** with **a lot of intuition**. For each method the course presents its objective function and hyperparameters, explains what problem it solves and how it works, implements it on real data in R, evaluates its out-of-sample performance against a baseline model, and interprets the results. Long derivations live in each session's *Para profundizar* appendix.

**One running case.** From session 2 to session 8 the class works on a single problem: predicting the vote of each of Colombia's 12,001 polling stations in the 2022 presidential runoff, using the census characteristics of the station's surroundings and its location. Every week the same table of leaders grows by one model, evaluated on the same untouched test set. The problem sets transfer the tools to a second dataset — housing prices in Cali — and in the final project each team brings its own data.

## Learning outcomes

By the end of the course, students will be able to:

- Distinguish a prediction problem from a causal-inference problem, and recognize when out-of-sample predictive performance is the quantity of interest.
- Build the complete workflow in R: splitting, preprocessing inside the pipeline, validation, tuning, evaluation against a baseline and interpretation.
- Evaluate regression and classification models with the appropriate metrics (RMSE, MAE, out-of-sample R², AUC, calibration, costs of each error), and diagnose where the errors concentrate.
- Apply and compare regularization, k-NN, trees, random forests, boosting and neural networks on economic data, knowing when each family is the right choice.
- Open a flexible model with permutation importance, partial dependence and SHAP — and know what it says and what it does not say.
- Read critically and present economic research that uses ML.

## How each class works

Each session is organized in three parts:

1. **Theory and concepts.** For every method, the same sequence: the problem it solves, the intuition, the essential formulation, how it works and how it is tuned, the application on real data, the evaluation and the interpretation. Long derivations go to the session's appendix.
2. **Applied work in R.** The last stretch of each class is hands-on work with prepared code on the running case (week 1 is the conceptual exception, with a small simulated example). Each script reports out-of-sample performance against the previous week's leader; they are written in base R plus a handful of packages (`rio`, `dplyr`, `glmnet`, `rpart`, `randomForest`, `xgboost`, `nnet`), with no hidden machinery.
3. **The papers.** Each session has a reference applied article that shows the method at work in published research. In session 2 each team picks the paper it will present — two options per field of economics — and presents it in **session 8**, in 15 minutes: the question and the decision behind it, the data, the baseline, the out-of-sample evaluation and where the model fails, and the main result.

## Getting up to speed in R

The R leveling is mandatory, self-paced and happens outside class hours:

- [Introduction to R](/teaching/intro-r/unidad-1-fundamentos/teoria/teoria_unidad-1.html) — R, RStudio, objects and data frames.
- [Data wrangling with `dplyr`](https://eduard-martinez.github.io/blog/dlplyr/){:target="_blank"}
- [Reading and writing data](/teaching/intro-r/unidad-2-manejo-datos/teoria/teoria_unidad-2.html)
- [Good practices in data management](https://eduard-martinez.github.io/blog/data_managment/){:target="_blank"}
- Good modeling practices with `tidymodels` — material posted on Intu.

Equivalent reference material is offered for students who choose the Python track.

## Schedule

Each week shows its class materials as buttons — the lecture slides, the R application script and a zip with the script plus its data — with the readings and the week's milestones on the small lines below.

**Key dates.** Problem set 1: published Oct 6, due Oct 20 at 8:00 a.m. · Project pitch: Nov 3 · Problem set 2: published Oct 20, due Nov 10 at 11:59 p.m. · Final project document (max. 8 pages) and presentations: Nov 24.

### Module 1 — Foundations and evaluation

**Week 1 · Sep 15 — Predict, don't explain: the statistical-learning framework.**
From β to Y; the generalization risk and why the conditional mean is the best predictor; the two golden rules (training error is optimistic; the test set is opened once); bias, variance and the U-curve.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-01/week-01.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/applications/week-01/week-01.R" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-r-project"></i>R application · one dataset, three models</a>
<a href="https://raw.githubusercontent.com/eduard-martinez/bdml-applied-economics/main/applications/week-01.zip" class="ws-btn"><i class="fas fa-download"></i>Download · script + data (.zip)</a>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 1–2 (section 2.2) · Mullainathan &amp; Spiess (2017), <em>Machine Learning: An Applied Econometric Approach</em></small>
</p>

**Week 2 · Sep 22 — Linear regression as a prediction machine, and how to evaluate a prediction.**
The same OLS with a different criterion: what survives, what stops mattering and what appears; k-NN as the first contrast; metrics, the baseline in the first row of the table, and where to look for the errors. The running case starts.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-02/week-02.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/applications/week-02/week-02.R" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-r-project"></i>R application · the vote of a polling station</a>
<a href="https://raw.githubusercontent.com/eduard-martinez/bdml-applied-economics/main/applications/week-02.zip" class="ws-btn"><i class="fas fa-download"></i>Download · script + data (.zip)</a>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 3 · ch. 7 (steps, splines and GAMs)</small>
<small class="ws-data"><strong>Milestone:</strong> teams choose their session-8 paper (two options per field of economics)</small>
</p>

**Week 3 · Sep 29 — Cross-validation and regularization: the honest pipeline.**
Choosing between models without spending the test set: k-fold, the CV curve, leakage and preprocessing inside the pipeline, validating by group, in time and in space; Ridge, Lasso and Elastic Net with λ by CV — 37 predictors, or 1,253 if each one weighs differently by department.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-03/week-03.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/applications/week-03/week-03.R" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-r-project"></i>R application · the pipeline and the Lasso</a>
<a href="https://raw.githubusercontent.com/eduard-martinez/bdml-applied-economics/main/applications/week-03.zip" class="ws-btn"><i class="fas fa-download"></i>Download · script + data (.zip)</a>
<small class="ws-data"><strong>Readings:</strong> ISL 5.1 (cross-validation) · 6.2 and 6.4 (Ridge, Lasso, high dimension)</small>
</p>

**Week 4 · Oct 6 — Classification: from the logit to decisions.**
Same election, same stations, new y: does Petro win the station? Logit as the baseline, penalized logit and k-NN; why accuracy misleads, the confusion matrix, the threshold as a decision with costs, ROC/AUC and calibration.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-04/week-04.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/applications/week-04/week-04.R" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-r-project"></i>R application · does Petro win the station?</a>
<a href="https://raw.githubusercontent.com/eduard-martinez/bdml-applied-economics/main/applications/week-04.zip" class="ws-btn"><i class="fas fa-download"></i>Download · script + data (.zip)</a>
<small class="ws-data"><strong>Readings:</strong> ISL 4.1–4.3 and 4.4.2 (confusion matrix and ROC) · 4.7.6 (penalized logit) · Fawcett (2006)</small>
<small class="ws-data"><strong>Milestone:</strong> Problem set 1 published (sessions 2–4; due Oct 20, 8:00 a.m.)</small>
</p>

### Module 2 — Trees, ensembles and interpretation

**Week 5 · Oct 13 — Trees, forests and boosting.**
Can the machine find the partitions that matter on its own? A tree you can read and its pruning by CV; the forest that averages hundreds of trees (out-of-bag error, `mtry`); boosting that fits residuals with early stopping.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-05/week-05.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/applications/week-05/week-05.R" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-r-project"></i>R application · tree, forest and boosting</a>
<a href="https://raw.githubusercontent.com/eduard-martinez/bdml-applied-economics/main/applications/week-05.zip" class="ws-btn"><i class="fas fa-download"></i>Download · script + data (.zip)</a>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 8 (8.1 the tree, 8.2 the ensembles) · Breiman (2001)</small>
<small class="ws-data"><strong>Thread paper:</strong> Gelvez, Cardiles, Martínez-González &amp; Muñoz (2026), <em>How Predictable Is an Election?</em> — <a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/literature/democratization_AIM4D_Notre_Dame.pdf" target="_blank" rel="noopener">PDF</a></small>
</p>

**Week 6 · Oct 20 — Opening the black box: importance, partial dependence and SHAP.**
No new method — today we walk into the box: permutation importance (and why the impurity one misleads), partial dependence and ICE curves, Shapley values and SHAP, the contribution of each census block, and where the leader gets it wrong.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-06/week-06.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/applications/week-06/week-06.R" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-r-project"></i>R application · opening the leader</a>
<a href="https://raw.githubusercontent.com/eduard-martinez/bdml-applied-economics/main/applications/week-06.zip" class="ws-btn"><i class="fas fa-download"></i>Download · script + data (.zip)</a>
<small class="ws-data"><strong>Readings:</strong> Molnar (2025), the permutation-importance, PDP and SHAP chapters (read the disadvantages twice)</small>
<small class="ws-data"><strong>Milestones:</strong> Problem set 1 due (8:00 a.m.) · Problem set 2 published (sessions 5–7; due Nov 10, 11:59 p.m.)</small>
</p>

### Module 3 — Representation, synthesis and project

**Week 7 · Oct 27 — Representing: PCA, k-means and neural networks.**
Can the data build their own summaries? Without y, PCA compresses the 37 census columns into a few indices and k-means groups stations into territory types; with y, a neural network learns the representation and the prediction at once, and is measured against the forest.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-07/week-07.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/applications/week-07/week-07.R" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-r-project"></i>R application · PCA, k-means and a network</a>
<a href="https://raw.githubusercontent.com/eduard-martinez/bdml-applied-economics/main/applications/week-07.zip" class="ws-btn"><i class="fas fa-download"></i>Download · script + data (.zip)</a>
<small class="ws-data"><strong>Readings:</strong> ISL 12.2 (principal components) and 12.4.1 (k-means) · 10.1–10.3 and 10.6–10.7 (neural networks)</small>
<small class="ws-data"><strong>Milestone:</strong> the session opens with the Problem set 1 debrief and ranking</small>
</p>

**Week 8 · Nov 3 — The papers and the synthesis: student presentations, the course map and the project pitches.**
No new method: today all of them are used. The student paper presentations (15 minutes each), the map that puts papers, methods and workflow together, and the one-page project pitches (five minutes each).

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-08/week-08.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<small class="ws-data"><strong>Readings:</strong> Athey &amp; Imbens (2019), sections 1–3 (the causal bridge)</small>
<small class="ws-data"><strong>Session papers:</strong> two papers per field of economics; each team picks one in session 2 and presents it today — the list is defined after session 2. The PDFs are not distributed in the repository for copyright reasons.</small>
<small class="ws-data"><strong>Milestone:</strong> project pitch — the idea in one page</small>
</p>

**Week 9 · Nov 24 — The final project: presentations and course closing.**
The Problem set 2 ranking and the course in one slide; then each team presents its predictive research proposal and hands in the document.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-09/week-09.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<small class="ws-data"><strong>Milestones:</strong> final project presentations · project document submitted (max. 8 pages)</small>
</p>

## Problem sets

Both problem sets are applied only — no conceptual questions — and work on a second dataset: **housing prices in Cali**, so the tools travel to a problem other than the class case. Each one closes with a ranking of the teams by test error.

- **Problem set 1 — sessions 2–4.** Published Oct 6, due Oct 20 at 8:00 a.m., before session 5. The session-2 to session-4 scripts are the starting point. *PDF and data: available soon.*
- **Problem set 2 — sessions 5–7.** Published Oct 20, due Nov 10 at 11:59 p.m. *PDF and data: available soon.*

Each problem set is submitted as a single PDF accompanied by a reproducible `.R` script.

## Evaluation

| Component | Weight |
|---|---|
| Paper presentation (15 min, session 8) | 10% |
| Problem set 1 — sessions 2–4 | 15% |
| Problem set 2 — sessions 5–7 | 15% |
| Final project | 60% |

**Final project.** A predictive research proposal: each team defines an economic question in which prediction is the quantity of interest, identifies its own data, and designs the study that survives the seven questions of the course — the question and the decision behind it, the unit and the outcome, the data and what is known at prediction time, the metric and the baseline, the validation strategy, the risks (leakage, extrapolation, subgroups where it fails), and the reading of the results. The idea is pitched in one page on **Nov 3** (session 8); the document — at most eight pages — and the presentation are due on **Nov 24** (session 9).

**AI policy:** AI tools are allowed in every component of the course, as long as their use is explicitly declared — what was used and for what.

## Reading library

Each session has a reference applied article that shows the method at work in published research; from session 2 each team also picks the paper it will present in session 8, choosing between two options per field of economics. The papers themselves are not distributed in the repository for copyright reasons: each one is announced in class with its full reference, to be retrieved through the university library.

The repo's [`literature/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/literature) folder holds the course's own thread paper: Gelvez, Cardiles, Martínez-González & Muñoz (2026), *How Predictable Is an Election? A Machine-Learning Approach to Electoral Behavior in Colombia* — the benchmark the class results are compared against in session 9.

## Core bibliography

- James, G., Witten, D., Hastie, T., & Tibshirani, R. (2021). *An Introduction to Statistical Learning with Applications in R* (2nd ed.). Springer. [ISL] — [free online](https://www.statlearning.com); a course copy is in the repo's [`books/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/books) folder.
- Molnar, C. (2025). *Interpretable Machine Learning: A Guide for Making Black Box Models Explainable* (3rd ed.) — [free online](https://christophm.github.io/interpretable-ml-book/).
- Hastie, T., Tibshirani, R., & Friedman, J. (2009). *The Elements of Statistical Learning* (2nd ed.). Springer. [ESL]
- Goodfellow, I., Bengio, Y., & Courville, A. (2016). *Deep Learning*. MIT Press.
