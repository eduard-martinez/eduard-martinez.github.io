/* ═══════════════════════════════════════════════════════════════
   EXAMEN-WEBR.JS — Calificación de código por SALIDA (webR)
   Curso Nivelatorio de R · CIENFI · Universidad Icesi

   Ejecuta el código del estudiante y la solución de referencia sobre
   los mismos datos (EXAMEN.setup) y compara el RESULTADO, no el texto.
   Así, cualquier código equivalente (dplyr, base R, count(), …) se
   acepta. Si webR no carga (sin internet), examen.js usa el respaldo
   por texto (p.respuestas). Expone window.ExamenWebR.
   ═══════════════════════════════════════════════════════════════ */
(function () {
  "use strict";
  const CDN = "https://webr.r-wasm.org/latest/webr.mjs";
  const BOOT_TIMEOUT = 70000;
  const EVAL_TIMEOUT = 12000;

  let webR = null, shelter = null, bootPromise = null, failed = false;

  function conTimeout(p, ms, etiqueta) {
    return Promise.race([p, new Promise(function (_, rej) { setTimeout(function () { rej(new Error("timeout " + (etiqueta || ""))); }, ms); })]);
  }

  function boot(setup, packages) {
    if (bootPromise) return bootPromise;
    bootPromise = (async function () {
      const mod = await conTimeout(import(CDN), BOOT_TIMEOUT, "import");
      webR = new mod.WebR({ baseUrl: "https://webr.r-wasm.org/latest/" });
      await conTimeout(webR.init(), BOOT_TIMEOUT, "init");
      shelter = await new webR.Shelter();
      const pk = packages || [];
      if (pk.length) await conTimeout(webR.installPackages(pk, { quiet: true }), BOOT_TIMEOUT, "pkgs");
      if (pk.length) {
        const libs = "suppressMessages({" + pk.map(function (p) { return "library(" + p + ")"; }).join(";") + "})";
        await webR.evalRVoid(libs).catch(function () {});
      }
      return true;
    })().catch(function (e) { failed = true; throw e; });
    return bootPromise;
  }

  // Devuelve true/false comparando el resultado del estudiante con el de la solución.
  async function calificar(setup, solucion, codigoEstudiante) {
    await conTimeout(boot(setup, window.__EXAMEN_PKGS__ || []), BOOT_TIMEOUT, "boot");
    const script =
      "local({\n" +
      "  .igual <- function(a,b){ if(is.data.frame(a)||is.data.frame(b)){ isTRUE(all.equal(as.data.frame(a), as.data.frame(b), check.attributes=FALSE)) } else { isTRUE(all.equal(a,b)) } }\n" +
      (setup || "") + "\n" +
      "  .ref <- { " + solucion + " }\n" +
      "  .stu <- tryCatch({ " + codigoEstudiante + " }, error=function(e) NULL)\n" +
      "  cat(if(is.null(.stu)) 'FALSE' else if(isTRUE(try(.igual(.ref,.stu), silent=TRUE))) 'TRUE' else 'FALSE')\n" +
      "})";
    const result = await conTimeout(
      shelter.captureR(script, { withAutoprint: false, captureStreams: true, captureConditions: false }),
      EVAL_TIMEOUT, "eval");
    let out = "";
    try { out = (result.output || []).filter(function (o) { return o.type === "stdout"; }).map(function (o) { return o.data; }).join("").trim(); }
    finally { try { await shelter.purge(); } catch (e) {} }
    return out === "TRUE";
  }

  window.ExamenWebR = {
    boot: function (setup, packages) { window.__EXAMEN_PKGS__ = packages || []; return boot(setup, packages).catch(function () {}); },
    calificar: calificar,
    disponible: function () { return !failed; },
  };
})();
