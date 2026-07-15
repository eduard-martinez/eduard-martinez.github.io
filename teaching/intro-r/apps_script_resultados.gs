/**
 * ===================================================================
 *  Backend del Curso de R (Google Apps Script) — Sheets + Drive
 * ===================================================================
 *  Recibe DOS tipos de envío (campo "tipo"):
 *    · Resultados de CUESTIONARIO  -> pestañas "Resultados" y "Respuestas".
 *    · ENTREGABLES (Tarea / Actividad IA) -> guarda el archivo .R en una
 *      carpeta de Drive y registra el envío en la pestaña "Entregas".
 *
 *  CÓMO USARLO (una sola vez):
 *   1) Crea una Hoja de cálculo de Google nueva.
 *   2) Menú: Extensiones → Apps Script.
 *   3) Borra el código que aparezca y pega TODO este archivo. Guarda.
 *   4) Implementar → Nueva implementación → "Aplicación web":
 *        · Ejecutar como:      Yo (tu cuenta)
 *        · Quién tiene acceso: Cualquier persona
 *      → Implementar. Autoriza los permisos (incluye Google Drive).
 *   5) Copia la "URL de la aplicación web" (termina en /exec) y pégala
 *      en assets/curso-config.js  (appsScriptUrl).
 *
 *  Verificar: abre la URL /exec en el navegador; debe responder
 *  "OK - Web App del curso activa".
 *
 *  IMPORTANTE: si cambias este código, vuelve a Implementar →
 *  Administrar implementaciones → editar (lápiz) → Versión: Nueva versión.
 * ===================================================================
 */

var HOJA_RESUMEN  = 'Resultados';
var HOJA_DETALLE  = 'Respuestas';
var HOJA_ENTREGAS = 'Entregas';
var CARPETA_ENTREGAS = 'Entregas Curso R';   // carpeta de Drive donde se guardan los .R

var ENC_RESUMEN = [
  'Marca de tiempo (servidor)', 'Fecha (cliente)', 'Nombre', 'Código', 'Parte', 'Intento',
  'Puntaje (%)', 'Aprobado', 'Correctas', 'Total', 'Duración (s)', 'Detalle por tema'
];
var ENC_DETALLE = [
  'Marca de tiempo (servidor)', 'Fecha (cliente)', 'Nombre', 'Código', 'Parte', 'Intento',
  'N° pregunta', 'Tema', 'Tipo', 'Enunciado', 'Respuesta del estudiante', 'Respuesta correcta', '¿Acertó?'
];
var ENC_ENTREGAS = [
  'Marca de tiempo (servidor)', 'Fecha (cliente)', 'Nombre', 'Código', 'Categoría',
  'Unidad', 'Archivo', 'Enlace en Drive'
];

function doPost(e) {
  try {
    var d = JSON.parse(e.postData.contents);

    // ================= ENTREGABLES (archivo .R) =================
    if (d.tipo === 'entrega') {
      return guardarEntrega_(d);
    }

    // ================= RESULTADOS DE CUESTIONARIO =================
    var detalleTema = '';
    if (d.porTema) {
      detalleTema = Object.keys(d.porTema).map(function (t) {
        return t + ': ' + d.porTema[t].ok + '/' + d.porTema[t].total;
      }).join('  |  ');
    }
    obtenerHoja_(HOJA_RESUMEN, ENC_RESUMEN).appendRow([
      new Date(), d.fecha || '', d.nombre || '', d.codigo || '', d.parte || d.evaluacion || '', d.intento || '',
      d.puntaje, d.aprobado ? 'Sí' : 'No', d.correctas, d.total, d.duracionSeg, detalleTema
    ]);

    if (d.detalle && d.detalle.length) {
      var hojaDet = obtenerHoja_(HOJA_DETALLE, ENC_DETALLE);
      var ahora = new Date();
      var filas = d.detalle.map(function (q) {
        return [
          ahora, d.fecha || '', d.nombre || '', d.codigo || '', d.parte || d.evaluacion || '', d.intento || '',
          q.n, q.tema || '', q.tipo || '', q.enunciado || '',
          q.respuesta || '', q.correcta || '', q.acierto ? 'Sí' : 'No'
        ];
      });
      hojaDet.getRange(hojaDet.getLastRow() + 1, 1, filas.length, ENC_DETALLE.length).setValues(filas);
    }

    // Cuando enviarCorreo === true, envía al estudiante sus resultados con las
    // respuestas correctas (el front-end lo activa en cada intento).
    if (d.enviarCorreo && d.correo) { try { enviarCorreoFeedback_(d); } catch (e) {} }

    return json_({ ok: true });
  } catch (err) {
    return json_({ ok: false, error: String(err) });
  }
}

function guardarEntrega_(d) {
  var carpeta = obtenerCarpetaEntregas_();
  var base = String(d.contentBase64 || '');
  var comma = base.indexOf(',');
  if (comma !== -1) base = base.substring(comma + 1); // por si viene como dataURL
  var bytes = Utilities.base64Decode(base);
  var nombreArchivo = (d.codigo || 'sincodigo') + '_' + (d.categoria || 'entrega') +
                      '_u' + (d.unidad || '') + '_' + (d.filename || 'entrega.R');
  var blob = Utilities.newBlob(bytes, d.mime || 'text/plain', nombreArchivo);
  // guarda dentro de la carpeta de la entrega (una por Tarea/Actividad y unidad); se crea sola
  var destino = carpetaDeEntrega_(carpeta, d.categoria, d.unidad);
  var file = destino.createFile(blob);
  var url = file.getUrl();

  obtenerHoja_(HOJA_ENTREGAS, ENC_ENTREGAS).appendRow([
    new Date(), d.fecha || '', d.nombre || '', d.codigo || '', d.categoria || '',
    d.unidad || '', nombreArchivo, url
  ]);
  // correo de confirmación de recibido al estudiante
  if (d.correo) { try { enviarCorreoEntrega_(d, nombreArchivo); } catch (e) {} }
  return json_({ ok: true, url: url });
}

function doGet() {
  return ContentService.createTextOutput('OK - Web App del curso activa');
}

function obtenerHoja_(nombre, encabezados) {
  var libro = SpreadsheetApp.getActiveSpreadsheet();
  var hoja = libro.getSheetByName(nombre);
  if (!hoja) { hoja = libro.insertSheet(nombre); }
  if (hoja.getLastRow() === 0) {
    hoja.appendRow(encabezados);
    hoja.getRange(1, 1, 1, encabezados.length).setFontWeight('bold');
    hoja.setFrozenRows(1);
  }
  return hoja;
}

function obtenerCarpetaEntregas_() {
  var it = DriveApp.getFoldersByName(CARPETA_ENTREGAS);
  return it.hasNext() ? it.next() : DriveApp.createFolder(CARPETA_ENTREGAS);
}

// Devuelve (creando si hace falta) la subcarpeta de una entrega:
// una por Tarea/Actividad y unidad. Ej: "Tarea — Unidad 1", "Actividad IA — Unidad 3".
function carpetaDeEntrega_(parent, categoria, unidad) {
  var etiqueta = (categoria === 'actividad_ia') ? 'Actividad IA' : 'Tarea';
  var nombre = etiqueta + ' — Unidad ' + (unidad || '');
  var it = parent.getFoldersByName(nombre);
  return it.hasNext() ? it.next() : parent.createFolder(nombre);
}

function json_(obj) {
  return ContentService.createTextOutput(JSON.stringify(obj)).setMimeType(ContentService.MimeType.JSON);
}

function escapeHtml_(s) {
  return String(s == null ? '' : s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

// Confirmación de recibido de una entrega (Tarea / Actividad IA).
function enviarCorreoEntrega_(d, nombreArchivo) {
  var cat = d.categoria === 'actividad_ia' ? 'Actividad con IA' : 'Tarea';
  var html =
    '<div style="font-family:Segoe UI,Arial,sans-serif;max-width:640px;margin:auto;color:#1b1d29;">' +
      '<h2 style="color:#3a3acb;margin-bottom:4px;">Entrega recibida &#10004;</h2>' +
      '<p style="color:#88898c;margin-top:0;">Curso Nivelatorio de R · CIENFI — Universidad Icesi</p>' +
      '<p>Hola ' + escapeHtml_(d.nombre || '') + ' (código ' + escapeHtml_(d.codigo || '') + '),</p>' +
      '<p>Recibimos tu <strong>' + cat + ' — Unidad ' + escapeHtml_(String(d.unidad || '')) + '</strong>. Estos son los datos del registro:</p>' +
      '<ul>' +
        '<li><strong>Archivo:</strong> ' + escapeHtml_(nombreArchivo) + '</li>' +
        '<li><strong>Fecha:</strong> ' + Utilities.formatDate(new Date(), Session.getScriptTimeZone(), 'yyyy-MM-dd HH:mm') + '</li>' +
      '</ul>' +
      '<p>Quedó guardada correctamente. Si vuelves a subir un archivo, se registra como una nueva versión.</p>' +
      '<p style="color:#88898c;font-size:12px;margin-top:22px;">Este correo es automático. Dudas: efmartinez@icesi.edu.co</p>' +
    '</div>';
  MailApp.sendEmail({
    to: d.correo,
    subject: 'Entrega recibida — ' + cat + ' Unidad ' + (d.unidad || '') + ' (Curso Nivelatorio de R)',
    htmlBody: html
  });
}

// Envía al estudiante un correo con su puntaje y las respuestas correctas.
function enviarCorreoFeedback_(d) {
  var filas = (d.detalle || []).map(function (q) {
    var ok = q.acierto;
    var color = ok ? '#2f9460' : '#c2552f';
    var icono = ok ? '&#10004;' : '&#10008;';
    return '<tr>' +
      '<td style="padding:6px 8px;border-bottom:1px solid #eee;">' + q.n + '</td>' +
      '<td style="padding:6px 8px;border-bottom:1px solid #eee;">' + escapeHtml_(q.enunciado) + '</td>' +
      '<td style="padding:6px 8px;border-bottom:1px solid #eee;">' + escapeHtml_(q.respuesta) + '</td>' +
      '<td style="padding:6px 8px;border-bottom:1px solid #eee;font-weight:bold;">' + escapeHtml_(q.correcta) + '</td>' +
      '<td style="padding:6px 8px;border-bottom:1px solid #eee;color:' + color + ';font-weight:bold;text-align:center;">' + icono + '</td>' +
    '</tr>';
  }).join('');
  var html =
    '<div style="font-family:Segoe UI,Arial,sans-serif;max-width:720px;margin:auto;color:#1b1d29;">' +
      '<h2 style="color:#3a3acb;margin-bottom:4px;">' + escapeHtml_(d.parte || 'Cuestionario') + '</h2>' +
      '<p style="color:#88898c;margin-top:0;">Curso Nivelatorio de R · CIENFI — Universidad Icesi</p>' +
      '<p>Hola ' + escapeHtml_(d.nombre || '') + ' (código ' + escapeHtml_(d.codigo || '') + '), este es el resultado de tu <strong>intento ' + d.intento + '</strong>:</p>' +
      '<p style="font-size:22px;"><strong>' + d.puntaje + '%</strong> — ' + (d.aprobado ? 'Aprobado' : 'No aprobado') +
        ' <span style="color:#88898c;font-size:15px;">(' + d.correctas + ' de ' + d.total + ' correctas)</span></p>' +
      '<p>Estas son las <strong>respuestas correctas</strong> para que repases:</p>' +
      '<table style="border-collapse:collapse;width:100%;font-size:13px;">' +
        '<tr style="background:#5454e9;color:#fff;text-align:left;">' +
          '<th style="padding:6px 8px;">#</th><th style="padding:6px 8px;">Pregunta</th>' +
          '<th style="padding:6px 8px;">Tu respuesta</th><th style="padding:6px 8px;">Respuesta correcta</th>' +
          '<th style="padding:6px 8px;">&nbsp;</th>' +
        '</tr>' + filas +
      '</table>' +
      '<p style="color:#88898c;font-size:12px;margin-top:22px;">Este correo es automático. Si tienes dudas, escribe a efmartinez@icesi.edu.co</p>' +
    '</div>';
  MailApp.sendEmail({
    to: d.correo,
    subject: 'Resultados — ' + (d.parte || 'Cuestionario') + ' (Curso Nivelatorio de R)',
    htmlBody: html
  });
}
