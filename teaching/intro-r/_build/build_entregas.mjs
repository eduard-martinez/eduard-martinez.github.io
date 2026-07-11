// Genera las 4 páginas "Tarea" (descargar .R + subir) e inyecta el bloque de
// entrega en las 4 páginas "Actividad IA" ya generadas. Idempotente.
// Ejecutar:  node _build/build_entregas.mjs
import { readFileSync, writeFileSync, existsSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const BACK = dirname(dirname(fileURLToPath(import.meta.url)));

const UNIDADES = {
  1: { slug: "unidad-1-fundamentos",    tituloU: "Fundamentos de R" },
  2: { slug: "unidad-2-manejo-datos",   tituloU: "Manejo de datos con tidyverse" },
  3: { slug: "unidad-3-visualizacion",  tituloU: "Visualización y descriptivas" },
  4: { slug: "unidad-4-regresiones",    tituloU: "Regresiones básicas" },
};

/* ---------- 1) páginas Tarea (profundidad 2 → rel ../..) ---------- */
function paginaTarea(n, u) {
  return `<!DOCTYPE html>
<html lang="es"><head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tarea · Unidad ${n} — ${u.tituloU}</title>
<link rel="stylesheet" href="../../styles.css">
<link rel="stylesheet" href="../../assets/curso-page.css">
<link rel="stylesheet" href="../../assets/entrega.css">
</head>
<body class="fullcontent quarto-light">
<div id="quarto-content" class="page-columns page-rows-contents page-layout-article">
<main class="content" id="quarto-document-content">
<div class="page-wrap">

<header id="title-block-header" class="quarto-title-block default">
<div class="quarto-title">
<h1 class="title">Tarea · Unidad ${n}</h1>
<p class="subtitle lead">${u.tituloU}</p>
</div>
</header>

<div class="curso-logo"><img src="../../figures/icesi_logo.png" alt="Universidad Icesi"></div>
<div class="curso-meta"><span class="curso-chip">Unidad ${n} · Entrega de la tarea</span></div>
<p class="curso-backlink"><a href="../../index.html">← Volver al inicio del curso</a></p>

<div class="callout-key">
<div class="callout-title">Cómo entregar la Tarea ${n}</div>
<ol style="margin:.4em 0 0 1.1em">
<li><strong>Descarga</strong> el script <code>tarea_unidad-${n}.R</code> con el botón de abajo.</li>
<li><strong>Complétalo en RStudio</strong>, dentro de tu proyecto del curso (rutas relativas).</li>
<li><strong>Súbelo aquí</strong> con tu código de estudiante cuando termines.</li>
</ol>
</div>

<div id="entrega-root"></div>

<footer class="curso-footer">
Curso Nivelatorio de Programación en R · CIENFI — Universidad Icesi ·
<a href="mailto:efmartinez@icesi.edu.co">efmartinez@icesi.edu.co</a>
</footer>

</div>
</main>
</div>

<script>
window.ENTREGA = {
  categoria: "tarea",
  unidad: ${n},
  titulo: "Subir la Tarea ${n}",
  intro: "Adjunta tu script tarea_unidad-${n}.R terminado. Puedes reemplazarlo si lo vuelves a subir.",
  archivo: "tarea_unidad-${n}.R"
};
</script>
<script src="../../assets/curso-config.js"></script>
<script src="../../assets/entrega.js"></script>
</body></html>
`;
}

let nTarea = 0;
for (const n of Object.keys(UNIDADES)) {
  const u = UNIDADES[n];
  const out = join(BACK, u.slug, "tarea", `tarea_unidad-${n}.html`);
  writeFileSync(out, paginaTarea(n, u), "utf8");
  console.log("OK (tarea) ->", `${u.slug}/tarea/tarea_unidad-${n}.html`);
  nTarea++;
}

/* ---------- 2) inyectar entrega en Actividad IA (profundidad 1 → rel ..) ---------- */
let nAct = 0, nSkip = 0;
for (const n of Object.keys(UNIDADES)) {
  const u = UNIDADES[n];
  const file = join(BACK, u.slug, `actividad_ia_unidad-${n}.html`);
  if (!existsSync(file)) { console.log("FALTA actividad", n); continue; }
  let html = readFileSync(file, "utf8");
  if (html.indexOf("entrega-root") !== -1) { nSkip++; continue; } // ya inyectado
  // link CSS antes de </head>
  html = html.replace("</head>", '<link rel="stylesheet" href="../assets/entrega.css">\n</head>');
  // bloque + scripts antes del footer
  const bloque =
    '<section id="entrega">\n' +
    '<h2>Entregar la actividad con IA</h2>\n' +
    '<div id="entrega-root"></div>\n' +
    '</section>\n' +
    '<script>\nwindow.ENTREGA = {\n' +
    '  categoria: "actividad_ia",\n' +
    '  unidad: ' + n + ',\n' +
    '  titulo: "Subir la Actividad con IA — Unidad ' + n + '",\n' +
    '  intro: "Adjunta el script .R de tu actividad con IA, con el apéndice donde declaras el uso de IA."\n' +
    '};\n</script>\n' +
    '<script src="../assets/curso-config.js"></script>\n' +
    '<script src="../assets/entrega.js"></script>\n';
  html = html.replace(/<footer class="curso-footer">/, bloque + '<footer class="curso-footer">');
  writeFileSync(file, html, "utf8");
  console.log("OK (actividad+entrega) ->", `${u.slug}/actividad_ia_unidad-${n}.html`);
  nAct++;
}

console.log(`\n${nTarea} páginas Tarea · ${nAct} Actividad IA con entrega${nSkip ? " (" + nSkip + " ya tenían)" : ""}.`);
