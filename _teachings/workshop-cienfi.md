---
layout: course
title: Workshop CIENFI — Spatial Data in R
description: >
  Hands-on workshop series of ICESI's CIENFI research center on spatial data analysis
  in R for applied economics research. Covers vector data with sf — geocoding,
  OpenStreetMap queries, spatial filters, geodesic distances and maps — raster data
  with terra — night lights, crop and mask, raster–vector joins with census blocks —
  and satellite applications: vegetation (NDVI) and built-up (NDBI) indices from
  Sentinel-2, and the monthly VIIRS night-lights series combined with Google Maps
  establishment data. Unlike the regular courses, this space also collects class
  notes, methodological explainers, and commentaries on the papers behind each
  application.
institution: Universidad ICESI
department: CIENFI — Centro de Investigaciones en Economía y Finanzas
program: Research workshop series
term: 2025 – 2026
instructor: Eduard F. Martínez-González
year: 2026
---

Original title (in Spanish): **Workshop CIENFI: Introducción al Análisis de Datos Espaciales en R**. All materials are in Spanish.

A series of hands-on workshops on spatial data analysis in R, aimed at researchers and students of ICESI's Centro de Investigaciones en Economía y Finanzas (CIENFI). Each workshop pairs a lecture with a live-coding session on real data from Cali — geocoded points, census blocks, night-lights rasters, and satellite imagery — and every session is packaged so that anyone can download the material and run it end to end without touching a single path.

## How the material is organized

Each workshop is a self-contained folder that follows the same structure:

```
workshop-N/
├── workshop-N.Rproj   ← open this file in RStudio
├── code/              ← the live-coding script(s) of the session
├── data/              ← every dataset the scripts read (relative paths)
└── output/            ← files the scripts produce
```

The scripts read from `data/` and write to `output/` using **relative paths only** — no URLs, no absolute directories, nothing machine-specific. Open the `.Rproj` file (so the working directory is set automatically) and run the script from top to bottom. The **Download (zip)** link of each workshop bundles the project, code, and data ready to use; the lecture slides are linked separately for viewing online.

## Workshops

### Workshop 1 — Introducción a Datos Espaciales en R

*Vector data with `sf`.* What spatial data is and how it is represented (geometries, CRS, datums, projections); geocoding addresses with `tidygeocoder` and turning coordinates into `sf` points; querying OpenStreetMap with `osmdata` — amenities and administrative boundaries; spatial filters and crops; geodesic distances between points; and maps with `mapview` and `ggplot2` (OSM basemap tiles, viridis scales, north arrow, and scale bar). The applications discussed include night lights as a proxy for GDP and motorcycle-restriction policies.

- [Session recording (YouTube)](https://youtu.be/gm6Oz2A91EM){:target="_blank"} — full video of the session (*Datos Espaciales (Vectoriales) en R*).
- [Lecture slides, part 1 (PDF)](/teaching/workshop-cienfi/workshop-1/lecture/parte-1.pdf) — concepts: GIS, geometries, CRS and projections, the `sf` ecosystem.
- [Lecture slides, part 2 (HTML)](/teaching/workshop-cienfi/workshop-1/lecture/parte-2.html) — the hands-on walkthrough of the session.
- [Script (`workshop-01.R`)](/teaching/workshop-cienfi/workshop-1/code/workshop-01.R) — live-coding script: geocoding, OSM, distances, and maps.
- [Dataset (`data_cali.rds`)](/teaching/workshop-cienfi/workshop-1/data/data_cali.rds) — addresses in Cali for the geocoding exercise.
- [**Download the full workshop (zip)**](/teaching/workshop-cienfi/workshop-1.zip)

### Workshop 2 — Introducción a Datos Raster en R

*Raster data with `terra`.* What a raster is (cells, resolution, bands) and how to read and inspect a GeoTIFF; night lights over Colombia cropped and masked to Cali's administrative boundary from OpenStreetMap; from raster to `data.frame` and to `sf` polygons; aligning CRSs; the spatial join between raster cells and census blocks (*manzanas*); the light–population relationship by block (including the `asinh` regression); and the 2013 vs. 2023 comparison of night lights. The lecture motivates rasters with applications on conflict (Ukraine), COVID lockdowns, land cover, and poverty measurement.

- [Session recording (YouTube)](https://youtu.be/V4q1mx2-CU0){:target="_blank"} — full video of the session (*Introducción a datos Raster en R*).
- [Lecture slides (HTML)](/teaching/workshop-cienfi/workshop-2/lecture/) — note: self-contained file of ~45 MB; it may take a moment to load.
- [Script (`intro_raster.R`)](/teaching/workshop-cienfi/workshop-2/code/intro_raster.R) — live-coding script: read, crop, mask, join, and regress.
- Datasets: [`night_light_201301.tif`](/teaching/workshop-cienfi/workshop-2/data/night_light_201301.tif) · [`night_light_202301.tif`](/teaching/workshop-cienfi/workshop-2/data/night_light_202301.tif) — night-lights rasters (January 2013 and January 2023) — and [`manzanas_cali.rds`](/teaching/workshop-cienfi/workshop-2/data/manzanas_cali.rds) — census blocks of Cali with population.
- [**Download the full workshop (zip)**](/teaching/workshop-cienfi/workshop-2.zip)

### Workshop 3 — Sentinel-2 y Luces Nocturnas VIIRS

*Satellite applications, in two code-first sessions (no slides — the scripts are fully annotated and document what they read and produce).*

**Part 1 — Sentinel-2 over southern Cali (Pance).** Multi-band imagery: reflectance bands at 10 m, true- and false-color RGB compositions, band algebra for the vegetation index (**NDVI**) and the built-up index (**NDBI**), and the raster–vector cross: 200 m buffers around places of interest and `extract()` to compute each place's average indices.

**Part 2 — VIIRS night lights + Google Maps points.** A monthly VIIRS stack (2012–2025) clipped to Cali's urban perimeter: the time dimension of rasters (including the 2020 lockdown dip in luminosity), 19,081 Google Maps establishments, the two directions of the raster–vector cross — from cells to points (`st_join`/`extract`) and from points to cells (`rasterize`) — and the business-density vs. luminosity relationship.

- [Session recording (YouTube)](https://youtu.be/U9Ii-alb_Hs){:target="_blank"} — full video of the session (*Datos Satelitales en R (Sentinel-II)*).
- [Script, part 1 (`parte-1.R`)](/teaching/workshop-cienfi/workshop-3/code/parte-1.R) — Sentinel-2, RGB compositions, NDVI and NDBI.
- [Script, part 2 (`parte-2.R`)](/teaching/workshop-cienfi/workshop-3/code/parte-2.R) — VIIRS series and Google Maps points.
- Datasets: [`sentinel_pance.tif`](/teaching/workshop-cienfi/workshop-3/data/sentinel_pance.tif) — Sentinel-2 image (Aug 18, 2024; 5 bands at 10 m) — [`nl_cali_viirs.tif`](/teaching/workshop-cienfi/workshop-3/data/nl_cali_viirs.tif) — monthly VIIRS stack 2012–2025 (162 bands) — and [`puntos_maps.rds`](/teaching/workshop-cienfi/workshop-3/data/puntos_maps.rds) — Google Maps establishments in Cali.
- Sample outputs: [NDVI map](/teaching/workshop-cienfi/workshop-3/output/pance_ndvi.png) · [NDBI map](/teaching/workshop-cienfi/workshop-3/output/pance_ndbi.png)
- [**Download the full workshop (zip)**](/teaching/workshop-cienfi/workshop-3.zip)

## Notes and documentation

Unlike the regular courses on this site — which revolve around R programming materials — this space is also meant for **writing**: class notes and summaries, methodological explainers behind each technique, short commentaries on the academic papers that motivate the applications (night lights as a proxy for economic activity, satellite indices for urban growth, and related literature), and documentation of the workshops themselves.

*The first notes and paper summaries are in preparation and will be published here.*

## Datasets

| Dataset | Description | Workshop |
|---|---|---|
| [`data_cali.rds`](/teaching/workshop-cienfi/workshop-1/data/data_cali.rds) | Addresses in Cali for the geocoding exercise | 1 |
| [`night_light_201301.tif`](/teaching/workshop-cienfi/workshop-2/data/night_light_201301.tif) / [`night_light_202301.tif`](/teaching/workshop-cienfi/workshop-2/data/night_light_202301.tif) | Night-lights rasters, January 2013 and January 2023 | 2 |
| [`manzanas_cali.rds`](/teaching/workshop-cienfi/workshop-2/data/manzanas_cali.rds) | Census blocks (*manzanas*) of Cali with population | 2 |
| [`sentinel_pance.tif`](/teaching/workshop-cienfi/workshop-3/data/sentinel_pance.tif) | Sentinel-2 image of southern Cali (Aug 2024), 5 bands at 10 m | 3 |
| [`nl_cali_viirs.tif`](/teaching/workshop-cienfi/workshop-3/data/nl_cali_viirs.tif) | Monthly VIIRS night-lights stack, 2012–2025, Cali urban perimeter | 3 |
| [`puntos_maps.rds`](/teaching/workshop-cienfi/workshop-3/data/puntos_maps.rds) | 19,081 Google Maps establishments in Cali (name, category, reviews, rating, location) | 3 |

---

*New workshops, notes, and paper summaries are added as the series progresses.*
