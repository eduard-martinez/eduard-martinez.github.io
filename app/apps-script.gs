/**
 * Diagnóstico Empresarial 3i - Apps Script V3.2
 * Consolidación incremental limpia por empresa, entrevistador y nodo.
 * Esta versión usa la hoja Respuestas para la base limpia.
 * Si detecta una hoja Respuestas heredada con JSON/metadatos, la archiva y crea una nueva Respuestas limpia.
 * Pegar este archivo completo en Código.gs y volver a implementar como App web.
 */

const SHEET_ID = '1orUQAFlKKRkKbJmSfFUilY40D2j7pRpk2HqMji-aBYg';
const CLEAN_SHEET_NAME = 'Respuestas';
const LEGACY_ARCHIVE_PREFIX = 'Respuestas_Anterior';
const APP_VERSION = '3.2.0';
const DEFAULT_NODE_IDS = ['P', 'INN', 'INV', 'INT'];
const BASE_HEADERS = [
  'id_entrevista_base',
  'id_empresa',
  'empresa',
  'id_entrevistador',
  'entrevistador',
  'P',
  'INN',
  'INV',
  'INT',
  'porcentaje_nodos',
  'consolidado_completo',
  'ultima_modificacion'
];

function doGet(e) {
  const params = e && e.parameter ? e.parameter : {};
  const action = params.action || 'status';
  let result;

  if (action === 'listar_consolidado') {
    result = listarConsolidado_();
  } else {
    result = {
      ok: true,
      app: 'Diagnóstico Empresarial 3i',
      status: 'Apps Script activo',
      version: APP_VERSION,
      sheet: CLEAN_SHEET_NAME
    };
  }

  return output_(result, params.callback);
}

function doPost(e) {
  const lock = LockService.getScriptLock();
  lock.waitLock(30000);
  try {
    const payload = JSON.parse(e.postData && e.postData.contents ? e.postData.contents : '{}');
    let result;

    if (payload.action === 'enviar_nodo') {
      result = enviarNodo_(payload);
    } else if (payload.action === 'eliminar_nodo') {
      result = eliminarNodo_(payload);
    } else if (payload.action === 'eliminar_entrevista') {
      result = eliminarEntrevista_(payload);
    } else {
      result = { ok: false, error: 'Acción no reconocida', action: payload.action || '' };
    }

    return output_(result);
  } catch (error) {
    return output_({ ok: false, error: error.message, stack: error.stack });
  } finally {
    lock.releaseLock();
  }
}

function enviarNodo_(payload) {
  validarPayloadBase_(payload);
  const sheet = getCleanSheet_();
  const nodeIds = getNodeIds_(payload);
  const allQuestions = Array.isArray(payload.allQuestions) ? payload.allQuestions : [];
  const questionHeaders = allQuestions.map(q => q.key).filter(Boolean);
  const headers = ensureHeaders_(sheet, BASE_HEADERS.concat(questionHeaders));
  const rowInfo = getOrCreateRow_(sheet, headers, payload);
  const rowObject = rowInfo.rowObject;

  rowObject.id_entrevista_base = payload.id_entrevista_base;
  rowObject.id_empresa = payload.id_empresa;
  rowObject.empresa = payload.empresa || '';
  rowObject.id_entrevistador = payload.id_entrevistador;
  rowObject.entrevistador = payload.entrevistador || '';
  rowObject.ultima_modificacion = fechaLocal_(payload.fecha_envio || new Date());

  nodeIds.forEach(id => {
    if (!rowObject[id]) rowObject[id] = 'NA';
  });
  rowObject[payload.nodo] = 'OK';

  const answers = payload.answers || {};
  allQuestions.forEach(q => {
    if (!q || !q.key) return;
    if (q.nodeId === payload.nodo) {
      rowObject[q.key] = cleanAnswer_(answers[q.key]);
    } else if (isBlank_(rowObject[q.key])) {
      rowObject[q.key] = 'NA';
    }
  });

  actualizarConsolidacion_(rowObject, nodeIds);
  writeRowObject_(sheet, headers, rowInfo.rowNumber, rowObject);

  return {
    ok: true,
    message: 'Nodo consolidado correctamente',
    id_entrevista_base: payload.id_entrevista_base,
    nodo: payload.nodo,
    rowNumber: rowInfo.rowNumber
  };
}

function eliminarNodo_(payload) {
  validarPayloadBase_(payload);
  const sheet = getCleanSheet_();
  const allQuestions = Array.isArray(payload.allQuestions) ? payload.allQuestions : [];
  const questionHeaders = allQuestions.map(q => q.key).filter(Boolean);
  const headers = ensureHeaders_(sheet, BASE_HEADERS.concat(questionHeaders));
  const found = findRow_(sheet, headers, payload.id_entrevista_base, payload.id_empresa, payload.id_entrevistador);
  if (!found) return { ok: true, message: 'No existía fila remota para eliminar nodo' };

  const rowObject = found.rowObject;
  rowObject[payload.nodo] = 'NA';
  rowObject.ultima_modificacion = fechaLocal_(payload.fecha_envio || new Date());
  allQuestions.forEach(q => {
    if (q && q.nodeId === payload.nodo && q.key) rowObject[q.key] = 'NA';
  });
  actualizarConsolidacion_(rowObject, getNodeIds_(payload));
  writeRowObject_(sheet, headers, found.rowNumber, rowObject);
  return { ok: true, message: 'Nodo eliminado del consolidado', nodo: payload.nodo };
}

function eliminarEntrevista_(payload) {
  validarPayloadBase_(payload);
  const sheet = getCleanSheet_();
  const headers = ensureHeaders_(sheet, BASE_HEADERS);
  const found = findRow_(sheet, headers, payload.id_entrevista_base, payload.id_empresa, payload.id_entrevistador);
  if (found) sheet.deleteRow(found.rowNumber);
  return { ok: true, message: 'Entrevista eliminada del consolidado', id_entrevista_base: payload.id_entrevista_base };
}

function listarConsolidado_() {
  const sheet = getCleanSheet_();
  const lastRow = sheet.getLastRow();
  const lastCol = sheet.getLastColumn();
  if (lastRow < 2 || lastCol < 1) return { ok: true, version: APP_VERSION, rows: [] };
  const values = sheet.getRange(1, 1, lastRow, lastCol).getDisplayValues();
  const headers = values[0];
  const keep = BASE_HEADERS;
  const rows = values.slice(1).filter(r => r.some(Boolean)).map(r => {
    const obj = {};
    keep.forEach(h => {
      const idx = headers.indexOf(h);
      obj[h] = idx >= 0 ? r[idx] : '';
    });
    return obj;
  });
  return { ok: true, version: APP_VERSION, rows: rows };
}

function getCleanSheet_() {
  const ss = SpreadsheetApp.openById(SHEET_ID);
  let sheet = ss.getSheetByName(CLEAN_SHEET_NAME);

  if (sheet && isLegacyDirtySheet_(sheet)) {
    const stamp = Utilities.formatDate(new Date(), 'America/Bogota', 'yyyyMMdd_HHmmss');
    let archiveName = LEGACY_ARCHIVE_PREFIX + '_' + stamp;
    let counter = 1;
    while (ss.getSheetByName(archiveName)) {
      archiveName = LEGACY_ARCHIVE_PREFIX + '_' + stamp + '_' + counter;
      counter++;
    }
    sheet.setName(archiveName);
    sheet = null;
  }

  if (!sheet) sheet = ss.insertSheet(CLEAN_SHEET_NAME);
  return sheet;
}

function isLegacyDirtySheet_(sheet) {
  const lastCol = sheet.getLastColumn();
  if (lastCol === 0) return false;
  const headers = sheet.getRange(1, 1, 1, lastCol).getValues()[0].map(String);
  const legacyMarkers = ['recibido_en', 'timestamp', 'submissionId', 'interviewGroupId', 'datosEmpresa_json', 'respuestas_json'];
  return legacyMarkers.some(h => headers.indexOf(h) !== -1);
}

function ensureHeaders_(sheet, incomingHeaders) {
  const uniqueIncoming = [];
  incomingHeaders.forEach(h => {
    const clean = String(h || '').trim();
    if (clean && uniqueIncoming.indexOf(clean) === -1) uniqueIncoming.push(clean);
  });

  const lastCol = sheet.getLastColumn();
  if (lastCol === 0) {
    sheet.getRange(1, 1, 1, uniqueIncoming.length).setValues([uniqueIncoming]);
    formatHeader_(sheet, uniqueIncoming.length);
    return uniqueIncoming;
  }

  const existing = sheet.getRange(1, 1, 1, lastCol).getValues()[0].map(String);
  const missing = uniqueIncoming.filter(h => existing.indexOf(h) === -1);
  if (missing.length) {
    sheet.getRange(1, existing.length + 1, 1, missing.length).setValues([missing]);
    formatHeader_(sheet, existing.length + missing.length);
  }
  return existing.concat(missing);
}

function getOrCreateRow_(sheet, headers, payload) {
  const found = findRow_(sheet, headers, payload.id_entrevista_base, payload.id_empresa, payload.id_entrevistador);
  if (found) return found;

  const rowNumber = Math.max(sheet.getLastRow() + 1, 2);
  const rowObject = {};
  headers.forEach(h => rowObject[h] = '');
  rowObject.id_entrevista_base = payload.id_entrevista_base;
  rowObject.id_empresa = payload.id_empresa;
  rowObject.empresa = payload.empresa || '';
  rowObject.id_entrevistador = payload.id_entrevistador;
  rowObject.entrevistador = payload.entrevistador || '';
  return { rowNumber: rowNumber, rowObject: rowObject };
}

function findRow_(sheet, headers, baseId, idEmpresa, idEntrevistador) {
  const lastRow = sheet.getLastRow();
  const lastCol = sheet.getLastColumn();
  if (lastRow < 2 || lastCol < 1) return null;
  const values = sheet.getRange(2, 1, lastRow - 1, lastCol).getValues();
  const idxBase = headers.indexOf('id_entrevista_base');
  const idxEmpresa = headers.indexOf('id_empresa');
  const idxEnt = headers.indexOf('id_entrevistador');
  for (let i = 0; i < values.length; i++) {
    const row = values[i];
    const sameBase = idxBase >= 0 && String(row[idxBase]) === String(baseId);
    const samePair = idxEmpresa >= 0 && idxEnt >= 0 && String(row[idxEmpresa]) === String(idEmpresa) && String(row[idxEnt]) === String(idEntrevistador);
    if (sameBase || samePair) {
      const obj = {};
      headers.forEach((h, j) => obj[h] = row[j]);
      return { rowNumber: i + 2, rowObject: obj };
    }
  }
  return null;
}

function writeRowObject_(sheet, headers, rowNumber, rowObject) {
  const row = headers.map(h => rowObject[h] !== undefined && rowObject[h] !== null && rowObject[h] !== '' ? rowObject[h] : 'NA');
  // Identificadores base no deben quedar como NA si vienen vacíos por error.
  ['id_entrevista_base', 'id_empresa', 'empresa', 'id_entrevistador', 'entrevistador', 'ultima_modificacion'].forEach(h => {
    const idx = headers.indexOf(h);
    if (idx >= 0 && rowObject[h] !== undefined) row[idx] = rowObject[h];
  });
  sheet.getRange(rowNumber, 1, 1, headers.length).setValues([row]);
  sheet.autoResizeColumns(1, Math.min(headers.length, 20));
}

function actualizarConsolidacion_(rowObject, nodeIds) {
  let ok = 0;
  nodeIds.forEach(id => {
    if (!rowObject[id]) rowObject[id] = 'NA';
    if (String(rowObject[id]).toUpperCase() === 'OK') ok += 1;
  });
  rowObject.porcentaje_nodos = nodeIds.length ? Math.round((ok / nodeIds.length) * 100) : 0;
  rowObject.consolidado_completo = ok === nodeIds.length ? 'SI' : 'NO';
}

function getNodeIds_(payload) {
  const ids = Array.isArray(payload.requiredNodeIds) && payload.requiredNodeIds.length ? payload.requiredNodeIds : DEFAULT_NODE_IDS;
  return ids.map(String).filter(Boolean);
}

function validarPayloadBase_(payload) {
  if (!payload) throw new Error('Payload vacío');
  if (!payload.id_empresa) throw new Error('Falta id_empresa');
  if (!payload.id_entrevistador) throw new Error('Falta id_entrevistador');
  if (!payload.id_entrevista_base) payload.id_entrevista_base = payload.id_empresa + '_' + payload.id_entrevistador;
}

function cleanAnswer_(value) {
  if (value === undefined || value === null) return 'NA';
  const text = String(value).trim();
  return text ? text : 'NA';
}

function isBlank_(value) {
  return value === undefined || value === null || String(value).trim() === '';
}

function fechaLocal_(value) {
  const d = value instanceof Date ? value : new Date(value);
  if (isNaN(d.getTime())) return Utilities.formatDate(new Date(), 'America/Bogota', 'yyyy-MM-dd HH:mm:ss');
  return Utilities.formatDate(d, 'America/Bogota', 'yyyy-MM-dd HH:mm:ss');
}

function formatHeader_(sheet, cols) {
  const range = sheet.getRange(1, 1, 1, cols);
  range.setFontWeight('bold');
  range.setBackground('#5454E9');
  range.setFontColor('#FFFFFF');
  range.setWrap(true);
  sheet.setFrozenRows(1);
}

function output_(obj, callback) {
  const text = callback ? String(callback) + '(' + JSON.stringify(obj) + ');' : JSON.stringify(obj);
  return ContentService
    .createTextOutput(text)
    .setMimeType(callback ? ContentService.MimeType.JAVASCRIPT : ContentService.MimeType.JSON);
}

function pruebaManual() {
  const payload = {
    action: 'enviar_nodo',
    appVersion: APP_VERSION,
    id_entrevista_base: '001_879',
    id_nodo_envio: '001_879_INN',
    id_empresa: '001',
    empresa: 'DENIM FACTORY S.A',
    id_entrevistador: '879',
    entrevistador: 'LEONARDO',
    nodo: 'INN',
    nodo_nombre: 'Innovación',
    fecha_envio: new Date().toISOString(),
    requiredNodeIds: ['P', 'INN', 'INV', 'INT'],
    allQuestions: [
      { key: 'INN | Pregunta de prueba', nodeId: 'INN', questionId: 'INN-1', question: 'Pregunta de prueba' },
      { key: 'INV | Pregunta inversión prueba', nodeId: 'INV', questionId: 'INV-1', question: 'Pregunta inversión prueba' }
    ],
    answers: {
      'INN | Pregunta de prueba': 'Respuesta seleccionada'
    }
  };
  doPost({ postData: { contents: JSON.stringify(payload) } });
}
