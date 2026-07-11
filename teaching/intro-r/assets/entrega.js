/* ═══════════════════════════════════════════════════════════════
   ENTREGA.JS — Subida de entregables (Tarea / Actividad IA) a Drive
   Curso Nivelatorio de R · CIENFI · Universidad Icesi

   Cada página define:
     window.ENTREGA = {
       categoria: "tarea" | "actividad_ia",
       unidad: 1,
       titulo: "Entregar la Tarea 1",
       intro: "Sube tu script .R terminado.",
       archivo: "tarea_unidad-1.R"   // opcional: enlace de descarga (mismo folder)
     }
   Envía el archivo (base64) al Web App de Apps Script configurado en
   assets/curso-config.js. Si no hay URL, avisa que el canal no está listo.
   ═══════════════════════════════════════════════════════════════ */
(function () {
  "use strict";
  const E = window.ENTREGA;
  const URL_APPS = (window.CURSO_CONFIG && window.CURSO_CONFIG.appsScriptUrl) || "";

  function esc(s) { return String(s == null ? "" : s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;"); }
  function correoOk(s) { return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(String(s || "").trim()); }

  function leerBase64(file) {
    return new Promise(function (resolve, reject) {
      const fr = new FileReader();
      fr.onload = function () {
        const res = String(fr.result || "");
        const coma = res.indexOf(",");
        resolve(coma === -1 ? res : res.substring(coma + 1)); // quitar el prefijo dataURL
      };
      fr.onerror = reject;
      fr.readAsDataURL(file);
    });
  }

  function render() {
    const root = document.getElementById("entrega-root");
    if (!E || !root) return;
    const descarga = E.archivo
      ? '<a class="entrega-descarga" href="' + esc(E.archivo) + '" download>⬇ Descargar el script (' + esc(E.archivo) + ")</a>"
      : "";
    root.innerHTML =
      '<div class="entrega">' +
        "<h3>" + esc(E.titulo || "Entregar") + "</h3>" +
        (E.intro ? '<p class="entrega-intro">' + esc(E.intro) + "</p>" : "") +
        descarga +
        '<div class="entrega-fila">' +
          '<div class="entrega-campo"><label for="entNombre">Nombre completo</label><input type="text" id="entNombre" placeholder="Tu nombre" autocomplete="name"></div>' +
          '<div class="entrega-campo"><label for="entCodigo">Código de estudiante</label><input type="text" id="entCodigo" placeholder="Ej: A00123456" autocomplete="off"></div>' +
          '<div class="entrega-campo"><label for="entCorreo">Correo</label><input type="email" id="entCorreo" placeholder="tucorreo@u.icesi.edu.co" autocomplete="email"></div>' +
        "</div>" +
        '<label class="entrega-drop" id="entDrop"><span id="entDropTxt">📎 Haz clic para elegir tu archivo <strong>.R</strong> (o arrástralo aquí)</span>' +
          '<input type="file" id="entFile" accept=".R,.r,.txt"></label>' +
        '<button class="entrega-btn" id="entEnviar" disabled>Enviar entrega</button>' +
        '<div class="entrega-status" id="entStatus"></div>' +
        '<p class="entrega-nota">Se guarda en la carpeta del curso en Google Drive junto con tu código, ' +
          "y te llega un <strong>correo de confirmación</strong>.</p>" +
      "</div>";

    const file = document.getElementById("entFile");
    const drop = document.getElementById("entDrop");
    const dropTxt = document.getElementById("entDropTxt");
    const btn = document.getElementById("entEnviar");
    const status = document.getElementById("entStatus");
    const codigo = document.getElementById("entCodigo");
    const correo = document.getElementById("entCorreo");
    let elegido = null;

    function refrescar() {
      btn.disabled = !(elegido && codigo.value.trim() && correoOk(correo.value));
    }
    function setArchivo(f) {
      elegido = f;
      if (f) { drop.classList.add("tiene"); dropTxt.innerHTML = "✓ " + esc(f.name); }
      else { drop.classList.remove("tiene"); dropTxt.innerHTML = "📎 Haz clic para elegir tu archivo <strong>.R</strong>"; }
      refrescar();
    }
    file.addEventListener("change", function () { setArchivo(file.files[0] || null); });
    codigo.addEventListener("input", refrescar);
    correo.addEventListener("input", refrescar);
    // arrastrar y soltar
    ["dragover", "dragenter"].forEach(function (ev) { drop.addEventListener(ev, function (e) { e.preventDefault(); drop.style.borderColor = "var(--primario)"; }); });
    ["dragleave", "drop"].forEach(function (ev) { drop.addEventListener(ev, function (e) { e.preventDefault(); drop.style.borderColor = ""; }); });
    drop.addEventListener("drop", function (e) { if (e.dataTransfer.files[0]) { file.files = e.dataTransfer.files; setArchivo(e.dataTransfer.files[0]); } });

    btn.addEventListener("click", async function () {
      if (!elegido || !codigo.value.trim() || !correoOk(correo.value)) return;
      if (!URL_APPS) {
        status.className = "entrega-status err";
        status.innerHTML = "El canal de entrega aún no está configurado. Avísale al profesor o guarda tu archivo para enviarlo luego.";
        return;
      }
      btn.disabled = true;
      status.className = "entrega-status";
      status.textContent = "Enviando…";
      try {
        const contentBase64 = await leerBase64(elegido);
        const payload = {
          tipo: "entrega",
          categoria: E.categoria || "entrega",
          unidad: E.unidad || "",
          codigo: codigo.value.trim(),
          correo: correo.value.trim(),
          nombre: (document.getElementById("entNombre").value || "").trim(),
          filename: elegido.name,
          mime: elegido.type || "text/plain",
          contentBase64: contentBase64,
          fecha: new Date().toISOString(),
        };
        // no-cors: no podemos leer la respuesta, pero el envío se realiza.
        await fetch(URL_APPS, { method: "POST", mode: "no-cors", headers: { "Content-Type": "text/plain;charset=utf-8" }, body: JSON.stringify(payload) });
        status.className = "entrega-status ok";
        status.innerHTML = "✓ ¡Entrega enviada! Quedó registrada con tu código <strong>" + esc(payload.codigo) + "</strong>. Te enviamos una confirmación a <strong>" + esc(payload.correo) + "</strong> (revisa también spam).";
      } catch (err) {
        status.className = "entrega-status err";
        status.innerHTML = "No se pudo enviar (revisa tu conexión). Puedes intentarlo de nuevo.";
        btn.disabled = false;
      }
    });
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", render);
  else render();
})();
