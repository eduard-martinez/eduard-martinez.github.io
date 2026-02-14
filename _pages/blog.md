---
layout: page
permalink: /blog/
title: Blog
description: Notes, tutorials, and workshop materials on R programming, data wrangling, and spatial data analysis.
nav: true
nav_order: 4
pagination:
  enabled: true
  collection: posts
  per_page: 5
  sort_field: date
  sort_reverse: true
---

<div class="post">

{% assign blog_name_size = site.blog_name | size %}
{% assign blog_description_size = site.blog_description | size %}

{% if blog_name_size > 0 or blog_description_size > 0 %}
<div class="header-bar">
  <h1>{{ site.blog_name }}</h1>
  <h2>{{ site.blog_description }}</h2>
</div>
{% endif %}

{% if page.pagination.enabled %}
{% assign postlist = paginator.posts %}
{% else %}
{% assign postlist = site.posts %}
{% endif %}

<ul class="post-list">
{% for post in postlist %}
  <li>
    <h3>
      <a class="post-title" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
    </h3>
    <p class="post-meta">{{ post.date | date: '%B %d, %Y' }}</p>
    <p class="post-description">{{ post.description }}</p>
  </li>
{% endfor %}
</ul>

{% if page.pagination.enabled %}
{% include pagination.liquid %}
{% endif %}

</div>
