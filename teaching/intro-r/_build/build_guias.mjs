// Builder de las "Guías del curso" y demás contenido de lectura: .md -> .html
// Conserva el diseño del curso usando Pandoc (--from gfm) + la plantilla
// assets/_pandoc_template.html. Ejecutar:  node _build/build_guias.mjs
import { execFileSync } from "node:child_process";
import { readFileSync, writeFileSync, mkdtempSync } from "node:fs";
import { tmpdir } from "node:os";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const BACK = dirname(dirname(fileURLToPath(import.meta.url))); // .../back
const TPL = join(BACK, "assets", "_pandoc_template.html");
const tmp = mkdtempSync(join(tmpdir(), "guias-"));

// Todas estas páginas están a profundidad 1 bajo back/ -> rel ".."
const PAGES = [
  { src: "programa/programa_curso.md",                       chip: "Guía del curso" },
  { src: "buenas_practicas/guia_estilo_scripts.md",          chip: "Buenas prácticas" },
  { src: "buenas_practicas/guia_organizacion_proyecto.md",   chip: "Buenas prácticas" },
  { src: "ia/guia_uso_ia.md",                                chip: "Uso de IA" },
  { src: "ia/investigacion_ia_recursos.md",                  chip: "Uso de IA" },
  { src: "proyecto_final/enunciado_proyecto_final.md",       chip: "Proyecto final" },
  { src: "proyecto_final/rubrica_proyecto_final.md",         chip: "Proyecto final" },
  { src: "datos/diccionario_datos.md",                       chip: "Datos del curso" },
  { src: "unidad-1-fundamentos/actividad_ia_unidad-1.md",    chip: "Unidad 1 · Actividad con IA" },
  { src: "unidad-2-manejo-datos/actividad_ia_unidad-2.md",   chip: "Unidad 2 · Actividad con IA" },
  { src: "unidad-3-visualizacion/actividad_ia_unidad-3.md",  chip: "Unidad 3 · Actividad con IA" },
  { src: "unidad-4-regresiones/actividad_ia_unidad-4.md",    chip: "Unidad 4 · Actividad con IA" },
];

function relinkear(html) {
  // .md -> .html (salvo la clave de respuestas, que es solo para docentes)
  html = html.replace(/href="([^"]+?)\.md(#[^"]*)?"/g, (m, path, anchor) => {
    if (/respuestas_cuestionarios$/.test(path)) return m;
    return `href="${path}.html${anchor || ""}"`;
  });
  // practica_unidad-N.R -> .html (ahora es página interactiva); tarea_unidad-N.R se deja como .R
  html = html.replace(/href="([^"]*practica_unidad-\d)\.R"/g, 'href="$1.html"');
  return html;
}

let ok = 0;
for (const page of PAGES) {
  const srcPath = join(BACK, page.src);
  const outPath = join(BACK, page.src.replace(/\.md$/, ".html"));
  const raw = readFileSync(srcPath, "utf8");

  // extraer el primer H1 como título y quitarlo del cuerpo
  const lines = raw.split(/\r?\n/);
  let title = basename(page.src, ".md");
  const idx = lines.findIndex((l) => /^#\s+/.test(l));
  if (idx !== -1) {
    title = lines[idx].replace(/^#\s+/, "").trim();
    lines.splice(idx, 1);
    if (lines[idx] !== undefined && lines[idx].trim() === "") lines.splice(idx, 1);
  }
  const bodyMd = lines.join("\n");
  const tmpMd = join(tmp, basename(page.src));
  writeFileSync(tmpMd, bodyMd, "utf8");

  const args = [
    tmpMd,
    "--from", "gfm",
    "--to", "html5",
    "--standalone",
    "--template", TPL,
    "--highlight-style", "pygments",
    "--wrap", "preserve",
    "-M", `title=${title}`,
    "-V", "rel=..",
    "-V", `chip=${page.chip}`,
  ];
  let html = execFileSync("pandoc", args, { encoding: "utf8" });
  html = relinkear(html);
  writeFileSync(outPath, html, "utf8");
  console.log("OK ->", page.src.replace(/\.md$/, ".html"));
  ok++;
}
console.log(`\n${ok}/${PAGES.length} páginas generadas.`);
