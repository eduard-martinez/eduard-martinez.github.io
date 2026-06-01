(function () {
  'use strict';

  const INSTRUMENT = window.INSTRUMENTO_3I || {};
  const CONFIG = window.APP_CONFIG_3I || { users: [], companyDirectory: [], requiredNodeIds: ['P', 'INN', 'INV', 'INT'], nodeNames: {} };
  const APP_VERSION = CONFIG.appVersion || '3.2.0';

  const INTERVIEWS_KEY = 'ccc3i_interviews_v3';
  const CURRENT_USER_KEY = 'ccc3i_current_user_v3';
  const CURRENT_INTERVIEW_KEY = 'ccc3i_current_interview_v3';
  const QUEUE_KEY = 'ccc3i_sync_queue_v3';
  const REMOTE_ROWS_KEY = 'ccc3i_remote_rows_v3';
  const LEGACY_KEYS = ['ccc3i_interviews_v2', 'ccc3i_final_sync_queue_v2', 'ccc3i_progress_sync_queue_v2'];

  const NODE_STATUS = { pending: 'Pendiente', progress: 'En progreso', done: 'Finalizado', sent: 'Enviado' };
  const dom = {};
  let session = null;
  let interviews = {};
  let remoteRows = [];
  let state = null;
  let saveTimer = null;
  let syncing = false;

  document.addEventListener('DOMContentLoaded', init);

  function init() {
    cacheDom();
    bindEvents();
    interviews = loadInterviews();
    remoteRows = loadRemoteRows();
    updateConnectionStatus();
    updateQueueStatus();

    const saved = getSavedUser();
    if (saved) startSession(saved.id, false);
    else showLogin();

    window.addEventListener('online', function () { updateConnectionStatus(); retryQueue(); if (session) fetchRemoteRows(); });
    window.addEventListener('offline', updateConnectionStatus);
    setInterval(function () { if (navigator.onLine) retryQueue(); }, 30000);
  }

  function cacheDom() {
    ['login-view','login-form','login-code','app-shell','welcome-title','role-subtitle','current-user-pill','connection-status','btn-dashboard','btn-retry-sync','btn-download-backup','backup-file','btn-logout','surveyor-dashboard','admin-dashboard','dashboard-title','btn-refresh-remote','stat-total','stat-pending','stat-progress','stat-completed','new-interview-form','new-company-id','new-company-name','company-lookup-hint','interview-list','btn-admin-refresh','admin-total','admin-complete','admin-incomplete','admin-percent','admin-table','interview-view','btn-back-dashboard','btn-delete-interview','interview-id','active-company-id','active-company-name','autosave-status','node-list','module-list','queue-status','company-id-display','surveyor-id-display','surveyor-name-display','created-at-display','updated-at-display','company-form','node-label','interviewee-name','interviewee-role','interview-date','current-node-title','current-module-title','module-progress-text','module-progress-bar','skip-warning','question-list','btn-prev-module','btn-next-module','btn-delete-node','btn-submit-node','btn-submit-all','toast'].forEach(function (id) {
      dom[toCamel(id)] = document.getElementById(id);
    });
  }

  function bindEvents() {
    dom.loginForm.addEventListener('submit', function (event) {
      event.preventDefault();
      const code = normalizeLoginCode(dom.loginCode.value);
      const user = findUser(code);
      if (!user) {
        window.alert('Código no autorizado. Verifique los últimos tres dígitos registrados para el proyecto.');
        return;
      }
      startSession(user.id, true);
    });

    dom.btnDashboard.addEventListener('click', showDashboard);
    dom.btnBackDashboard.addEventListener('click', showDashboard);
    dom.btnLogout.addEventListener('click', logout);
    dom.btnRetrySync.addEventListener('click', retryQueue);
    dom.btnRefreshRemote.addEventListener('click', fetchRemoteRows);
    dom.btnAdminRefresh.addEventListener('click', fetchRemoteRows);
    dom.btnDownloadBackup.addEventListener('click', downloadBackup);
    dom.backupFile.addEventListener('change', restoreBackup);
    dom.btnDeleteInterview.addEventListener('click', deleteCurrentInterview);
    dom.btnDeleteNode.addEventListener('click', deleteCurrentNode);
    dom.btnPrevModule.addEventListener('click', function () { moveModule(-1); });
    dom.btnNextModule.addEventListener('click', function () { moveModule(1); });
    dom.btnSubmitNode.addEventListener('click', submitCurrentNode);
    dom.btnSubmitAll.addEventListener('click', submitFullCompany);

    dom.newCompanyId.addEventListener('input', onCompanyIdLookup);
    dom.newInterviewForm.addEventListener('submit', function (event) {
      event.preventDefault();
      createInterviewFromForm();
    });

    [dom.intervieweeName, dom.intervieweeRole, dom.interviewDate].forEach(function (input) {
      input.addEventListener('input', onIntervieweeChange);
      input.addEventListener('change', onIntervieweeChange);
    });
    dom.questionList.addEventListener('input', onQuestionChange);
    dom.questionList.addEventListener('change', onQuestionChange);
  }

  function showLogin() {
    dom.loginView.classList.remove('hidden');
    dom.appShell.classList.add('hidden');
    dom.loginCode.value = '';
    setTimeout(function () { dom.loginCode.focus(); }, 30);
  }

  function startSession(code, refreshRemote) {
    const user = findUser(code);
    if (!user) return showLogin();
    session = user;
    localStorage.setItem(CURRENT_USER_KEY, JSON.stringify(user));
    dom.loginView.classList.add('hidden');
    dom.appShell.classList.remove('hidden');
    dom.welcomeTitle.textContent = 'Bienvenido ' + user.name;
    dom.roleSubtitle.textContent = user.role === 'admin' ? 'Perfil administrador · Seguimiento general' : 'Perfil entrevistador · Captura de campo';
    dom.currentUserPill.textContent = user.role === 'admin' ? 'Administrador: ' + user.name : 'Entrevistador: ' + user.name + ' (' + user.id + ')';
    state = null;
    if (refreshRemote) fetchRemoteRows();
    retryQueue();
    showDashboard();
  }

  function logout() {
    saveCurrentInterview();
    state = null;
    session = null;
    localStorage.removeItem(CURRENT_USER_KEY);
    localStorage.removeItem(CURRENT_INTERVIEW_KEY);
    showLogin();
  }

  function showDashboard() {
    saveCurrentInterview();
    state = null;
    localStorage.removeItem(CURRENT_INTERVIEW_KEY);
    dom.interviewView.classList.add('hidden');
    if (session && session.role === 'admin') {
      dom.surveyorDashboard.classList.add('hidden');
      dom.adminDashboard.classList.remove('hidden');
      renderAdminDashboard();
    } else {
      dom.adminDashboard.classList.add('hidden');
      dom.surveyorDashboard.classList.remove('hidden');
      renderSurveyorDashboard();
    }
    updateQueueStatus();
  }

  function showInterview(baseId) {
    const interview = interviews[baseId];
    if (!interview) return showToast('No se encontró la entrevista.');
    if (!session || session.role !== 'surveyor') return;
    if (interview.idEntrevistador !== session.id) return window.alert('Esta entrevista pertenece a otro entrevistador.');
    state = interview;
    ensureInterviewDefaults(state);
    localStorage.setItem(CURRENT_INTERVIEW_KEY, state.baseId);
    dom.surveyorDashboard.classList.add('hidden');
    dom.adminDashboard.classList.add('hidden');
    dom.interviewView.classList.remove('hidden');
    renderInterview();
  }

  function renderSurveyorDashboard() {
    const list = getInterviewsForCurrentSurveyor();
    const summary = summarizeInterviews(list);
    dom.dashboardTitle.textContent = 'Mis entrevistas · ' + session.name;
    dom.statTotal.textContent = summary.total;
    dom.statPending.textContent = summary.pending;
    dom.statProgress.textContent = summary.progress;
    dom.statCompleted.textContent = summary.completed;
    if (!list.length) {
      dom.interviewList.innerHTML = '<p class="hint">Todavía no hay entrevistas locales para este entrevistador.</p>';
      return;
    }
    dom.interviewList.innerHTML = list.map(function (interview) {
      const statuses = getNodeStatuses(interview);
      const percent = getInterviewPercent(interview);
      const chips = statuses.map(function (item) {
        return '<span class="node-chip ' + nodeStateClass(item.status) + '">' + item.node.id + ': ' + item.label + '</span>';
      }).join('');
      return '<article class="interview-card">' +
        '<div class="interview-main"><div><h3>' + escapeHtml(interview.empresaName) + '</h3>' +
        '<div class="interview-meta">ID empresa: <strong>' + escapeHtml(interview.idEmpresa) + '</strong> · ID entrevista: <strong>' + escapeHtml(interview.baseId) + '</strong><br>Última modificación: ' + formatDateTime(interview.lastModifiedAt) + '</div></div>' +
        '<div class="card-actions"><button class="btn btn-primary" data-open="' + escapeHtml(interview.baseId) + '">Abrir / continuar</button><button class="btn btn-danger-outline" data-delete="' + escapeHtml(interview.baseId) + '">Eliminar</button></div></div>' +
        '<div class="percentbar"><span style="width:' + percent + '%"></span></div>' +
        '<div class="node-state-row">' + chips + '</div>' +
        '<div class="interview-meta">Avance: ' + percent + '% · Estado: ' + statusLabel(computeInterviewStatus(interview)) + '</div>' +
      '</article>';
    }).join('');
    dom.interviewList.querySelectorAll('[data-open]').forEach(function (btn) { btn.addEventListener('click', function () { showInterview(btn.getAttribute('data-open')); }); });
    dom.interviewList.querySelectorAll('[data-delete]').forEach(function (btn) { btn.addEventListener('click', function () { deleteInterviewById(btn.getAttribute('data-delete')); }); });
  }

  function renderAdminDashboard() {
    const rows = remoteRows.slice().sort(function (a, b) { return String(a.id_empresa || '').localeCompare(String(b.id_empresa || '')); });
    const total = rows.length;
    const complete = rows.filter(function (r) { return String(r.consolidado_completo || '').toUpperCase() === 'SI'; }).length;
    const avg = total ? Math.round(rows.reduce(function (sum, r) { return sum + Number(r.porcentaje_nodos || 0); }, 0) / total) : 0;
    dom.adminTotal.textContent = total;
    dom.adminComplete.textContent = complete;
    dom.adminIncomplete.textContent = Math.max(0, total - complete);
    dom.adminPercent.textContent = avg + '%';
    const nodeIds = getOperationalNodeIds();
    const header = ['Empresa', 'Entrevistador'].concat(nodeIds).concat(['% avance', 'Completa', 'Última modificación']);
    let html = '<thead><tr>' + header.map(function (h) { return '<th>' + escapeHtml(h) + '</th>'; }).join('') + '</tr></thead><tbody>';
    if (!rows.length) {
      html += '<tr><td colspan="' + header.length + '">No hay datos remotos cargados. Use “Actualizar consolidado”.</td></tr>';
    } else {
      html += rows.map(function (r) {
        return '<tr>' +
          '<td><strong>' + escapeHtml(r.id_empresa || '') + '</strong> · ' + escapeHtml(r.empresa || '') + '</td>' +
          '<td>' + escapeHtml((r.id_entrevistador || '') + ' · ' + (r.entrevistador || '')) + '</td>' +
          nodeIds.map(function (n) { return statusCell(r[n]); }).join('') +
          '<td>' + escapeHtml(r.porcentaje_nodos || '0') + '%</td>' +
          '<td>' + escapeHtml(r.consolidado_completo || 'NO') + '</td>' +
          '<td>' + escapeHtml(r.ultima_modificacion || '') + '</td>' +
        '</tr>';
      }).join('');
    }
    html += '</tbody>';
    dom.adminTable.innerHTML = html;
  }

  function renderInterview() {
    if (!state) return;
    ensureInterviewDefaults(state);
    const node = getCurrentNode();
    const module = getCurrentModule();
    dom.interviewId.value = state.baseId;
    dom.activeCompanyId.value = state.idEmpresa;
    dom.activeCompanyName.value = state.empresaName;
    dom.companyIdDisplay.value = state.idEmpresa;
    dom.surveyorIdDisplay.value = state.idEntrevistador;
    dom.surveyorNameDisplay.value = state.encuestadorNombre;
    dom.createdAtDisplay.value = formatDateTime(state.createdAt);
    dom.updatedAtDisplay.value = formatDateTime(state.lastModifiedAt);
    dom.nodeLabel.value = node.id + ' · ' + node.name;
    const interviewee = state.interviewees[node.id] || defaultInterviewee();
    dom.intervieweeName.value = interviewee.nombre || '';
    dom.intervieweeRole.value = interviewee.cargo || '';
    dom.interviewDate.value = interviewee.fecha || todayInputValue();
    renderCompanyForm();
    renderNodeList();
    renderModuleList();
    renderQuestions();
    renderProgress();
    updateQueueStatus();
    dom.autosaveStatus.textContent = 'Guardado local activo. Última modificación: ' + formatDateTime(state.lastModifiedAt) + '. La base solo se actualiza al enviar nodo.';
    dom.currentNodeTitle.textContent = node.id + ' · ' + node.name;
    dom.currentModuleTitle.textContent = module ? module.title : node.name;
  }

  function renderCompanyForm() {
    const fields = getProfileFields();
    dom.companyForm.innerHTML = fields.map(function (field) {
      const value = state.company[field.id] || '';
      const readonly = field.id === 'razon_social' || field.id === 'id_empresa';
      return '<div class="field"><label>' + escapeHtml(field.label) + (field.required ? ' *' : '') + '</label><input data-company-field="' + escapeHtml(field.id) + '" type="' + inputType(field.type) + '" value="' + escapeHtml(value) + '" ' + (readonly ? 'readonly' : '') + '></div>';
    }).join('');
    dom.companyForm.querySelectorAll('[data-company-field]').forEach(function (input) {
      input.addEventListener('input', onCompanyFieldChange);
      input.addEventListener('change', onCompanyFieldChange);
    });
  }

  function renderNodeList() {
    const statuses = getNodeStatuses(state);
    dom.nodeList.innerHTML = statuses.map(function (item) {
      const active = item.node.id === state.currentNodeId ? ' active' : '';
      return '<button class="node-button' + active + '" data-node="' + escapeHtml(item.node.id) + '"><span class="label">' + escapeHtml(item.node.id + ' · ' + item.node.name) + '</span><span class="meta">' + item.label + ' · ' + item.progress.answered + '/' + item.progress.required + '</span></button>';
    }).join('');
    dom.nodeList.querySelectorAll('[data-node]').forEach(function (btn) { btn.addEventListener('click', function () { selectNode(btn.getAttribute('data-node')); }); });
  }

  function renderModuleList() {
    const node = getCurrentNode();
    dom.moduleList.innerHTML = node.modules.map(function (module) {
      const progress = getProgressForModule(node, module, state);
      const active = module.id === state.currentModuleId ? ' active' : '';
      return '<button class="module-button' + active + '" data-module="' + escapeHtml(module.id) + '"><span class="label">' + escapeHtml(module.title || module.id) + '</span><span class="meta">' + progress.answered + '/' + progress.required + ' respondidas</span></button>';
    }).join('');
    dom.moduleList.querySelectorAll('[data-module]').forEach(function (btn) { btn.addEventListener('click', function () { state.currentModuleId = btn.getAttribute('data-module'); markModified(); renderInterview(); }); });
  }

  function renderQuestions() {
    const node = getCurrentNode();
    const module = getCurrentModule();
    if (!module) { dom.questionList.innerHTML = '<p class="hint">Este nodo no tiene módulos configurados.</p>'; return; }
    if (node.id === 'P' && !hasRealProfileNode()) {
      dom.skipWarning.classList.add('hidden');
      dom.questionList.innerHTML = '<article class="question-card"><div class="question-text">Nodo P · Perfilamiento</div><p class="hint">Complete y verifique los campos de perfilamiento en la sección “Datos de la entrevista”. Este nodo se envía una sola vez y queda consolidado como P.</p>' + getProfileFields().map(function (field) { return '<div class="question-meta"><strong>' + escapeHtml(field.label) + ':</strong> ' + escapeHtml(state.company[field.id] || 'NA') + '</div>'; }).join('') + '</article>';
      return;
    }
    const skipped = getSkippedQuestions(node, state);
    dom.skipWarning.classList.toggle('hidden', skipped.size === 0);
    dom.skipWarning.textContent = skipped.size ? 'Algunas preguntas fueron omitidas por lógica de pase del instrumento.' : '';
    dom.questionList.innerHTML = module.questions.map(function (question) { return renderQuestionCard(question, skipped.has(question.id)); }).join('');
  }

  function renderQuestionCard(question, skipped) {
    const answer = getQuestionValue(question);
    let fieldHtml = '';
    if (question.type === 'single') {
      fieldHtml = '<div class="option-list">' + (question.options || []).map(function (opt) {
        return '<label class="option-item"><input type="radio" name="' + safeId(question.id) + '" data-question-id="' + escapeHtml(question.id) + '" value="' + escapeHtml(opt.id) + '" ' + (answer === opt.id ? 'checked' : '') + ' ' + (skipped ? 'disabled' : '') + '> <span>' + escapeHtml(opt.raw || opt.label || opt.value) + '</span></label>';
      }).join('') + '</div>';
    } else if (question.type === 'multiple') {
      const values = Array.isArray(answer) ? answer : [];
      fieldHtml = '<div class="option-list">' + (question.options || []).map(function (opt) {
        return '<label class="option-item"><input type="checkbox" data-question-id="' + escapeHtml(question.id) + '" value="' + escapeHtml(opt.id) + '" ' + (values.includes(opt.id) ? 'checked' : '') + ' ' + (skipped ? 'disabled' : '') + '> <span>' + escapeHtml(opt.raw || opt.label || opt.value) + '</span></label>';
      }).join('') + '</div>';
    } else if (question.type === 'textarea') {
      fieldHtml = '<textarea data-question-id="' + escapeHtml(question.id) + '" rows="4" ' + (skipped ? 'disabled' : '') + '>' + escapeHtml(answer || '') + '</textarea>';
    } else {
      fieldHtml = '<input data-question-id="' + escapeHtml(question.id) + '" type="' + inputType(question.type) + '" value="' + escapeHtml(answer || '') + '" ' + (skipped ? 'disabled' : '') + '>';
    }
    return '<article class="question-card ' + (skipped ? 'skipped' : '') + '"><div class="question-text">' + escapeHtml(question.text) + (question.required !== false ? ' *' : '') + '</div><div class="question-meta">' + escapeHtml(question.id) + ' · ' + escapeHtml(getFriendlyType(question.type)) + '</div>' + fieldHtml + '</article>';
  }

  function renderProgress() {
    const node = getCurrentNode();
    const module = getCurrentModule();
    const progress = getProgressForModule(node, module, state);
    const percent = progress.required ? Math.round((progress.answered / progress.required) * 100) : 0;
    dom.moduleProgressText.textContent = progress.answered + '/' + progress.required + ' respondidas';
    dom.moduleProgressBar.style.width = percent + '%';
  }

  function createInterviewFromForm() {
    if (!session || session.role !== 'surveyor') return;
    const idEmpresa = normalizeCompanyId(dom.newCompanyId.value);
    const found = findCompany(idEmpresa);
    if (!idEmpresa || !found) {
      window.alert('Ingrese un ID de empresa válido que exista en el diccionario empresarial.');
      return;
    }
    const baseId = makeBaseId(idEmpresa, session.id);
    if (findActiveDuplicate(baseId)) {
      window.alert('Ya existe una entrevista activa con este ID empresa e ID entrevistador. Abra la entrevista existente desde el listado.');
      return;
    }
    if (remoteRows.some(function (r) { return String(r.id_entrevista_base || '') === baseId && String(r.consolidado_completo || '').toUpperCase() !== 'SI'; })) {
      window.alert('Este ID empresa + entrevistador ya aparece activo en Google Sheets. Actualice/retome el registro existente o elimínelo si fue un error.');
      return;
    }
    const interview = createEmptyInterview(idEmpresa, found.empresa, session);
    interviews[interview.baseId] = interview;
    saveInterviews();
    dom.newCompanyId.value = '';
    dom.newCompanyName.value = '';
    dom.companyLookupHint.textContent = 'Ingrese el ID para autocompletar la razón social.';
    dom.companyLookupHint.className = 'field-hint';
    showInterview(interview.baseId);
    showToast('Entrevista creada. El avance queda guardado localmente.');
  }

  function createEmptyInterview(idEmpresa, empresaName, user) {
    const nodes = getOperationalNodes();
    const now = new Date().toISOString();
    const interviewees = {};
    nodes.forEach(function (node) { interviewees[node.id] = defaultInterviewee(user.name); });
    const company = { id_empresa: idEmpresa, razon_social: empresaName };
    getProfileFields().forEach(function (f) { if (company[f.id] === undefined) company[f.id] = ''; });
    company.id_empresa = idEmpresa;
    company.razon_social = empresaName;
    return { version: 3, appVersion: APP_VERSION, baseId: makeBaseId(idEmpresa, user.id), createdAt: now, lastModifiedAt: now, idEmpresa: idEmpresa, empresaName: empresaName, idEntrevistador: user.id, encuestadorNombre: user.name, currentNodeId: nodes[0].id, currentModuleId: nodes[0].modules[0] ? nodes[0].modules[0].id : '', company: company, responses: {}, interviewees: interviewees, nodeFinalizedIds: [], nodeSentIds: [], deletedNodeIds: [] };
  }

  function ensureInterviewDefaults(interview) {
    interview.version = 3;
    interview.appVersion = APP_VERSION;
    interview.baseId = interview.baseId || makeBaseId(interview.idEmpresa, interview.idEntrevistador);
    interview.company = interview.company || { id_empresa: interview.idEmpresa, razon_social: interview.empresaName || '' };
    interview.company.id_empresa = interview.idEmpresa;
    interview.company.razon_social = interview.company.razon_social || interview.empresaName || '';
    interview.responses = interview.responses || {};
    interview.interviewees = interview.interviewees || {};
    interview.nodeFinalizedIds = interview.nodeFinalizedIds || [];
    interview.nodeSentIds = interview.nodeSentIds || [];
    getOperationalNodes().forEach(function (node) {
      if (!interview.interviewees[node.id]) interview.interviewees[node.id] = defaultInterviewee(interview.encuestadorNombre || interview.idEntrevistador);
    });
    if (!interview.currentNodeId || !getNode(interview.currentNodeId)) interview.currentNodeId = getOperationalNodes()[0].id;
    const node = getNode(interview.currentNodeId);
    if (!interview.currentModuleId || !node.modules.some(function (m) { return m.id === interview.currentModuleId; })) interview.currentModuleId = node.modules[0] ? node.modules[0].id : '';
    interview.lastModifiedAt = interview.lastModifiedAt || interview.createdAt || new Date().toISOString();
  }

  function onCompanyIdLookup() {
    const id = normalizeCompanyId(dom.newCompanyId.value);
    const found = findCompany(id);
    if (found) {
      dom.newCompanyName.value = found.empresa;
      dom.companyLookupHint.textContent = 'Razón social encontrada en el diccionario.';
      dom.companyLookupHint.className = 'field-hint ok';
    } else {
      dom.newCompanyName.value = '';
      dom.companyLookupHint.textContent = id ? 'ID no encontrado en el diccionario empresarial.' : 'Ingrese el ID para autocompletar la razón social.';
      dom.companyLookupHint.className = id ? 'field-hint error' : 'field-hint';
    }
  }

  function onCompanyFieldChange(event) {
    if (!state) return;
    const key = event.target.getAttribute('data-company-field');
    if (!key) return;
    state.company[key] = event.target.value;
    if (key === 'razon_social') state.empresaName = event.target.value;
    markModified();
    renderProgress();
  }

  function onIntervieweeChange(event) {
    if (!state) return;
    const key = event.target.getAttribute('data-interview-field');
    const node = getCurrentNode();
    if (!state.interviewees[node.id]) state.interviewees[node.id] = defaultInterviewee();
    state.interviewees[node.id][key] = event.target.value;
    markModified();
  }

  function onQuestionChange(event) {
    if (!state) return;
    const qid = event.target.getAttribute('data-question-id');
    if (!qid) return;
    const question = getQuestion(qid);
    if (!question) return;
    if (question.sourceField) {
      state.company[question.sourceField] = event.target.value;
      if (question.sourceField === 'razon_social') state.empresaName = event.target.value;
      markModified();
      renderCompanyForm();
      renderProgress();
      return;
    }
    if (question.type === 'multiple') {
      const checked = Array.from(dom.questionList.querySelectorAll('[data-question-id="' + cssEscape(qid) + '"]:checked'));
      state.responses[qid] = checked.map(function (input) { return input.value; });
    } else if (question.type === 'single') {
      state.responses[qid] = event.target.value;
    } else {
      state.responses[qid] = event.target.value;
    }
    removeNodeSentFlags(question.nodeId || getCurrentNode().id);
    clearSkippedResponses();
    markModified();
    renderNodeList();
    renderModuleList();
    renderProgress();
  }

  function selectNode(nodeId) {
    const node = getNode(nodeId);
    if (!node) return;
    state.currentNodeId = node.id;
    state.currentModuleId = node.modules[0] ? node.modules[0].id : '';
    markModified();
    renderInterview();
  }

  function moveModule(direction) {
    const node = getCurrentNode();
    const idx = node.modules.findIndex(function (m) { return m.id === state.currentModuleId; });
    const next = Math.max(0, Math.min(node.modules.length - 1, idx + direction));
    if (node.modules[next]) {
      state.currentModuleId = node.modules[next].id;
      markModified();
      renderInterview();
    }
  }

  function submitCurrentNode() {
    if (!state) return;
    const node = getCurrentNode();
    const issues = validateNode(node.id, state);
    if (issues.length) return showValidationIssues(issues);
    if (!state.nodeFinalizedIds.includes(node.id)) state.nodeFinalizedIds.push(node.id);
    if (!state.nodeSentIds.includes(node.id)) state.nodeSentIds.push(node.id);
    markModified();
    enqueuePayload(buildNodePayload(node.id, state));
    retryQueue();
    renderInterview();
    showToast('Nodo ' + node.id + ' listo para sincronización.');
  }

  function submitFullCompany() {
    if (!state) return;
    const nodes = getOperationalNodes();
    let issues = [];
    nodes.forEach(function (node) { issues = issues.concat(validateNode(node.id, state)); });
    if (issues.length) return showValidationIssues(issues);
    nodes.forEach(function (node) {
      if (!state.nodeFinalizedIds.includes(node.id)) state.nodeFinalizedIds.push(node.id);
      if (!state.nodeSentIds.includes(node.id)) state.nodeSentIds.push(node.id);
      enqueuePayload(buildNodePayload(node.id, state));
    });
    markModified();
    retryQueue();
    renderInterview();
    showToast('Empresa completa enviada por nodos.');
  }

  function deleteCurrentNode() {
    if (!state) return;
    const node = getCurrentNode();
    if (!window.confirm('¿Eliminar solo el nodo ' + node.id + ' de esta entrevista? Esta acción también marcará el nodo como NA en Google Sheets si ya había sido enviado.')) return;
    removeAnswersForNode(node.id, state);
    state.nodeFinalizedIds = state.nodeFinalizedIds.filter(function (id) { return id !== node.id; });
    state.nodeSentIds = state.nodeSentIds.filter(function (id) { return id !== node.id; });
    markModified();
    enqueuePayload(buildDeleteNodePayload(node.id, state));
    retryQueue();
    renderInterview();
    showToast('Nodo eliminado localmente y marcado para actualización remota.');
  }

  function deleteCurrentInterview() {
    if (!state) return;
    deleteInterviewById(state.baseId);
  }

  function deleteInterviewById(baseId) {
    const interview = interviews[baseId];
    if (!interview) return;
    if (!window.confirm('¿Eliminar la entrevista completa de ' + interview.empresaName + '? También se enviará eliminación al consolidado remoto.')) return;
    enqueuePayload(buildDeleteInterviewPayload(interview));
    delete interviews[baseId];
    saveInterviews();
    if (state && state.baseId === baseId) state = null;
    retryQueue();
    showDashboard();
    showToast('Entrevista eliminada localmente y marcada para eliminar en Google Sheets.');
  }

  function validateNode(nodeId, interview) {
    const node = getNode(nodeId);
    if (!node) return ['Nodo no encontrado: ' + nodeId];
    const issues = [];
    if (nodeId === 'P') {
      getProfileFields().forEach(function (field) {
        if (field.required !== false && !String(interview.company[field.id] || '').trim()) issues.push('P · ' + field.label);
      });
      return issues;
    }
    const interviewee = interview.interviewees[nodeId] || {};
    if (!String(interviewee.nombre || '').trim()) issues.push(nodeId + ' · Nombre del entrevistado');
    if (!String(interviewee.cargo || '').trim()) issues.push(nodeId + ' · Cargo del entrevistado');
    if (!String(interviewee.fecha || '').trim()) issues.push(nodeId + ' · Fecha');
    const skipped = getSkippedQuestions(node, interview);
    node.modules.forEach(function (module) {
      module.questions.forEach(function (question) {
        if (skipped.has(question.id)) return;
        if (question.required === false) return;
        if (!isAnswered(question, interview)) issues.push(nodeId + ' · ' + question.id + ' · ' + question.text);
      });
    });
    return issues;
  }

  function showValidationIssues(issues) {
    window.alert('Faltan campos obligatorios antes de enviar:\n\n' + issues.slice(0, 15).join('\n') + (issues.length > 15 ? '\n...' : ''));
  }

  function buildNodePayload(nodeId, interview) {
    const node = getNode(nodeId);
    const allQuestions = collectQuestionColumns();
    const answers = getAnswersForNode(nodeId, interview);
    return { action: 'enviar_nodo', appVersion: APP_VERSION, id_entrevista_base: interview.baseId, id_nodo_envio: makeNodeSubmissionId(interview.idEmpresa, interview.idEntrevistador, nodeId), id_empresa: interview.idEmpresa, empresa: interview.empresaName, id_entrevistador: interview.idEntrevistador, entrevistador: interview.encuestadorNombre, nodo: nodeId, nodo_nombre: node.name, fecha_envio: new Date().toISOString(), requiredNodeIds: getOperationalNodeIds(), nodeStatuses: getNodeStatusMap(interview), allQuestions: allQuestions, answers: answers };
  }

  function buildDeleteNodePayload(nodeId, interview) {
    return { action: 'eliminar_nodo', appVersion: APP_VERSION, id_entrevista_base: interview.baseId, id_empresa: interview.idEmpresa, empresa: interview.empresaName, id_entrevistador: interview.idEntrevistador, entrevistador: interview.encuestadorNombre, nodo: nodeId, fecha_envio: new Date().toISOString(), requiredNodeIds: getOperationalNodeIds(), allQuestions: collectQuestionColumns() };
  }

  function buildDeleteInterviewPayload(interview) {
    return { action: 'eliminar_entrevista', appVersion: APP_VERSION, id_entrevista_base: interview.baseId, id_empresa: interview.idEmpresa, id_entrevistador: interview.idEntrevistador, fecha_envio: new Date().toISOString() };
  }

  function collectQuestionColumns() {
    const rows = [];
    getOperationalNodes().forEach(function (node) {
      node.modules.forEach(function (module) {
        module.questions.forEach(function (q) {
          rows.push({ key: makeQuestionKey(node.id, q), nodeId: node.id, questionId: q.id, question: q.text });
        });
      });
    });
    return rows;
  }

  function getAnswersForNode(nodeId, interview) {
    const answers = {};
    const node = getNode(nodeId);
    const skipped = getSkippedQuestions(node, interview);
    node.modules.forEach(function (module) {
      module.questions.forEach(function (q) {
        const key = makeQuestionKey(nodeId, q);
        answers[key] = skipped.has(q.id) ? 'NA' : answerLabel(q, interview);
      });
    });
    return answers;
  }

  function answerLabel(question, interview) {
    const value = interview.responses[question.id];
    if (question.sourceField) return String(interview.company[question.sourceField] || '').trim() || 'NA';
    if (question.type === 'multiple') {
      const ids = Array.isArray(value) ? value : [];
      if (!ids.length) return 'NA';
      return ids.map(function (id) { const o = (question.options || []).find(function (opt) { return opt.id === id; }); return o ? (o.raw || o.label || o.value) : id; }).join(' | ');
    }
    if (question.type === 'single') {
      const o = (question.options || []).find(function (opt) { return opt.id === value; });
      return o ? (o.raw || o.label || o.value) : 'NA';
    }
    return String(value || '').trim() || 'NA';
  }

  function enqueuePayload(payload) {
    const queue = getQueue();
    queue.push({ queueId: makeId('Q'), createdAt: new Date().toISOString(), attempts: 0, payload: payload });
    setQueue(queue);
    updateQueueStatus();
  }

  async function retryQueue() {
    if (syncing || !navigator.onLine) { updateConnectionStatus(); updateQueueStatus(); return; }
    const queue = getQueue();
    if (!queue.length) { updateConnectionStatus(); updateQueueStatus(); return; }
    syncing = true;
    updateConnectionStatus('Sincronizando...');
    const remaining = [];
    for (const item of queue) {
      try { await sendPayload(item.payload); }
      catch (error) { item.attempts = (item.attempts || 0) + 1; item.lastError = String(error.message || error); remaining.push(item); }
    }
    setQueue(remaining);
    syncing = false;
    updateQueueStatus();
    updateConnectionStatus();
    if (queue.length && !remaining.length) { showToast('Sincronización enviada. Actualice el Sheet para verificar la fila.'); fetchRemoteRows(); }
  }

  async function sendPayload(payload) {
    const url = INSTRUMENT.scriptUrl || CONFIG.defaultScriptUrl;
    if (!url) throw new Error('No hay URL de Apps Script configurada.');
    if (!navigator.onLine) throw new Error('Sin conexión.');
    await verifyRemoteScriptVersion(url);
    await fetch(url, { method: 'POST', mode: 'no-cors', headers: { 'Content-Type': 'text/plain;charset=utf-8' }, body: JSON.stringify(payload) });
    return true;
  }

  async function verifyRemoteScriptVersion(url) {
    const result = await jsonp(url, { action: 'status' });
    const version = result && result.version ? String(result.version) : '';
    if (!result || !result.ok) throw new Error('Apps Script no respondió correctamente.');
    if (!version || version.split('.')[0] !== '3') {
      throw new Error('Apps Script no está actualizado. Abra apps-script.gs, péguelo completo en Código.gs y vuelva a implementar. Versión detectada: ' + (version || 'sin versión'));
    }
    return true;
  }

  function fetchRemoteRows() {
    const url = INSTRUMENT.scriptUrl || CONFIG.defaultScriptUrl;
    if (!url || !navigator.onLine) { renderAdminDashboard(); return; }
    updateConnectionStatus('Consultando Google Sheets...');
    jsonp(url, { action: 'listar_consolidado' }).then(function (result) {
      if (result && result.ok && Array.isArray(result.rows)) {
        const version = result.version ? String(result.version) : '';
        if (!version || version.split('.')[0] !== '3') {
          showToast('Atención: Apps Script no está actualizado. Versión detectada: ' + (version || 'sin versión'));
        }
        remoteRows = result.rows;
        localStorage.setItem(REMOTE_ROWS_KEY, JSON.stringify(remoteRows));
        showToast('Consolidado actualizado desde Google Sheets.');
      }
      updateConnectionStatus();
      if (session && session.role === 'admin') renderAdminDashboard();
      else renderSurveyorDashboard();
    }).catch(function () {
      updateConnectionStatus();
      showToast('No fue posible consultar Google Sheets. Se mantiene la información local.');
    });
  }

  function jsonp(url, params) {
    return new Promise(function (resolve, reject) {
      const callbackName = 'ccc3i_jsonp_' + Date.now() + '_' + Math.round(Math.random() * 100000);
      const query = Object.assign({}, params || {}, { callback: callbackName, t: Date.now() });
      const src = url + (url.indexOf('?') === -1 ? '?' : '&') + Object.keys(query).map(function (k) { return encodeURIComponent(k) + '=' + encodeURIComponent(query[k]); }).join('&');
      const script = document.createElement('script');
      const timer = setTimeout(function () { cleanup(); reject(new Error('Tiempo agotado.')); }, 15000);
      function cleanup() { clearTimeout(timer); delete window[callbackName]; if (script.parentNode) script.parentNode.removeChild(script); }
      window[callbackName] = function (data) { cleanup(); resolve(data); };
      script.onerror = function () { cleanup(); reject(new Error('Error JSONP.')); };
      script.src = src;
      document.body.appendChild(script);
    });
  }

  function getOperationalNodes() {
    const existing = Array.isArray(INSTRUMENT.nodes) ? INSTRUMENT.nodes.map(normalizeNode) : [];
    const hasP = existing.some(function (n) { return n.id === 'P'; });
    const nodes = hasP ? existing : [createProfileNode()].concat(existing);
    const order = CONFIG.requiredNodeIds || ['P', 'INN', 'INV', 'INT'];
    return nodes.sort(function (a, b) {
      const ia = order.indexOf(a.id), ib = order.indexOf(b.id);
      return (ia === -1 ? 99 : ia) - (ib === -1 ? 99 : ib);
    });
  }

  function hasRealProfileNode() { return Array.isArray(INSTRUMENT.nodes) && INSTRUMENT.nodes.some(function (n) { return String(n.id || '').toUpperCase() === 'P'; }); }

  function normalizeNode(node) {
    node.modules = (node.modules || []).map(function (module) {
      module.questions = (module.questions || []).map(function (q) { q.nodeId = node.id; return q; });
      return module;
    });
    return node;
  }

  function createProfileNode() {
    return { id: 'P', name: 'Perfilamiento', title: 'Nodo P — Perfilamiento', modules: [{ id: 'P-1', letter: 'P', title: 'Perfilamiento empresarial', questions: getProfileFields().map(function (field, idx) { return { id: 'P.' + (idx + 1), nodeId: 'P', text: field.label, type: field.type || 'text', required: field.required !== false, sourceField: field.id, options: [] }; }) }] };
  }

  function getProfileFields() {
    const fields = (INSTRUMENT.general && Array.isArray(INSTRUMENT.general.fields)) ? INSTRUMENT.general.fields.slice() : [];
    if (!fields.some(function (f) { return f.id === 'id_empresa'; })) fields.unshift({ id: 'id_empresa', label: 'ID único de empresa', type: 'text', required: true });
    if (!fields.some(function (f) { return f.id === 'razon_social'; })) fields.unshift({ id: 'razon_social', label: 'Razón social', type: 'text', required: true });
    return fields;
  }

  function getOperationalNodeIds() { return getOperationalNodes().map(function (n) { return n.id; }); }
  function getNode(id) { return getOperationalNodes().find(function (n) { return n.id === id; }); }
  function getCurrentNode() { return getNode(state.currentNodeId) || getOperationalNodes()[0]; }
  function getCurrentModule() { const node = getCurrentNode(); return node.modules.find(function (m) { return m.id === state.currentModuleId; }) || node.modules[0]; }
  function getQuestion(qid) { for (const node of getOperationalNodes()) for (const module of node.modules) for (const q of module.questions) if (q.id === qid) return q; return null; }
  function getQuestionValue(question) { if (question.sourceField) return state.company[question.sourceField] || ''; return state.responses[question.id] || (question.type === 'multiple' ? [] : ''); }

  function getProgressForNode(node, interview) { let required = 0, answered = 0; const skipped = getSkippedQuestions(node, interview); node.modules.forEach(function (module) { module.questions.forEach(function (q) { if (q.required === false || skipped.has(q.id)) return; required += 1; if (isAnswered(q, interview)) answered += 1; }); }); return { required: required, answered: answered }; }
  function getProgressForModule(node, module, interview) { if (!module) return { required: 0, answered: 0 }; let required = 0, answered = 0; const skipped = getSkippedQuestions(node, interview); module.questions.forEach(function (q) { if (q.required === false || skipped.has(q.id)) return; required += 1; if (isAnswered(q, interview)) answered += 1; }); return { required: required, answered: answered }; }
  function isAnswered(question, interview) { if (question.sourceField) return !!String(interview.company[question.sourceField] || '').trim(); const v = interview.responses[question.id]; if (question.type === 'multiple') return Array.isArray(v) && v.length > 0; return v !== undefined && v !== null && String(v).trim() !== ''; }
  function getInterviewPercent(interview) { let req = 0, ans = 0; getOperationalNodes().forEach(function (n) { const p = getProgressForNode(n, interview); req += p.required; ans += p.answered; }); return req ? Math.round((ans / req) * 100) : 0; }
  function getNodeStatuses(interview) { return getOperationalNodes().map(function (node) { const progress = getProgressForNode(node, interview); let status = 'pending'; if ((interview.nodeSentIds || []).includes(node.id)) status = 'done'; else if (progress.answered > 0) status = 'progress'; return { node: node, status: status, label: NODE_STATUS[status], progress: progress }; }); }
  function getNodeStatusMap(interview) { const map = {}; getOperationalNodeIds().forEach(function (id) { map[id] = (interview.nodeSentIds || []).includes(id) ? 'OK' : 'NA'; }); return map; }
  function computeInterviewStatus(interview) { const nodes = getOperationalNodeIds(); if (nodes.every(function (id) { return (interview.nodeSentIds || []).includes(id); })) return 'finalizado'; const percent = getInterviewPercent(interview); return percent <= 0 ? 'pendiente' : 'en_progreso'; }

  function getSkippedQuestions(node, interview) {
    const skipped = new Set();
    if (!node || node.id === 'P') return skipped;
    const flat = [];
    node.modules.forEach(function (module, mi) { module.questions.forEach(function (question, qi) { flat.push({ module: module, question: question, mi: mi, qi: qi }); }); });
    flat.forEach(function (item, index) {
      if (skipped.has(item.question.id)) return;
      const selected = selectedOptions(item.question, interview);
      selected.forEach(function (opt) {
        const raw = String(opt.raw || opt.label || '').toUpperCase();
        const match = raw.match(/PASE\s+A\s+M[ÓO]DULO\s+([A-Z])/i);
        if (match) {
          const target = node.modules.findIndex(function (m) { return String(m.letter || '').toUpperCase() === match[1].toUpperCase(); });
          if (target >= 0) {
            flat.slice(index + 1).forEach(function (later) { if (later.mi < target) skipped.add(later.question.id); });
          }
        }
      });
    });
    return skipped;
  }

  function selectedOptions(question, interview) {
    if (!question || !question.options) return [];
    const value = interview.responses[question.id];
    const ids = question.type === 'multiple' ? (Array.isArray(value) ? value : []) : (value ? [value] : []);
    return ids.map(function (id) { return question.options.find(function (o) { return o.id === id; }); }).filter(Boolean);
  }

  function clearSkippedResponses() { const node = getCurrentNode(); const skipped = getSkippedQuestions(node, state); skipped.forEach(function (qid) { delete state.responses[qid]; }); }
  function removeNodeSentFlags(nodeId) { if (!state) return; state.nodeFinalizedIds = (state.nodeFinalizedIds || []).filter(function (id) { return id !== nodeId; }); state.nodeSentIds = (state.nodeSentIds || []).filter(function (id) { return id !== nodeId; }); }
  function removeAnswersForNode(nodeId, interview) { const node = getNode(nodeId); if (!node) return; if (nodeId === 'P') { getProfileFields().forEach(function (f) { if (!['id_empresa','razon_social'].includes(f.id)) interview.company[f.id] = ''; }); return; } node.modules.forEach(function (m) { m.questions.forEach(function (q) { delete interview.responses[q.id]; }); }); }

  function markModified() { if (!state) return; state.lastModifiedAt = new Date().toISOString(); scheduleLocalSave(); }
  function scheduleLocalSave() { clearTimeout(saveTimer); saveTimer = setTimeout(saveCurrentInterview, 350); }
  function saveCurrentInterview() { if (state) { interviews[state.baseId] = state; saveInterviews(); } }
  function loadInterviews() { try { const parsed = JSON.parse(localStorage.getItem(INTERVIEWS_KEY) || '{}'); Object.keys(parsed).forEach(function (k) { ensureInterviewDefaults(parsed[k]); }); return parsed; } catch (e) { return {}; } }
  function saveInterviews() { localStorage.setItem(INTERVIEWS_KEY, JSON.stringify(interviews)); }
  function loadRemoteRows() { try { return JSON.parse(localStorage.getItem(REMOTE_ROWS_KEY) || '[]'); } catch (e) { return []; } }
  function getQueue() { try { return JSON.parse(localStorage.getItem(QUEUE_KEY) || '[]'); } catch (e) { return []; } }
  function setQueue(q) { localStorage.setItem(QUEUE_KEY, JSON.stringify(q)); updateQueueStatus(); }
  function updateQueueStatus() { const q = getQueue(); const count = q.length; const text = count ? count + ' envío(s) pendiente(s) por sincronizar.' : 'Sin registros pendientes.'; if (dom.queueStatus) dom.queueStatus.textContent = text; if (dom.btnRetrySync) dom.btnRetrySync.textContent = count ? 'Sincronizar pendientes (' + count + ')' : 'Sincronizar pendientes'; }
  function updateConnectionStatus(custom) { if (!dom.connectionStatus) return; if (custom) { dom.connectionStatus.textContent = custom; dom.connectionStatus.className = 'status-pill warn'; return; } if (navigator.onLine) { dom.connectionStatus.textContent = 'En línea'; dom.connectionStatus.className = 'status-pill ok'; } else { dom.connectionStatus.textContent = 'Sin conexión · guardado local'; dom.connectionStatus.className = 'status-pill warn'; } }

  function getInterviewsForCurrentSurveyor() { return Object.keys(interviews).map(function (k) { return interviews[k]; }).filter(function (i) { return i.idEntrevistador === session.id; }).sort(function (a, b) { return new Date(b.lastModifiedAt || 0) - new Date(a.lastModifiedAt || 0); }); }
  function summarizeInterviews(list) { return list.reduce(function (acc, i) { acc.total++; const s = computeInterviewStatus(i); if (s === 'pendiente') acc.pending++; else if (s === 'finalizado') acc.completed++; else acc.progress++; return acc; }, { total: 0, pending: 0, progress: 0, completed: 0 }); }
  function findActiveDuplicate(baseId) { const existing = interviews[baseId]; return existing && computeInterviewStatus(existing) !== 'finalizado' ? existing : null; }
  function findUser(code) { const id = normalizeLoginCode(code); return (CONFIG.users || []).find(function (u) { return String(u.id) === id; }); }
  function getSavedUser() { try { const saved = JSON.parse(localStorage.getItem(CURRENT_USER_KEY) || 'null'); return saved && findUser(saved.id); } catch (e) { return null; } }
  function findCompany(id) { const normalized = normalizeCompanyId(id); return (CONFIG.companyDirectory || []).find(function (c) { return normalizeCompanyId(c.id) === normalized; }); }

  function downloadBackup() { const backup = { version: 3, appVersion: APP_VERSION, exportedAt: new Date().toISOString(), interviews: interviews, queue: getQueue(), remoteRows: remoteRows }; const blob = new Blob([JSON.stringify(backup, null, 2)], { type: 'application/json' }); const a = document.createElement('a'); a.href = URL.createObjectURL(blob); a.download = 'respaldo_diagnostico_3i_' + compactTimestamp() + '.json'; a.click(); URL.revokeObjectURL(a.href); }
  function restoreBackup(event) { const file = event.target.files[0]; if (!file) return; const reader = new FileReader(); reader.onload = function () { try { const backup = JSON.parse(reader.result); if (backup.interviews) { interviews = backup.interviews; Object.keys(interviews).forEach(function (k) { ensureInterviewDefaults(interviews[k]); }); saveInterviews(); } if (Array.isArray(backup.queue)) setQueue(backup.queue); if (Array.isArray(backup.remoteRows)) { remoteRows = backup.remoteRows; localStorage.setItem(REMOTE_ROWS_KEY, JSON.stringify(remoteRows)); } showDashboard(); showToast('Respaldo restaurado.'); } catch (e) { window.alert('No fue posible restaurar el respaldo.'); } event.target.value = ''; }; reader.readAsText(file); }

  function statusCell(value) { const v = String(value || 'NA').toUpperCase(); const cls = v === 'OK' ? 'ok' : (v === 'NA' ? 'na' : 'missing'); return '<td class="' + cls + '">' + escapeHtml(v) + '</td>'; }
  function statusLabel(s) { return s === 'finalizado' ? 'Finalizada' : s === 'en_progreso' ? 'En progreso' : 'Pendiente'; }
  function nodeStateClass(s) { return s === 'done' ? 'done' : s === 'progress' ? 'progress' : 'pending'; }
  function defaultInterviewee(name) { return { nombre: '', cargo: '', encuestador: name || (session ? session.name : ''), fecha: todayInputValue() }; }
  function makeBaseId(idEmpresa, idEntrevistador) { return normalizeCompanyId(idEmpresa) + '_' + normalizeLoginCode(idEntrevistador); }
  function makeNodeSubmissionId(idEmpresa, idEntrevistador, nodeId) { return makeBaseId(idEmpresa, idEntrevistador) + '_' + nodeId; }
  function makeQuestionKey(nodeId, question) { return nodeId + ' | ' + question.text; }
  function makeId(prefix) { return prefix + '-' + Date.now() + '-' + Math.round(Math.random() * 100000); }
  function normalizeLoginCode(v) { return String(v || '').replace(/\D/g, '').slice(-3).padStart(3, '0'); }
  function normalizeCompanyId(v) { const s = String(v || '').trim(); if (/^\d+$/.test(s)) return s.padStart(3, '0'); return s.toUpperCase(); }
  function inputType(t) { return t === 'number' ? 'number' : t === 'date' ? 'date' : 'text'; }
  function getFriendlyType(t) { return t === 'single' ? 'Selección única' : t === 'multiple' ? 'Selección múltiple' : t === 'number' ? 'Numérica' : t === 'date' ? 'Fecha' : 'Texto'; }
  function todayInputValue() { const d = new Date(); const pad = function (n) { return String(n).padStart(2, '0'); }; return d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate()); }
  function compactTimestamp() { const d = new Date(); const pad = function (n) { return String(n).padStart(2, '0'); }; return d.getFullYear() + pad(d.getMonth() + 1) + pad(d.getDate()) + '_' + pad(d.getHours()) + pad(d.getMinutes()); }
  function formatDateTime(value) { if (!value) return ''; const d = new Date(value); if (isNaN(d)) return String(value); return d.toLocaleString('es-CO', { dateStyle: 'short', timeStyle: 'short' }); }
  function toCamel(id) { return id.replace(/-([a-z])/g, function (_, c) { return c.toUpperCase(); }); }
  function safeId(v) { return String(v || '').replace(/[^a-zA-Z0-9_-]/g, '_'); }
  function cssEscape(v) { if (window.CSS && CSS.escape) return CSS.escape(v); return String(v).replace(/"/g, '\\"'); }
  function escapeHtml(v) { return String(v === undefined || v === null ? '' : v).replace(/[&<>"]/g, function (ch) { return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[ch]; }); }
  function showToast(message) { dom.toast.textContent = message; dom.toast.classList.add('show'); clearTimeout(showToast.timer); showToast.timer = setTimeout(function () { dom.toast.classList.remove('show'); }, 4200); }
})();
