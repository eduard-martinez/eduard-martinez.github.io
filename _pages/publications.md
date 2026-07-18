---
layout: page
permalink: /research/
title: Research
description: Working papers and publications on development economics, public policy, big data, and machine learning.
nav: true
nav_order: 2
---

<!-- _pages/publications.md -->

<style>
  .publications .tldr {
    font-size: 0.92rem;
    color: var(--global-text-color-light);
    margin: 0.2rem 0 0.25rem;
  }
  .publications h2.bib-section {
    color: var(--global-theme-color);
    font-size: 1.22rem;
    font-weight: 700;
    text-align: left;
    border-bottom: 1px solid var(--global-divider-color);
    padding-bottom: 0.4rem;
    margin: 2.2rem 0 1.2rem;
  }
  .publications h2.bib-section:first-of-type { margin-top: 0.5rem; }
</style>

<div class="publications">

<h2 class="bib-section">Publications</h2>
{% bibliography --query @*[category=pub] %}

<h2 class="bib-section">Working Papers</h2>
{% bibliography --query @*[category=wp] %}

<h2 class="bib-section">Policy &amp; Technical Reports</h2>
{% bibliography --query @*[category=policy] %}

</div>
