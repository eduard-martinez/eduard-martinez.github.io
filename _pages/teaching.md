---
layout: page
permalink: /teaching/
title: Teaching
description: Courses and workshops on economics, econometrics, data science, and R programming.
nav: true
nav_order: 3
---

## Universidad ICESI, Colombia

<style>
  .course-accordion .card {
    border: none;
    border-bottom: 1px solid var(--global-divider-color);
    border-radius: 0;
    background: transparent;
    margin: 0;
  }
  .course-accordion .card:first-of-type { border-top: 1px solid var(--global-divider-color); }
  .course-accordion .card-header { background: transparent; border: none; padding: 0; }
  .course-accordion .btn-link {
    color: var(--global-text-color);
    text-decoration: none;
    box-shadow: none;
    padding: 0.8rem 0.25rem;
  }
  .course-accordion .btn-link:hover,
  .course-accordion .btn-link:focus { text-decoration: none; box-shadow: none; color: var(--global-theme-color); }
  .course-accordion .course-meta { color: var(--global-text-color-light); }
  .course-accordion .chevron { transition: transform 0.2s ease; opacity: 0.55; }
  .course-accordion .btn-link[aria-expanded="true"] .chevron { transform: rotate(180deg); }
  .course-accordion .card-body { padding: 0 0.25rem 1rem; }
</style>

<div class="accordion course-accordion" id="icesi-courses">

  <div class="card">
    <div class="card-header" id="head-ci">
      <button class="btn btn-link btn-block text-left collapsed" type="button"
              data-toggle="collapse" data-target="#body-ci"
              aria-expanded="false" aria-controls="body-ci">
        <i class="fas fa-chevron-down chevron float-right mt-1"></i>
        <strong>Causal Inference for Public Policy</strong><br>
        <small class="course-meta">Department of Economics · Master's (ME, MCA, MFC) &amp; PhD · ECO-60116 · 2026-01</small>
      </button>
    </div>
    <div id="body-ci" class="collapse" aria-labelledby="head-ci" data-parent="#icesi-courses">
      <div class="card-body">
        <p>Graduate course on impact-evaluation methods for public policy and development economics. Every method is paired with a canonical empirical paper and a hands-on replication in R.</p>
        <p class="mb-2"><strong>Topics:</strong> potential outcomes · RCT · instrumental variables · sharp &amp; fuzzy RD · panel &amp; fixed effects · difference-in-differences · event studies · propensity-score matching.</p>
        <a href="/teaching/causal-inference/" class="btn btn-sm z-depth-0" role="button" style="font-size: 12px;">View full course &rarr;</a>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-header" id="head-ba">
      <button class="btn btn-link btn-block text-left collapsed" type="button"
              data-toggle="collapse" data-target="#body-ba"
              aria-expanded="false" aria-controls="body-ba">
        <i class="fas fa-chevron-down chevron float-right mt-1"></i>
        <strong>Introduction to Business Analytics</strong><br>
        <small class="course-meta">Department of Economics · Undergraduate · 06278-ECO · 2026-01</small>
      </button>
    </div>
    <div id="body-ba" class="collapse" aria-labelledby="head-ba" data-parent="#icesi-courses">
      <div class="card-body">
        <p>Undergraduate course on data analysis and machine learning for business decision-making — from R programming and the tidyverse to exploratory data analysis, clustering, decision trees, and AI tools.</p>
        <p class="mb-2"><strong>Topics:</strong> R foundations · data wrangling with dplyr · visualization with ggplot2 · data quality &amp; EDA · machine-learning foundations · clustering · classification &amp; regression trees · LLMs &amp; prompting.</p>
        <a href="/teaching/business-analytics/" class="btn btn-sm z-depth-0" role="button" style="font-size: 12px;">View full course &rarr;</a>
      </div>
    </div>
  </div>

</div>

---

## Universidad de los Andes, Colombia

- **Statistical & R Programming Workshop Seminar — Econ 1302**
  Department of Economics
  [Fall 2022 Syllabus](https://eduard-martinez.github.io/teaching/r_uniandes/2022-02/syllabus.pdf)

- **Big Data and Machine Learning for Real Estate**
  [Spring 2022 Website](https://ignaciomsarmiento.github.io/teaching/BDML)

- **Big Data and Machine Learning for Applied Economics — Econ 4676**
  Department of Economics
  [Fall 2021 Website](https://github.com/ECON-4676-UNIANDES-Fall-2021)

---

## Workshops

- **R for Applied Research in Economics**
  Universidad del Magdalena, Colombia, 2022
  [Website](https://eduard-martinez.github.io/teaching/unimag/2022-02/website.html)

- **R for Applied Research in Economics**
  Universidad EAFIT, Colombia, 2021
  [Recordings](https://www.youtube.com/channel/UCLqqb0eZ1razOkTDusAVEnA) ·
  [Website](https://github.com/taller-R/taller_cief_202102)

- **Workshop on Geostatistics**
  Universidad Piloto de Colombia, Colombia, 2021
