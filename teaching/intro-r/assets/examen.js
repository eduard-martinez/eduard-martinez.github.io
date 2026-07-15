/* ═══════════════════════════════════════════════════════════════
   EXAMEN.JS — Motor de cuestionario evaluativo (un examen por página)
   Curso Nivelatorio de R · CIENFI · Universidad Icesi

   Flujo:  identidad (código + correo) → instrucciones
           → en curso → resultado.
   · Sin límite de tiempo.
   · 2 intentos por estudiante (localStorage).
   · Los resultados se envían (sin bloquear) a Google Sheets vía Apps
     Script; en CADA intento, el Apps Script le envía al correo
     del estudiante sus resultados con las respuestas correctas.
   ═══════════════════════════════════════════════════════════════ */
(function () {
  "use strict";
  const C = window.ExamenCore;

  /* ─────────── [CONFIG-EVALUACION] ─────────── */
  const EVAL_CONFIG = {
    maxIntentos:    2,             // intentos por estudiante
    notaAprobacion: 60,            // % mínimo para aprobar
  };

  /* La URL de Apps Script se configura UNA sola vez en assets/curso-config.js. */
  const SHEETS_CONFIG = { url: (window.CURSO_CONFIG && window.CURSO_CONFIG.appsScriptUrl) || "" };

  const EXAMEN = window.EXAMEN;
  const PARTE = (EXAMEN && EXAMEN.parteId) || "examen";

  const LS_ATTEMPTS   = "cursoR_intentos_" + PARTE;
  const LS_SESION     = "cursoR_sesion_" + PARTE;
  const LS_ULT_EST    = "cursoR_ult_estudiante";

  let resultadoActual = null;

  function root() { return document.getElementById("examen-root"); }
  function $(sel, ctx) { return (ctx || document).querySelector(sel); }
  function $$(sel, ctx) { return Array.prototype.slice.call((ctx || document).querySelectorAll(sel)); }
  function lsGet(k, def) { try { const v = JSON.parse(localStorage.getItem(k)); return v == null ? def : v; } catch (e) { return def; } }
  function lsSet(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) {} }
  function correoValido(s) { return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(String(s || "").trim()); }

  function registro(id) { return lsGet(LS_ATTEMPTS, {})[id] || { intentosUsados: 0, historial: [] }; }
  function guardarRegistro(id, reg) { const t = lsGet(LS_ATTEMPTS, {}); t[id] = reg; lsSet(LS_ATTEMPTS, t); }

  /* ─────────── enrutador ─────────── */
  function render() {
    if (!EXAMEN || !C) return;
    const sesion = lsGet(LS_SESION, null);
    if (sesion && !sesion.finalizada) { pantallaEnCurso(sesion); return; }
    if (resultadoActual) { pantallaResultado(resultadoActual); return; }
    pantallaInstrucciones();
  }

  /* ─────────── instrucciones + identidad ─────────── */
  function pantallaInstrucciones() {
    const total = EXAMEN.preguntas.length;
    root().innerHTML =
      '<div class="reglas" style="border-left-color:var(--exito);background:#f2fdf7">' +
        "<strong>" + C.escHtml(EXAMEN.titulo) + "</strong>" +
        '<p style="margin:.3em 0 0">' + C.escHtml(EXAMEN.descripcion || "") + "</p>" +
      "</div>" +
      '<div class="instrucciones-grid">' +
        '<div class="dato-eval"><div class="v">' + total + '</div><div class="l">preguntas</div></div>' +
        '<div class="dato-eval"><div class="v">' + EVAL_CONFIG.maxIntentos + '</div><div class="l">intentos máx.</div></div>' +
        '<div class="dato-eval"><div class="v">' + EVAL_CONFIG.notaAprobacion + '%</div><div class="l">para aprobar</div></div>' +
        '<div class="dato-eval"><div class="v">∞</div><div class="l">sin límite de tiempo</div></div>' +
      "</div>" +
      '<div class="reglas"><strong>Reglas</strong><ul>' +
        "<li>Dispones de <strong>máximo " + EVAL_CONFIG.maxIntentos + " intento(s)</strong>. Cada envío cuenta como un intento.</li>" +
        "<li><strong>No hay límite de tiempo</strong>: tómate lo que necesites, pero responde con lo que sabes.</li>" +
        "<li>Debes <strong>escribir el código</strong> en R en las preguntas que lo pidan.</li>" +
        "<li>Después de <strong>cada intento</strong> recibirás por <strong>correo</strong> tus resultados con las respuestas correctas.</li>" +
      "</ul></div>" +
      '<div class="form-identidad">' +
        '<div class="campo"><label for="estNombre">Nombre completo</label><input type="text" id="estNombre" placeholder="Tu nombre" autocomplete="name"></div>' +
        '<div class="campo"><label for="estCodigo">Código de estudiante</label><input type="text" id="estCodigo" placeholder="Ej: A00123456" autocomplete="off"></div>' +
        '<div class="campo"><label for="estCorreo">Correo</label><input type="email" id="estCorreo" placeholder="tucorreo@u.icesi.edu.co" autocomplete="email"></div>' +
      "</div>" +
      '<div class="ex-error" id="estAviso"></div>' +
      '<div id="estZonaInicio"></div>';
    const ult = lsGet(LS_ULT_EST, null);
    if (ult) { $("#estNombre").value = ult.nombre || ""; $("#estCodigo").value = ult.codigo || ""; $("#estCorreo").value = ult.correo || ""; }
    pintarZonaInicio();
    ["#estCodigo", "#estNombre", "#estCorreo"].forEach(function (sel) { $(sel).addEventListener("input", pintarZonaInicio); });
  }

  function idActual() {
    const cod = ($("#estCodigo") && $("#estCodigo").value || "").trim();
    return cod ? cod.toLowerCase() : null;
  }

  function pintarZonaInicio() {
    const zona = $("#estZonaInicio"); if (!zona) return;
    const id = idActual();
    const correo = ($("#estCorreo") && $("#estCorreo").value || "").trim();
    const aviso = $("#estAviso");
    if (!id || !correoValido(correo)) {
      if (aviso) aviso.textContent = (id && correo && !correoValido(correo)) ? "Escribe un correo válido para continuar." : "";
      zona.innerHTML = '<button class="ex-btn ex-btn--primario ex-btn--block" disabled>Ingresa tu código y correo para comenzar</button>';
      return;
    }
    if (aviso) aviso.textContent = "";
    const reg = registro(id);
    const restantes = EVAL_CONFIG.maxIntentos - reg.intentosUsados;
    let hist = "";
    if (reg.historial.length) {
      hist = '<div class="historial-intentos"><strong>Tus intentos previos</strong>' +
        '<table><thead><tr><th>#</th><th>Fecha</th><th>Puntaje</th><th>Estado</th></tr></thead><tbody>' +
        reg.historial.map(function (h) {
          return "<tr><td>" + h.intento + "</td><td>" + C.escHtml(h.fecha) + "</td><td>" + h.puntaje + "%</td>" +
            '<td><span class="pill ' + (h.aprobado ? "ok" : "no") + '">' + (h.aprobado ? "Aprobado" : "No aprobado") + "</span></td></tr>";
        }).join("") + "</tbody></table></div>";
    }
    if (restantes <= 0) {
      const mejor = Math.max.apply(null, [0].concat(reg.historial.map(function (h) { return h.puntaje; })));
      zona.innerHTML = '<div class="reglas" style="border-left-color:var(--aviso);background:#fdf3f3">' +
        "<strong>Has agotado tus intentos</strong><p style=\"margin:.3em 0 0\">Tu mejor resultado fue <strong>" + mejor + "%</strong>. No hay más intentos disponibles.</p></div>" + hist;
      return;
    }
    zona.innerHTML = hist + '<button class="ex-btn ex-btn--primario ex-btn--block" id="btnComenzar" style="margin-top:14px">Comenzar · intento ' + (reg.intentosUsados + 1) + " de " + EVAL_CONFIG.maxIntentos + " →</button>";
    $("#btnComenzar").addEventListener("click", function () { comenzar(id); });
  }

  /* ─────────── iniciar ─────────── */
  function comenzar(id) {
    const reg = registro(id);
    if (reg.intentosUsados >= EVAL_CONFIG.maxIntentos) return;
    const nombre = ($("#estNombre") && $("#estNombre").value || "").trim();
    const correo = ($("#estCorreo") && $("#estCorreo").value || "").trim();
    if (!correoValido(correo)) { const a = $("#estAviso"); if (a) a.textContent = "Escribe un correo válido para continuar."; return; }
    const sesion = { idEstudiante: id, nombre: nombre, correo: correo, intento: reg.intentosUsados + 1, inicioTs: Date.now(), respuestas: {}, finalizada: false };
    lsSet(LS_ULT_EST, { nombre: nombre, codigo: id, correo: correo });
    lsSet(LS_SESION, sesion);
    resultadoActual = null;
    // arranca webR en segundo plano para calificar el código por su salida
    if (window.ExamenWebR && EXAMEN.setup) window.ExamenWebR.boot(EXAMEN.setup, EXAMEN.packages || []);
    pantallaEnCurso(sesion);
  }

  /* ─────────── en curso ─────────── */
  function pantallaEnCurso(sesion) {
    const preguntas = EXAMEN.preguntas;
    root().innerHTML =
      '<div class="eval-barra">' +
        '<div class="eval-barra__prog"><div class="barra"><span id="progBarra"></span></div>' +
          '<div class="et"><span id="progTxt">0</span> de ' + preguntas.length + " respondidas</div></div>" +
        '<div class="eval-barra__intento">intento ' + sesion.intento + "/" + EVAL_CONFIG.maxIntentos + "</div>" +
      "</div>" +
      '<form id="evalForm">' +
        preguntas.map(function (p, i) {
          const idBase = "eval_" + i;
          return '<div class="q-card" data-idx="' + i + '">' +
            '<div class="q-head"><span class="q-num">' + String(i + 1).padStart(2, "0") + "</span>" +
              '<span class="q-tipo">' + C.ETIQUETA_TIPO[p.tipo] + "</span>" +
              '<span class="q-tema">' + C.escHtml(p.tema || "") + "</span></div>" +
            '<div class="q-texto">' + C.fmt(p.enunciado) + "</div>" +
            C.bloqueCodigo(p.codigo, "R") +
            C.controlesHTML(p, idBase) +
          "</div>";
        }).join("") +
      "</form>" +
      '<button class="ex-btn ex-btn--exito ex-btn--block" id="btnFinalizar">Finalizar y enviar</button>' +
      '<p style="text-align:center;font-size:.82rem;color:var(--tenue);margin-top:10px">Tus respuestas se guardan automáticamente mientras avanzas.</p>';

    const form = $("#evalForm");
    preguntas.forEach(function (p, i) {
      const g = sesion.respuestas[i];
      if (g === undefined || g === null) return;
      const idBase = "eval_" + i;
      if (p.tipo === "completar_codigo" || p.tipo === "escribir_codigo") {
        const ta = form.querySelector('[name="' + idBase + '"]'); if (ta) { ta.value = g; ta.style.height = "auto"; ta.style.height = ta.scrollHeight + "px"; }
      } else {
        const inp = form.querySelector('[name="' + idBase + '"][value="' + String(g) + '"]');
        if (inp) { inp.checked = true; inp.closest(".opcion").classList.add("sel"); }
      }
    });
    form.addEventListener("change", function (e) {
      if (e.target.matches('input[type="radio"]')) {
        const card = e.target.closest(".q-card");
        $$(".opcion", card).forEach(function (o) { o.classList.remove("sel"); });
        e.target.closest(".opcion").classList.add("sel");
      }
      guardarDesdeDOM();
    });
    form.addEventListener("input", function (e) {
      if (e.target.matches("textarea.codigo-input")) {
        e.target.style.height = "auto"; e.target.style.height = e.target.scrollHeight + "px";
        guardarDesdeDOM();
      }
    });
    $("#btnFinalizar").addEventListener("click", function () {
      if (confirm("¿Enviar el cuestionario? No podrás modificar tus respuestas de este intento.")) finalizar();
    });
    actualizarProgreso();
  }

  function guardarDesdeDOM() {
    const sesion = lsGet(LS_SESION, null);
    if (!sesion || sesion.finalizada) return;
    const form = $("#evalForm"); if (!form) return;
    EXAMEN.preguntas.forEach(function (p, i) {
      const r = C.leerRespuesta(p, "eval_" + i, form);
      if (r !== null && !(typeof r === "string" && r.trim() === "")) sesion.respuestas[i] = r;
      else delete sesion.respuestas[i];
    });
    lsSet(LS_SESION, sesion);
    actualizarProgreso();
  }

  function actualizarProgreso() {
    const sesion = lsGet(LS_SESION, null); if (!sesion) return;
    const n = Object.keys(sesion.respuestas).length;
    const pct = Math.round(n / EXAMEN.preguntas.length * 100);
    const b = $("#progBarra"); if (b) b.style.width = pct + "%";
    const t = $("#progTxt"); if (t) t.textContent = n;
  }

  /* ─────────── envío a Sheets / Apps Script (no bloqueante) ─────────── */
  function enviarSheets(datos) {
    if (!SHEETS_CONFIG.url) return;
    try {
      fetch(SHEETS_CONFIG.url, { method: "POST", mode: "no-cors", headers: { "Content-Type": "text/plain;charset=utf-8" }, body: JSON.stringify(datos) }).catch(function () {});
    } catch (e) {}
  }

  /* ─────────── finalizar y calificar (ejecuta el código en webR) ─────────── */
  function mostrarCalificando() {
    root().innerHTML = '<div class="resultado" style="padding:2.5rem 0">' +
      '<div class="ex-spin">⏳</div><h3>Calificando tus respuestas…</h3>' +
      '<p class="ex-intro">Estamos ejecutando tu código para evaluar el <strong>resultado</strong>. Puede tardar unos segundos.</p></div>';
  }

  async function calificarPregunta(p, r) {
    const respondida = !(r === undefined || r === null || (typeof r === "string" && r.trim() === ""));
    if (!respondida) return false;
    if ((p.tipo === "escribir_codigo" || p.tipo === "completar_codigo") && p.solucion && window.ExamenWebR) {
      try { return await window.ExamenWebR.calificar(EXAMEN.setup, p.solucion, String(r)); }
      catch (e) { return C.esCorrecta(p, r); }  // respaldo por texto si webR no está disponible
    }
    return C.esCorrecta(p, r);
  }

  async function finalizar() {
    const sesion = lsGet(LS_SESION, null);
    if (!sesion || sesion.finalizada) return;
    sesion.finalizada = true; lsSet(LS_SESION, sesion);   // evita doble envío
    mostrarCalificando();
    const preguntas = EXAMEN.preguntas;
    const oks = [];
    for (let i = 0; i < preguntas.length; i++) oks[i] = await calificarPregunta(preguntas[i], sesion.respuestas[i]);
    let correctas = 0; const porTema = {};
    preguntas.forEach(function (p, i) {
      const ok = oks[i];
      if (ok) correctas++;
      const tema = p.tema || "General";
      if (!porTema[tema]) porTema[tema] = { ok: 0, total: 0 };
      porTema[tema].total++; if (ok) porTema[tema].ok++;
    });
    const total = preguntas.length;
    const pct = Math.round(correctas / total * 100);
    const aprobado = pct >= EVAL_CONFIG.notaAprobacion;
    const dur = Math.round((Date.now() - sesion.inicioTs) / 1000);
    const id = sesion.idEstudiante;
    const reg = registro(id);
    reg.intentosUsados += 1;
    reg.historial.push({ intento: sesion.intento, fecha: new Date().toLocaleString("es-CO", { dateStyle: "short", timeStyle: "short" }), puntaje: pct, aprobado: aprobado, duracionSeg: dur });
    guardarRegistro(id, reg);

    const detalle = preguntas.map(function (p, i) {
      const r = sesion.respuestas[i];
      return { n: i + 1, tema: p.tema || "", tipo: C.ETIQUETA_TIPO[p.tipo] || p.tipo, enunciado: C.textoPlano(p.enunciado), respuesta: C.respuestaLegible(p, r), correcta: C.respuestaCorrectaLegible(p), acierto: oks[i] };
    });
    enviarSheets({
      fecha: new Date().toISOString(), nombre: sesion.nombre || "", codigo: id, correo: sesion.correo || "",
      parte: EXAMEN.titulo, evaluacion: EXAMEN.titulo, intento: sesion.intento,
      puntaje: pct, aprobado: aprobado, correctas: correctas, total: total, duracionSeg: dur,
      porTema: porTema, detalle: detalle,
      // el Apps Script envía el correo con respuestas correctas cuando enviarCorreo === true
      // (se envía en TODOS los intentos, no solo en el último)
      enviarCorreo: true,
    });

    sesion.finalizada = true;
    lsSet(LS_SESION, null);
    resultadoActual = { pct: pct, correctas: correctas, total: total, aprobado: aprobado, porTema: porTema, intento: sesion.intento, nombre: sesion.nombre, correo: sesion.correo, intentosRestantes: EVAL_CONFIG.maxIntentos - reg.intentosUsados };
    pantallaResultado(resultadoActual);
  }

  /* ─────────── resultado ─────────── */
  function mensaje(pct, aprobado) {
    if (pct >= 90) return "¡Excelente! Dominas estos temas.";
    if (aprobado) return "¡Aprobaste! Repasa los temas con menos aciertos para afianzar.";
    if (pct >= 40) return "Estás cerca. Repasa la teoría y la práctica antes de tu siguiente intento.";
    return "Conviene reforzar las bases. Revisa con calma los materiales y practica de nuevo.";
  }

  function pantallaResultado(res) {
    const aro = res.aprobado ? "var(--exito)" : "var(--aviso)";
    const temas = Object.keys(res.porTema).map(function (t) {
      const v = res.porTema[t]; const pct = Math.round(v.ok / v.total * 100);
      return '<div class="res-tema"><div class="res-tema__l">' + C.escHtml(t) + '</div><div class="res-tema__b"><span style="width:' + pct + '%"></span></div><div class="res-tema__n">' + v.ok + "/" + v.total + "</div></div>";
    }).join("");
    const esUltimo = res.intento >= EVAL_CONFIG.maxIntentos;
    const puedeReintentar = res.intentosRestantes > 0;
    root().innerHTML =
      '<div class="resultado">' +
        '<div class="res-ring" style="--pct:' + res.pct + ";--aro:" + aro + '"><div class="res-ring__inner"><div class="res-ring__pct">' + res.pct + "%</div></div></div>" +
        '<div class="res-estado ' + (res.aprobado ? "ok" : "no") + '">' + (res.aprobado ? "Aprobado" : "No aprobado") + "</div>" +
        "<p>" + C.escHtml(mensaje(res.pct, res.aprobado)) + "</p>" +
        '<p style="color:var(--tinta-suave)">' + res.correctas + " de " + res.total + " correctas · intento " + res.intento + "/" + EVAL_CONFIG.maxIntentos + "</p>" +
        (esUltimo && res.correo ? '<div class="reglas" style="border-left-color:var(--primario);background:var(--primario-claro)">📧 Te enviamos a <strong>' + C.escHtml(res.correo) + "</strong> tus resultados con las respuestas correctas. (Revisa también la carpeta de spam.)</div>" : "") +
        '<div class="res-temas"><strong>Desempeño por tema</strong>' + temas + "</div>" +
        (puedeReintentar
          ? '<button class="ex-btn ex-btn--primario" id="btnOtro">Hacer otro intento (' + res.intentosRestantes + " restante" + (res.intentosRestantes === 1 ? "" : "s") + ")</button>"
          : '<p class="ex-intro">Has usado tus ' + EVAL_CONFIG.maxIntentos + " intentos. Tu resultado quedó registrado.</p>") +
      "</div>";
    if (puedeReintentar) $("#btnOtro").addEventListener("click", function () { resultadoActual = null; render(); });
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", render);
  else render();
})();
