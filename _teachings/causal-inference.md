---
layout: course
title: Causal Inference for Public Policy
description: >
  Graduate course on impact evaluation methods for public policy and development economics.
  Covers the potential outcomes framework, randomized experiments, instrumental variables,
  regression discontinuity (sharp and fuzzy), panel data with fixed effects,
  difference-in-differences, event studies, and propensity score matching.
  Applied focus with R, anchored on canonical empirical papers each week.
institution: Universidad ICESI
department: Department of Economics
course_code: ECO-60116
program: Master's (ME, MCA, MFC) and PhD
term: 2026-01
instructor: Eduard F. Martínez-González
year: 2026
credits: 3
weekly_hours: 3
---

Original title (in Spanish): **Inferencia, Causalidad y Políticas Públicas**.

All course materials — syllabus, lecture slides, problem sets, replication code, and reference papers — are hosted on GitHub:

<a href="https://github.com/eduard-martinez/causal-inference" target="_blank" class="btn btn-sm z-depth-0" role="button" style="font-size: 12px;">
  <i class="fab fa-github"></i> &nbsp; github.com/eduard-martinez/causal-inference
</a>
<a href="https://github.com/eduard-martinez/causal-inference/blob/main/syllabus/syllabus.pdf" target="_blank" class="btn btn-sm z-depth-0" role="button" style="font-size: 12px;">
  <i class="fas fa-file-pdf"></i> &nbsp; Full syllabus (PDF)
</a>

## Course description

Impact evaluation aims to estimate the causal effect of programs, projects, and public policies in order to guide evidence-based decisions. In a context of limited resources, it is essential to identify the most cost-effective interventions, anticipate unintended effects, and maximize benefits for the population.

The course is highly applied, with an emphasis on Public Policy and Development Economics, drawing on applications from Colombia and other developing countries. Each method is paired with an *anchor paper* from the empirical literature, and every session combines theory, replication exercises in R, and a student-led discussion of a related paper.

## Learning outcomes

By the end of the course, students will be able to:

- Apply the **potential outcomes framework** and identify the conditions under which OLS, IV, RCT, RD, fixed effects, DiD, event studies, and matching methods deliver causal estimates.
- Formally derive identification and unbiasedness properties of the main causal estimators (mean-difference decomposition, Wald estimator, identification under continuity, parallel trends, etc.).
- Critically appraise empirical studies in the economics literature and propose applications to real-world policy contexts.
- Design and implement impact evaluations end-to-end in **R** — from data preparation through estimation and interpretation.

## Schedule

### Module 1 — Foundations of Causal Inference

**Week 1 — Foundations of Causal Inference.**
Correlation vs. causation; Rubin Causal Model; fundamental problem of causal inference; endogeneity, selection bias and omitted-variable bias; DAGs; causal estimands (ATE, ATT, ATC, ITT, LATE).
*Readings:* Cunningham (2021), ch. 1 & 4; Angrist & Pischke (2009), ch. 1.
[Slides — week 1](https://github.com/eduard-martinez/causal-inference/blob/main/slides/week-01/week-01.pdf)

### Module 2 — Experimental and quasi-experimental designs

**Week 2 — Randomized Controlled Trials (RCT).**
Randomization by design, internal validity, the three properties of RCTs, SUTVA, stratification and clusters, statistical power, ATE / ITT / TOT under noncompliance, threats to validity (attrition, spillovers, John Henry and Hawthorne effects).
*Anchor paper:* Duflo, Hanna & Ryan (2012, AER) — *Incentives Work: Getting Teachers to Come to School*.
*R activity:* Partial replication of Tables 1–3 with `haven`, `fixest`, `broom`.
[Slides — week 2](https://github.com/eduard-martinez/causal-inference/blob/main/slides/week-02/week-02.pdf)

**Week 3 — Instrumental Variables (IV).**
Endogenous variables and noncompliance; relevance, independence, exclusion; Wald estimator and 2SLS; heterogeneous effects (compliers, never-takers, always-takers, defiers); monotonicity and the LATE theorem (Imbens & Angrist, 1994); weak-instrument diagnostics.
*Anchor paper:* Angrist (1990, AER) — *Lifetime Earnings and the Vietnam Era Draft Lottery*.
*R activity:* IV with `AER::ivreg` and `fixest::feols`.
[Slides — week 3](https://github.com/eduard-martinez/causal-inference/blob/main/slides/week-03/week-03.pdf)

**Week 4 — Sharp Regression Discontinuity (RD).**
Quasi-random variation around a threshold; identification under continuity (Hahn, Todd & Van der Klaauw, 2001); local polynomial estimation; bandwidth selection (CCT, IK); robust inference (Calonico, Cattaneo & Titiunik, 2014); McCrary density test and placebo cutoffs.
*Anchor paper:* Lee (2008, JoE) — *Randomized Experiments from Non-random Selection in U.S. House Elections*.
*R activity:* `rdrobust` and `rddensity`.
[Slides — week 4](https://github.com/eduard-martinez/causal-inference/blob/main/slides/week-04/week-04.pdf)

**Week 5 — Fuzzy Regression Discontinuity.**
From Sharp to Fuzzy; Fuzzy RD as local IV with `Z = 1{X ≥ c}`; identification of the local LATE; 2SLS with local polynomial regression; interpretation as effect on compliers at the threshold.
*Anchor paper:* Pop-Eleches & Urquiola (2013, AER) — *Going to a Better School: Effects and Behavioral Responses*.
*R activity:* Fuzzy RD with `rdrobust` and manipulation diagnostics.
[Slides — week 5](https://github.com/eduard-martinez/causal-inference/blob/main/slides/week-05/week-05.pdf)

### Module 3 — Panel data methods

**Week 6 — Panel Data and Fixed Effects.**
Panel structure and unobserved heterogeneity; within estimator and the demeaning transformation; unit and time fixed effects; cluster-robust standard errors; limits — observed heterogeneity that varies over time, dynamic effects.
*Readings:* Cunningham (2021), ch. 8; Angrist & Pischke (2009), ch. 5.
*R activity:* Panel with `fixest::feols`.

**Week 7 — Difference-in-Differences (DiD).**
Canonical 2×2 DiD; parallel-trends assumption; DiD as panel with fixed effects; multi-period DiD; triple differences; limitations of TWFE under staggered adoption (introduction to Goodman-Bacon, 2021).
*Anchor paper:* Card & Krueger (1994, AER) — *Minimum Wages and Employment* (NJ–PA).
*R activity:* DiD with `fixest` and a simple event study.

**Week 8 — Event Study.**
Event-study specifications with relative dummies; pre-trends as visual test of parallel trends; leads and lags; staggered-treatment bias (Goodman-Bacon, 2021; de Chaisemartin & D'Haultfœuille, 2020; Sun & Abraham, 2021; Callaway & Sant'Anna, 2021); modern robust estimators.
*Readings:* Borusyak, Jaravel & Spiess (2024); Roth, Sant'Anna, Bilinski & Poe (2023).
*R activity:* Event-study with `fixest::sunab` and the `did` package.

### Module 4 — Selection on observables

**Week 9 — Propensity Score Matching (PSM).**
Selection on observables and unconfoundedness; the propensity score (Rosenbaum & Rubin, 1983); nearest-neighbor, kernel, stratification matching; inverse-probability weighting; common support and balance diagnostics; limits of relying on observables.
*Readings:* Cunningham (2021), ch. 5; Imbens & Wooldridge (2009).
*R activity:* `MatchIt` and `cobalt`.

## Problem sets

- [**Problem set 1** — Foundations, RCT and IV (weeks 1–3)](https://github.com/eduard-martinez/causal-inference/tree/main/problem-sets/pset-1)
- [**Problem set 2** — RD, Panel and DiD (weeks 4–7)](https://github.com/eduard-martinez/causal-inference/tree/main/problem-sets/pset-2)

Each problem set has a **mathematical component** (40%) — formal derivations of identification properties — and an **applied component in R** (60%) — Monte Carlo simulation plus partial replication of an anchor paper. Submitted as a single PDF plus a reproducible `.R` script.

## Evaluation

| Component | Weight |
|---|---|
| Article presentation (15 min) | 10% |
| Problem set 1 — Foundations, RCT, IV | 15% |
| Problem set 2 — RD, Panel, DiD | 15% |
| Final project (proposal + mini-paper + oral defense) | 60% |

The final project is built around a policy-relevant research question chosen by the student. After the proposal is approved, the instructor provides a synthetic dataset and a policy context aligned with the question. Deliverables: proposal (10%), 10-page mini-paper with diagnostics and robustness (60%), oral defense in the last week (30%).

## Methodology

Each class is organized in three parts: (1) **theoretical exposition** of the model and its identification assumptions; (2) **guided R applications** with prepared datasets and code, anchored on a canonical empirical paper; (3) **student-led discussion** of a related empirical paper from the bibliography (15-minute presentation covering the research question, identification strategy, and main results).

## Core bibliography

- Cunningham, S. (2021). *Causal Inference: The Mixtape*. Yale University Press.
- Angrist, J. D., & Pischke, J.-S. (2009). *Mostly Harmless Econometrics: An Empiricist's Companion*. Princeton University Press.
- Imbens, G. W., & Rubin, D. B. (2015). *Causal Inference for Statistics, Social, and Biomedical Sciences*. Cambridge University Press.
- Hernán, M., & Robins, J. (2020). *Causal Inference: What If*. Chapman & Hall/CRC.
- Gertler, P., Martinez, S., Premand, P., Rawlings, L., & Vermeersch, C. (2017). *La evaluación de impacto en la práctica* (2ª ed.). Banco Mundial.

The full reference list — including the foundational papers for IV, RD, DiD, event studies and PSM — is in the [course syllabus](https://github.com/eduard-martinez/causal-inference/blob/main/syllabus/syllabus.pdf).
