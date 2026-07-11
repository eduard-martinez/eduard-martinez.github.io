// Ensambla practica_unidad-{2,3,4}.html a partir del JSON verificado del
// workflow (journal.jsonl). Usa la MISMA plantilla/chrome que la Unidad 1 e
// inyecta WEBR_CONFIG/WEBR_BLOCKS con JSON.stringify (escapado seguro).
// Ejecutar:  node _build/build_practicas.mjs
import { readFileSync, writeFileSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const BACK = dirname(dirname(fileURLToPath(import.meta.url)));
const JOURNAL = "C:/Users/Andrea del Pilar/.claude/projects/C--Users-Andrea-del-Pilar-Universidad-ICESI-Dropbox-Cienfi-Tutoriales-RA-nivelatorio-R/e522984e-02f8-47a0-9624-c46b2665e828/subagents/workflows/wf_28445e60-234/journal.jsonl";

const OUT = {
  2: "unidad-2-manejo-datos/practica/practica_unidad-2.html",
  3: "unidad-3-visualizacion/practica/practica_unidad-3.html",
  4: "unidad-4-regresiones/practica/practica_unidad-4.html",
};

// --- 1. leer el journal y quedarnos con el ÚLTIMO resultado por unidad (= verify) ---
const results = readFileSync(JOURNAL, "utf8").trim().split(/\r?\n/)
  .map((l) => JSON.parse(l))
  .filter((o) => o.type === "result" && o.result && typeof o.result === "object");

const porUnidad = {};
for (const o of results) porUnidad[o.result.unidad] = o.result; // el último gana (verify)

// --- 2. saneado defensivo: el código R debe ser literal, no entidades HTML ---
function desescapaCodigo(s) {
  if (typeof s !== "string") return s;
  if (!/&(lt|gt|amp|quot|#39);/.test(s)) return s; // ya es literal
  return s.replace(/&lt;/g, "<").replace(/&gt;/g, ">")
          .replace(/&quot;/g, '"').replace(/&#39;/g, "'").replace(/&amp;/g, "&");
}
function saneaProsa(s) {
  if (typeof s !== "string") return s;
  // la prosa es innerHTML: si viene doble-escapada (&lt;code&gt;), desescapar una vez
  if (/&lt;\/?(code|strong|em)&gt;/.test(s)) return desescapaCodigo(s);
  return s;
}

let avisos = [];
for (const u of Object.values(porUnidad)) {
  if (u.config) u.config.setup = desescapaCodigo(u.config.setup);
  for (const b of u.blocks) {
    if (b.type === "code" || b.type === "static") b.code = desescapaCodigo(b.code);
    if (b.type === "prose") b.html = saneaProsa(b.html);
    if (b.type === "section" && b.title) b.title = saneaProsa(b.title);
  }
  // chequeo de validez básico: ninguna celda ejecutable debe leer archivos
  for (const b of u.blocks) {
    if (b.type === "code" && /\b(import|read_csv|read_excel|read\.csv|read\.delim)\s*\(/.test(b.code)) {
      avisos.push(`U${u.unidad}: celda EJECUTABLE parece leer un archivo -> revisar: ${b.code.slice(0, 60)}`);
    }
  }
}

// --- 2b. checks formativos (se insertan al final de la sección cuyo título contiene "after") ---
const CHECKS = {
  2: [
    { after: "filter",
      pregunta: { tema: "filter()", tipo: "escribir_codigo",
        enunciado: "Escribe una **tubería** que, a partir de `firmas`, se quede solo con las filas cuyo `cod_sector` sea `\"C\"`.",
        respuestas: ["firmas %>% filter(cod_sector == \"C\")", "firmas |> filter(cod_sector == \"C\")", "filter(firmas, cod_sector == \"C\")"],
        retro_ok: "Bien: `filter()` selecciona filas y se compara con `==`.",
        retro_no: "Se espera `firmas %>% filter(cod_sector == \"C\")`. Recuerda `==` para comparar." } },
    { after: "group_by",
      pregunta: { tema: "group_by + summarise", tipo: "escribir_codigo",
        enunciado: "Escribe una **tubería** que agrupe `firmas` por `cod_sector` y en `summarise()` calcule `n` con el número de filas (usa `n()`).",
        respuestas: ["firmas %>% group_by(cod_sector) %>% summarise(n = n())", "firmas |> group_by(cod_sector) |> summarise(n = n())"],
        retro_ok: "Correcto: `group_by()` define grupos y `summarise(n = n())` cuenta filas.",
        retro_no: "Se espera `firmas %>% group_by(cod_sector) %>% summarise(n = n())`. `n()` va sin argumentos." } },
  ],
  3: [
    { after: "capas",
      pregunta: { tema: "Gramática de ggplot2", tipo: "opcion_multiple",
        enunciado: "¿Cuáles son los componentes **mínimos** de un gráfico de `ggplot2`?",
        opciones: ["Solo los datos", "Datos + estéticas (`aes`) + una geometría (`geom_*`)", "Solo un `geom_*`", "Un archivo `.png`"],
        correcta: 1,
        retro_ok: "Correcto: datos, estéticas y al menos una geometría.",
        retro_no: "Un ggplot necesita **datos + `aes()` + un `geom_*`**." } },
    { after: "Exportar",
      pregunta: { tema: "Exportar", tipo: "escribir_codigo",
        enunciado: "Guarda el último gráfico en la ruta relativa `output/fig.png` con `ggsave()`.",
        respuestas: ["ggsave(\"output/fig.png\")", "ggsave(filename = \"output/fig.png\")"],
        retro_ok: "Correcto: `ggsave(\"output/fig.png\")` (ruta relativa, nada de capturas).",
        retro_no: "Se espera `ggsave(\"output/fig.png\")`." } },
  ],
  4: [
    { after: "lm",
      pregunta: { tema: "lm()", tipo: "escribir_codigo",
        enunciado: "Escribe la **estructura** de una llamada a `lm()` para regresar `y` sobre `x` en el data frame `d`, pasando los datos con `data =`.",
        respuestas: ["lm(y ~ x, data = d)", "lm(formula = y ~ x, data = d)"],
        retro_ok: "Correcto: la fórmula usa `~` y los datos van en `data =`.",
        retro_no: "Se espera `lm(y ~ x, data = d)`." } },
    { after: "fixest",
      pregunta: { tema: "Efectos fijos", tipo: "escribir_codigo",
        enunciado: "Con `feols()`, escribe la estructura para regresar `y ~ x` **con efectos fijos** de `g`, usando `data = d`.",
        respuestas: ["feols(y ~ x | g, data = d)"],
        retro_ok: "Correcto: en `feols` los efectos fijos van tras la barra `|`.",
        retro_no: "Se espera `feols(y ~ x | g, data = d)`. Los efectos fijos van después de `|`." } },
  ],
};
function insertarChecks(blocks, checks) {
  let out = blocks.slice();
  for (const chk of checks) {
    const secIdx = out.findIndex((b) => b.type === "section" && (b.title || "").toLowerCase().includes(chk.after.toLowerCase()));
    if (secIdx === -1) { out.push({ type: "check", pregunta: chk.pregunta }); continue; }
    let insertAt = out.length;
    for (let i = secIdx + 1; i < out.length; i++) { if (out[i].type === "section") { insertAt = i; break; } }
    out.splice(insertAt, 0, { type: "check", pregunta: chk.pregunta });
  }
  return out;
}
for (const u of Object.values(porUnidad)) {
  const cs = CHECKS[u.unidad];
  if (cs) u.blocks = insertarChecks(u.blocks, cs);
}

// --- 3. plantilla (mismo chrome que la Unidad 1) ---
function pagina(u) {
  const chip = `Unidad ${u.unidad} · Práctica ejecutable`;
  return `<!DOCTYPE html>
<html lang="es"><head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Práctica · Unidad ${u.unidad} — ${u.titulo}</title>
<link rel="stylesheet" href="../../styles.css">
<link rel="stylesheet" href="../../assets/curso-page.css">
<link rel="stylesheet" href="../../assets/webr.css">
<link rel="stylesheet" href="../../assets/examen.css">
</head>
<body class="fullcontent quarto-light">
<div id="quarto-content" class="page-columns page-rows-contents page-layout-article">
<main class="content" id="quarto-document-content">
<div class="page-wrap">

<header id="title-block-header" class="quarto-title-block default">
<div class="quarto-title">
<h1 class="title">Práctica · Unidad ${u.unidad}</h1>
<p class="subtitle lead">${u.subtitulo || u.titulo}</p>
</div>
</header>

<div class="curso-logo"><img src="../../figures/icesi_logo.png" alt="Universidad Icesi"></div>
<div class="curso-meta"><span class="curso-chip">${chip}</span></div>
<p class="curso-backlink"><a href="../../index.html">← Volver al inicio del curso</a></p>

<div class="callout-key">
<div class="callout-title">Cómo usar esta práctica</div>
El código corre <strong>en el navegador</strong> sobre una versión reducida de los datos (no necesitas
instalar nada). Ejecuta cada celda con <strong>▶ Ejecutar</strong> o <code>Ctrl/Cmd + Enter</code>; las
celdas comparten la misma sesión de R. Las celdas marcadas 🔒 se corren en RStudio con la base real.
</div>

<div id="practica-root"></div>

<footer class="curso-footer">
Curso Nivelatorio de Programación en R · CIENFI — Universidad Icesi ·
<a href="mailto:efmartinez@icesi.edu.co">efmartinez@icesi.edu.co</a>
</footer>

</div>
</main>
</div>

<script>
window.WEBR_CONFIG = ${JSON.stringify(Object.assign({ unidad: u.unidad }, u.config))};
window.WEBR_BLOCKS = ${JSON.stringify(u.blocks)};
</script>
<script src="../../assets/curso-config.js"></script>
<script src="../../assets/examen-core.js"></script>
<script src="../../assets/webr.js"></script>
</body></html>
`;
}

let n = 0;
for (const [unidad, rel] of Object.entries(OUT)) {
  const u = porUnidad[unidad];
  if (!u) { console.log("FALTA unidad", unidad); continue; }
  writeFileSync(join(BACK, rel), pagina(u), "utf8");
  console.log(`OK -> ${rel}  (${u.blocks.length} bloques, pkgs: ${JSON.stringify(u.config.packages)})`);
  n++;
}
if (avisos.length) { console.log("\n⚠ AVISOS:"); avisos.forEach((a) => console.log("  -", a)); }
console.log(`\n${n}/3 prácticas ensambladas.`);
