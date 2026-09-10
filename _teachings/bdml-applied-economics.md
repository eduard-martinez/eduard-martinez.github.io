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
program: Master's in Economics (ME)
instructor: Eduard F. Martínez-González
year: 2026
credits: 3
weekly_hours: 3
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

Original title (in Spanish): **Big Data y Machine Learning para Economía Aplicada**. Lectures and materials are in Spanish. *Prerequisites:* Econometrics I & II (or equivalent); basic R is recommended, not required.

All course materials — syllabus, lecture slides, problem sets, R applications, and reference papers — are hosted on GitHub:

<p>
<a href="https://github.com/eduard-martinez/bdml-applied-economics" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-github"></i>github.com/eduard-martinez/bdml-applied-economics</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/syllabus/syllabus.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-file-pdf"></i>Full syllabus (PDF, in Spanish)</a>
<a href="https://github.com/eduard-martinez/bdml-applied-economics/blob/main/final-project/projecto_final.pdf" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-graduation-cap"></i>Final project (PDF, in Spanish)</a>
<a href="https://www.statlearning.com" target="_blank" rel="noopener" class="ws-btn"><i class="fas fa-book"></i>Course text — ISL, 2nd ed. (free online)</a>
</p>

## Course description

In causal inference the goal is to identify a parameter correctly: the effect β of an intervention on an outcome. In this course the goal changes place — the interest is Y: building models that **predict the variable of interest well** on data the model has not seen, **evaluating** that predictive performance honestly, and **opening the model** to understand what the prediction depends on. That distinction between explaining and predicting organizes the whole semester and is drawn from the very first session.

The course introduces Master's students to the statistical-learning framework and to the machine-learning tools most used today in applied economics and finance: regression as a prediction machine, classification, cross-validation, regularization (Ridge, Lasso, Elastic Net), trees, random forests and boosting, interpretation tools (variable importance, partial dependence, SHAP values) and neural networks. The progression follows *An Introduction to Statistical Learning* (James, Witten, Hastie & Tibshirani, 2nd ed.), the course textbook. Three datasets run through the semester: a panel of Colombian polling stations with census characteristics, housing prices in Bogotá, and satellite imagery.

The treatment combines **sufficient formality** with **a lot of intuition**. For each method the course presents its objective function and hyperparameters, explains what problem it solves and how it works, implements it on real data in R, evaluates its out-of-sample performance against a baseline model, and interprets the results. Long derivations live in per-session appendices, available for anyone who wants to go deeper. In the same spirit as the Causal Inference course, each session is paired with a recent applied article presented by a student, and the semester culminates in a project where teams pose a predictive question, compare several algorithms and defend their results.

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
3. **Student presentation.** From the second session on, one student closes the class with a 15-minute presentation of an applied article related to the previous session: the question and what is predicted, the data, the ML method and how out-of-sample performance is evaluated, and the main results and how the model is interpreted.

## Getting up to speed in R

Before the applied sessions, each student completes a self-paced R leveling using the materials of the [R Programming Leveling Course](/teaching/intro-r/):

- [Introduction to R](/teaching/intro-r/unidad-1-fundamentos/teoria/teoria_unidad-1.html) — R, RStudio, objects and data frames.
- [Data wrangling with `dplyr`](/teaching/intro-r/unidad-2-manejo-datos/teoria/teoria_unidad-2.html)
- [Data visualization with `ggplot2`](/teaching/intro-r/unidad-3-visualizacion/teoria/teoria_unidad-3.html)
- Good modeling practices with `tidymodels` — *available soon*.

Reviewing this material is mandatory and happens outside class hours. Equivalent reference material is offered for students who choose the Python track — *available soon*.

## Schedule

### Module 1 — Foundations and evaluation

**Week 1 — Predict, don't explain: the statistical-learning framework.**
From β to Y: the same data, two different questions; prediction policy problems; out-of-sample predictability as the quantity of interest. What it means to learn *f*; parametric vs. non-parametric; flexibility vs. interpretability; training vs. test error, overfitting, the U-curve and bias–variance; supervised and unsupervised learning; the course workflow.
*Readings:* ISL ch. 1–2; Mullainathan & Spiess (2017); Kleinberg, Ludwig, Mullainathan & Obermeyer (2015).
*Paper presentation:* Kim & Zilinsky (2024), *Division Does Not Imply Predictability* — [PDF in the repo](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/literature/Kim_Kilinsky_2024_Division_Does_Not_Imply_Predictability.pdf).
*R application:* first train/test split with a linear model on the polling-station panel: in-sample vs. out-of-sample R². *(code available soon)*
[Slides — week 1](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-01/week-01.pdf)

**Week 2 — Linear regression as a prediction machine — and how to evaluate a prediction.**
OLS as a predictor: qualitative predictors, interactions, transformations; beyond linearity — polynomials, step functions, splines and GAMs; k-NN regression and the curse of dimensionality. Regression metrics: MSE, RMSE, MAE, MAPE and out-of-sample R²; baseline models; predicted vs. observed and compression toward the mean; error by decile of Y and by subgroup; extrapolation.
*Readings:* ISL ch. 3 and 7 (sections 7.1–7.7).
*Paper presentation:* Bogin & Shui (2020), *Appraisal Accuracy and Automated Valuation Models in Rural Areas*, or Pace & Hayunga (2020).
*R application:* Bogotá housing prices — linear vs. polynomials and splines vs. k-NN; metrics table, predicted-vs-observed scatter, error by price decile. *(code available soon)*
[Slides — week 2](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-02/week-02.pdf)

**Week 3 — Classification: from the logit to the metrics that decide.**
Why not OLS; logistic regression (binary and multinomial); LDA, QDA and Naive Bayes in brief; k-NN. Probabilities vs. classes: the threshold as a decision with costs; confusion matrix; accuracy, precision, recall, F1 and balanced accuracy — why accuracy misleads under unequal prevalence; ROC/AUC vs. precision–recall; calibration; class imbalance and its remedies.
*Readings:* ISL ch. 4; Fawcett (2006).
*Paper presentation:* Kleinberg, Lakkaraju, Leskovec, Ludwig & Mullainathan (2018), or Fuster, Goldsmith-Pinkham, Ramadorai & Walther (2022).
*R application:* did the eventual president win this polling station? Logit vs. k-NN with a stratified split; AUC vs. accuracy under imbalance; ROC and calibration curves. *(code available soon)*
[Slides — week 3](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-03/week-03.pdf)

**Week 4 — Resampling, validation and the honest pipeline.**
Validation set, LOOCV and k-fold; the bias–variance of CV; CV for hyperparameter tuning — grid, random and Bayesian search; nested CV; leakage and preprocessing inside the pipeline; temporal and spatial CV — when random k-fold lies; bootstrap intervals for metrics and model comparison.
*Readings:* ISL ch. 5; Roberts et al. (2017); Neunhoeffer & Sternberg (2019).
*Paper presentation:* Deppner & Cajias (2024), *Accounting for Spatial Autocorrelation in Algorithm-Driven Hedonic Models*, or Goulet Coulombe, Leroux, Stevanovic & Surprenant (2022).
*R application:* `tidymodels` (`recipes`, `rsample`, `tune`): CV comparison of the week 2–3 models with bootstrap intervals; spatial CV on the polling stations. *(code available soon)*
[Slides — week 4](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-04/week-04.pdf)

**Week 5 — Variable selection and regularization.**
Many predictors: overfitting and collinearity; subset selection and information criteria vs. CV; Ridge (shrink) and Lasso (exact zeros); Elastic Net; choosing λ by CV; coefficient paths; PCR and PLS as compression; high dimension — the correlated proxy; "the Lasso selects predictors, not causes"; double selection as a preview of week 9.
*Readings:* ISL ch. 6; Belloni, Chernozhukov & Hansen (2014) as complementary reading.
*Paper presentation:* Gu, Kelly & Xiu (2020), *Empirical Asset Pricing via Machine Learning*, or Blumenstock, Cadamuro & On (2015).
*R application:* housing prices with many covariates (`glmnet`): OLS vs. Ridge vs. Lasso vs. Elastic Net; coefficient paths, CV curve, out-of-sample comparison. *(code available soon)*
[Slides — week 5](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-05/week-05.pdf)

### Module 2 — Trees, ensembles and interpretation

**Week 6 — Trees, forests and boosting.**
Regression and classification trees: partitions, split criterion, pruning — why a single tree is unstable; bagging and random forests (*m*, out-of-bag error, native importance); boosting — fitting residuals; learning rate, depth, number of trees and early stopping; XGBoost and LightGBM; BART as a mention; random forest vs. boosting; when trees win on tabular data.
*Readings:* ISL ch. 8; Breiman (2001).
*Thread paper:* Gelvez, Cardiles, Martínez-González & Muñoz (2026), *How Predictable Is an Election?* — [PDF in the repo](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/literature/democratization_AIM4D_Notre_Dame.pdf).
*Paper presentation:* Medeiros, Vasconcelos, Veiga & Zilberman (2021), or Bertrand & Kamenica (2023).
*R application:* random forest and XGBoost for the vote share and the local winner, with Bayesian hyperparameter search; comparison table against logit and Lasso; OOB vs. CV. *(code available soon)*
[Slides — week 6](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-06/week-06.pdf)

**Week 7 — Opening the black box: importance, partial dependence and SHAP.**
Why interpret: auditing, communicating, generating hypotheses; global and local interpretation; impurity vs. permutation importance and their biases with correlated predictors; partial dependence, ICE and ALE — what they show and when they mislead; Shapley values and SHAP; block ablation and R² decomposition; error by subgroup and fairness; what interpretation is *not*: causality, ecological inference, forecasting.
*Readings:* Molnar (2025), chapters on permutation importance, PDP, ALE and SHAP; Lundberg & Lee (2017).
*Paper presentation:* Bluwstein, Buckmann, Joseph, Kapadia & Şimşek (2023), or Ludwig & Mullainathan (2024).
*R application:* on the week-6 models — permutation vs. impurity importance (`DALEX`), PDP/ICE, SHAP (`shapviz`), block hierarchy and error by decile; reproducing figures 3, 5 and 6 of Gelvez et al. *(code available soon)*
[Slides — week 7](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-07/week-07.pdf)

### Module 3 — Neural networks, structure without Y, and closing

**Week 8 — Neural networks: what they are, when to use them, and an application with images.**
Neuron, layers and function composition; activation functions; the loss; SGD and mini-batches; backpropagation as the chain rule; early stopping, dropout and weight decay; when deep learning pays off — tabular data vs. images and text; convolutional networks as application: transfer learning and poverty from satellite imagery; text and language models as complementary readings.
*Readings:* ISL ch. 10 (sections 10.1–10.3 and 10.6–10.7); Jean et al. (2016).
*Paper presentation:* Jean, Burke, Xie, Davis, Lobell & Ermon (2016), or Glaeser, Kincaid & Naik (2018).
*R application:* feedforward network (`keras`) vs. XGBoost on the same tabular data; demo of a pre-trained convolutional network on satellite images. *(code available soon)*
[Slides — week 8](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-08/week-08.pdf)

**Week 9 — Beyond prediction: structure without Y, the causal frontier — and final presentations.**
PCA as an index (Filmer–Pritchett) and k-means as segmentation: what they are, how to validate them without Y, caveats; ML in the service of β: double selection, double machine learning as residuals-on-residuals with cross-fitting, causal forests for heterogeneity — identify before you estimate; the course in one slide; final-project presentations.
*Readings:* ISL ch. 12 (sections 12.2 and 12.4); Athey & Imbens (2019); Filmer & Pritchett (2001).
*R application:* socioeconomic index with PCA and k-means segmentation on the polling-station census; a causal forest with `grf` as a reading demo. *(code available soon)*
[Slides — week 9](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/lectures/week-09/week-09.pdf)

## Problem sets

- **Problem set 1 — Foundations, evaluation and regularization (weeks 1–5).** Take-home, in pairs. Short conceptual questions (why training error is optimistic, what changes from OLS to Lasso, which metric to use and why) plus a complete predictive pipeline in R: splitting, cross-validation, model comparison against a baseline and error diagnostics. *PDF and datasets: available soon* — they will live in [`problem-sets/pset-1/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/problem-sets/pset-1).
- **Problem set 2 — Trees, interpretation and networks (weeks 6–9).** Same structure: conceptual questions plus a pipeline with random forest or boosting and neural networks, out-of-sample evaluation and interpretation with variable importance, partial dependence and SHAP. *PDF and datasets: available soon* — they will live in [`problem-sets/pset-2/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/problem-sets/pset-2).

Each problem set is submitted as a single PDF accompanied by a reproducible repository (`.R`).

## Evaluation

| Component | Weight |
|---|---|
| Article presentation (15 min) | 10% |
| Problem set 1 — Foundations, evaluation, regularization (weeks 1–5) | 15% |
| Problem set 2 — Trees, interpretation, networks (weeks 6–9) | 15% |
| Final project with oral defense | 60% |

**Final project.** In groups of 2–3, the team defines an economic question in which prediction is the quantity of interest, identifies a dataset, applies several algorithms, and evaluates and interprets their out-of-sample performance. The results are written up as a mini academic paper: question, data, predictive strategy, results, evaluation and interpretation. Deliverables: **proposal** — question, data, target metric, baseline model and validation strategy (10% of the project); **report** — a document of at most 10 pages with model comparison, diagnostics, interpretation and limitations, plus the reproducible repository (60%); **oral defense** in the last session, discussing the fit of the methods and their policy implications (30%). Full details: [final project guidelines (PDF)](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/final-project/projecto_final.pdf).

**AI policy:** AI tools are allowed in every component of the course, as long as their use is explicitly declared — what was used and for what.

## Reading library

The repo's [`literature/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/literature) folder collects the papers for the student presentations as the semester advances. Available now:

- Kim & Zilinsky (2024) — *Division Does Not Imply Predictability: Demographics Continue to Reveal Little About Voting and Partisanship* (week 1).
- Gelvez, Cardiles, Martínez-González & Muñoz (2026) — *How Predictable Is an Election? A Machine-Learning Approach to Electoral Behavior in Colombia* (the course's thread paper, weeks 6–7).

The full bibliography — framework papers, per-week presentation candidates and methodological references — is in the [course syllabus](https://github.com/eduard-martinez/bdml-applied-economics/blob/main/syllabus/syllabus.pdf).

## Core bibliography

- James, G., Witten, D., Hastie, T., & Tibshirani, R. (2021). *An Introduction to Statistical Learning with Applications in R* (2nd ed.). Springer. [ISL] — [free online](https://www.statlearning.com); a course copy is in the repo's [`books/`](https://github.com/eduard-martinez/bdml-applied-economics/tree/main/books) folder.
- Molnar, C. (2025). *Interpretable Machine Learning: A Guide for Making Black Box Models Explainable* (3rd ed.) — [free online](https://christophm.github.io/interpretable-ml-book/).
- Hastie, T., Tibshirani, R., & Friedman, J. (2009). *The Elements of Statistical Learning* (2nd ed.). Springer. [ESL]
- Goodfellow, I., Bengio, Y., & Courville, A. (2016). *Deep Learning*. MIT Press.
