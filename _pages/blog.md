---
layout: page
permalink: /blog/
title: Blog
description: Notes, tutorials, and workshop materials on R programming, data wrangling, and spatial data analysis.
nav: true
nav_order: 4
---

<style>
  .entry-list { margin-top: 0.5rem; }
  .entry-list .group {
    color: var(--global-theme-color);
    font-weight: 700;
    font-size: 1.22rem;
    border-bottom: 1px solid var(--global-divider-color);
    padding-bottom: 0.4rem;
    margin: 2.4rem 0 1.2rem;
  }
  .entry-list .group:first-of-type { margin-top: 0.5rem; }
  .entry-list .entry { margin-bottom: 1.25rem; }
  .entry-list .entry .ttl { font-size: 1.08rem; font-weight: 600; line-height: 1.35; }
  .entry-list .entry .ttl a { color: var(--global-text-color); }
  .entry-list .entry .ttl a:hover { color: var(--global-theme-color); text-decoration: none; }
  .entry-list .entry .meta { display: block; color: var(--global-text-color-light); font-size: 0.85rem; margin: 0.12rem 0 0.35rem; }
  .entry-list .entry .desc { margin: 0; }
  .entry-list .entry .links { margin: 0.1rem 0 0; font-size: 0.92rem; }
</style>

<div class="entry-list">

  <div class="group">R programming &amp; data</div>
  {% for post in site.posts %}
    {% unless post.tags contains 'spatial-data' %}
    <div class="entry">
      <span class="ttl"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></span>
      <span class="meta">{{ post.date | date: "%B %d, %Y" }}</span>
      {% if post.description %}<p class="desc">{{ post.description }}</p>{% endif %}
      <p class="links"><a href="{{ post.url | relative_url }}">Read post &rarr;</a></p>
    </div>
    {% endunless %}
  {% endfor %}

  <div class="group">Spatial data &amp; GIS</div>
  {% for post in site.posts %}
    {% if post.tags contains 'spatial-data' %}
    <div class="entry">
      <span class="ttl"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></span>
      <span class="meta">{{ post.date | date: "%B %d, %Y" }}</span>
      {% if post.description %}<p class="desc">{{ post.description }}</p>{% endif %}
      <p class="links"><a href="{{ post.url | relative_url }}">Read post &rarr;</a></p>
    </div>
    {% endif %}
  {% endfor %}

</div>
