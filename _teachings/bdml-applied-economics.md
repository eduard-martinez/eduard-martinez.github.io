---
layout: course
title: Big Data and Machine Learning for Applied Economics
description: >
  Graduate course on statistical learning for applied economics and finance:
  the predict-vs-explain distinction, regression and classification as prediction
  machines, resampling and honest validation, regularization (Ridge, Lasso, Elastic
  Net), trees, random forests and boosting, model interpretation (variable
  importance, partial dependence, SHAP) and neural networks — following ISL,
  applied in R on Colombian data.
institution: Universidad ICESI
department: Department of Economics
course_code: "60-121 · NRC 10-993"
program: Master's in Economics (ME)
term: "September 15 – November 11, 2026"
instructor: Eduard F. Martínez-González
year: 2026
credits: 3
weekly_hours: 3
location: "Room 406-E (Block E)"
time: "8:00–11:00 a.m."
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

All course materials — syllabus, lecture slides, problem sets, R applications, and reference papers — are hosted on GitHub:

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-github"></i>github.com/eduard-martinez/bdml-applied-economics</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/syllabus/syllabus.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Full syllabus (PDF, in Spanish)</a>
<span class="ws-btn ws-soon"><i class="fas fa-graduation-cap"></i>Final project guidelines · soon</span>
<a href="https://www.statlearning.com" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-book"></i>Course text — ISL, 2nd ed. (free online)</a>
</p>

## Course description

In causal inference the goal is to identify a parameter correctly: the effect β of an intervention on an outcome. In this course the goal changes place — the interest is Y: building models that **predict the variable of interest well** on data the model has not seen, **evaluating** that predictive performance honestly, and **opening the model** to understand what the prediction depends on. That distinction between explaining and predicting organizes the whole semester and is drawn from the very first session.

The course introduces Master's students to the statistical-learning framework and to the machine-learning tools most used today in applied economics and finance: regression as a prediction machine, classification, cross-validation, regularization (Ridge, Lasso, Elastic Net), trees, random forests and boosting, interpretation tools (variable importance, partial dependence, SHAP values) and neural networks. The progression follows *An Introduction to Statistical Learning* (James, Witten, Hastie & Tibshirani, 2nd ed.), the course textbook. Three datasets run through the semester: a panel of Colombian polling stations with census characteristics, housing prices in Bogotá, and satellite imagery.

The treatment combines **sufficient formality** with **a lot of intuition**. For each method the course presents its objective function and hyperparameters, explains what problem it solves and how it works, implements it on real data in R, evaluates its out-of-sample performance against a baseline model, and interprets the results. Long derivations live in per-session appendices, available for anyone who wants to go deeper. Each session is organized around a recent applied article — the *paper of the session* — that students read beforehand and whose exercise the guided application reproduces on the course data; the semester culminates in a project where teams pose a predictive question, compare several algorithms and defend their results.

## Learning outcomes

By the end of the course, students will be able to:

- Distinguish a prediction problem from a causal-inference problem, and recognize when out-of-sample predictive performance is the quantity of interest.
- Build the complete workflow of a predictive exercise: data splitting, preprocessing inside the pipeline, cross-validation, hyperparameter tuning, evaluation and interpretation.
- Evaluate regression and classification models with the appropriate metrics (RMSE, MAE, out-of-sample R², AUC, calibration, inclusion and exclusion errors), with their uncertainty and against a baseline model, and diagnose where the errors concentrate.
- Apply and compare regularization, trees, random forests, boosting and neural networks on economic data, knowing when each family is the right choice.
- Interpret flexible models with variable importance, partial dependence and SHAP values, distinguishing what they describe (what the prediction depends on) from what they do not establish (causal effects).
- Read critically and present articles in economics and finance that use ML, judging the fit of the method, the validation and the interpretation.
- Implement all of the above in R (`tidymodels`, `glmnet`, `ranger`, `xgboost`, `DALEX` and `shapviz`, `keras`), with an optional translation to Python.

## How each class works

Each session is organized in three parts:

1. **Theory and concepts.** For every method, the same sequence: the economic problem it solves, the intuition with a figure, the essential formulation (objective function and hyperparameters), how it works and how it is tuned, and when to use it. Intuition before formalism; long derivations go to the session appendix.
2. **Guided R application.** From around week 2 onward, the last 20–30 minutes of each class are hands-on work in R with prepared code on the three course datasets (week 1 is mostly conceptual). Every application reports out-of-sample performance against a baseline, predicted-vs-observed plots and, from week 6 on, interpretation tools. An optional Python track (`scikit-learn`) is offered.
3. **The paper of the session.** Each session has a reference applied article that students read beforehand with a three-question guide: what is predicted and against which baseline; how out-of-sample performance is evaluated and where the model fails; what the article interprets and what it does not claim. The article opens the session, the theory explains the method it uses, and the guided application reproduces its exercise on the course data. From the second session on, one student opens the class with a 10-minute presentation of the paper (question, data, baseline, evaluation, main result); explaining the method is not required, since that is the day's topic. Papers built around broad algorithm comparisons (Gu, Kelly & Xiu 2020; Medeiros et al. 2021; Goulet Coulombe et al. 2022) are reference readings for the final project.

## Getting up to speed in R

Before the applied sessions, each student completes a self-paced R leveling using the materials of the [R Programming Leveling Course](/teaching/intro-r/):

- [Introduction to R](/teaching/intro-r/unidad-1-fundamentos/teoria/teoria_unidad-1.html) — R, RStudio, objects and data frames.
- [Data wrangling with `dplyr`](/teaching/intro-r/unidad-2-manejo-datos/teoria/teoria_unidad-2.html)
- [Data visualization with `ggplot2`](/teaching/intro-r/unidad-3-visualizacion/teoria/teoria_unidad-3.html)
- Good modeling practices with `tidymodels` — *available soon*.

Reviewing this material is mandatory and happens outside class hours. Equivalent reference material is offered for students who choose the Python track — *available soon*.

## Schedule

Each week shows its class materials as buttons — lecture slides and, when published, the R application — with the assigned readings and the paper of the session on the small lines below.

**Key dates.** Problem set 1: published Sep 29, due Oct 20 · Project proposal: Oct 13 · Problem set 2: published Oct 27, due Nov 17 · Project progress presentations: Nov 10 (last session) · Final report and repository: Nov 24. Deliverables after the last session fall within the 2026-2 final-exam period (Nov 17–28).

### Module 1 — Foundations and evaluation

**Week 1 · Sep 15 — Predict, don't explain: the statistical-learning framework.**
From β to Y: prediction as the quantity of interest; overfitting and bias–variance; the course workflow.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-01/week-01.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<span class="ws-btn ws-soon"><i class="fa-brands fa-r-project"></i>R application · soon</span>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 1–2 · Mullainathan &amp; Spiess (2017) · Kleinberg, Ludwig, Mullainathan &amp; Obermeyer (2015)</small>
<small class="ws-data"><strong>Paper of the session:</strong> Kim &amp; Zilinsky (2024), <em>Division Does Not Imply Predictability</em> — <a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/literature/Kim_Kilinsky_2024_Division_Does_Not_Imply_Predictability.pdf" target="_blank" rel="noopener">PDF</a></small>
</p>

**Week 2 · Sep 22 — Linear regression as a prediction machine, and how to evaluate a prediction.**
OLS, polynomials, splines and k-NN as predictors; regression metrics, baseline models and where a model fails.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-02/week-02.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<span class="ws-btn ws-soon"><i class="fa-brands fa-r-project"></i>R application · soon</span>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 3 and 7 (sections 7.1–7.7)</small>
<small class="ws-data"><strong>Paper of the session:</strong> Bogin &amp; Shui (2020), <em>Appraisal Accuracy and Automated Valuation Models in Rural Areas</em> · Complementary: Pace &amp; Hayunga (2020)</small>
</p>

**Week 3 · Sep 29 — Classification: from the logit to the metrics that decide.**
Logistic regression and its neighbors; probabilities vs. classes and the threshold as a decision with costs; ROC/AUC and calibration under class imbalance.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-03/week-03.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<span class="ws-btn ws-soon"><i class="fa-brands fa-r-project"></i>R application · soon</span>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 4 · Fawcett (2006)</small>
<small class="ws-data"><strong>Paper of the session:</strong> Kleinberg, Lakkaraju, Leskovec, Ludwig &amp; Mullainathan (2018), <em>Human Decisions and Machine Predictions</em> · Complementary: Fuster, Goldsmith-Pinkham, Ramadorai &amp; Walther (2022)</small>
</p>

**Week 4 · Oct 6 — Resampling, validation and the honest pipeline.**
k-fold CV and hyperparameter tuning; leakage; temporal and spatial CV; the pipeline reused for the rest of the course.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-04/week-04.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<span class="ws-btn ws-soon"><i class="fa-brands fa-r-project"></i>R application · soon</span>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 5 · Roberts et al. (2017) · Neunhoeffer &amp; Sternberg (2019)</small>
<small class="ws-data"><strong>Paper of the session:</strong> Deppner &amp; Cajias (2024), <em>Accounting for Spatial Autocorrelation in Algorithm-Driven Hedonic Models</em> · Project reference reading: Goulet Coulombe, Leroux, Stevanovic &amp; Surprenant (2022)</small>
</p>

**Week 5 · Oct 13 — Variable selection and regularization.**
Ridge, Lasso and Elastic Net: predicting with many predictors without overfitting — a variable that survives the penalty is not a cause.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-05/week-05.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<span class="ws-btn ws-soon"><i class="fa-brands fa-r-project"></i>R application · soon</span>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 6 · Belloni, Chernozhukov &amp; Hansen (2014)</small>
<small class="ws-data"><strong>Paper of the session:</strong> Blumenstock, Cadamuro &amp; On (2015), <em>Predicting Poverty and Wealth from Mobile Phone Metadata</em> · Project reference reading: Gu, Kelly &amp; Xiu (2020)</small>
</p>

### Module 2 — Trees, ensembles and interpretation

**Week 6 · Oct 20 — Trees, forests and boosting.**
From a single unstable tree to bagging, random forests and boosting (XGBoost, LightGBM): why ensembles dominate tabular data.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-06/week-06.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<span class="ws-btn ws-soon"><i class="fa-brands fa-r-project"></i>R application · soon</span>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 8 · Breiman (2001)</small>
<small class="ws-data"><strong>Thread paper:</strong> Gelvez, Cardiles, Martínez-González &amp; Muñoz (2026), <em>How Predictable Is an Election?</em> — <a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/literature/democratization_AIM4D_Notre_Dame.pdf" target="_blank" rel="noopener">PDF</a></small>
<small class="ws-data"><strong>Complementary:</strong> Bertrand &amp; Kamenica (2023) · Project reference reading: Medeiros, Vasconcelos, Veiga &amp; Zilberman (2021)</small>
</p>

**Week 7 · Oct 27 — Opening the black box: importance, partial dependence and SHAP.**
Interpreting and auditing flexible models — permutation importance, PDP/ICE/ALE and SHAP — and what interpretation does not establish.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-07/week-07.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<span class="ws-btn ws-soon"><i class="fa-brands fa-r-project"></i>R application · soon</span>
<small class="ws-data"><strong>Readings:</strong> Molnar (2025), chapters on permutation importance, PDP, ALE and SHAP · Lundberg &amp; Lee (2017)</small>
<small class="ws-data"><strong>Paper of the session:</strong> Bluwstein, Buckmann, Joseph, Kapadia &amp; Şimşek (2023), <em>Credit Growth, the Yield Curve and Financial Crisis Prediction</em> · Complementary: Ludwig &amp; Mullainathan (2024)</small>
</p>

### Module 3 — Neural networks, structure without Y, and closing

**Week 8 · Nov 3 — Neural networks: what they are, when to use them, and an application with images.**
The network as composed regressions; fitting and regularizing it; when deep learning pays off — transfer learning on satellite imagery.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-08/week-08.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<span class="ws-btn ws-soon"><i class="fa-brands fa-r-project"></i>R application · soon</span>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 10 (sections 10.1–10.3 and 10.6–10.7) · Jean et al. (2016)</small>
<small class="ws-data"><strong>Paper of the session:</strong> Jean, Burke, Xie, Davis, Lobell &amp; Ermon (2016), <em>Combining Satellite Imagery and Machine Learning to Predict Poverty</em> · Complementary: Glaeser, Kincaid &amp; Naik (2018)</small>
</p>

**Week 9 · Nov 10 — Beyond prediction: structure without Y, the causal frontier, and project progress presentations.**
PCA and k-means without a response; ML in the service of β — double selection, double ML, causal forests; the course in one slide and each team's progress presentation of the final project.

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-09/week-09.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Lecture slides</a>
<span class="ws-btn ws-soon"><i class="fa-brands fa-r-project"></i>R application · soon</span>
<small class="ws-data"><strong>Readings:</strong> ISL ch. 12 (sections 12.2 and 12.4) · Athey &amp; Imbens (2019) · Filmer &amp; Pritchett (2001)</small>
</p>

## Problem sets

- **Problem set 1 — Foundations, evaluation and regularization (weeks 1–5).** Published Sep 29, due Oct 20. Take-home, in pairs. Short conceptual questions (why training error is optimistic, what changes from OLS to Lasso, which metric to use and why) plus a complete predictive pipeline in R: splitting, cross-validation, model comparison against a baseline and error diagnostics. *PDF and datasets: available soon* — they will live in [`problem-sets/pset-1/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/problem-sets/pset-1).
- **Problem set 2 — Trees, interpretation and networks (weeks 6–9).** Published Oct 27, due Nov 17. Same structure: conceptual questions plus a pipeline with random forest or boosting and neural networks, out-of-sample evaluation and interpretation with variable importance, partial dependence and SHAP. *PDF and datasets: available soon* — they will live in [`problem-sets/pset-2/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/problem-sets/pset-2).

Each problem set is submitted as a single PDF accompanied by a reproducible repository (`.R`).

## Evaluation

| Component | Weight |
|---|---|
| Paper of the session — reading guides and a 10-minute opening | 10% |
| Problem set 1 — Foundations, evaluation, regularization (weeks 1–5) | 15% |
| Problem set 2 — Trees, interpretation, networks (weeks 6–9) | 15% |
| Final project — proposal, progress presentation and final report | 60% |

**Final project.** In groups of 2–3, the team defines an economic question in which prediction is the quantity of interest, identifies a dataset, applies several algorithms, and evaluates and interprets their out-of-sample performance. The results are written up as a mini academic paper: question, data, predictive strategy, results, evaluation and interpretation. Deliverables: **proposal** (Oct 13) — question, data, target metric, baseline model and validation strategy (10% of the project); **progress presentation** (Nov 10, last session) — design, pipeline, baseline and at least one flexible model with its validation, defended before the group; the feedback feeds the final report (30%); **final report and repository** (Nov 24) — at most 10 pages with model comparison, diagnostics, interpretation, limitations and policy implications (60%). Detailed guidelines will be published in the repo's [`final-project/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/final-project) folder.

**AI policy:** AI tools are allowed in every component of the course, as long as their use is explicitly declared — what was used and for what.

## Reading library

The repo's [`literature/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/literature) folder collects the papers of each session as the semester advances, together with the course's literature review ([`literature/revision/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/literature/revision): 139 applied papers with their methods, metrics and suggested week). Available now:

- Kim & Zilinsky (2024) — *Division Does Not Imply Predictability: Demographics Continue to Reveal Little About Voting and Partisanship* (week 1).
- Gelvez, Cardiles, Martínez-González & Muñoz (2026) — *How Predictable Is an Election? A Machine-Learning Approach to Electoral Behavior in Colombia* (the course's thread paper, weeks 6–7).

The full bibliography — framework papers, the paper of each session and methodological references — is in the [course syllabus](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/syllabus/syllabus.pdf).

## Core bibliography

- James, G., Witten, D., Hastie, T., & Tibshirani, R. (2021). *An Introduction to Statistical Learning with Applications in R* (2nd ed.). Springer. [ISL] — [free online](https://www.statlearning.com); a course copy is in the repo's [`books/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/books) folder.
- Molnar, C. (2025). *Interpretable Machine Learning: A Guide for Making Black Box Models Explainable* (3rd ed.) — [free online](https://christophm.github.io/interpretable-ml-book/).
- Hastie, T., Tibshirani, R., & Friedman, J. (2009). *The Elements of Statistical Learning* (2nd ed.). Springer. [ESL]
- Goodfellow, I., Bengio, Y., & Courville, A. (2016). *Deep Learning*. MIT Press.
