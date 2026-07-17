---
layout: course
title: Workshop CIENFI — Spatial Data in R
description: >
  Hands-on workshop series of ICESI's CIENFI research center: vector data with sf,
  rasters and night lights with terra, and satellite applications (Sentinel-2, VIIRS)
  in R — plus class notes and commentaries on the papers behind each application.
institution: Universidad ICESI
department: CIENFI — Centro de Investigaciones en Economía y Finanzas
program: Research workshop series
term: 2025 – 2026
instructor: Eduard F. Martínez-González
year: 2026
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

Original title (in Spanish): **Workshop CIENFI: Introducción al Análisis de Datos Espaciales en R**. All materials are in Spanish.

Hands-on workshops on spatial data in R for applied economics, built on real data from Cali — geocoded points, census blocks, night lights, and satellite imagery. Each workshop is a **self-contained folder**: download the zip, open the `.Rproj` in RStudio, and run the script from top to bottom — every path is relative, nothing needs to be edited.

```
workshop-N/
├── workshop-N.Rproj   ← open this file in RStudio
├── code/              ← live-coding script(s) of the session
├── data/              ← every dataset the scripts read
└── output/            ← files the scripts produce
```

## Workshop 1 — Introducción a Datos Espaciales en R

*Vector data with `sf`: geocoding addresses, querying OpenStreetMap, spatial filters, geodesic distances, and maps with `mapview` and `ggplot2`.*

<p>
<a href="https://youtu.be/gm6Oz2A91EM" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Recording</a>
<a href="/teaching/workshop-cienfi/workshop-1/lecture/parte-1.pdf" class="ws-btn"><i class="fas fa-file-pdf"></i>Slides · part 1</a>
<a href="/teaching/workshop-cienfi/workshop-1/lecture/parte-2.html" class="ws-btn"><i class="fas fa-chalkboard"></i>Slides · part 2</a>
<a href="/teaching/workshop-cienfi/workshop-1/code/workshop-01.R" class="ws-btn"><i class="fas fa-code"></i>Script</a>
<a href="/teaching/workshop-cienfi/workshop-1.zip" class="ws-btn"><i class="fas fa-download"></i>Download (zip)</a>
<small class="ws-data">Data: <a href="/teaching/workshop-cienfi/workshop-1/data/data_cali.rds"><code>data_cali.rds</code></a> — addresses in Cali for the geocoding exercise.</small>
</p>

## Workshop 2 — Introducción a Datos Raster en R

*Raster data with `terra`: night lights over Colombia cropped to Cali with OSM boundaries, raster-to-vector conversion, the spatial join with census blocks, and the light–population regression.*

<p>
<a href="https://youtu.be/V4q1mx2-CU0" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Recording</a>
<a href="/teaching/workshop-cienfi/workshop-2/lecture/" class="ws-btn"><i class="fas fa-chalkboard"></i>Slides (~45 MB)</a>
<a href="/teaching/workshop-cienfi/workshop-2/code/intro_raster.R" class="ws-btn"><i class="fas fa-code"></i>Script</a>
<a href="/teaching/workshop-cienfi/workshop-2.zip" class="ws-btn"><i class="fas fa-download"></i>Download (zip)</a>
<small class="ws-data">Data: <a href="/teaching/workshop-cienfi/workshop-2/data/manzanas_cali.rds"><code>manzanas_cali.rds</code></a> (census blocks with population) · <a href="/teaching/workshop-cienfi/workshop-2/data/night_light_201301.tif"><code>night_light_201301.tif</code></a> · <a href="/teaching/workshop-cienfi/workshop-2/data/night_light_202301.tif"><code>night_light_202301.tif</code></a> (night lights, Jan 2013 and Jan 2023).</small>
</p>

## Workshop 3 — Sentinel-2 y Luces Nocturnas VIIRS

*Satellite applications in two annotated, code-first scripts (no slides): band algebra on a Sentinel-2 image of southern Cali — true/false color, **NDVI** and **NDBI** — and the monthly VIIRS night-lights series (2012–2025) crossed in both directions with 19,081 Google Maps establishments.*

<p>
<a href="https://youtu.be/U9Ii-alb_Hs" target="_blank" rel="noopener" class="ws-btn"><i class="fa-brands fa-youtube"></i>Recording</a>
<a href="/teaching/workshop-cienfi/workshop-3/code/parte-1.R" class="ws-btn"><i class="fas fa-code"></i>Script · part 1</a>
<a href="/teaching/workshop-cienfi/workshop-3/code/parte-2.R" class="ws-btn"><i class="fas fa-code"></i>Script · part 2</a>
<a href="/teaching/workshop-cienfi/workshop-3.zip" class="ws-btn"><i class="fas fa-download"></i>Download (zip)</a>
<small class="ws-data">Data: <a href="/teaching/workshop-cienfi/workshop-3/data/sentinel_pance.tif"><code>sentinel_pance.tif</code></a> (Sentinel-2, Aug 2024, 5 bands at 10 m) · <a href="/teaching/workshop-cienfi/workshop-3/data/nl_cali_viirs.tif"><code>nl_cali_viirs.tif</code></a> (monthly VIIRS stack, 162 bands) · <a href="/teaching/workshop-cienfi/workshop-3/data/puntos_maps.rds"><code>puntos_maps.rds</code></a> (Google Maps establishments).
<br>Sample outputs: <a href="/teaching/workshop-cienfi/workshop-3/output/pance_ndvi.png">NDVI map</a> · <a href="/teaching/workshop-cienfi/workshop-3/output/pance_ndbi.png">NDBI map</a></small>
</p>

## Notes and documentation

Unlike the regular courses on this site, this space also collects **writing**: class notes, methodological explainers behind each technique, and short commentaries on the papers that motivate the applications (night lights as a proxy for economic activity, satellite indices for urban growth).

*The first notes and paper summaries are in preparation and will be published here.*

---

*New workshops, notes, and paper summaries are added as the series progresses.*
