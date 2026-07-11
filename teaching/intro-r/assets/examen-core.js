/* ═══════════════════════════════════════════════════════════════
   EXAMEN-CORE.JS — Núcleo compartido de preguntas (calificación)
   Curso Nivelatorio de R · CIENFI · Universidad Icesi

   Portado de la plataforma anterior (Version_Andrea). Lo usan tanto
   el motor de examen (examen.js) como los checks formativos de la
   práctica (webr.js). Expone window.ExamenCore.

   Esquema de una pregunta:
     { tema, tipo, enunciado,
       codigo?,                         // bloque de código-contexto (consola)
       opciones?, correcta?,            // opcion_multiple / verdadero_falso
       respuestas?,                     // escribir_codigo / completar_codigo (aceptadas)
       retro_ok?, retro_no? }           // retro (checks formativos)
   Tipos: opcion_multiple · verdadero_falso · completar_codigo · escribir_codigo
   ═══════════════════════════════════════════════════════════════ */
(function () {
  "use strict";

  function escHtml(s) {
    return String(s == null ? "" : s)
      .replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
  }

  // Formato ligero para enunciados: escapa HTML y aplica ```bloque```, `código`, **negrita** y saltos de línea.
  function fmt(s) {
    let t = escHtml(s);
    t = t.replace(/```[a-zA-Z]*\n?([\s\S]*?)```/g, function (_, code) {
      return '<pre class="q-pre">' + code.replace(/\n$/, "") + "</pre>";
    });
    t = t.replace(/`([^`]+)`/g, "<code>$1</code>");
    t = t.replace(/\*\*([^*]+)\*\*/g, "<strong>$1</strong>");
    t = t.replace(/\n/g, "<br>");
    return t;
  }

  // Normaliza código para comparar (tolerante con espacios, mayúsculas y comillas)
  function normCodigo(s) {
    return String(s)
      .replace(/[“”]/g, '"').replace(/[‘’]/g, "'")
      .replace(/'/g, '"')
      .replace(/\s+/g, "")
      .toLowerCase();
  }

  const ETIQUETA_TIPO = {
    opcion_multiple: "Selección múltiple",
    verdadero_falso: "Verdadero / Falso",
    completar_codigo: "Completar código",
    escribir_codigo: "Escribir código",
  };

  function bloqueCodigo(codigo, etiqueta) {
    if (!codigo) return "";
    return (
      '<div class="q-codigo">' +
      '<div class="q-codigo__barra">' +
      '<span class="q-dot r"></span><span class="q-dot y"></span><span class="q-dot g"></span>' +
      '<span class="q-codigo__et">' + escHtml(etiqueta || "R") + "</span>" +
      "</div>" +
      "<pre>" + escHtml(codigo) + "</pre>" +
      "</div>"
    );
  }

  // Controles de respuesta (opción múltiple, V/F, escribir/completar código)
  function controlesHTML(p, idBase) {
    if (p.tipo === "opcion_multiple") {
      return '<div class="opciones" role="radiogroup">' +
        p.opciones.map(function (op, i) {
          return '<label class="opcion" data-i="' + i + '">' +
            '<input type="radio" name="' + idBase + '" value="' + i + '">' +
            '<span class="opcion__txt">' + fmt(op) + "</span></label>";
        }).join("") + "</div>";
    }
    if (p.tipo === "verdadero_falso") {
      return '<div class="opciones" role="radiogroup">' +
        [["true", "Verdadero"], ["false", "Falso"]].map(function (par) {
          return '<label class="opcion" data-i="' + par[0] + '">' +
            '<input type="radio" name="' + idBase + '" value="' + par[0] + '">' +
            '<span class="opcion__txt">' + par[1] + "</span></label>";
        }).join("") + "</div>";
    }
    // completar_codigo / escribir_codigo — recuadro estilo consola
    return '<div class="codigo-input-wrap">' +
      '<span class="gutter">&gt;</span>' +
      '<textarea class="codigo-input" name="' + idBase + '" rows="1" spellcheck="false" ' +
      'autocapitalize="off" autocomplete="off" placeholder="Escribe aquí tu respuesta en R…"></textarea>' +
      "</div>";
  }

  function leerRespuesta(p, idBase, ctx) {
    ctx = ctx || document;
    if (p.tipo === "completar_codigo" || p.tipo === "escribir_codigo") {
      const ta = ctx.querySelector('[name="' + idBase + '"]');
      return ta ? ta.value : "";
    }
    const sel = ctx.querySelector('[name="' + idBase + '"]:checked');
    if (!sel) return null;
    if (p.tipo === "verdadero_falso") return sel.value === "true";
    return Number(sel.value);
  }

  function esCorrecta(p, resp) {
    switch (p.tipo) {
      case "opcion_multiple":
        return Number(resp) === p.correcta;
      case "verdadero_falso":
        return resp === p.correcta;
      case "completar_codigo":
      case "escribir_codigo": {
        if (resp == null || String(resp).trim() === "") return false;
        const r = normCodigo(resp);
        return (p.respuestas || []).some(function (a) { return normCodigo(a) === r; });
      }
      default: return false;
    }
  }

  // Para el detalle legible que se envía a Google Sheets
  function textoPlano(s) {
    return String(s == null ? "" : s).replace(/`/g, "").replace(/\*\*/g, "").replace(/\s+/g, " ").trim();
  }
  function respuestaLegible(p, r) {
    if (r === undefined || r === null || (typeof r === "string" && r.trim() === "")) return "(sin responder)";
    if (p.tipo === "verdadero_falso") return r === true ? "Verdadero" : "Falso";
    if (p.tipo === "opcion_multiple") {
      const i = Number(r);
      return (p.opciones && p.opciones[i] != null) ? textoPlano(p.opciones[i]) : "(sin responder)";
    }
    return String(r).trim();
  }
  function respuestaCorrectaLegible(p) {
    if (p.tipo === "verdadero_falso") return p.correcta ? "Verdadero" : "Falso";
    if (p.tipo === "opcion_multiple") return textoPlano(p.opciones[p.correcta]);
    return ((p.respuestas || [])[0]) || "";
  }

  window.ExamenCore = {
    escHtml: escHtml, fmt: fmt, normCodigo: normCodigo,
    ETIQUETA_TIPO: ETIQUETA_TIPO, bloqueCodigo: bloqueCodigo,
    controlesHTML: controlesHTML, leerRespuesta: leerRespuesta, esCorrecta: esCorrecta,
    textoPlano: textoPlano, respuestaLegible: respuestaLegible, respuestaCorrectaLegible: respuestaCorrectaLegible,
  };
})();
