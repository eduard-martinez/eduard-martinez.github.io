/* ═══════════════════════════════════════════════════════════════
   WEBR.JS — Runner de prácticas con R ejecutable en el navegador
   Curso Nivelatorio de R · CIENFI · Universidad Icesi

   Lee dos objetos globales definidos por cada práctica:
     window.WEBR_CONFIG = { packages: ["dplyr", ...], setup: "R code" }
     window.WEBR_BLOCKS = [
       { type:"section", title:"1. R como calculadora" },
       { type:"prose",   html:"<p>...</p>" },
       { type:"code",    code:"2 + 2", label?:"" },
       { type:"static",  code:'import("datos/...")', note?:"Se corre en RStudio" }
     ]
   Renderiza todo en #practica-root. Las celdas comparten una misma
   sesión de R (el objeto creado en una celda existe en la siguiente).
   Si webR no puede cargar (sin conexión), degrada con elegancia:
   el código queda visible, editable y copiable.
   ═══════════════════════════════════════════════════════════════ */

(function () {
  "use strict";

  const CDN = "https://webr.r-wasm.org/latest/webr.mjs";
  const BOOT_TIMEOUT_MS = 60000;

  let webR = null;
  let shelter = null;
  let bootPromise = null;
  let bootFailed = false;
  const runButtons = [];

  // Checks formativos + registro de avance (usan examen-core.js y curso-config.js)
  const CORE = window.ExamenCore;
  const CFG = window.CURSO_CONFIG || {};
  const checkEstado = {};
  function totalChecks() { return (window.WEBR_BLOCKS || []).filter(function (b) { return b.type === "check"; }).length; }
  function actualizarRegistro() {
    const el2 = document.getElementById("webr-reg-prog");
    if (el2) { const ok = Object.keys(checkEstado).filter(function (k) { return checkEstado[k]; }).length; el2.textContent = ok + "/" + totalChecks(); }
  }

  function $(sel, ctx) { return (ctx || document).querySelector(sel); }
  function el(tag, cls, html) {
    const n = document.createElement(tag);
    if (cls) n.className = cls;
    if (html != null) n.innerHTML = html;
    return n;
  }
  function setStatus(state, text) {
    const dot = $(".webr-status-dot");
    const txt = $(".webr-status-text");
    if (dot) dot.className = "webr-status-dot " + state;
    if (txt) txt.innerHTML = text;
  }

  /* ---------- arranque de webR ---------- */
  function boot() {
    if (bootPromise) return bootPromise;
    const cfg = window.WEBR_CONFIG || {};
    bootPromise = (async function () {
      setStatus("loading", "Iniciando R en el navegador… (la primera vez puede tardar)");
      const withTimeout = function (p, ms) {
        return Promise.race([
          p,
          new Promise(function (_, rej) { setTimeout(function () { rej(new Error("timeout")); }, ms); })
        ]);
      };
      const mod = await withTimeout(import(CDN), BOOT_TIMEOUT_MS);
      webR = new mod.WebR({ baseUrl: "https://webr.r-wasm.org/latest/" });
      await withTimeout(webR.init(), BOOT_TIMEOUT_MS);
      shelter = await new webR.Shelter();
      const pkgs = cfg.packages || [];
      if (pkgs.length) {
        setStatus("loading", "Instalando paquetes: <strong>" + pkgs.join(", ") + "</strong>…");
        await webR.installPackages(pkgs, { quiet: true });
      }
      if (cfg.setup) {
        setStatus("loading", "Preparando los datos de la práctica…");
        await webR.evalRVoid(cfg.setup, { env: webR.objs.globalEnv });
      }
      setStatus("ready", "<strong>R listo.</strong> Ejecuta las celdas en orden — comparten la misma sesión.");
      return true;
    })().catch(function (err) {
      bootFailed = true;
      setStatus("error", "No se pudo iniciar R en el navegador (¿sin conexión?). Puedes copiar el código y ejecutarlo en RStudio.");
      document.querySelectorAll(".webr-fallback").forEach(function (f) { f.classList.add("show"); });
      runButtons.forEach(function (b) { b.disabled = true; b.title = "R no disponible sin conexión"; });
      throw err;
    });
    return bootPromise;
  }

  /* ---------- ejecutar una celda ---------- */
  async function runCell(code, outEl, btn) {
    outEl.classList.add("show");
    outEl.innerHTML = '<span class="webr-output-empty">Ejecutando…</span>';
    btn.disabled = true;
    try {
      await boot();
    } catch (e) {
      outEl.innerHTML = '<span class="webr-stderr">R no está disponible (sin conexión). Copia el código y ejecútalo en RStudio.</span>';
      return;
    }
    try {
      const result = await shelter.captureR(code, {
        withAutoprint: true,
        captureStreams: true,
        captureConditions: false,
        captureGraphics: { width: 700, height: 450 },
        env: webR.objs.globalEnv
      });
      renderResult(result, outEl);
    } catch (err) {
      outEl.innerHTML = '<pre class="webr-stderr">' + escapeHtml(String(err && err.message ? err.message : err)) + "</pre>";
    } finally {
      if (!bootFailed) btn.disabled = false;
      if (shelter) { try { await shelter.purge(); } catch (e) {} }
    }
  }

  function renderResult(result, outEl) {
    outEl.innerHTML = "";
    const lines = (result.output || [])
      .filter(function (o) { return o.type === "stdout" || o.type === "stderr"; });
    if (lines.length) {
      const pre = el("pre");
      lines.forEach(function (o) {
        const span = el("span", o.type === "stderr" ? "webr-stderr" : null,
          escapeHtml(o.data) + "\n");
        pre.appendChild(span);
      });
      outEl.appendChild(pre);
    }
    const imgs = result.images || [];
    if (imgs.length) {
      imgs.forEach(function (img) {
        const wrap = el("div", "webr-plot");
        const canvas = document.createElement("canvas");
        canvas.width = img.width; canvas.height = img.height;
        canvas.style.maxWidth = "100%";
        canvas.getContext("2d").drawImage(img, 0, 0);
        wrap.appendChild(canvas);
        outEl.appendChild(wrap);
      });
    }
    if (!lines.length && !imgs.length) {
      outEl.innerHTML = '<span class="webr-output-empty">(sin salida en consola)</span>';
    }
  }

  function escapeHtml(s) {
    return String(s).replace(/[&<>]/g, function (c) {
      return c === "&" ? "&amp;" : c === "<" ? "&lt;" : "&gt;";
    });
  }

  /* ---------- render de bloques ---------- */
  function buildCodeCell(block) {
    const cell = el("div", "webr-cell");
    const bar = el("div", "webr-toolbar");
    bar.appendChild(el("span", "webr-tag", block.label || "R"));
    bar.appendChild(el("span", "webr-spacer"));
    const bRun = el("button", "webr-btn webr-btn-run", "▶ Ejecutar");
    bRun.type = "button";
    const bReset = el("button", "webr-btn webr-btn-ghost", "⟲");
    bReset.type = "button"; bReset.title = "Restaurar el código original";
    const bCopy = el("button", "webr-btn webr-btn-ghost", "⧉ Copiar");
    bCopy.type = "button";
    bar.appendChild(bRun); bar.appendChild(bReset); bar.appendChild(bCopy);

    const ta = el("textarea", "webr-code");
    ta.spellcheck = false;
    ta.setAttribute("autocomplete", "off");
    ta.setAttribute("autocapitalize", "off");
    ta.value = block.code;
    const original = block.code;
    // altura inicial según líneas
    ta.rows = Math.min(22, Math.max(2, block.code.split("\n").length));

    const out = el("div", "webr-output");

    bRun.addEventListener("click", function () { runCell(ta.value, out, bRun); });
    bReset.addEventListener("click", function () { ta.value = original; ta.rows = Math.min(22, Math.max(2, original.split("\n").length)); });
    bCopy.addEventListener("click", function () {
      navigator.clipboard.writeText(ta.value).then(function () {
        bCopy.textContent = "✓ Copiado";
        setTimeout(function () { bCopy.textContent = "⧉ Copiar"; }, 1400);
      });
    });
    // Ctrl/Cmd + Enter para ejecutar
    ta.addEventListener("keydown", function (e) {
      if ((e.ctrlKey || e.metaKey) && e.key === "Enter") { e.preventDefault(); bRun.click(); }
    });

    runButtons.push(bRun);
    cell.appendChild(bar); cell.appendChild(ta); cell.appendChild(out);
    return cell;
  }

  function buildStaticCell(block) {
    const box = el("div", "webr-static");
    box.appendChild(el("div", "webr-static-note", "🔒 " + (block.note || "Se ejecuta en RStudio (no aquí)")));
    const pre = el("pre");
    pre.appendChild(document.createTextNode(block.code));
    box.appendChild(pre);
    return box;
  }

  // Check formativo (escribir_codigo / opcion_multiple / verdadero_falso) con retro inmediata
  function buildCheckCell(block, i) {
    const p = block.pregunta; if (!p || !CORE) return el("div");
    const id = "chk_" + i;
    const card = el("div", "webr-check");
    card.innerHTML =
      '<div class="webr-check__head">✍ Comprueba lo que aprendiste' + (p.tema ? ' · <span>' + CORE.escHtml(p.tema) + "</span>" : "") + "</div>" +
      '<div class="q-texto">' + CORE.fmt(p.enunciado) + "</div>" +
      CORE.bloqueCodigo(p.codigo, "R") +
      CORE.controlesHTML(p, id) +
      '<div class="webr-check__actions"><button type="button" class="webr-btn webr-btn-run">Comprobar</button></div>' +
      '<div class="webr-check__fb"></div>';
    const btn = card.querySelector(".webr-check__actions button");
    const fb = card.querySelector(".webr-check__fb");
    const ta = card.querySelector("textarea.codigo-input");
    if (ta) ta.addEventListener("input", function () { ta.style.height = "auto"; ta.style.height = ta.scrollHeight + "px"; });
    card.addEventListener("change", function (e) {
      if (e.target.matches('input[type="radio"]')) {
        Array.prototype.forEach.call(card.querySelectorAll(".opcion"), function (o) { o.classList.remove("sel"); });
        e.target.closest(".opcion").classList.add("sel");
      }
    });
    btn.addEventListener("click", function () {
      const r = CORE.leerRespuesta(p, id, card);
      const ok = CORE.esCorrecta(p, r);
      checkEstado[id] = ok;
      fb.className = "webr-check__fb " + (ok ? "ok" : "no");
      fb.innerHTML = ok
        ? "<strong>¡Correcto!</strong> " + CORE.escHtml(p.retro_ok || "")
        : "<strong>Aún no.</strong> " + CORE.escHtml(p.retro_no || "Revisa la teoría y vuelve a intentarlo.");
      actualizarRegistro();
    });
    return card;
  }

  // Barra de registro de avance (código de estudiante + envío formativo opcional)
  function buildRegistro() {
    const unidad = (window.WEBR_CONFIG && window.WEBR_CONFIG.unidad) || "";
    const bar = el("div", "webr-registro");
    bar.innerHTML =
      '<div class="webr-registro__campos">' +
        '<input type="text" id="webr-reg-nombre" placeholder="Nombre" autocomplete="name">' +
        '<input type="text" id="webr-reg-codigo" placeholder="Código de estudiante" autocomplete="off">' +
      "</div>" +
      '<div class="webr-registro__acc"><span class="webr-registro__prog">Comprobaciones: <b id="webr-reg-prog">0/' + totalChecks() + "</b></span>" +
        '<button type="button" class="webr-btn webr-btn-run" id="webr-reg-btn">Registrar mi avance</button></div>' +
      '<div class="webr-registro__st" id="webr-reg-st"></div>';
    bar.querySelector("#webr-reg-btn").addEventListener("click", function () {
      const codigo = (bar.querySelector("#webr-reg-codigo").value || "").trim();
      const st = bar.querySelector("#webr-reg-st");
      if (!codigo) { st.className = "webr-registro__st err"; st.textContent = "Ingresa tu código para registrar."; return; }
      const total = totalChecks();
      const ok = Object.keys(checkEstado).filter(function (k) { return checkEstado[k]; }).length;
      const pct = total ? Math.round(ok / total * 100) : 0;
      if (!CFG.appsScriptUrl) {
        st.className = "webr-registro__st ok";
        st.textContent = "✓ Avance guardado (" + ok + "/" + total + "). El canal de registro aún no está configurado.";
        return;
      }
      try {
        fetch(CFG.appsScriptUrl, { method: "POST", mode: "no-cors", headers: { "Content-Type": "text/plain;charset=utf-8" }, body: JSON.stringify({
          fecha: new Date().toISOString(), nombre: (bar.querySelector("#webr-reg-nombre").value || "").trim(), codigo: codigo,
          parte: "Práctica Unidad " + unidad + " (formativa)", evaluacion: "Práctica Unidad " + unidad, intento: 1,
          puntaje: pct, aprobado: false, correctas: ok, total: total, duracionSeg: 0, porTema: {}, detalle: [],
        }) }).catch(function () {});
      } catch (e) {}
      st.className = "webr-registro__st ok";
      st.textContent = "✓ ¡Avance registrado! (" + ok + "/" + total + " comprobaciones)";
    });
    return bar;
  }

  function render() {
    const root = document.getElementById("practica-root");
    if (!root) return;
    const blocks = window.WEBR_BLOCKS || [];

    const wrap = el("div", "practica");

    // barra de estado
    const bar = el("div", "webr-statusbar");
    bar.appendChild(el("span", "webr-status-dot"));
    bar.appendChild(el("span", "webr-status-text",
      "Código ejecutable en el navegador. Pulsa <strong>▶ Ejecutar</strong> en la primera celda para iniciar R."));
    const bReset = el("button", "webr-reset-btn", "Reiniciar sesión R");
    bReset.type = "button";
    bReset.addEventListener("click", function () {
      if (webR) { try { webR.close(); } catch (e) {} }
      webR = null; shelter = null; bootPromise = null; bootFailed = false;
      setStatus("", "Sesión reiniciada. Pulsa <strong>▶ Ejecutar</strong> para volver a iniciar R.");
      document.querySelectorAll(".webr-output").forEach(function (o) { o.classList.remove("show"); o.innerHTML = ""; });
    });
    bar.appendChild(bReset);
    wrap.appendChild(bar);

    // aviso de fallback (oculto hasta que falle)
    const fb = el("div", "webr-fallback",
      "⚠️ No se pudo cargar R en el navegador (posible falta de conexión). El código sigue disponible para copiarlo y ejecutarlo en RStudio.");
    wrap.appendChild(fb);

    // barra de registro de avance (solo si la práctica trae checks formativos)
    if (totalChecks() > 0 && CORE) wrap.appendChild(buildRegistro());

    blocks.forEach(function (b, i) {
      if (b.type === "section") wrap.appendChild(el("h2", "webr-section-title", b.title));
      else if (b.type === "prose") wrap.appendChild(el("div", "webr-prose", b.html));
      else if (b.type === "code") wrap.appendChild(buildCodeCell(b));
      else if (b.type === "static") wrap.appendChild(buildStaticCell(b));
      else if (b.type === "check") wrap.appendChild(buildCheckCell(b, i));
    });

    root.innerHTML = "";
    root.appendChild(wrap);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", render);
  } else {
    render();
  }
})();
