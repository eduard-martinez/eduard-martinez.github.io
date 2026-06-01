/* Instrumento generado automáticamente desde instrumento.xlsx. No editar textos de preguntas/opciones aquí manualmente. */
window.INSTRUMENTO_3I = {
  "title": "DIAGNÓSTICO EMPRESARIAL 3i",
  "subtitle": "Innovación · Inversión · Internacionalización",
  "sourceFile": "instrumento.xlsx",
  "sheetId": "1orUQAFlKKRkKbJmSfFUilY40D2j7pRpk2HqMji-aBYg",
  "scriptUrl": "https://script.google.com/macros/s/AKfycbySzI9PUz3gsuU1HDohzqr4Jig5L_K1m6hQAuFtuSQ_PwrKfxzQh1RIk79TnsTpYfQ9-w/exec",
  "general": {
    "companySectionTitle": "DATOS DE LA EMPRESA",
    "fields": [
      {
        "id": "razon_social",
        "label": "Razón social",
        "type": "text",
        "required": true,
        "row": 11
      },
      {
        "id": "anio_constitucion",
        "label": "Año de constitución",
        "type": "number",
        "required": true,
        "row": 12
      },
      {
        "id": "tamano",
        "label": "Tamaño (Ley 590/2000)",
        "type": "text",
        "required": true,
        "row": 13
      },
      {
        "id": "empleados_activos",
        "label": "N° de empleados activos",
        "type": "number",
        "required": true,
        "row": 14
      }
    ],
    "nodeInterviewSectionTitle": "ENTREVISTADOS POR NODO TEMÁTICO",
    "nodeInterviewColumns": [
      "Nodo",
      "Nombre del entrevistado",
      "Cargo",
      "Nombre del encuestador",
      "Fecha"
    ],
    "observationsTitle": "OBSERVACIONES GENERALES DE LA ENTREVISTA"
  },
  "nodes": [
    {
      "id": "INN",
      "name": "Innovación",
      "title": "Nodo 1 — Innovación",
      "sheetName": "Innovación",
      "modules": [
        {
          "id": "INN-A",
          "letter": "A",
          "title": "[INN]  Módulo A — Estratégico-Direccional",
          "questions": [
            {
              "id": "INN-A.1",
              "text": "¿La empresa tiene una declaración escrita y vigente que define qué se entiende por innovación dentro de ella?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.1_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-A.1_O2",
                  "value": "2",
                  "label": "Sí, no documentada",
                  "raw": "2. Sí, no documentada"
                },
                {
                  "id": "INN-A.1_O3",
                  "value": "3",
                  "label": "Sí, documentada pero no aprobada formalmente",
                  "raw": "3. Sí, documentada pero no aprobada formalmente"
                },
                {
                  "id": "INN-A.1_O4",
                  "value": "4",
                  "label": "Sí, documentada y aprobada por la Junta",
                  "raw": "4. Sí, documentada y aprobada por la Junta"
                }
              ],
              "row": 12
            },
            {
              "id": "INN-A.2",
              "text": "¿En cuál instancia formal se discute la estrategia de innovación al menos trimestralmente?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.2_O1",
                  "value": "1",
                  "label": "No existe instancia formal",
                  "raw": "1. No existe instancia formal"
                },
                {
                  "id": "INN-A.2_O2",
                  "value": "2",
                  "label": "Reunión gerencial recurrente",
                  "raw": "2. Reunión gerencial recurrente"
                },
                {
                  "id": "INN-A.2_O3",
                  "value": "3",
                  "label": "Comité Ejecutivo",
                  "raw": "3. Comité Ejecutivo"
                },
                {
                  "id": "INN-A.2_O4",
                  "value": "4",
                  "label": "Junta Directiva",
                  "raw": "4. Junta Directiva"
                },
                {
                  "id": "INN-A.2_O5",
                  "value": "5",
                  "label": "Comité de Innovación dedicado",
                  "raw": "5. Comité de Innovación dedicado"
                }
              ],
              "row": 20
            },
            {
              "id": "INN-A.3",
              "text": "¿Cada cuánto sesiona efectivamente esa instancia para tratar temas de innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.3_O1",
                  "value": "1",
                  "label": "No sesiona",
                  "raw": "1. No sesiona"
                },
                {
                  "id": "INN-A.3_O2",
                  "value": "2",
                  "label": "Anual",
                  "raw": "2. Anual"
                },
                {
                  "id": "INN-A.3_O3",
                  "value": "3",
                  "label": "Semestral",
                  "raw": "3. Semestral"
                },
                {
                  "id": "INN-A.3_O4",
                  "value": "4",
                  "label": "Trimestral",
                  "raw": "4. Trimestral"
                },
                {
                  "id": "INN-A.3_O5",
                  "value": "5",
                  "label": "Mensual",
                  "raw": "5. Mensual"
                },
                {
                  "id": "INN-A.3_O6",
                  "value": "6",
                  "label": "Quincenal o más frecuente",
                  "raw": "6. Quincenal o más frecuente"
                }
              ],
              "row": 29
            },
            {
              "id": "INN-A.4",
              "text": "¿El plan estratégico vigente incluye metas cuantitativas de innovación con plazos definidos?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.4_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-A.4_O2",
                  "value": "2",
                  "label": "Sí, una categoría",
                  "raw": "2. Sí, una categoría"
                },
                {
                  "id": "INN-A.4_O3",
                  "value": "3",
                  "label": "Sí, dos categorías",
                  "raw": "3. Sí, dos categorías"
                },
                {
                  "id": "INN-A.4_O4",
                  "value": "4",
                  "label": "Sí, las tres categorías",
                  "raw": "4. Sí, las tres categorías"
                }
              ],
              "row": 39
            },
            {
              "id": "INN-A.5",
              "text": "¿Existe un cargo de primer nivel con responsabilidad explícita sobre innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.5_O1",
                  "value": "1",
                  "label": "No existe responsable",
                  "raw": "1. No existe responsable"
                },
                {
                  "id": "INN-A.5_O2",
                  "value": "2",
                  "label": "Responsabilidad distribuida sin titular",
                  "raw": "2. Responsabilidad distribuida sin titular"
                },
                {
                  "id": "INN-A.5_O3",
                  "value": "3",
                  "label": "Sí, dedicación parcial",
                  "raw": "3. Sí, dedicación parcial"
                },
                {
                  "id": "INN-A.5_O4",
                  "value": "4",
                  "label": "Sí, dedicación 100%",
                  "raw": "4. Sí, dedicación 100%"
                }
              ],
              "row": 47
            },
            {
              "id": "INN-A.6",
              "text": "¿Cuál es el tipo de innovación que MÁS busca activamente la empresa?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INN-A.6_O1",
                  "value": "1",
                  "label": "Producto (bienes/servicios)",
                  "raw": "1. Producto (bienes/servicios)"
                },
                {
                  "id": "INN-A.6_O2",
                  "value": "2",
                  "label": "Proceso productivo",
                  "raw": "2. Proceso productivo"
                },
                {
                  "id": "INN-A.6_O3",
                  "value": "3",
                  "label": "Modelo de negocio",
                  "raw": "3. Modelo de negocio"
                },
                {
                  "id": "INN-A.6_O4",
                  "value": "4",
                  "label": "Experiencia de cliente",
                  "raw": "4. Experiencia de cliente"
                },
                {
                  "id": "INN-A.6_O5",
                  "value": "5",
                  "label": "Marketing / canal",
                  "raw": "5. Marketing / canal"
                },
                {
                  "id": "INN-A.6_O6",
                  "value": "6",
                  "label": "Organizacional / cultural",
                  "raw": "6. Organizacional / cultural"
                },
                {
                  "id": "INN-A.6_O7",
                  "value": "7",
                  "label": "Tecnologías habilitadoras (IA, automatización, datos)",
                  "raw": "7. Tecnologías habilitadoras (IA, automatización, datos)"
                }
              ],
              "row": 55
            },
            {
              "id": "INN-A.7",
              "text": "¿En qué horizonte predomina actualmente el portafolio de proyectos de innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.7_O1",
                  "value": "1",
                  "label": "Principalmente núcleo (mejoras a lo existente)",
                  "raw": "1. Principalmente núcleo (mejoras a lo existente)"
                },
                {
                  "id": "INN-A.7_O2",
                  "value": "2",
                  "label": "Principalmente adyacente (extensiones próximas)",
                  "raw": "2. Principalmente adyacente (extensiones próximas)"
                },
                {
                  "id": "INN-A.7_O3",
                  "value": "3",
                  "label": "Principalmente transformacional (disruptivo)",
                  "raw": "3. Principalmente transformacional (disruptivo)"
                },
                {
                  "id": "INN-A.7_O4",
                  "value": "4",
                  "label": "Equilibrado entre los tres horizontes",
                  "raw": "4. Equilibrado entre los tres horizontes"
                }
              ],
              "row": 66
            },
            {
              "id": "INN-A.8",
              "text": "¿Cuántas veces durante el último año la alta gerencia participó personalmente en sesiones de innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.8_O1",
                  "value": "1",
                  "label": "0",
                  "raw": "1. 0"
                },
                {
                  "id": "INN-A.8_O2",
                  "value": "2",
                  "label": "1-2",
                  "raw": "2. 1-2"
                },
                {
                  "id": "INN-A.8_O3",
                  "value": "3",
                  "label": "3-5",
                  "raw": "3. 3-5"
                },
                {
                  "id": "INN-A.8_O4",
                  "value": "4",
                  "label": "6-10",
                  "raw": "4. 6-10"
                },
                {
                  "id": "INN-A.8_O5",
                  "value": "5",
                  "label": "11-20",
                  "raw": "5. 11-20"
                },
                {
                  "id": "INN-A.8_O6",
                  "value": "6",
                  "label": "> 20",
                  "raw": "6. > 20"
                }
              ],
              "row": 74
            },
            {
              "id": "INN-A.9",
              "text": "¿Existe un sistema de indicadores (KPI) de innovación con tablero que se reporta a la Junta?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.9_O1",
                  "value": "1",
                  "label": "No existe tablero",
                  "raw": "1. No existe tablero"
                },
                {
                  "id": "INN-A.9_O2",
                  "value": "2",
                  "label": "Sí, anual",
                  "raw": "2. Sí, anual"
                },
                {
                  "id": "INN-A.9_O3",
                  "value": "3",
                  "label": "Sí, semestral",
                  "raw": "3. Sí, semestral"
                },
                {
                  "id": "INN-A.9_O4",
                  "value": "4",
                  "label": "Sí, trimestral",
                  "raw": "4. Sí, trimestral"
                },
                {
                  "id": "INN-A.9_O5",
                  "value": "5",
                  "label": "Sí, mensual",
                  "raw": "5. Sí, mensual"
                }
              ],
              "row": 84
            },
            {
              "id": "INN-A.10",
              "text": "La estrategia de innovación está claramente comunicada a los líderes y mandos medios.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.10_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-A.10_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-A.10_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-A.10_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-A.10_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-A.10_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 93
            },
            {
              "id": "INN-A.11",
              "text": "La alta gerencia tolera activamente el fracaso controlado en proyectos de innovación.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.11_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-A.11_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-A.11_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-A.11_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-A.11_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-A.11_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 103
            },
            {
              "id": "INN-A.12",
              "text": "¿La empresa tiene reglas claras de cómo se canaliza, evalúa y decide una propuesta de innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.12_O1",
                  "value": "1",
                  "label": "No existe",
                  "raw": "1. No existe"
                },
                {
                  "id": "INN-A.12_O2",
                  "value": "2",
                  "label": "No documentado",
                  "raw": "2. No documentado"
                },
                {
                  "id": "INN-A.12_O3",
                  "value": "3",
                  "label": "Sí, documentado pero poco conocido",
                  "raw": "3. Sí, documentado pero poco conocido"
                },
                {
                  "id": "INN-A.12_O4",
                  "value": "4",
                  "label": "Sí, documentado y conocido",
                  "raw": "4. Sí, documentado y conocido"
                }
              ],
              "row": 113
            },
            {
              "id": "INN-A.13",
              "text": "¿En qué horizonte se proyectan las metas de innovación más ambiciosas?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.13_O1",
                  "value": "1",
                  "label": "No están proyectadas",
                  "raw": "1. No están proyectadas"
                },
                {
                  "id": "INN-A.13_O2",
                  "value": "2",
                  "label": "≤ 12 meses",
                  "raw": "2. ≤ 12 meses"
                },
                {
                  "id": "INN-A.13_O3",
                  "value": "3",
                  "label": "1-3 años",
                  "raw": "3. 1-3 años"
                },
                {
                  "id": "INN-A.13_O4",
                  "value": "4",
                  "label": "3-5 años",
                  "raw": "4. 3-5 años"
                },
                {
                  "id": "INN-A.13_O5",
                  "value": "5",
                  "label": "5-10 años",
                  "raw": "5. 5-10 años"
                }
              ],
              "row": 121
            },
            {
              "id": "INN-A.14",
              "text": "La organización tiene un sesgo hacia la acción y evita la parálisis por análisis en innovación.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-A.14_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-A.14_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-A.14_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-A.14_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-A.14_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-A.14_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 130
            }
          ]
        },
        {
          "id": "INN-B",
          "letter": "B",
          "title": "[INN]  Módulo B — Inversión en Innovación",
          "questions": [
            {
              "id": "INN-B.1",
              "text": "¿La empresa diferencia explícitamente en sus presupuestos un rubro para innovación (CAPEX y/o OPEX)?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.1_O1",
                  "value": "1",
                  "label": "No diferenciado",
                  "raw": "1. No diferenciado"
                },
                {
                  "id": "INN-B.1_O2",
                  "value": "2",
                  "label": "Sí, solo OPEX",
                  "raw": "2. Sí, solo OPEX"
                },
                {
                  "id": "INN-B.1_O3",
                  "value": "3",
                  "label": "Sí, solo CAPEX",
                  "raw": "3. Sí, solo CAPEX"
                },
                {
                  "id": "INN-B.1_O4",
                  "value": "4",
                  "label": "Sí, en CAPEX y OPEX",
                  "raw": "4. Sí, en CAPEX y OPEX"
                }
              ],
              "row": 144
            },
            {
              "id": "INN-B.2",
              "text": "% del CAPEX del último año fiscal ejecutado en proyectos clasificados como innovación.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.2_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-B.2_O2",
                  "value": "2",
                  "label": "0,1-1%",
                  "raw": "2. 0,1-1%"
                },
                {
                  "id": "INN-B.2_O3",
                  "value": "3",
                  "label": "1,1-2%",
                  "raw": "3. 1,1-2%"
                },
                {
                  "id": "INN-B.2_O4",
                  "value": "4",
                  "label": "2,1-5%",
                  "raw": "4. 2,1-5%"
                },
                {
                  "id": "INN-B.2_O5",
                  "value": "5",
                  "label": "5,1-10%",
                  "raw": "5. 5,1-10%"
                },
                {
                  "id": "INN-B.2_O6",
                  "value": "6",
                  "label": "> 10%",
                  "raw": "6. > 10%"
                }
              ],
              "row": 152
            },
            {
              "id": "INN-B.3",
              "text": "Monto absoluto del CAPEX-Innovación del último año fiscal (rango en millones COP).",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.3_O1",
                  "value": "1",
                  "label": "0",
                  "raw": "1. 0"
                },
                {
                  "id": "INN-B.3_O2",
                  "value": "2",
                  "label": "≤ 100 M COP",
                  "raw": "2. ≤ 100 M COP"
                },
                {
                  "id": "INN-B.3_O3",
                  "value": "3",
                  "label": "101-500 M COP",
                  "raw": "3. 101-500 M COP"
                },
                {
                  "id": "INN-B.3_O4",
                  "value": "4",
                  "label": "501-2.000 M COP",
                  "raw": "4. 501-2.000 M COP"
                },
                {
                  "id": "INN-B.3_O5",
                  "value": "5",
                  "label": "2.001-10.000 M COP",
                  "raw": "5. 2.001-10.000 M COP"
                },
                {
                  "id": "INN-B.3_O6",
                  "value": "6",
                  "label": "> 10.000 M COP",
                  "raw": "6. > 10.000 M COP"
                }
              ],
              "row": 162
            },
            {
              "id": "INN-B.4",
              "text": "% del OPEX del último año destinado a actividades de innovación.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.4_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-B.4_O2",
                  "value": "2",
                  "label": "0,1-1%",
                  "raw": "2. 0,1-1%"
                },
                {
                  "id": "INN-B.4_O3",
                  "value": "3",
                  "label": "1,1-3%",
                  "raw": "3. 1,1-3%"
                },
                {
                  "id": "INN-B.4_O4",
                  "value": "4",
                  "label": "3,1-7%",
                  "raw": "4. 3,1-7%"
                },
                {
                  "id": "INN-B.4_O5",
                  "value": "5",
                  "label": "7,1-15%",
                  "raw": "5. 7,1-15%"
                },
                {
                  "id": "INN-B.4_O6",
                  "value": "6",
                  "label": "> 15%",
                  "raw": "6. > 15%"
                }
              ],
              "row": 172
            },
            {
              "id": "INN-B.5",
              "text": "% de ventas del último año de productos o servicios lanzados en los últimos 36 meses.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.5_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-B.5_O2",
                  "value": "2",
                  "label": "0,1-5%",
                  "raw": "2. 0,1-5%"
                },
                {
                  "id": "INN-B.5_O3",
                  "value": "3",
                  "label": "5,1-10%",
                  "raw": "3. 5,1-10%"
                },
                {
                  "id": "INN-B.5_O4",
                  "value": "4",
                  "label": "10,1-20%",
                  "raw": "4. 10,1-20%"
                },
                {
                  "id": "INN-B.5_O5",
                  "value": "5",
                  "label": "20,1-40%",
                  "raw": "5. 20,1-40%"
                },
                {
                  "id": "INN-B.5_O6",
                  "value": "6",
                  "label": "> 40%",
                  "raw": "6. > 40%"
                }
              ],
              "row": 182
            },
            {
              "id": "INN-B.6",
              "text": "¿La empresa ha aplicado a beneficios tributarios por inversión en innovación en los últimos 24 meses?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.6_O1",
                  "value": "1",
                  "label": "No ha aplicado",
                  "raw": "1. No ha aplicado"
                },
                {
                  "id": "INN-B.6_O2",
                  "value": "2",
                  "label": "Sí, rechazada",
                  "raw": "2. Sí, rechazada"
                },
                {
                  "id": "INN-B.6_O3",
                  "value": "3",
                  "label": "Sí, en trámite",
                  "raw": "3. Sí, en trámite"
                },
                {
                  "id": "INN-B.6_O4",
                  "value": "4",
                  "label": "Sí, aprobada",
                  "raw": "4. Sí, aprobada"
                }
              ],
              "row": 192
            },
            {
              "id": "INN-B.7",
              "text": "¿Ha recibido financiación pública para innovación (Minciencias, iNNpulsa, SENA, BID) en los últimos 24 meses?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.7_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-B.7_O2",
                  "value": "2",
                  "label": "Sí, ≤ 100 M COP",
                  "raw": "2. Sí, ≤ 100 M COP"
                },
                {
                  "id": "INN-B.7_O3",
                  "value": "3",
                  "label": "Sí, 100-500 M COP",
                  "raw": "3. Sí, 100-500 M COP"
                },
                {
                  "id": "INN-B.7_O4",
                  "value": "4",
                  "label": "Sí, > 500 M COP",
                  "raw": "4. Sí, > 500 M COP"
                }
              ],
              "row": 200
            },
            {
              "id": "INN-B.8",
              "text": "¿Ha realizado inversiones de Corporate Venture Capital o adquisición de startups en los últimos 36 meses?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.8_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-B.8_O2",
                  "value": "2",
                  "label": "Evaluado pero no ejecutado",
                  "raw": "2. Evaluado pero no ejecutado"
                },
                {
                  "id": "INN-B.8_O3",
                  "value": "3",
                  "label": "Sí, transacciones ad-hoc",
                  "raw": "3. Sí, transacciones ad-hoc"
                },
                {
                  "id": "INN-B.8_O4",
                  "value": "4",
                  "label": "Sí, con vehículo formal",
                  "raw": "4. Sí, con vehículo formal"
                }
              ],
              "row": 208
            },
            {
              "id": "INN-B.9",
              "text": "¿Cómo se calcula el retorno de inversión de los proyectos de innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.9_O1",
                  "value": "1",
                  "label": "No se calcula",
                  "raw": "1. No se calcula"
                },
                {
                  "id": "INN-B.9_O2",
                  "value": "2",
                  "label": "Hoja de ruta sin métrica financiera",
                  "raw": "2. Hoja de ruta sin métrica financiera"
                },
                {
                  "id": "INN-B.9_O3",
                  "value": "3",
                  "label": "VPN/TIR estándar",
                  "raw": "3. VPN/TIR estándar"
                },
                {
                  "id": "INN-B.9_O4",
                  "value": "4",
                  "label": "Métricas específicas de innovación (opciones reales, lookback)",
                  "raw": "4. Métricas específicas de innovación (opciones reales, lookback)"
                }
              ],
              "row": 216
            },
            {
              "id": "INN-B.10",
              "text": "Crecimiento promedio anual de la inversión en innovación en los últimos 3 años (CAGR).",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.10_O1",
                  "value": "1",
                  "label": "Negativo",
                  "raw": "1. Negativo"
                },
                {
                  "id": "INN-B.10_O2",
                  "value": "2",
                  "label": "0%",
                  "raw": "2. 0%"
                },
                {
                  "id": "INN-B.10_O3",
                  "value": "3",
                  "label": "0-5%",
                  "raw": "3. 0-5%"
                },
                {
                  "id": "INN-B.10_O4",
                  "value": "4",
                  "label": "5-15%",
                  "raw": "4. 5-15%"
                },
                {
                  "id": "INN-B.10_O5",
                  "value": "5",
                  "label": "15-30%",
                  "raw": "5. 15-30%"
                },
                {
                  "id": "INN-B.10_O6",
                  "value": "6",
                  "label": "> 30%",
                  "raw": "6. > 30%"
                }
              ],
              "row": 224
            },
            {
              "id": "INN-B.11",
              "text": "¿El presupuesto de innovación se asigna mediante stage-gate, comité o concurso interno?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.11_O1",
                  "value": "1",
                  "label": "No hay asignación específica",
                  "raw": "1. No hay asignación específica"
                },
                {
                  "id": "INN-B.11_O2",
                  "value": "2",
                  "label": "Asignación discrecional",
                  "raw": "2. Asignación discrecional"
                },
                {
                  "id": "INN-B.11_O3",
                  "value": "3",
                  "label": "Concurso interno",
                  "raw": "3. Concurso interno"
                },
                {
                  "id": "INN-B.11_O4",
                  "value": "4",
                  "label": "Comité con criterios públicos",
                  "raw": "4. Comité con criterios públicos"
                },
                {
                  "id": "INN-B.11_O5",
                  "value": "5",
                  "label": "Stage-gate formal",
                  "raw": "5. Stage-gate formal"
                }
              ],
              "row": 234
            },
            {
              "id": "INN-B.12",
              "text": "Tasa promedio de proyectos que llegan a fase comercial respecto del total iniciado en los últimos 24 meses.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.12_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-B.12_O2",
                  "value": "2",
                  "label": "1-10%",
                  "raw": "2. 1-10%"
                },
                {
                  "id": "INN-B.12_O3",
                  "value": "3",
                  "label": "11-25%",
                  "raw": "3. 11-25%"
                },
                {
                  "id": "INN-B.12_O4",
                  "value": "4",
                  "label": "26-50%",
                  "raw": "4. 26-50%"
                },
                {
                  "id": "INN-B.12_O5",
                  "value": "5",
                  "label": "51-75%",
                  "raw": "5. 51-75%"
                },
                {
                  "id": "INN-B.12_O6",
                  "value": "6",
                  "label": "> 75%",
                  "raw": "6. > 75%"
                }
              ],
              "row": 243
            },
            {
              "id": "INN-B.13",
              "text": "La asignación de recursos para innovación es predecible y sostenida en el tiempo.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-B.13_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-B.13_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-B.13_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-B.13_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-B.13_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-B.13_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 253
            }
          ]
        },
        {
          "id": "INN-C",
          "letter": "C",
          "title": "[INN]  Módulo C — Portafolio, Proceso y Propiedad Intelectual",
          "questions": [
            {
              "id": "INN-C.1",
              "text": "Número total de proyectos de innovación activos al cierre del último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.1_O1",
                  "value": "1",
                  "label": "0",
                  "raw": "1. 0"
                },
                {
                  "id": "INN-C.1_O2",
                  "value": "2",
                  "label": "1-2",
                  "raw": "2. 1-2"
                },
                {
                  "id": "INN-C.1_O3",
                  "value": "3",
                  "label": "3-5",
                  "raw": "3. 3-5"
                },
                {
                  "id": "INN-C.1_O4",
                  "value": "4",
                  "label": "6-10",
                  "raw": "4. 6-10"
                },
                {
                  "id": "INN-C.1_O5",
                  "value": "5",
                  "label": "11-20",
                  "raw": "5. 11-20"
                },
                {
                  "id": "INN-C.1_O6",
                  "value": "6",
                  "label": "> 20",
                  "raw": "6. > 20"
                }
              ],
              "row": 267
            },
            {
              "id": "INN-C.2",
              "text": "Número de proyectos cerrados con éxito comercial (lanzamiento) en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.2_O1",
                  "value": "1",
                  "label": "0",
                  "raw": "1. 0"
                },
                {
                  "id": "INN-C.2_O2",
                  "value": "2",
                  "label": "1-2",
                  "raw": "2. 1-2"
                },
                {
                  "id": "INN-C.2_O3",
                  "value": "3",
                  "label": "3-5",
                  "raw": "3. 3-5"
                },
                {
                  "id": "INN-C.2_O4",
                  "value": "4",
                  "label": "6-10",
                  "raw": "4. 6-10"
                },
                {
                  "id": "INN-C.2_O5",
                  "value": "5",
                  "label": "11-20",
                  "raw": "5. 11-20"
                },
                {
                  "id": "INN-C.2_O6",
                  "value": "6",
                  "label": "> 20",
                  "raw": "6. > 20"
                }
              ],
              "row": 277
            },
            {
              "id": "INN-C.3",
              "text": "Número de proyectos abandonados por decisión metódica (kill formal) en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.3_O1",
                  "value": "1",
                  "label": "No aplica disciplina de kill",
                  "raw": "1. No aplica disciplina de kill"
                },
                {
                  "id": "INN-C.3_O2",
                  "value": "2",
                  "label": "0",
                  "raw": "2. 0"
                },
                {
                  "id": "INN-C.3_O3",
                  "value": "3",
                  "label": "1-2",
                  "raw": "3. 1-2"
                },
                {
                  "id": "INN-C.3_O4",
                  "value": "4",
                  "label": "3-5",
                  "raw": "4. 3-5"
                },
                {
                  "id": "INN-C.3_O5",
                  "value": "5",
                  "label": "6-10",
                  "raw": "5. 6-10"
                },
                {
                  "id": "INN-C.3_O6",
                  "value": "6",
                  "label": "> 10",
                  "raw": "6. > 10"
                }
              ],
              "row": 287
            },
            {
              "id": "INN-C.4",
              "text": "¿Cada cuánto se realizan ejercicios formales de identificación de oportunidades?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.4_O1",
                  "value": "1",
                  "label": "Nunca",
                  "raw": "1. Nunca"
                },
                {
                  "id": "INN-C.4_O2",
                  "value": "2",
                  "label": "Anual",
                  "raw": "2. Anual"
                },
                {
                  "id": "INN-C.4_O3",
                  "value": "3",
                  "label": "Semestral",
                  "raw": "3. Semestral"
                },
                {
                  "id": "INN-C.4_O4",
                  "value": "4",
                  "label": "Trimestral",
                  "raw": "4. Trimestral"
                },
                {
                  "id": "INN-C.4_O5",
                  "value": "5",
                  "label": "Mensual",
                  "raw": "5. Mensual"
                },
                {
                  "id": "INN-C.4_O6",
                  "value": "6",
                  "label": "Continuo",
                  "raw": "6. Continuo"
                }
              ],
              "row": 297
            },
            {
              "id": "INN-C.5",
              "text": "¿Cada cuánto se realizan sesiones formales de ideación o creatividad?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.5_O1",
                  "value": "1",
                  "label": "Nunca",
                  "raw": "1. Nunca"
                },
                {
                  "id": "INN-C.5_O2",
                  "value": "2",
                  "label": "Anual",
                  "raw": "2. Anual"
                },
                {
                  "id": "INN-C.5_O3",
                  "value": "3",
                  "label": "Semestral",
                  "raw": "3. Semestral"
                },
                {
                  "id": "INN-C.5_O4",
                  "value": "4",
                  "label": "Trimestral",
                  "raw": "4. Trimestral"
                },
                {
                  "id": "INN-C.5_O5",
                  "value": "5",
                  "label": "Mensual",
                  "raw": "5. Mensual"
                },
                {
                  "id": "INN-C.5_O6",
                  "value": "6",
                  "label": "Más frecuente",
                  "raw": "6. Más frecuente"
                }
              ],
              "row": 307
            },
            {
              "id": "INN-C.6",
              "text": "Número de ideas formales ingresadas al sistema de gestión de innovación en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.6_O1",
                  "value": "1",
                  "label": "0",
                  "raw": "1. 0"
                },
                {
                  "id": "INN-C.6_O2",
                  "value": "2",
                  "label": "1-10",
                  "raw": "2. 1-10"
                },
                {
                  "id": "INN-C.6_O3",
                  "value": "3",
                  "label": "11-50",
                  "raw": "3. 11-50"
                },
                {
                  "id": "INN-C.6_O4",
                  "value": "4",
                  "label": "51-200",
                  "raw": "4. 51-200"
                },
                {
                  "id": "INN-C.6_O5",
                  "value": "5",
                  "label": "201-500",
                  "raw": "5. 201-500"
                },
                {
                  "id": "INN-C.6_O6",
                  "value": "6",
                  "label": "> 500",
                  "raw": "6. > 500"
                }
              ],
              "row": 317
            },
            {
              "id": "INN-C.7",
              "text": "Tasa de conversión idea → prototipo en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.7_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-C.7_O2",
                  "value": "2",
                  "label": "0,1-2%",
                  "raw": "2. 0,1-2%"
                },
                {
                  "id": "INN-C.7_O3",
                  "value": "3",
                  "label": "2,1-5%",
                  "raw": "3. 2,1-5%"
                },
                {
                  "id": "INN-C.7_O4",
                  "value": "4",
                  "label": "5,1-15%",
                  "raw": "4. 5,1-15%"
                },
                {
                  "id": "INN-C.7_O5",
                  "value": "5",
                  "label": "15,1-30%",
                  "raw": "5. 15,1-30%"
                },
                {
                  "id": "INN-C.7_O6",
                  "value": "6",
                  "label": "> 30%",
                  "raw": "6. > 30%"
                }
              ],
              "row": 327
            },
            {
              "id": "INN-C.8",
              "text": "Número de prototipos o pruebas de concepto desarrollados en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.8_O1",
                  "value": "1",
                  "label": "0",
                  "raw": "1. 0"
                },
                {
                  "id": "INN-C.8_O2",
                  "value": "2",
                  "label": "1-5",
                  "raw": "2. 1-5"
                },
                {
                  "id": "INN-C.8_O3",
                  "value": "3",
                  "label": "6-15",
                  "raw": "3. 6-15"
                },
                {
                  "id": "INN-C.8_O4",
                  "value": "4",
                  "label": "16-30",
                  "raw": "4. 16-30"
                },
                {
                  "id": "INN-C.8_O5",
                  "value": "5",
                  "label": "31-60",
                  "raw": "5. 31-60"
                },
                {
                  "id": "INN-C.8_O6",
                  "value": "6",
                  "label": "> 60",
                  "raw": "6. > 60"
                }
              ],
              "row": 337
            },
            {
              "id": "INN-C.9",
              "text": "¿La empresa cuenta con metodología formal para gestionar la innovación (stage-gate, lean startup, ISO 56002)?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.9_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-C.9_O2",
                  "value": "2",
                  "label": "Sí, informal",
                  "raw": "2. Sí, informal"
                },
                {
                  "id": "INN-C.9_O3",
                  "value": "3",
                  "label": "Sí, varias coexisten",
                  "raw": "3. Sí, varias coexisten"
                },
                {
                  "id": "INN-C.9_O4",
                  "value": "4",
                  "label": "Sí, una formal y documentada",
                  "raw": "4. Sí, una formal y documentada"
                }
              ],
              "row": 347
            },
            {
              "id": "INN-C.10",
              "text": "¿La empresa cuenta con software dedicado para gestión de innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.10_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-C.10_O2",
                  "value": "2",
                  "label": "Solo hojas de cálculo",
                  "raw": "2. Solo hojas de cálculo"
                },
                {
                  "id": "INN-C.10_O3",
                  "value": "3",
                  "label": "Sí, herramientas adaptadas (PMO, BPM)",
                  "raw": "3. Sí, herramientas adaptadas (PMO, BPM)"
                },
                {
                  "id": "INN-C.10_O4",
                  "value": "4",
                  "label": "Sí, software dedicado",
                  "raw": "4. Sí, software dedicado"
                }
              ],
              "row": 355
            },
            {
              "id": "INN-C.11",
              "text": "Tiempo promedio (en meses) desde aprobación del proyecto hasta lanzamiento al mercado.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.11_O1",
                  "value": "1",
                  "label": "> 24 meses",
                  "raw": "1. > 24 meses"
                },
                {
                  "id": "INN-C.11_O2",
                  "value": "2",
                  "label": "13-24 meses",
                  "raw": "2. 13-24 meses"
                },
                {
                  "id": "INN-C.11_O3",
                  "value": "3",
                  "label": "7-12 meses",
                  "raw": "3. 7-12 meses"
                },
                {
                  "id": "INN-C.11_O4",
                  "value": "4",
                  "label": "4-6 meses",
                  "raw": "4. 4-6 meses"
                },
                {
                  "id": "INN-C.11_O5",
                  "value": "5",
                  "label": "≤ 3 meses",
                  "raw": "5. ≤ 3 meses"
                }
              ],
              "row": 363
            },
            {
              "id": "INN-C.12",
              "text": "¿Cuántas alianzas formales con actores externos activas en innovación tiene la empresa?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.12_O1",
                  "value": "1",
                  "label": "0",
                  "raw": "1. 0"
                },
                {
                  "id": "INN-C.12_O2",
                  "value": "2",
                  "label": "1",
                  "raw": "2. 1"
                },
                {
                  "id": "INN-C.12_O3",
                  "value": "3",
                  "label": "2-3",
                  "raw": "3. 2-3"
                },
                {
                  "id": "INN-C.12_O4",
                  "value": "4",
                  "label": "4-5",
                  "raw": "4. 4-5"
                },
                {
                  "id": "INN-C.12_O5",
                  "value": "5",
                  "label": "6-10",
                  "raw": "5. 6-10"
                },
                {
                  "id": "INN-C.12_O6",
                  "value": "6",
                  "label": "> 10",
                  "raw": "6. > 10"
                }
              ],
              "row": 372
            },
            {
              "id": "INN-C.13",
              "text": "Sesiones formales con clientes para co-creación o validación de soluciones en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.13_O1",
                  "value": "1",
                  "label": "Nunca",
                  "raw": "1. Nunca"
                },
                {
                  "id": "INN-C.13_O2",
                  "value": "2",
                  "label": "Anual",
                  "raw": "2. Anual"
                },
                {
                  "id": "INN-C.13_O3",
                  "value": "3",
                  "label": "Semestral",
                  "raw": "3. Semestral"
                },
                {
                  "id": "INN-C.13_O4",
                  "value": "4",
                  "label": "Trimestral",
                  "raw": "4. Trimestral"
                },
                {
                  "id": "INN-C.13_O5",
                  "value": "5",
                  "label": "Mensual",
                  "raw": "5. Mensual"
                },
                {
                  "id": "INN-C.13_O6",
                  "value": "6",
                  "label": "Más frecuente",
                  "raw": "6. Más frecuente"
                }
              ],
              "row": 382
            },
            {
              "id": "INN-C.14",
              "text": "Existe un proceso claro y rápido para detener un proyecto que no muestra resultados (fail fast).",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.14_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-C.14_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-C.14_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-C.14_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-C.14_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-C.14_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 392
            },
            {
              "id": "INN-C.15",
              "text": "El feedback a autores de propuestas no aceptadas es transparente, adecuado y oportuno.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.15_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-C.15_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-C.15_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-C.15_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-C.15_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-C.15_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 402
            },
            {
              "id": "INN-C.16",
              "text": "¿Cuál es el principal resultado de impacto reportado por las innovaciones en el último año?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INN-C.16_O1",
                  "value": "1",
                  "label": "Aumento en ventas atribuible",
                  "raw": "1. Aumento en ventas atribuible"
                },
                {
                  "id": "INN-C.16_O2",
                  "value": "2",
                  "label": "Reducción de costos atribuible",
                  "raw": "2. Reducción de costos atribuible"
                },
                {
                  "id": "INN-C.16_O3",
                  "value": "3",
                  "label": "Mejora en satisfacción de cliente (NPS/CSAT)",
                  "raw": "3. Mejora en satisfacción de cliente (NPS/CSAT)"
                },
                {
                  "id": "INN-C.16_O4",
                  "value": "4",
                  "label": "Nuevos clientes captados",
                  "raw": "4. Nuevos clientes captados"
                },
                {
                  "id": "INN-C.16_O5",
                  "value": "5",
                  "label": "Nuevos mercados abiertos",
                  "raw": "5. Nuevos mercados abiertos"
                },
                {
                  "id": "INN-C.16_O6",
                  "value": "6",
                  "label": "Reconocimiento externo",
                  "raw": "6. Reconocimiento externo"
                },
                {
                  "id": "INN-C.16_O7",
                  "value": "7",
                  "label": "Reducción de huella ambiental",
                  "raw": "7. Reducción de huella ambiental"
                },
                {
                  "id": "INN-C.16_O8",
                  "value": "8",
                  "label": "Sin resultados medibles",
                  "raw": "8. Sin resultados medibles"
                }
              ],
              "row": 412
            },
            {
              "id": "INN-C.17",
              "text": "¿La empresa cuenta con una política de propiedad intelectual documentada?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.17_O1",
                  "value": "1",
                  "label": "No existe",
                  "raw": "1. No existe"
                },
                {
                  "id": "INN-C.17_O2",
                  "value": "2",
                  "label": "En elaboración",
                  "raw": "2. En elaboración"
                },
                {
                  "id": "INN-C.17_O3",
                  "value": "3",
                  "label": "Sí, documentada pero poco comunicada",
                  "raw": "3. Sí, documentada pero poco comunicada"
                },
                {
                  "id": "INN-C.17_O4",
                  "value": "4",
                  "label": "Sí, documentada, vigente y comunicada",
                  "raw": "4. Sí, documentada, vigente y comunicada"
                }
              ],
              "row": 424
            },
            {
              "id": "INN-C.18",
              "text": "Solicitudes de propiedad industrial radicadas en los últimos 24 meses (conteo total).",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.18_O1",
                  "value": "1",
                  "label": "0",
                  "raw": "1. 0"
                },
                {
                  "id": "INN-C.18_O2",
                  "value": "2",
                  "label": "1-2",
                  "raw": "2. 1-2"
                },
                {
                  "id": "INN-C.18_O3",
                  "value": "3",
                  "label": "3-5",
                  "raw": "3. 3-5"
                },
                {
                  "id": "INN-C.18_O4",
                  "value": "4",
                  "label": "6-10",
                  "raw": "4. 6-10"
                },
                {
                  "id": "INN-C.18_O5",
                  "value": "5",
                  "label": "> 10",
                  "raw": "5. > 10"
                }
              ],
              "row": 432
            },
            {
              "id": "INN-C.19",
              "text": "¿La empresa tiene NDA y contratos de cesión de derechos para empleados y proveedores en proyectos de innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.19_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-C.19_O2",
                  "value": "2",
                  "label": "Solo cesión de derechos",
                  "raw": "2. Solo cesión de derechos"
                },
                {
                  "id": "INN-C.19_O3",
                  "value": "3",
                  "label": "Solo NDA",
                  "raw": "3. Solo NDA"
                },
                {
                  "id": "INN-C.19_O4",
                  "value": "4",
                  "label": "Sí, ambos firmados y vigentes",
                  "raw": "4. Sí, ambos firmados y vigentes"
                }
              ],
              "row": 441
            },
            {
              "id": "INN-C.20",
              "text": "% del CAPEX-Innovación destinado a protección y gestión de propiedad intelectual.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.20_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-C.20_O2",
                  "value": "2",
                  "label": "0,1-0,5%",
                  "raw": "2. 0,1-0,5%"
                },
                {
                  "id": "INN-C.20_O3",
                  "value": "3",
                  "label": "0,6-1%",
                  "raw": "3. 0,6-1%"
                },
                {
                  "id": "INN-C.20_O4",
                  "value": "4",
                  "label": "1,1-3%",
                  "raw": "4. 1,1-3%"
                },
                {
                  "id": "INN-C.20_O5",
                  "value": "5",
                  "label": "3,1-7%",
                  "raw": "5. 3,1-7%"
                },
                {
                  "id": "INN-C.20_O6",
                  "value": "6",
                  "label": "> 7%",
                  "raw": "6. > 7%"
                }
              ],
              "row": 449
            },
            {
              "id": "INN-C.21",
              "text": "¿Ha ejecutado operaciones de transferencia tecnológica en los últimos 24 meses?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-C.21_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-C.21_O2",
                  "value": "2",
                  "label": "En análisis o negociación",
                  "raw": "2. En análisis o negociación"
                },
                {
                  "id": "INN-C.21_O3",
                  "value": "3",
                  "label": "Sí, como licenciatario",
                  "raw": "3. Sí, como licenciatario"
                },
                {
                  "id": "INN-C.21_O4",
                  "value": "4",
                  "label": "Sí, como licenciante",
                  "raw": "4. Sí, como licenciante"
                },
                {
                  "id": "INN-C.21_O5",
                  "value": "5",
                  "label": "Sí, ambos roles",
                  "raw": "5. Sí, ambos roles"
                }
              ],
              "row": 459
            }
          ]
        },
        {
          "id": "INN-D",
          "letter": "D",
          "title": "[INN]  Módulo D — Cultura, Talento y Liderazgo",
          "questions": [
            {
              "id": "INN-D.1",
              "text": "Número total de horas de formación en innovación impartidas a colaboradores en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.1_O1",
                  "value": "1",
                  "label": "0",
                  "raw": "1. 0"
                },
                {
                  "id": "INN-D.1_O2",
                  "value": "2",
                  "label": "1-100",
                  "raw": "2. 1-100"
                },
                {
                  "id": "INN-D.1_O3",
                  "value": "3",
                  "label": "101-500",
                  "raw": "3. 101-500"
                },
                {
                  "id": "INN-D.1_O4",
                  "value": "4",
                  "label": "501-2.000",
                  "raw": "4. 501-2.000"
                },
                {
                  "id": "INN-D.1_O5",
                  "value": "5",
                  "label": "2.001-5.000",
                  "raw": "5. 2.001-5.000"
                },
                {
                  "id": "INN-D.1_O6",
                  "value": "6",
                  "label": "> 5.000",
                  "raw": "6. > 5.000"
                }
              ],
              "row": 472
            },
            {
              "id": "INN-D.2",
              "text": "% del personal que recibió al menos 1 hora de formación en innovación en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.2_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-D.2_O2",
                  "value": "2",
                  "label": "0,1-5%",
                  "raw": "2. 0,1-5%"
                },
                {
                  "id": "INN-D.2_O3",
                  "value": "3",
                  "label": "5,1-15%",
                  "raw": "3. 5,1-15%"
                },
                {
                  "id": "INN-D.2_O4",
                  "value": "4",
                  "label": "15,1-30%",
                  "raw": "4. 15,1-30%"
                },
                {
                  "id": "INN-D.2_O5",
                  "value": "5",
                  "label": "30,1-60%",
                  "raw": "5. 30,1-60%"
                },
                {
                  "id": "INN-D.2_O6",
                  "value": "6",
                  "label": "> 60%",
                  "raw": "6. > 60%"
                }
              ],
              "row": 482
            },
            {
              "id": "INN-D.3",
              "text": "¿La empresa tiene sistema formal de incentivos por participar en iniciativas de innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.3_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-D.3_O2",
                  "value": "2",
                  "label": "Sí, solo no monetario",
                  "raw": "2. Sí, solo no monetario"
                },
                {
                  "id": "INN-D.3_O3",
                  "value": "3",
                  "label": "Sí, solo monetario",
                  "raw": "3. Sí, solo monetario"
                },
                {
                  "id": "INN-D.3_O4",
                  "value": "4",
                  "label": "Sí, monetario y no monetario",
                  "raw": "4. Sí, monetario y no monetario"
                }
              ],
              "row": 492
            },
            {
              "id": "INN-D.4",
              "text": "% del personal que recibió algún incentivo asociado a innovación en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.4_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-D.4_O2",
                  "value": "2",
                  "label": "0,1-5%",
                  "raw": "2. 0,1-5%"
                },
                {
                  "id": "INN-D.4_O3",
                  "value": "3",
                  "label": "5,1-15%",
                  "raw": "3. 5,1-15%"
                },
                {
                  "id": "INN-D.4_O4",
                  "value": "4",
                  "label": "15,1-30%",
                  "raw": "4. 15,1-30%"
                },
                {
                  "id": "INN-D.4_O5",
                  "value": "5",
                  "label": "30,1-60%",
                  "raw": "5. 30,1-60%"
                },
                {
                  "id": "INN-D.4_O6",
                  "value": "6",
                  "label": "> 60%",
                  "raw": "6. > 60%"
                }
              ],
              "row": 500
            },
            {
              "id": "INN-D.5",
              "text": "¿Existe un programa formal de intraemprendimiento?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.5_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-D.5_O2",
                  "value": "2",
                  "label": "Diseñado pero no ejecutado",
                  "raw": "2. Diseñado pero no ejecutado"
                },
                {
                  "id": "INN-D.5_O3",
                  "value": "3",
                  "label": "Sí, esporádico",
                  "raw": "3. Sí, esporádico"
                },
                {
                  "id": "INN-D.5_O4",
                  "value": "4",
                  "label": "Sí, con presupuesto recurrente",
                  "raw": "4. Sí, con presupuesto recurrente"
                }
              ],
              "row": 510
            },
            {
              "id": "INN-D.6",
              "text": "¿La empresa ha definido perfiles de cargo y competencias para roles asociados a innovación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.6_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-D.6_O2",
                  "value": "2",
                  "label": "En diseño",
                  "raw": "2. En diseño"
                },
                {
                  "id": "INN-D.6_O3",
                  "value": "3",
                  "label": "Sí, descritos informalmente",
                  "raw": "3. Sí, descritos informalmente"
                },
                {
                  "id": "INN-D.6_O4",
                  "value": "4",
                  "label": "Sí, formalizados en gestión humana",
                  "raw": "4. Sí, formalizados en gestión humana"
                }
              ],
              "row": 518
            },
            {
              "id": "INN-D.7",
              "text": "Tasa de retención del personal del área de innovación en los últimos 24 meses.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.7_O1",
                  "value": "1",
                  "label": "≤ 50%",
                  "raw": "1. ≤ 50%"
                },
                {
                  "id": "INN-D.7_O2",
                  "value": "2",
                  "label": "51-65%",
                  "raw": "2. 51-65%"
                },
                {
                  "id": "INN-D.7_O3",
                  "value": "3",
                  "label": "66-80%",
                  "raw": "3. 66-80%"
                },
                {
                  "id": "INN-D.7_O4",
                  "value": "4",
                  "label": "81-90%",
                  "raw": "4. 81-90%"
                },
                {
                  "id": "INN-D.7_O5",
                  "value": "5",
                  "label": "91-95%",
                  "raw": "5. 91-95%"
                },
                {
                  "id": "INN-D.7_O6",
                  "value": "6",
                  "label": "> 95%",
                  "raw": "6. > 95%"
                }
              ],
              "row": 526
            },
            {
              "id": "INN-D.8",
              "text": "% del personal en liderazgo que participó activamente en sesiones de innovación en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.8_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-D.8_O2",
                  "value": "2",
                  "label": "0,1-5%",
                  "raw": "2. 0,1-5%"
                },
                {
                  "id": "INN-D.8_O3",
                  "value": "3",
                  "label": "5,1-15%",
                  "raw": "3. 5,1-15%"
                },
                {
                  "id": "INN-D.8_O4",
                  "value": "4",
                  "label": "15,1-30%",
                  "raw": "4. 15,1-30%"
                },
                {
                  "id": "INN-D.8_O5",
                  "value": "5",
                  "label": "30,1-60%",
                  "raw": "5. 30,1-60%"
                },
                {
                  "id": "INN-D.8_O6",
                  "value": "6",
                  "label": "> 60%",
                  "raw": "6. > 60%"
                }
              ],
              "row": 536
            },
            {
              "id": "INN-D.9",
              "text": "Frecuencia con la que la alta gerencia comunica la estrategia de innovación a toda la organización.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.9_O1",
                  "value": "1",
                  "label": "Nunca",
                  "raw": "1. Nunca"
                },
                {
                  "id": "INN-D.9_O2",
                  "value": "2",
                  "label": "Anual",
                  "raw": "2. Anual"
                },
                {
                  "id": "INN-D.9_O3",
                  "value": "3",
                  "label": "Semestral",
                  "raw": "3. Semestral"
                },
                {
                  "id": "INN-D.9_O4",
                  "value": "4",
                  "label": "Trimestral",
                  "raw": "4. Trimestral"
                },
                {
                  "id": "INN-D.9_O5",
                  "value": "5",
                  "label": "Mensual",
                  "raw": "5. Mensual"
                },
                {
                  "id": "INN-D.9_O6",
                  "value": "6",
                  "label": "Más frecuente",
                  "raw": "6. Más frecuente"
                }
              ],
              "row": 546
            },
            {
              "id": "INN-D.10",
              "text": "¿La empresa tiene canales formales para que cualquier colaborador proponga ideas y reciba respuesta?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.10_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-D.10_O2",
                  "value": "2",
                  "label": "Existe pero inactivo",
                  "raw": "2. Existe pero inactivo"
                },
                {
                  "id": "INN-D.10_O3",
                  "value": "3",
                  "label": "Sí, canal sin SLA",
                  "raw": "3. Sí, canal sin SLA"
                },
                {
                  "id": "INN-D.10_O4",
                  "value": "4",
                  "label": "Sí, plataforma con SLA documentado",
                  "raw": "4. Sí, plataforma con SLA documentado"
                }
              ],
              "row": 556
            },
            {
              "id": "INN-D.11",
              "text": "% de ideas de colaboradores que recibieron retroalimentación documentada en el último año.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.11_O1",
                  "value": "1",
                  "label": "0%",
                  "raw": "1. 0%"
                },
                {
                  "id": "INN-D.11_O2",
                  "value": "2",
                  "label": "0,1-5%",
                  "raw": "2. 0,1-5%"
                },
                {
                  "id": "INN-D.11_O3",
                  "value": "3",
                  "label": "5,1-15%",
                  "raw": "3. 5,1-15%"
                },
                {
                  "id": "INN-D.11_O4",
                  "value": "4",
                  "label": "15,1-30%",
                  "raw": "4. 15,1-30%"
                },
                {
                  "id": "INN-D.11_O5",
                  "value": "5",
                  "label": "30,1-60%",
                  "raw": "5. 30,1-60%"
                },
                {
                  "id": "INN-D.11_O6",
                  "value": "6",
                  "label": "> 60%",
                  "raw": "6. > 60%"
                }
              ],
              "row": 564
            },
            {
              "id": "INN-D.12",
              "text": "¿Existe un espacio físico o virtual dedicado para sesiones de creatividad o prototipado?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.12_O1",
                  "value": "1",
                  "label": "No",
                  "raw": "1. No"
                },
                {
                  "id": "INN-D.12_O2",
                  "value": "2",
                  "label": "Solo virtual",
                  "raw": "2. Solo virtual"
                },
                {
                  "id": "INN-D.12_O3",
                  "value": "3",
                  "label": "Solo físico",
                  "raw": "3. Solo físico"
                },
                {
                  "id": "INN-D.12_O4",
                  "value": "4",
                  "label": "Sí, físico y virtual",
                  "raw": "4. Sí, físico y virtual"
                }
              ],
              "row": 574
            },
            {
              "id": "INN-D.13",
              "text": "Los líderes son ejemplo visible de la conducta innovadora que esperan del equipo.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.13_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-D.13_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-D.13_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-D.13_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-D.13_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-D.13_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 582
            },
            {
              "id": "INN-D.14",
              "text": "El error de buena fe en innovación no se castiga; se documenta y se aprende.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.14_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-D.14_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-D.14_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-D.14_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-D.14_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-D.14_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 592
            },
            {
              "id": "INN-D.15",
              "text": "Cualquier colaborador puede expresar desacuerdo con propuestas de innovación sin consecuencias.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.15_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-D.15_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-D.15_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-D.15_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-D.15_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-D.15_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 602
            },
            {
              "id": "INN-D.16",
              "text": "La empresa promueve activamente la diversidad de pensamiento en los equipos de innovación.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.16_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-D.16_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-D.16_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-D.16_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-D.16_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-D.16_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 612
            },
            {
              "id": "INN-D.17",
              "text": "La cultura soporta consistentemente la innovación; no depende de iniciativas aisladas de líderes.",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INN-D.17_O1",
                  "value": "1",
                  "label": "Totalmente en desacuerdo",
                  "raw": "1. Totalmente en desacuerdo"
                },
                {
                  "id": "INN-D.17_O2",
                  "value": "2",
                  "label": "Bastante en desacuerdo",
                  "raw": "2. Bastante en desacuerdo"
                },
                {
                  "id": "INN-D.17_O3",
                  "value": "3",
                  "label": "Algo en desacuerdo",
                  "raw": "3. Algo en desacuerdo"
                },
                {
                  "id": "INN-D.17_O4",
                  "value": "4",
                  "label": "Algo de acuerdo",
                  "raw": "4. Algo de acuerdo"
                },
                {
                  "id": "INN-D.17_O5",
                  "value": "5",
                  "label": "Bastante de acuerdo",
                  "raw": "5. Bastante de acuerdo"
                },
                {
                  "id": "INN-D.17_O6",
                  "value": "6",
                  "label": "Totalmente de acuerdo",
                  "raw": "6. Totalmente de acuerdo"
                }
              ],
              "row": 622
            }
          ]
        }
      ]
    },
    {
      "id": "INV",
      "name": "Inversión",
      "title": "Nodo 2 — Inversión (CAPEX)",
      "sheetName": "Inversión",
      "modules": [
        {
          "id": "INV-A",
          "letter": "A",
          "title": "[INV]  Módulo A — Capacidad y Gobierno de Inversión",
          "questions": [
            {
              "id": "INV-A.1",
              "text": "¿La empresa tiene activos fijos productivos propios en operación?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-A.1_O1",
                  "value": "1",
                  "label": "Sí, en propiedad",
                  "raw": "1. Sí, en propiedad"
                },
                {
                  "id": "INV-A.1_O2",
                  "value": "2",
                  "label": "Sí, bajo arrendamiento financiero / leasing",
                  "raw": "2. Sí, bajo arrendamiento financiero / leasing"
                },
                {
                  "id": "INV-A.1_O3",
                  "value": "3",
                  "label": "Combinación de propiedad y leasing",
                  "raw": "3. Combinación de propiedad y leasing"
                },
                {
                  "id": "INV-A.1_O4",
                  "value": "4",
                  "label": "No — la operación es principalmente tercerizada",
                  "raw": "4. No — la operación es principalmente tercerizada"
                }
              ],
              "row": 12
            },
            {
              "id": "INV-A.2",
              "text": "¿La empresa tiene un proceso formal de presupuesto y aprobación para sus inversiones en capital?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-A.2_O1",
                  "value": "1",
                  "label": "Sí, presupuesto anual de CAPEX aprobado por junta",
                  "raw": "1. Sí, presupuesto anual de CAPEX aprobado por junta"
                },
                {
                  "id": "INV-A.2_O2",
                  "value": "2",
                  "label": "Sí, proceso interno sin revisión formal de junta",
                  "raw": "2. Sí, proceso interno sin revisión formal de junta"
                },
                {
                  "id": "INV-A.2_O3",
                  "value": "3",
                  "label": "Las inversiones se deciden caso a caso",
                  "raw": "3. Las inversiones se deciden caso a caso"
                },
                {
                  "id": "INV-A.2_O4",
                  "value": "4",
                  "label": "No existe un proceso definido",
                  "raw": "4. No existe un proceso definido"
                }
              ],
              "row": 20
            },
            {
              "id": "INV-A.3",
              "text": "¿Qué criterio predomina al momento de priorizar una inversión en capital?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-A.3_O1",
                  "value": "1",
                  "label": "Necesidad operativa urgente / equipo fuera de servicio",
                  "raw": "1. Necesidad operativa urgente / equipo fuera de servicio"
                },
                {
                  "id": "INV-A.3_O2",
                  "value": "2",
                  "label": "Cumplimiento regulatorio o de certificación",
                  "raw": "2. Cumplimiento regulatorio o de certificación"
                },
                {
                  "id": "INV-A.3_O3",
                  "value": "3",
                  "label": "Rentabilidad esperada (VPN, TIR u otro análisis formal)",
                  "raw": "3. Rentabilidad esperada (VPN, TIR u otro análisis formal)"
                },
                {
                  "id": "INV-A.3_O4",
                  "value": "4",
                  "label": "Estrategia de expansión o ganancia de competitividad",
                  "raw": "4. Estrategia de expansión o ganancia de competitividad"
                },
                {
                  "id": "INV-A.3_O5",
                  "value": "5",
                  "label": "Directriz de casa matriz o grupo empresarial",
                  "raw": "5. Directriz de casa matriz o grupo empresarial"
                },
                {
                  "id": "INV-A.3_O6",
                  "value": "6",
                  "label": "Otro",
                  "raw": "6. Otro"
                }
              ],
              "row": 28
            }
          ]
        },
        {
          "id": "INV-B",
          "letter": "B",
          "title": "[INV]  Módulo B — Magnitud e Intensidad del CAPEX",
          "questions": [
            {
              "id": "INV-B.1",
              "text": "CAPEX total ejecutado — Año 1 (hace 3 años)",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-B.1_O1",
                  "value": "1",
                  "label": "Menos de $500M COP",
                  "raw": "1. Menos de $500M COP"
                },
                {
                  "id": "INV-B.1_O2",
                  "value": "2",
                  "label": "$500M - $2.000M COP",
                  "raw": "2. $500M - $2.000M COP"
                },
                {
                  "id": "INV-B.1_O3",
                  "value": "3",
                  "label": "$2.000M - $5.000M COP",
                  "raw": "3. $2.000M - $5.000M COP"
                },
                {
                  "id": "INV-B.1_O4",
                  "value": "4",
                  "label": "$5.000M - $20.000M COP",
                  "raw": "4. $5.000M - $20.000M COP"
                },
                {
                  "id": "INV-B.1_O5",
                  "value": "5",
                  "label": "$20.000M - $50.000M COP",
                  "raw": "5. $20.000M - $50.000M COP"
                },
                {
                  "id": "INV-B.1_O6",
                  "value": "6",
                  "label": "Más de $50.000M COP",
                  "raw": "6. Más de $50.000M COP"
                }
              ],
              "row": 42
            },
            {
              "id": "INV-B.2",
              "text": "CAPEX total ejecutado — Año 2 (hace 2 años)",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-B.2_O1",
                  "value": "1",
                  "label": "Menos de $500M COP",
                  "raw": "1. Menos de $500M COP"
                },
                {
                  "id": "INV-B.2_O2",
                  "value": "2",
                  "label": "$500M - $2.000M COP",
                  "raw": "2. $500M - $2.000M COP"
                },
                {
                  "id": "INV-B.2_O3",
                  "value": "3",
                  "label": "$2.000M - $5.000M COP",
                  "raw": "3. $2.000M - $5.000M COP"
                },
                {
                  "id": "INV-B.2_O4",
                  "value": "4",
                  "label": "$5.000M - $20.000M COP",
                  "raw": "4. $5.000M - $20.000M COP"
                },
                {
                  "id": "INV-B.2_O5",
                  "value": "5",
                  "label": "$20.000M - $50.000M COP",
                  "raw": "5. $20.000M - $50.000M COP"
                },
                {
                  "id": "INV-B.2_O6",
                  "value": "6",
                  "label": "Más de $50.000M COP",
                  "raw": "6. Más de $50.000M COP"
                }
              ],
              "row": 52
            },
            {
              "id": "INV-B.3",
              "text": "CAPEX total ejecutado — Año 3 (último año)",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-B.3_O1",
                  "value": "1",
                  "label": "Menos de $500M COP",
                  "raw": "1. Menos de $500M COP"
                },
                {
                  "id": "INV-B.3_O2",
                  "value": "2",
                  "label": "$500M - $2.000M COP",
                  "raw": "2. $500M - $2.000M COP"
                },
                {
                  "id": "INV-B.3_O3",
                  "value": "3",
                  "label": "$2.000M - $5.000M COP",
                  "raw": "3. $2.000M - $5.000M COP"
                },
                {
                  "id": "INV-B.3_O4",
                  "value": "4",
                  "label": "$5.000M - $20.000M COP",
                  "raw": "4. $5.000M - $20.000M COP"
                },
                {
                  "id": "INV-B.3_O5",
                  "value": "5",
                  "label": "$20.000M - $50.000M COP",
                  "raw": "5. $20.000M - $50.000M COP"
                },
                {
                  "id": "INV-B.3_O6",
                  "value": "6",
                  "label": "Más de $50.000M COP",
                  "raw": "6. Más de $50.000M COP"
                }
              ],
              "row": 62
            },
            {
              "id": "INV-B.4",
              "text": "¿Cómo describiría la tendencia de la inversión en capital en los últimos 3 años?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-B.4_O1",
                  "value": "1",
                  "label": "Creciente — invirtió más cada año",
                  "raw": "1. Creciente — invirtió más cada año"
                },
                {
                  "id": "INV-B.4_O2",
                  "value": "2",
                  "label": "Estable — niveles similares año a año",
                  "raw": "2. Estable — niveles similares año a año"
                },
                {
                  "id": "INV-B.4_O3",
                  "value": "3",
                  "label": "Decreciente — invirtió menos cada año",
                  "raw": "3. Decreciente — invirtió menos cada año"
                },
                {
                  "id": "INV-B.4_O4",
                  "value": "4",
                  "label": "Variable — con picos por proyectos no recurrentes",
                  "raw": "4. Variable — con picos por proyectos no recurrentes"
                }
              ],
              "row": 72
            },
            {
              "id": "INV-B.5",
              "text": "¿Qué porcentaje aproximado de los ingresos operacionales destina anualmente la empresa a CAPEX?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-B.5_O1",
                  "value": "1",
                  "label": "Menos del 1%",
                  "raw": "1. Menos del 1%"
                },
                {
                  "id": "INV-B.5_O2",
                  "value": "2",
                  "label": "Entre 1% y 3%",
                  "raw": "2. Entre 1% y 3%"
                },
                {
                  "id": "INV-B.5_O3",
                  "value": "3",
                  "label": "Entre 3% y 6%",
                  "raw": "3. Entre 3% y 6%"
                },
                {
                  "id": "INV-B.5_O4",
                  "value": "4",
                  "label": "Entre 6% y 10%",
                  "raw": "4. Entre 6% y 10%"
                },
                {
                  "id": "INV-B.5_O5",
                  "value": "5",
                  "label": "Entre 10% y 20%",
                  "raw": "5. Entre 10% y 20%"
                },
                {
                  "id": "INV-B.5_O6",
                  "value": "6",
                  "label": "Más del 20%",
                  "raw": "6. Más del 20%"
                },
                {
                  "id": "INV-B.5_O7",
                  "value": "7",
                  "label": "No calcula este indicador",
                  "raw": "7. No calcula este indicador"
                }
              ],
              "row": 80
            }
          ]
        },
        {
          "id": "INV-C",
          "letter": "C",
          "title": "[INV]  Módulo C — Composición y Destino del CAPEX",
          "questions": [
            {
              "id": "INV-C.1",
              "text": "¿Qué proporción del CAPEX total corresponde a mantenimiento versus expansión de capacidad?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-C.1_O1",
                  "value": "1",
                  "label": "Principalmente mantenimiento y reposición (> 70%)",
                  "raw": "1. Principalmente mantenimiento y reposición (> 70%)"
                },
                {
                  "id": "INV-C.1_O2",
                  "value": "2",
                  "label": "Mayoría mantenimiento con algo de expansión (50-70% mant.)",
                  "raw": "2. Mayoría mantenimiento con algo de expansión (50-70% mant.)"
                },
                {
                  "id": "INV-C.1_O3",
                  "value": "3",
                  "label": "Equilibrado entre mantenimiento y expansión",
                  "raw": "3. Equilibrado entre mantenimiento y expansión"
                },
                {
                  "id": "INV-C.1_O4",
                  "value": "4",
                  "label": "Mayoría expansión con algo de mantenimiento (50-70% exp.)",
                  "raw": "4. Mayoría expansión con algo de mantenimiento (50-70% exp.)"
                },
                {
                  "id": "INV-C.1_O5",
                  "value": "5",
                  "label": "Principalmente expansión y crecimiento (> 70%)",
                  "raw": "5. Principalmente expansión y crecimiento (> 70%)"
                }
              ],
              "row": 95
            },
            {
              "id": "INV-C.2",
              "text": "Principal tipo de activo en el que se concentra el CAPEX (por participación % mayor)",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-C.2_O1",
                  "value": "1",
                  "label": "Maquinaria y equipo",
                  "raw": "1. Maquinaria y equipo"
                },
                {
                  "id": "INV-C.2_O2",
                  "value": "2",
                  "label": "Infraestructura / edificaciones",
                  "raw": "2. Infraestructura / edificaciones"
                },
                {
                  "id": "INV-C.2_O3",
                  "value": "3",
                  "label": "Tecnología productiva",
                  "raw": "3. Tecnología productiva"
                },
                {
                  "id": "INV-C.2_O4",
                  "value": "4",
                  "label": "TI / Digitalización",
                  "raw": "4. TI / Digitalización"
                },
                {
                  "id": "INV-C.2_O5",
                  "value": "5",
                  "label": "I+D aplicado (gasto productivo)",
                  "raw": "5. I+D aplicado (gasto productivo)"
                },
                {
                  "id": "INV-C.2_O6",
                  "value": "6",
                  "label": "Activos intangibles",
                  "raw": "6. Activos intangibles"
                },
                {
                  "id": "INV-C.2_O7",
                  "value": "7",
                  "label": "Otro",
                  "raw": "7. Otro"
                }
              ],
              "row": 104
            },
            {
              "id": "INV-C.3",
              "text": "Principal propósito de ese activo",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-C.3_O1",
                  "value": "1",
                  "label": "Mantenimiento / Reposición",
                  "raw": "1. Mantenimiento / Reposición"
                },
                {
                  "id": "INV-C.3_O2",
                  "value": "2",
                  "label": "Expansión de capacidad",
                  "raw": "2. Expansión de capacidad"
                },
                {
                  "id": "INV-C.3_O3",
                  "value": "3",
                  "label": "Actualización tecnológica",
                  "raw": "3. Actualización tecnológica"
                },
                {
                  "id": "INV-C.3_O4",
                  "value": "4",
                  "label": "Innovación / I+D aplicado",
                  "raw": "4. Innovación / I+D aplicado"
                }
              ],
              "row": 115
            },
            {
              "id": "INV-C.4",
              "text": "¿La empresa identifica explícitamente una parte de su inversión como destinada a innovación o I+D?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-C.4_O1",
                  "value": "1",
                  "label": "Sí, rubro presupuestal separada para innovación / I+D",
                  "raw": "1. Sí, rubro presupuestal separada para innovación / I+D"
                },
                {
                  "id": "INV-C.4_O2",
                  "value": "2",
                  "label": "Sí, embebida en otros rubros sin separación formal",
                  "raw": "2. Sí, embebida en otros rubros sin separación formal"
                },
                {
                  "id": "INV-C.4_O3",
                  "value": "3",
                  "label": "No — no existe esa distinción en el presupuesto",
                  "raw": "3. No — no existe esa distinción en el presupuesto"
                },
                {
                  "id": "INV-C.4_O4",
                  "value": "4",
                  "label": "Está en proceso de crear esa categoría",
                  "raw": "4. Está en proceso de crear esa categoría"
                }
              ],
              "row": 123
            }
          ]
        },
        {
          "id": "INV-D",
          "letter": "D",
          "title": "[INV]  Módulo D — Fuentes de Financiación",
          "questions": [
            {
              "id": "INV-D.1",
              "text": "¿Cuál es la principal fuente de financiación del CAPEX de la empresa?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INV-D.1_O1",
                  "value": "1",
                  "label": "Reinversión de utilidades propias de la operación local",
                  "raw": "1. Reinversión de utilidades propias de la operación local"
                },
                {
                  "id": "INV-D.1_O2",
                  "value": "2",
                  "label": "Crédito bancario del sistema financiero colombiano",
                  "raw": "2. Crédito bancario del sistema financiero colombiano"
                },
                {
                  "id": "INV-D.1_O3",
                  "value": "3",
                  "label": "Crédito de banca de desarrollo (Bancóldex, Findeter, IFC)",
                  "raw": "3. Crédito de banca de desarrollo (Bancóldex, Findeter, IFC)"
                },
                {
                  "id": "INV-D.1_O4",
                  "value": "4",
                  "label": "Leasing financiero u operativo",
                  "raw": "4. Leasing financiero u operativo"
                },
                {
                  "id": "INV-D.1_O5",
                  "value": "5",
                  "label": "Recursos de casa matriz o grupo empresarial",
                  "raw": "5. Recursos de casa matriz o grupo empresarial"
                },
                {
                  "id": "INV-D.1_O6",
                  "value": "6",
                  "label": "Inversión extranjera directa o capital externo nuevo",
                  "raw": "6. Inversión extranjera directa o capital externo nuevo"
                },
                {
                  "id": "INV-D.1_O7",
                  "value": "7",
                  "label": "Emisión de deuda o bonos en mercado de capitales",
                  "raw": "7. Emisión de deuda o bonos en mercado de capitales"
                },
                {
                  "id": "INV-D.1_O8",
                  "value": "8",
                  "label": "Otro",
                  "raw": "8. Otro"
                }
              ],
              "row": 135
            },
            {
              "id": "INV-D.2",
              "text": "¿Qué proporción del CAPEX de los últimos 3 años provino de reinversión de utilidades de la operación local?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-D.2_O1",
                  "value": "1",
                  "label": "Menos del 25%",
                  "raw": "1. Menos del 25%"
                },
                {
                  "id": "INV-D.2_O2",
                  "value": "2",
                  "label": "Entre 25% y 50%",
                  "raw": "2. Entre 25% y 50%"
                },
                {
                  "id": "INV-D.2_O3",
                  "value": "3",
                  "label": "Entre 50% y 75%",
                  "raw": "3. Entre 50% y 75%"
                },
                {
                  "id": "INV-D.2_O4",
                  "value": "4",
                  "label": "Más del 75%",
                  "raw": "4. Más del 75%"
                },
                {
                  "id": "INV-D.2_O5",
                  "value": "5",
                  "label": "No aplica — no se financia con utilidades propias",
                  "raw": "5. No aplica — no se financia con utilidades propias"
                },
                {
                  "id": "INV-D.2_O6",
                  "value": "6",
                  "label": "No lo tiene cuantificado",
                  "raw": "6. No lo tiene cuantificado"
                }
              ],
              "row": 147
            }
          ]
        },
        {
          "id": "INV-E",
          "letter": "E",
          "title": "[INV]  Módulo E — Perspectiva Estratégica e Intención Inversora",
          "questions": [
            {
              "id": "INV-E.1",
              "text": "¿Cuál es el principal obstáculo para ejecutar la inversión en capital planeada?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INV-E.1_O1",
                  "value": "1",
                  "label": "Acceso o costo del financiamiento",
                  "raw": "1. Acceso o costo del financiamiento"
                },
                {
                  "id": "INV-E.1_O2",
                  "value": "2",
                  "label": "Incertidumbre macroeconómica o política",
                  "raw": "2. Incertidumbre macroeconómica o política"
                },
                {
                  "id": "INV-E.1_O3",
                  "value": "3",
                  "label": "Baja demanda o incertidumbre de mercado",
                  "raw": "3. Baja demanda o incertidumbre de mercado"
                },
                {
                  "id": "INV-E.1_O4",
                  "value": "4",
                  "label": "Incertidumbre regulatoria o cambios normativos",
                  "raw": "4. Incertidumbre regulatoria o cambios normativos"
                },
                {
                  "id": "INV-E.1_O5",
                  "value": "5",
                  "label": "Disponibilidad de proveedores o restricciones a importaciones",
                  "raw": "5. Disponibilidad de proveedores o restricciones a importaciones"
                },
                {
                  "id": "INV-E.1_O6",
                  "value": "6",
                  "label": "Capacidad interna de ejecución de proyectos",
                  "raw": "6. Capacidad interna de ejecución de proyectos"
                },
                {
                  "id": "INV-E.1_O7",
                  "value": "7",
                  "label": "Demoras en permisos, licencias o trámites",
                  "raw": "7. Demoras en permisos, licencias o trámites"
                },
                {
                  "id": "INV-E.1_O8",
                  "value": "8",
                  "label": "Restricciones o directrices de casa matriz",
                  "raw": "8. Restricciones o directrices de casa matriz"
                },
                {
                  "id": "INV-E.1_O9",
                  "value": "9",
                  "label": "No tiene obstáculos significativos",
                  "raw": "9. No tiene obstáculos significativos"
                },
                {
                  "id": "INV-E.1_O10",
                  "value": "10",
                  "label": "Otro",
                  "raw": "10. Otro"
                }
              ],
              "row": 161
            },
            {
              "id": "INV-E.2",
              "text": "¿La empresa tiene proyecciones formales de CAPEX para los próximos 2 o 3 años?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-E.2_O1",
                  "value": "1",
                  "label": "Sí, presupuesto plurianual de inversión aprobado",
                  "raw": "1. Sí, presupuesto plurianual de inversión aprobado"
                },
                {
                  "id": "INV-E.2_O2",
                  "value": "2",
                  "label": "Sí, estimaciones preliminares en proceso",
                  "raw": "2. Sí, estimaciones preliminares en proceso"
                },
                {
                  "id": "INV-E.2_O3",
                  "value": "3",
                  "label": "No — las inversiones se definen año a año",
                  "raw": "3. No — las inversiones se definen año a año"
                },
                {
                  "id": "INV-E.2_O4",
                  "value": "4",
                  "label": "No existe planeación de mediano plazo",
                  "raw": "4. No existe planeación de mediano plazo"
                }
              ],
              "row": 175
            },
            {
              "id": "INV-E.3",
              "text": "En comparación con los últimos 3 años, ¿cuál es la intención inversora para los próximos 2 a 3 años?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INV-E.3_O1",
                  "value": "1",
                  "label": "Aumentar significativamente (> 30% por encima)",
                  "raw": "1. Aumentar significativamente (> 30% por encima)"
                },
                {
                  "id": "INV-E.3_O2",
                  "value": "2",
                  "label": "Aumentar moderadamente (entre 10% y 30% más)",
                  "raw": "2. Aumentar moderadamente (entre 10% y 30% más)"
                },
                {
                  "id": "INV-E.3_O3",
                  "value": "3",
                  "label": "Mantener niveles similares",
                  "raw": "3. Mantener niveles similares"
                },
                {
                  "id": "INV-E.3_O4",
                  "value": "4",
                  "label": "Reducir de manera temporal",
                  "raw": "4. Reducir de manera temporal"
                },
                {
                  "id": "INV-E.3_O5",
                  "value": "5",
                  "label": "Reducir de forma estructural",
                  "raw": "5. Reducir de forma estructural"
                },
                {
                  "id": "INV-E.3_O6",
                  "value": "6",
                  "label": "No tiene proyección definida",
                  "raw": "6. No tiene proyección definida"
                }
              ],
              "row": 183
            }
          ]
        }
      ]
    },
    {
      "id": "INT",
      "name": "Internacionalización",
      "title": "Nodo 3 — Internacionalización",
      "sheetName": "Internacionalización",
      "modules": [
        {
          "id": "INT-A",
          "letter": "A",
          "title": "[INT]  Módulo A — Experiencia Internacional",
          "questions": [
            {
              "id": "INT-A.1",
              "text": "¿La empresa ha tenido alguna vez operaciones, ventas o vínculos comerciales con el exterior?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-A.1_O1",
                  "value": "1",
                  "label": "Sí, actualmente tiene operaciones internacionales activas",
                  "raw": "1. Sí, actualmente tiene operaciones internacionales activas"
                },
                {
                  "id": "INT-A.1_O2",
                  "value": "2",
                  "label": "Sí, tuvo en el pasado pero hoy no tiene",
                  "raw": "2. Sí, tuvo en el pasado pero hoy no tiene"
                },
                {
                  "id": "INT-A.1_O3",
                  "value": "3",
                  "label": "No, nunca ha tenido → Pase a Módulo G",
                  "raw": "3. No, nunca ha tenido → Pase a Módulo G"
                }
              ],
              "row": 12
            },
            {
              "id": "INT-A.2",
              "text": "¿En qué período tuvo o tiene su primera operación internacional?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-A.2_O1",
                  "value": "1",
                  "label": "Antes de 1990",
                  "raw": "1. Antes de 1990"
                },
                {
                  "id": "INT-A.2_O2",
                  "value": "2",
                  "label": "Entre 1990 y 1999",
                  "raw": "2. Entre 1990 y 1999"
                },
                {
                  "id": "INT-A.2_O3",
                  "value": "3",
                  "label": "Entre 2000 y 2009",
                  "raw": "3. Entre 2000 y 2009"
                },
                {
                  "id": "INT-A.2_O4",
                  "value": "4",
                  "label": "Entre 2010 y 2019",
                  "raw": "4. Entre 2010 y 2019"
                },
                {
                  "id": "INT-A.2_O5",
                  "value": "5",
                  "label": "Entre 2020 y 2025",
                  "raw": "5. Entre 2020 y 2025"
                }
              ],
              "row": 19
            },
            {
              "id": "INT-A.3",
              "text": "¿Cuál es la principal forma de internacionalización que tiene o ha tenido la empresa?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INT-A.3_O1",
                  "value": "1",
                  "label": "Exportación directa de bienes físicos",
                  "raw": "1. Exportación directa de bienes físicos"
                },
                {
                  "id": "INT-A.3_O2",
                  "value": "2",
                  "label": "Exportación indirecta de bienes (intermediario)",
                  "raw": "2. Exportación indirecta de bienes (intermediario)"
                },
                {
                  "id": "INT-A.3_O3",
                  "value": "3",
                  "label": "Exportación de servicios",
                  "raw": "3. Exportación de servicios"
                },
                {
                  "id": "INT-A.3_O4",
                  "value": "4",
                  "label": "Oficina comercial propia en el exterior",
                  "raw": "4. Oficina comercial propia en el exterior"
                },
                {
                  "id": "INT-A.3_O5",
                  "value": "5",
                  "label": "Tiendas propias o puntos de venta en el exterior",
                  "raw": "5. Tiendas propias o puntos de venta en el exterior"
                },
                {
                  "id": "INT-A.3_O6",
                  "value": "6",
                  "label": "Representante o agente comercial en el exterior",
                  "raw": "6. Representante o agente comercial en el exterior"
                },
                {
                  "id": "INT-A.3_O7",
                  "value": "7",
                  "label": "Franquicia internacional",
                  "raw": "7. Franquicia internacional"
                },
                {
                  "id": "INT-A.3_O8",
                  "value": "8",
                  "label": "Planta de producción en el exterior",
                  "raw": "8. Planta de producción en el exterior"
                },
                {
                  "id": "INT-A.3_O9",
                  "value": "9",
                  "label": "Joint venture con empresa extranjera",
                  "raw": "9. Joint venture con empresa extranjera"
                },
                {
                  "id": "INT-A.3_O10",
                  "value": "10",
                  "label": "Licencia o transferencia de tecnología / PI",
                  "raw": "10. Licencia o transferencia de tecnología / PI"
                },
                {
                  "id": "INT-A.3_O11",
                  "value": "11",
                  "label": "Servicios digitales a clientes extranjeros",
                  "raw": "11. Servicios digitales a clientes extranjeros"
                },
                {
                  "id": "INT-A.3_O12",
                  "value": "12",
                  "label": "Atención a clientes extranjeros en Colombia",
                  "raw": "12. Atención a clientes extranjeros en Colombia"
                },
                {
                  "id": "INT-A.3_O13",
                  "value": "13",
                  "label": "Inversión directa en el exterior",
                  "raw": "13. Inversión directa en el exterior"
                }
              ],
              "row": 28
            },
            {
              "id": "INT-A.4",
              "text": "¿Cuál fue la razón principal por la que la empresa cesó sus operaciones internacionales? (Solo si ya no opera)",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-A.4_O1",
                  "value": "1",
                  "label": "No aplica — la empresa sí opera internacionalmente",
                  "raw": "1. No aplica — la empresa sí opera internacionalmente"
                },
                {
                  "id": "INT-A.4_O2",
                  "value": "2",
                  "label": "Pérdida de competitividad en precio",
                  "raw": "2. Pérdida de competitividad en precio"
                },
                {
                  "id": "INT-A.4_O3",
                  "value": "3",
                  "label": "Problemas de calidad o cumplimiento de estándares",
                  "raw": "3. Problemas de calidad o cumplimiento de estándares"
                },
                {
                  "id": "INT-A.4_O4",
                  "value": "4",
                  "label": "Volatilidad del tipo de cambio o riesgo cambiario",
                  "raw": "4. Volatilidad del tipo de cambio o riesgo cambiario"
                },
                {
                  "id": "INT-A.4_O5",
                  "value": "5",
                  "label": "Barreras arancelarias o no arancelarias",
                  "raw": "5. Barreras arancelarias o no arancelarias"
                },
                {
                  "id": "INT-A.4_O6",
                  "value": "6",
                  "label": "Cambio en la estrategia corporativa",
                  "raw": "6. Cambio en la estrategia corporativa"
                },
                {
                  "id": "INT-A.4_O7",
                  "value": "7",
                  "label": "Crisis del mercado destino",
                  "raw": "7. Crisis del mercado destino"
                },
                {
                  "id": "INT-A.4_O8",
                  "value": "8",
                  "label": "Falta de capacidad productiva",
                  "raw": "8. Falta de capacidad productiva"
                },
                {
                  "id": "INT-A.4_O9",
                  "value": "9",
                  "label": "Dificultades logísticas o de transporte",
                  "raw": "9. Dificultades logísticas o de transporte"
                },
                {
                  "id": "INT-A.4_O10",
                  "value": "10",
                  "label": "Otras razones",
                  "raw": "10. Otras razones"
                }
              ],
              "row": 45
            },
            {
              "id": "INT-A.5",
              "text": "¿En cuántos países distintos tiene o tuvo presencia la empresa?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-A.5_O1",
                  "value": "1",
                  "label": "1 a 2 países",
                  "raw": "1. 1 a 2 países"
                },
                {
                  "id": "INT-A.5_O2",
                  "value": "2",
                  "label": "3 a 5 países",
                  "raw": "2. 3 a 5 países"
                },
                {
                  "id": "INT-A.5_O3",
                  "value": "3",
                  "label": "6 a 10 países",
                  "raw": "3. 6 a 10 países"
                },
                {
                  "id": "INT-A.5_O4",
                  "value": "4",
                  "label": "Más de 10 países",
                  "raw": "4. Más de 10 países"
                }
              ],
              "row": 59
            },
            {
              "id": "INT-A.6",
              "text": "¿Cuáles regiones del mundo son o fueron los destinos principales de las operaciones internacionales?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INT-A.6_O1",
                  "value": "1",
                  "label": "América Latina y El Caribe",
                  "raw": "1. América Latina y El Caribe"
                },
                {
                  "id": "INT-A.6_O2",
                  "value": "2",
                  "label": "América del Norte (EE.UU., Canadá, México)",
                  "raw": "2. América del Norte (EE.UU., Canadá, México)"
                },
                {
                  "id": "INT-A.6_O3",
                  "value": "3",
                  "label": "Europa (UE y Reino Unido)",
                  "raw": "3. Europa (UE y Reino Unido)"
                },
                {
                  "id": "INT-A.6_O4",
                  "value": "4",
                  "label": "Asia (China, Japón, India, Corea del Sur)",
                  "raw": "4. Asia (China, Japón, India, Corea del Sur)"
                },
                {
                  "id": "INT-A.6_O5",
                  "value": "5",
                  "label": "África",
                  "raw": "5. África"
                },
                {
                  "id": "INT-A.6_O6",
                  "value": "6",
                  "label": "Medio Oriente",
                  "raw": "6. Medio Oriente"
                },
                {
                  "id": "INT-A.6_O7",
                  "value": "7",
                  "label": "Oceanía",
                  "raw": "7. Oceanía"
                }
              ],
              "row": 67
            }
          ]
        },
        {
          "id": "INT-B",
          "letter": "B",
          "title": "[INT]  Módulo B — Exportación de Bienes",
          "questions": [
            {
              "id": "INT-B.1",
              "text": "¿La empresa exporta o ha exportado bienes directamente?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-B.1_O1",
                  "value": "1",
                  "label": "Sí, actualmente exporta bienes de forma regular",
                  "raw": "1. Sí, actualmente exporta bienes de forma regular"
                },
                {
                  "id": "INT-B.1_O2",
                  "value": "2",
                  "label": "Sí, actualmente exporta de forma ocasional",
                  "raw": "2. Sí, actualmente exporta de forma ocasional"
                },
                {
                  "id": "INT-B.1_O3",
                  "value": "3",
                  "label": "Sí, exportó en el pasado pero dejó de hacerlo",
                  "raw": "3. Sí, exportó en el pasado pero dejó de hacerlo"
                }
              ],
              "row": 82
            },
            {
              "id": "INT-B.2",
              "text": "¿Cuál fue el valor aproximado de las exportaciones de bienes en el último año completo disponible?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-B.2_O1",
                  "value": "1",
                  "label": "Menos de USD $100.000",
                  "raw": "1. Menos de USD $100.000"
                },
                {
                  "id": "INT-B.2_O2",
                  "value": "2",
                  "label": "Entre USD $100.001 y $500.000",
                  "raw": "2. Entre USD $100.001 y $500.000"
                },
                {
                  "id": "INT-B.2_O3",
                  "value": "3",
                  "label": "Entre USD $500.001 y $2.000.000",
                  "raw": "3. Entre USD $500.001 y $2.000.000"
                },
                {
                  "id": "INT-B.2_O4",
                  "value": "4",
                  "label": "Entre USD $2.000.001 y $10.000.000",
                  "raw": "4. Entre USD $2.000.001 y $10.000.000"
                },
                {
                  "id": "INT-B.2_O5",
                  "value": "5",
                  "label": "Más de USD $10.000.000",
                  "raw": "5. Más de USD $10.000.000"
                },
                {
                  "id": "INT-B.2_O6",
                  "value": "6",
                  "label": "No sabe / No informa",
                  "raw": "6. No sabe / No informa"
                }
              ],
              "row": 89
            },
            {
              "id": "INT-B.3",
              "text": "¿Qué porcentaje representan las exportaciones de bienes sobre el total de ingresos de la empresa?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-B.3_O1",
                  "value": "1",
                  "label": "Menos del 5%",
                  "raw": "1. Menos del 5%"
                },
                {
                  "id": "INT-B.3_O2",
                  "value": "2",
                  "label": "Entre el 5% y el 20%",
                  "raw": "2. Entre el 5% y el 20%"
                },
                {
                  "id": "INT-B.3_O3",
                  "value": "3",
                  "label": "Entre el 21% y el 50%",
                  "raw": "3. Entre el 21% y el 50%"
                },
                {
                  "id": "INT-B.3_O4",
                  "value": "4",
                  "label": "Más del 50%",
                  "raw": "4. Más del 50%"
                },
                {
                  "id": "INT-B.3_O5",
                  "value": "5",
                  "label": "No sabe / No calcula",
                  "raw": "5. No sabe / No calcula"
                }
              ],
              "row": 99
            },
            {
              "id": "INT-B.4",
              "text": "¿Cuál es el principal canal de exportación utilizado?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-B.4_O1",
                  "value": "1",
                  "label": "Exportación directa al cliente final en el exterior",
                  "raw": "1. Exportación directa al cliente final en el exterior"
                },
                {
                  "id": "INT-B.4_O2",
                  "value": "2",
                  "label": "A través de distribuidor o importador en el exterior",
                  "raw": "2. A través de distribuidor o importador en el exterior"
                },
                {
                  "id": "INT-B.4_O3",
                  "value": "3",
                  "label": "A través de agente comercial en el exterior",
                  "raw": "3. A través de agente comercial en el exterior"
                },
                {
                  "id": "INT-B.4_O4",
                  "value": "4",
                  "label": "A través de marketplace internacional",
                  "raw": "4. A través de marketplace internacional"
                },
                {
                  "id": "INT-B.4_O5",
                  "value": "5",
                  "label": "A través de sociedad vinculada o filial",
                  "raw": "5. A través de sociedad vinculada o filial"
                },
                {
                  "id": "INT-B.4_O6",
                  "value": "6",
                  "label": "Exportación indirecta (trading company en Colombia)",
                  "raw": "6. Exportación indirecta (trading company en Colombia)"
                }
              ],
              "row": 108
            },
            {
              "id": "INT-B.5",
              "text": "¿Cuántos años consecutivos lleva o llevó la empresa exportando bienes de forma continua?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-B.5_O1",
                  "value": "1",
                  "label": "Menos de 2 años",
                  "raw": "1. Menos de 2 años"
                },
                {
                  "id": "INT-B.5_O2",
                  "value": "2",
                  "label": "Entre 2 y 5 años",
                  "raw": "2. Entre 2 y 5 años"
                },
                {
                  "id": "INT-B.5_O3",
                  "value": "3",
                  "label": "Entre 6 y 10 años",
                  "raw": "3. Entre 6 y 10 años"
                },
                {
                  "id": "INT-B.5_O4",
                  "value": "4",
                  "label": "Entre 11 y 20 años",
                  "raw": "4. Entre 11 y 20 años"
                },
                {
                  "id": "INT-B.5_O5",
                  "value": "5",
                  "label": "Más de 20 años",
                  "raw": "5. Más de 20 años"
                },
                {
                  "id": "INT-B.5_O6",
                  "value": "6",
                  "label": "No aplica — exporta de forma esporádica",
                  "raw": "6. No aplica — exporta de forma esporádica"
                }
              ],
              "row": 118
            },
            {
              "id": "INT-B.6",
              "text": "¿Cuál es la razón principal por la que la empresa no exporta bienes o dejó de exportarlos?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-B.6_O1",
                  "value": "1",
                  "label": "No aplica — la empresa sí exporta bienes",
                  "raw": "1. No aplica — la empresa sí exporta bienes"
                },
                {
                  "id": "INT-B.6_O2",
                  "value": "2",
                  "label": "El mercado interno es suficiente",
                  "raw": "2. El mercado interno es suficiente"
                },
                {
                  "id": "INT-B.6_O3",
                  "value": "3",
                  "label": "Falta de información sobre mercados internacionales",
                  "raw": "3. Falta de información sobre mercados internacionales"
                },
                {
                  "id": "INT-B.6_O4",
                  "value": "4",
                  "label": "Altos costos logísticos y de transporte",
                  "raw": "4. Altos costos logísticos y de transporte"
                },
                {
                  "id": "INT-B.6_O5",
                  "value": "5",
                  "label": "Incumplimiento de estándares o certificaciones",
                  "raw": "5. Incumplimiento de estándares o certificaciones"
                },
                {
                  "id": "INT-B.6_O6",
                  "value": "6",
                  "label": "Capacidad productiva insuficiente",
                  "raw": "6. Capacidad productiva insuficiente"
                },
                {
                  "id": "INT-B.6_O7",
                  "value": "7",
                  "label": "Dificultades con trámites aduaneros",
                  "raw": "7. Dificultades con trámites aduaneros"
                },
                {
                  "id": "INT-B.6_O8",
                  "value": "8",
                  "label": "Barreras de idioma o desconocimiento de prácticas",
                  "raw": "8. Barreras de idioma o desconocimiento de prácticas"
                }
              ],
              "row": 128
            }
          ]
        },
        {
          "id": "INT-C",
          "letter": "C",
          "title": "[INT]  Módulo C — Exportación de Servicios",
          "questions": [
            {
              "id": "INT-C.1",
              "text": "¿La empresa presta o ha prestado servicios a clientes ubicados fuera de Colombia?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-C.1_O1",
                  "value": "1",
                  "label": "Sí, actualmente presta servicios internacionales de forma regular",
                  "raw": "1. Sí, actualmente presta servicios internacionales de forma regular"
                },
                {
                  "id": "INT-C.1_O2",
                  "value": "2",
                  "label": "Sí, actualmente lo hace de forma esporádica",
                  "raw": "2. Sí, actualmente lo hace de forma esporádica"
                },
                {
                  "id": "INT-C.1_O3",
                  "value": "3",
                  "label": "Sí, lo hizo en el pasado pero actualmente no",
                  "raw": "3. Sí, lo hizo en el pasado pero actualmente no"
                },
                {
                  "id": "INT-C.1_O4",
                  "value": "4",
                  "label": "No, nunca ha prestado servicios a clientes extranjeros → Pase a Módulo F",
                  "raw": "4. No, nunca ha prestado servicios a clientes extranjeros → Pase a Módulo F"
                }
              ],
              "row": 144
            },
            {
              "id": "INT-C.2",
              "text": "¿En cuál categoría principal se clasifican los servicios que la empresa exporta o ha exportado?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INT-C.2_O1",
                  "value": "1",
                  "label": "Turismo médico o servicios de salud",
                  "raw": "1. Turismo médico o servicios de salud"
                },
                {
                  "id": "INT-C.2_O2",
                  "value": "2",
                  "label": "Tecnología e informática (software, datos, IA)",
                  "raw": "2. Tecnología e informática (software, datos, IA)"
                },
                {
                  "id": "INT-C.2_O3",
                  "value": "3",
                  "label": "Consultoría empresarial, financiera o legal",
                  "raw": "3. Consultoría empresarial, financiera o legal"
                },
                {
                  "id": "INT-C.2_O4",
                  "value": "4",
                  "label": "Servicios de educación o formación",
                  "raw": "4. Servicios de educación o formación"
                },
                {
                  "id": "INT-C.2_O5",
                  "value": "5",
                  "label": "Servicios creativos y culturales",
                  "raw": "5. Servicios creativos y culturales"
                },
                {
                  "id": "INT-C.2_O6",
                  "value": "6",
                  "label": "Ingeniería, construcción o infraestructura",
                  "raw": "6. Ingeniería, construcción o infraestructura"
                },
                {
                  "id": "INT-C.2_O7",
                  "value": "7",
                  "label": "Logística o transporte internacional",
                  "raw": "7. Logística o transporte internacional"
                },
                {
                  "id": "INT-C.2_O8",
                  "value": "8",
                  "label": "Servicios financieros o de inversión",
                  "raw": "8. Servicios financieros o de inversión"
                },
                {
                  "id": "INT-C.2_O9",
                  "value": "9",
                  "label": "Servicios digitales (plataformas, apps, e-commerce)",
                  "raw": "9. Servicios digitales (plataformas, apps, e-commerce)"
                },
                {
                  "id": "INT-C.2_O10",
                  "value": "10",
                  "label": "Servicios turísticos",
                  "raw": "10. Servicios turísticos"
                },
                {
                  "id": "INT-C.2_O11",
                  "value": "11",
                  "label": "Franquicia de servicios en el exterior",
                  "raw": "11. Franquicia de servicios en el exterior"
                },
                {
                  "id": "INT-C.2_O12",
                  "value": "12",
                  "label": "I+D para clientes internacionales",
                  "raw": "12. I+D para clientes internacionales"
                },
                {
                  "id": "INT-C.2_O13",
                  "value": "13",
                  "label": "Otros",
                  "raw": "13. Otros"
                }
              ],
              "row": 152
            },
            {
              "id": "INT-C.3",
              "text": "¿Cuál es la modalidad principal mediante la cual presta servicios a clientes internacionales?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-C.3_O1",
                  "value": "1",
                  "label": "Completamente remoto (desde Colombia)",
                  "raw": "1. Completamente remoto (desde Colombia)"
                },
                {
                  "id": "INT-C.3_O2",
                  "value": "2",
                  "label": "Con desplazamiento del personal al exterior",
                  "raw": "2. Con desplazamiento del personal al exterior"
                },
                {
                  "id": "INT-C.3_O3",
                  "value": "3",
                  "label": "El cliente extranjero viaja a Colombia",
                  "raw": "3. El cliente extranjero viaja a Colombia"
                },
                {
                  "id": "INT-C.3_O4",
                  "value": "4",
                  "label": "A través de filial u oficina propia en el exterior",
                  "raw": "4. A través de filial u oficina propia en el exterior"
                },
                {
                  "id": "INT-C.3_O5",
                  "value": "5",
                  "label": "Mediante plataforma digital o app en línea",
                  "raw": "5. Mediante plataforma digital o app en línea"
                },
                {
                  "id": "INT-C.3_O6",
                  "value": "6",
                  "label": "Combinación de modalidades",
                  "raw": "6. Combinación de modalidades"
                }
              ],
              "row": 169
            },
            {
              "id": "INT-C.4",
              "text": "¿Cuál fue el valor aproximado de los ingresos por servicios internacionales en el último año fiscal?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-C.4_O1",
                  "value": "1",
                  "label": "Menos de USD $50.000",
                  "raw": "1. Menos de USD $50.000"
                },
                {
                  "id": "INT-C.4_O2",
                  "value": "2",
                  "label": "Entre USD $50.001 y $200.000",
                  "raw": "2. Entre USD $50.001 y $200.000"
                },
                {
                  "id": "INT-C.4_O3",
                  "value": "3",
                  "label": "Entre USD $200.001 y $1.000.000",
                  "raw": "3. Entre USD $200.001 y $1.000.000"
                },
                {
                  "id": "INT-C.4_O4",
                  "value": "4",
                  "label": "Entre USD $1.000.001 y $5.000.000",
                  "raw": "4. Entre USD $1.000.001 y $5.000.000"
                },
                {
                  "id": "INT-C.4_O5",
                  "value": "5",
                  "label": "Más de USD $5.000.000",
                  "raw": "5. Más de USD $5.000.000"
                },
                {
                  "id": "INT-C.4_O6",
                  "value": "6",
                  "label": "No sabe / No informa",
                  "raw": "6. No sabe / No informa"
                }
              ],
              "row": 179
            },
            {
              "id": "INT-C.5",
              "text": "¿La empresa lleva un registro sistemático y separado de sus ingresos provenientes de clientes internacionales?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-C.5_O1",
                  "value": "1",
                  "label": "Sí, cuenta contable separada para ingresos internacionales",
                  "raw": "1. Sí, cuenta contable separada para ingresos internacionales"
                },
                {
                  "id": "INT-C.5_O2",
                  "value": "2",
                  "label": "Sí, los identifica pero no los registra por separado",
                  "raw": "2. Sí, los identifica pero no los registra por separado"
                },
                {
                  "id": "INT-C.5_O3",
                  "value": "3",
                  "label": "No, se consolidan con ingresos nacionales",
                  "raw": "3. No, se consolidan con ingresos nacionales"
                }
              ],
              "row": 189
            },
            {
              "id": "INT-C.6",
              "text": "¿Cuántos países distintos tiene como destino de sus servicios internacionales?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-C.6_O1",
                  "value": "1",
                  "label": "1 país destino",
                  "raw": "1. 1 país destino"
                },
                {
                  "id": "INT-C.6_O2",
                  "value": "2",
                  "label": "Entre 2 y 5 países",
                  "raw": "2. Entre 2 y 5 países"
                },
                {
                  "id": "INT-C.6_O3",
                  "value": "3",
                  "label": "Entre 6 y 10 países",
                  "raw": "3. Entre 6 y 10 países"
                },
                {
                  "id": "INT-C.6_O4",
                  "value": "4",
                  "label": "Más de 10 países",
                  "raw": "4. Más de 10 países"
                }
              ],
              "row": 196
            },
            {
              "id": "INT-C.7",
              "text": "¿Qué porcentaje representan los ingresos por servicios internacionales sobre el total de ingresos?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-C.7_O1",
                  "value": "1",
                  "label": "Menos del 5%",
                  "raw": "1. Menos del 5%"
                },
                {
                  "id": "INT-C.7_O2",
                  "value": "2",
                  "label": "Entre el 5% y el 20%",
                  "raw": "2. Entre el 5% y el 20%"
                },
                {
                  "id": "INT-C.7_O3",
                  "value": "3",
                  "label": "Entre el 21% y el 50%",
                  "raw": "3. Entre el 21% y el 50%"
                },
                {
                  "id": "INT-C.7_O4",
                  "value": "4",
                  "label": "Más del 50%",
                  "raw": "4. Más del 50%"
                },
                {
                  "id": "INT-C.7_O5",
                  "value": "5",
                  "label": "No sabe / No calcula",
                  "raw": "5. No sabe / No calcula"
                }
              ],
              "row": 204
            },
            {
              "id": "INT-C.8",
              "text": "¿Cuál es la razón principal por la que la empresa no presta o dejó de prestar servicios internacionales?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-C.8_O1",
                  "value": "1",
                  "label": "No aplica — la empresa sí presta servicios internacionales",
                  "raw": "1. No aplica — la empresa sí presta servicios internacionales"
                },
                {
                  "id": "INT-C.8_O2",
                  "value": "2",
                  "label": "El mercado interno es suficiente y rentable",
                  "raw": "2. El mercado interno es suficiente y rentable"
                },
                {
                  "id": "INT-C.8_O3",
                  "value": "3",
                  "label": "Falta de contactos o redes internacionales",
                  "raw": "3. Falta de contactos o redes internacionales"
                },
                {
                  "id": "INT-C.8_O4",
                  "value": "4",
                  "label": "Barreras regulatorias o de homologación",
                  "raw": "4. Barreras regulatorias o de homologación"
                },
                {
                  "id": "INT-C.8_O5",
                  "value": "5",
                  "label": "Dificultades para cobrar en divisas",
                  "raw": "5. Dificultades para cobrar en divisas"
                },
                {
                  "id": "INT-C.8_O6",
                  "value": "6",
                  "label": "La empresa no se considera competitiva internacionalmente",
                  "raw": "6. La empresa no se considera competitiva internacionalmente"
                },
                {
                  "id": "INT-C.8_O7",
                  "value": "7",
                  "label": "Falta de conocimiento sobre formalización",
                  "raw": "7. Falta de conocimiento sobre formalización"
                },
                {
                  "id": "INT-C.8_O8",
                  "value": "8",
                  "label": "Los clientes prefieren proveedores locales",
                  "raw": "8. Los clientes prefieren proveedores locales"
                }
              ],
              "row": 213
            }
          ]
        },
        {
          "id": "INT-D",
          "letter": "D",
          "title": "[INT]  Módulo D — Presencia Corporativa Internacional",
          "questions": [
            {
              "id": "INT-D.1",
              "text": "¿La empresa cuenta actualmente con alguna forma de presencia física, comercial o jurídica fuera de Colombia?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-D.1_O1",
                  "value": "1",
                  "label": "Sí → Continúe el Módulo D",
                  "raw": "1. Sí → Continúe el Módulo D"
                },
                {
                  "id": "INT-D.1_O2",
                  "value": "2",
                  "label": "No, sin presencia en el exterior → Pase a Módulo E",
                  "raw": "2. No, sin presencia en el exterior → Pase a Módulo E"
                }
              ],
              "row": 229
            },
            {
              "id": "INT-D.2",
              "text": "¿Cuál es la principal estructura que tiene actualmente fuera de Colombia?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INT-D.2_O1",
                  "value": "1",
                  "label": "Filial o subsidiaria en el exterior",
                  "raw": "1. Filial o subsidiaria en el exterior"
                },
                {
                  "id": "INT-D.2_O2",
                  "value": "2",
                  "label": "Oficina de representación comercial",
                  "raw": "2. Oficina de representación comercial"
                },
                {
                  "id": "INT-D.2_O3",
                  "value": "3",
                  "label": "Tienda propia o punto de venta al público",
                  "raw": "3. Tienda propia o punto de venta al público"
                },
                {
                  "id": "INT-D.2_O4",
                  "value": "4",
                  "label": "Planta de manufactura o producción",
                  "raw": "4. Planta de manufactura o producción"
                },
                {
                  "id": "INT-D.2_O5",
                  "value": "5",
                  "label": "Centro de distribución o bodega",
                  "raw": "5. Centro de distribución o bodega"
                },
                {
                  "id": "INT-D.2_O6",
                  "value": "6",
                  "label": "Franquicia otorgada a operador local",
                  "raw": "6. Franquicia otorgada a operador local"
                },
                {
                  "id": "INT-D.2_O7",
                  "value": "7",
                  "label": "Representante o agente comercial exclusivo",
                  "raw": "7. Representante o agente comercial exclusivo"
                },
                {
                  "id": "INT-D.2_O8",
                  "value": "8",
                  "label": "Joint venture operando fuera de Colombia",
                  "raw": "8. Joint venture operando fuera de Colombia"
                },
                {
                  "id": "INT-D.2_O9",
                  "value": "9",
                  "label": "Participación accionaria en empresa extranjera",
                  "raw": "9. Participación accionaria en empresa extranjera"
                }
              ],
              "row": 235
            },
            {
              "id": "INT-D.3",
              "text": "¿En cuántos países tiene la empresa alguna de estas estructuras actualmente?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-D.3_O1",
                  "value": "1",
                  "label": "En 1 país",
                  "raw": "1. En 1 país"
                },
                {
                  "id": "INT-D.3_O2",
                  "value": "2",
                  "label": "En 2 a 3 países",
                  "raw": "2. En 2 a 3 países"
                },
                {
                  "id": "INT-D.3_O3",
                  "value": "3",
                  "label": "En 4 a 6 países",
                  "raw": "3. En 4 a 6 países"
                },
                {
                  "id": "INT-D.3_O4",
                  "value": "4",
                  "label": "En 7 o más países",
                  "raw": "4. En 7 o más países"
                }
              ],
              "row": 248
            },
            {
              "id": "INT-D.4",
              "text": "¿Cuál fue la inversión aproximada realizada en el exterior en los últimos tres años?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-D.4_O1",
                  "value": "1",
                  "label": "Menos de USD $200.000",
                  "raw": "1. Menos de USD $200.000"
                },
                {
                  "id": "INT-D.4_O2",
                  "value": "2",
                  "label": "Entre USD $200.001 y $1.000.000",
                  "raw": "2. Entre USD $200.001 y $1.000.000"
                },
                {
                  "id": "INT-D.4_O3",
                  "value": "3",
                  "label": "Entre USD $1.000.001 y $5.000.000",
                  "raw": "3. Entre USD $1.000.001 y $5.000.000"
                },
                {
                  "id": "INT-D.4_O4",
                  "value": "4",
                  "label": "Más de USD $5.000.000",
                  "raw": "4. Más de USD $5.000.000"
                },
                {
                  "id": "INT-D.4_O5",
                  "value": "5",
                  "label": "No sabe / No informa",
                  "raw": "5. No sabe / No informa"
                }
              ],
              "row": 256
            },
            {
              "id": "INT-D.5",
              "text": "¿Cuál es el principal objetivo estratégico de la presencia corporativa en el exterior?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-D.5_O1",
                  "value": "1",
                  "label": "Acceso a mercados de consumo en el exterior",
                  "raw": "1. Acceso a mercados de consumo en el exterior"
                },
                {
                  "id": "INT-D.5_O2",
                  "value": "2",
                  "label": "Reducción de costos de producción o mano de obra",
                  "raw": "2. Reducción de costos de producción o mano de obra"
                },
                {
                  "id": "INT-D.5_O3",
                  "value": "3",
                  "label": "Acceso a materias primas o recursos estratégicos",
                  "raw": "3. Acceso a materias primas o recursos estratégicos"
                },
                {
                  "id": "INT-D.5_O4",
                  "value": "4",
                  "label": "Acceso a talento humano especializado",
                  "raw": "4. Acceso a talento humano especializado"
                },
                {
                  "id": "INT-D.5_O5",
                  "value": "5",
                  "label": "Posicionamiento de marca y reconocimiento global",
                  "raw": "5. Posicionamiento de marca y reconocimiento global"
                },
                {
                  "id": "INT-D.5_O6",
                  "value": "6",
                  "label": "Cumplimiento de requisitos regulatorios",
                  "raw": "6. Cumplimiento de requisitos regulatorios"
                },
                {
                  "id": "INT-D.5_O7",
                  "value": "7",
                  "label": "Diversificación del riesgo geográfico",
                  "raw": "7. Diversificación del riesgo geográfico"
                }
              ],
              "row": 265
            }
          ]
        },
        {
          "id": "INT-E",
          "letter": "E",
          "title": "[INT]  Módulo E — Internacionalización de la Cadena de Valor",
          "questions": [
            {
              "id": "INT-E.1",
              "text": "¿La empresa importa insumos, materias primas o servicios del exterior que son parte esencial de su proceso?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-E.1_O1",
                  "value": "1",
                  "label": "Sí, más del 50% de los insumos son importados",
                  "raw": "1. Sí, más del 50% de los insumos son importados"
                },
                {
                  "id": "INT-E.1_O2",
                  "value": "2",
                  "label": "Sí, entre el 20% y el 50% son importados",
                  "raw": "2. Sí, entre el 20% y el 50% son importados"
                },
                {
                  "id": "INT-E.1_O3",
                  "value": "3",
                  "label": "Sí, menos del 20% (importación marginal)",
                  "raw": "3. Sí, menos del 20% (importación marginal)"
                },
                {
                  "id": "INT-E.1_O4",
                  "value": "4",
                  "label": "No, usa exclusivamente insumos nacionales",
                  "raw": "4. No, usa exclusivamente insumos nacionales"
                }
              ],
              "row": 280
            },
            {
              "id": "INT-E.2",
              "text": "¿La empresa aprovecha los acuerdos comerciales o TLC vigentes de Colombia?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-E.2_O1",
                  "value": "1",
                  "label": "Sí, principalmente para exportar",
                  "raw": "1. Sí, principalmente para exportar"
                },
                {
                  "id": "INT-E.2_O2",
                  "value": "2",
                  "label": "Sí, principalmente para importar insumos",
                  "raw": "2. Sí, principalmente para importar insumos"
                },
                {
                  "id": "INT-E.2_O3",
                  "value": "3",
                  "label": "Sí, tanto para exportar como para importar",
                  "raw": "3. Sí, tanto para exportar como para importar"
                },
                {
                  "id": "INT-E.2_O4",
                  "value": "4",
                  "label": "No, aunque opera en mercados con acuerdos comerciales",
                  "raw": "4. No, aunque opera en mercados con acuerdos comerciales"
                },
                {
                  "id": "INT-E.2_O5",
                  "value": "5",
                  "label": "No, porque no opera en mercados con TLC vigentes",
                  "raw": "5. No, porque no opera en mercados con TLC vigentes"
                },
                {
                  "id": "INT-E.2_O6",
                  "value": "6",
                  "label": "No conoce suficientemente los acuerdos comerciales",
                  "raw": "6. No conoce suficientemente los acuerdos comerciales"
                }
              ],
              "row": 288
            },
            {
              "id": "INT-E.3",
              "text": "¿La empresa tiene certificaciones internacionales de calidad, inocuidad o sostenibilidad?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-E.3_O1",
                  "value": "1",
                  "label": "Sí, varias certificaciones vigentes (ISO, BPM, GlobalGAP, FDA, CE, LEED)",
                  "raw": "1. Sí, varias certificaciones vigentes (ISO, BPM, GlobalGAP, FDA, CE, LEED)"
                },
                {
                  "id": "INT-E.3_O2",
                  "value": "2",
                  "label": "Sí, al menos una certificación internacional vigente",
                  "raw": "2. Sí, al menos una certificación internacional vigente"
                },
                {
                  "id": "INT-E.3_O3",
                  "value": "3",
                  "label": "No, pero está en proceso de obtener alguna",
                  "raw": "3. No, pero está en proceso de obtener alguna"
                },
                {
                  "id": "INT-E.3_O4",
                  "value": "4",
                  "label": "No tiene ni está en proceso",
                  "raw": "4. No tiene ni está en proceso"
                }
              ],
              "row": 298
            },
            {
              "id": "INT-E.4",
              "text": "¿La empresa desarrolla I+D en colaboración con socios o centros de conocimiento de otros países?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-E.4_O1",
                  "value": "1",
                  "label": "Sí, alianzas activas de I+D con socios internacionales",
                  "raw": "1. Sí, alianzas activas de I+D con socios internacionales"
                },
                {
                  "id": "INT-E.4_O2",
                  "value": "2",
                  "label": "Sí, tuvo en el pasado pero actualmente no",
                  "raw": "2. Sí, tuvo en el pasado pero actualmente no"
                },
                {
                  "id": "INT-E.4_O3",
                  "value": "3",
                  "label": "No, pero tiene interés a corto plazo",
                  "raw": "3. No, pero tiene interés a corto plazo"
                },
                {
                  "id": "INT-E.4_O4",
                  "value": "4",
                  "label": "No, no es estratégicamente prioritario",
                  "raw": "4. No, no es estratégicamente prioritario"
                }
              ],
              "row": 306
            },
            {
              "id": "INT-E.5",
              "text": "¿La empresa tiene contratos de largo plazo (> 1 año) con clientes o proveedores internacionales?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-E.5_O1",
                  "value": "1",
                  "label": "Sí, contratos de largo plazo con clientes internacionales",
                  "raw": "1. Sí, contratos de largo plazo con clientes internacionales"
                },
                {
                  "id": "INT-E.5_O2",
                  "value": "2",
                  "label": "Sí, contratos de largo plazo con proveedores internacionales",
                  "raw": "2. Sí, contratos de largo plazo con proveedores internacionales"
                },
                {
                  "id": "INT-E.5_O3",
                  "value": "3",
                  "label": "Sí, tanto con clientes como con proveedores",
                  "raw": "3. Sí, tanto con clientes como con proveedores"
                },
                {
                  "id": "INT-E.5_O4",
                  "value": "4",
                  "label": "No, opera con acuerdos transaccionales de corto plazo",
                  "raw": "4. No, opera con acuerdos transaccionales de corto plazo"
                }
              ],
              "row": 314
            }
          ]
        },
        {
          "id": "INT-F",
          "letter": "F",
          "title": "[INT]  Módulo F — Capacidades y Barreras",
          "questions": [
            {
              "id": "INT-F.1",
              "text": "¿La empresa cuenta con un área o responsable dedicado a las operaciones o estrategia internacional?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-F.1_O1",
                  "value": "1",
                  "label": "Sí, área o gerencia de negocios internacionales dedicada",
                  "raw": "1. Sí, área o gerencia de negocios internacionales dedicada"
                },
                {
                  "id": "INT-F.1_O2",
                  "value": "2",
                  "label": "Sí, responsable asignado que comparte funciones",
                  "raw": "2. Sí, responsable asignado que comparte funciones"
                },
                {
                  "id": "INT-F.1_O3",
                  "value": "3",
                  "label": "No, la gestión la asume la gerencia general",
                  "raw": "3. No, la gestión la asume la gerencia general"
                },
                {
                  "id": "INT-F.1_O4",
                  "value": "4",
                  "label": "No tiene ninguna estructura formal",
                  "raw": "4. No tiene ninguna estructura formal"
                }
              ],
              "row": 326
            },
            {
              "id": "INT-F.2",
              "text": "¿Cuál es el nivel de dominio de idiomas extranjeros en los cargos directivos y comerciales?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-F.2_O1",
                  "value": "1",
                  "label": "La mayoría tienen dominio funcional de al menos un idioma",
                  "raw": "1. La mayoría tienen dominio funcional de al menos un idioma"
                },
                {
                  "id": "INT-F.2_O2",
                  "value": "2",
                  "label": "Algunos directivos tienen dominio pero no es generalizado",
                  "raw": "2. Algunos directivos tienen dominio pero no es generalizado"
                },
                {
                  "id": "INT-F.2_O3",
                  "value": "3",
                  "label": "Solo 1 o 2 personas tienen conocimiento funcional",
                  "raw": "3. Solo 1 o 2 personas tienen conocimiento funcional"
                },
                {
                  "id": "INT-F.2_O4",
                  "value": "4",
                  "label": "No cuenta con personal con dominio funcional de idiomas",
                  "raw": "4. No cuenta con personal con dominio funcional de idiomas"
                }
              ],
              "row": 334
            },
            {
              "id": "INT-F.3",
              "text": "¿La empresa ha participado en programas de apoyo a la internacionalización (ProColombia, CCC, Bancóldex)?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-F.3_O1",
                  "value": "1",
                  "label": "Sí, varios programas — muy útiles",
                  "raw": "1. Sí, varios programas — muy útiles"
                },
                {
                  "id": "INT-F.3_O2",
                  "value": "2",
                  "label": "Sí, algún programa — impacto limitado",
                  "raw": "2. Sí, algún programa — impacto limitado"
                },
                {
                  "id": "INT-F.3_O3",
                  "value": "3",
                  "label": "No ha participado, pero conoce la oferta y tiene interés",
                  "raw": "3. No ha participado, pero conoce la oferta y tiene interés"
                },
                {
                  "id": "INT-F.3_O4",
                  "value": "4",
                  "label": "No ha participado y no conoce bien la oferta",
                  "raw": "4. No ha participado y no conoce bien la oferta"
                }
              ],
              "row": 342
            },
            {
              "id": "INT-F.4",
              "text": "¿Cuál es la principal barrera para internacionalizarse o profundizar la internacionalización?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INT-F.4_O1",
                  "value": "1",
                  "label": "Acceso a financiamiento para operaciones internacionales",
                  "raw": "1. Acceso a financiamiento para operaciones internacionales"
                },
                {
                  "id": "INT-F.4_O2",
                  "value": "2",
                  "label": "Volatilidad del tipo de cambio y riesgo cambiario",
                  "raw": "2. Volatilidad del tipo de cambio y riesgo cambiario"
                },
                {
                  "id": "INT-F.4_O3",
                  "value": "3",
                  "label": "Falta de información sobre mercados internacionales",
                  "raw": "3. Falta de información sobre mercados internacionales"
                },
                {
                  "id": "INT-F.4_O4",
                  "value": "4",
                  "label": "Costos elevados de logística y transporte",
                  "raw": "4. Costos elevados de logística y transporte"
                },
                {
                  "id": "INT-F.4_O5",
                  "value": "5",
                  "label": "Dificultad para cumplir estándares y certificaciones",
                  "raw": "5. Dificultad para cumplir estándares y certificaciones"
                },
                {
                  "id": "INT-F.4_O6",
                  "value": "6",
                  "label": "Complejidad de trámites aduaneros y regulatorios",
                  "raw": "6. Complejidad de trámites aduaneros y regulatorios"
                },
                {
                  "id": "INT-F.4_O7",
                  "value": "7",
                  "label": "Falta de talento con formación internacional o idiomas",
                  "raw": "7. Falta de talento con formación internacional o idiomas"
                },
                {
                  "id": "INT-F.4_O8",
                  "value": "8",
                  "label": "Tamaño insuficiente para competir a escala internacional",
                  "raw": "8. Tamaño insuficiente para competir a escala internacional"
                },
                {
                  "id": "INT-F.4_O9",
                  "value": "9",
                  "label": "Entorno macroeconómico desfavorable en Colombia",
                  "raw": "9. Entorno macroeconómico desfavorable en Colombia"
                },
                {
                  "id": "INT-F.4_O10",
                  "value": "10",
                  "label": "No ha identificado mercados con demanda suficiente",
                  "raw": "10. No ha identificado mercados con demanda suficiente"
                },
                {
                  "id": "INT-F.4_O11",
                  "value": "11",
                  "label": "No enfrenta barreras significativas",
                  "raw": "11. No enfrenta barreras significativas"
                }
              ],
              "row": 350
            },
            {
              "id": "INT-F.5",
              "text": "¿La empresa ha recibido financiamiento específico para operaciones de comercio exterior?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-F.5_O1",
                  "value": "1",
                  "label": "Sí, crédito de Bancóldex u otra entidad pública",
                  "raw": "1. Sí, crédito de Bancóldex u otra entidad pública"
                },
                {
                  "id": "INT-F.5_O2",
                  "value": "2",
                  "label": "Sí, financiamiento bancario para capital exportador",
                  "raw": "2. Sí, financiamiento bancario para capital exportador"
                },
                {
                  "id": "INT-F.5_O3",
                  "value": "3",
                  "label": "Sí, financiamiento de casa matriz o inversionista extranjero",
                  "raw": "3. Sí, financiamiento de casa matriz o inversionista extranjero"
                },
                {
                  "id": "INT-F.5_O4",
                  "value": "4",
                  "label": "No, se financia con recursos propios",
                  "raw": "4. No, se financia con recursos propios"
                },
                {
                  "id": "INT-F.5_O5",
                  "value": "5",
                  "label": "No tiene operaciones que requieran financiamiento diferenciado",
                  "raw": "5. No tiene operaciones que requieran financiamiento diferenciado"
                }
              ],
              "row": 365
            }
          ]
        },
        {
          "id": "INT-G",
          "letter": "G",
          "title": "[INT]  Módulo G — Potencial y Proyección Internacional",
          "questions": [
            {
              "id": "INT-G.1",
              "text": "¿La empresa tiene planes concretos de iniciar, retomar o ampliar operaciones internacionales en los próximos 3 años?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-G.1_O1",
                  "value": "1",
                  "label": "Sí, planes formalizados en plan estratégico",
                  "raw": "1. Sí, planes formalizados en plan estratégico"
                },
                {
                  "id": "INT-G.1_O2",
                  "value": "2",
                  "label": "Sí, intención clara pero no formalizada",
                  "raw": "2. Sí, intención clara pero no formalizada"
                },
                {
                  "id": "INT-G.1_O3",
                  "value": "3",
                  "label": "No, sin planes ni interés a corto plazo",
                  "raw": "3. No, sin planes ni interés a corto plazo"
                },
                {
                  "id": "INT-G.1_O4",
                  "value": "4",
                  "label": "No sabe / Depende de condiciones no definidas",
                  "raw": "4. No sabe / Depende de condiciones no definidas"
                }
              ],
              "row": 378
            },
            {
              "id": "INT-G.2",
              "text": "¿Cuál forma de internacionalización considera la empresa prioritaria para los próximos 3 años?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-G.2_O1",
                  "value": "1",
                  "label": "Inicio o aumento de exportación de bienes a nuevos mercados",
                  "raw": "1. Inicio o aumento de exportación de bienes a nuevos mercados"
                },
                {
                  "id": "INT-G.2_O2",
                  "value": "2",
                  "label": "Inicio o expansión de exportación de servicios",
                  "raw": "2. Inicio o expansión de exportación de servicios"
                },
                {
                  "id": "INT-G.2_O3",
                  "value": "3",
                  "label": "Apertura de oficina, tienda o punto de venta en el exterior",
                  "raw": "3. Apertura de oficina, tienda o punto de venta en el exterior"
                },
                {
                  "id": "INT-G.2_O4",
                  "value": "4",
                  "label": "Alianza estratégica o joint venture con empresa extranjera",
                  "raw": "4. Alianza estratégica o joint venture con empresa extranjera"
                },
                {
                  "id": "INT-G.2_O5",
                  "value": "5",
                  "label": "Plataforma digital para clientes internacionales",
                  "raw": "5. Plataforma digital para clientes internacionales"
                },
                {
                  "id": "INT-G.2_O6",
                  "value": "6",
                  "label": "No aplica — sin planes de internacionalización",
                  "raw": "6. No aplica — sin planes de internacionalización"
                }
              ],
              "row": 386
            },
            {
              "id": "INT-G.3",
              "text": "¿A qué región geográfica está orientada la proyección internacional para los próximos años?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-G.3_O1",
                  "value": "1",
                  "label": "América Latina y El Caribe",
                  "raw": "1. América Latina y El Caribe"
                },
                {
                  "id": "INT-G.3_O2",
                  "value": "2",
                  "label": "América del Norte (EE.UU., Canadá)",
                  "raw": "2. América del Norte (EE.UU., Canadá)"
                },
                {
                  "id": "INT-G.3_O3",
                  "value": "3",
                  "label": "Europa",
                  "raw": "3. Europa"
                },
                {
                  "id": "INT-G.3_O4",
                  "value": "4",
                  "label": "Asia-Pacífico",
                  "raw": "4. Asia-Pacífico"
                },
                {
                  "id": "INT-G.3_O5",
                  "value": "5",
                  "label": "África o Medio Oriente",
                  "raw": "5. África o Medio Oriente"
                },
                {
                  "id": "INT-G.3_O6",
                  "value": "6",
                  "label": "Varias regiones sin una prioritaria definida",
                  "raw": "6. Varias regiones sin una prioritaria definida"
                },
                {
                  "id": "INT-G.3_O7",
                  "value": "7",
                  "label": "Sin proyección internacional a corto plazo",
                  "raw": "7. Sin proyección internacional a corto plazo"
                }
              ],
              "row": 396
            },
            {
              "id": "INT-G.4",
              "text": "¿Qué tipo de apoyo considera más valioso para avanzar en la internacionalización de su empresa?",
              "type": "multiple",
              "typeLabel": "▸  Selección múltiple — marque todas las que aplican",
              "options": [
                {
                  "id": "INT-G.4_O1",
                  "value": "1",
                  "label": "Acceso a información de mercados y oportunidades en el exterior",
                  "raw": "1. Acceso a información de mercados y oportunidades en el exterior"
                },
                {
                  "id": "INT-G.4_O2",
                  "value": "2",
                  "label": "Financiamiento o crédito para operaciones internacionales",
                  "raw": "2. Financiamiento o crédito para operaciones internacionales"
                },
                {
                  "id": "INT-G.4_O3",
                  "value": "3",
                  "label": "Formación en comercio exterior y negocios internacionales",
                  "raw": "3. Formación en comercio exterior y negocios internacionales"
                },
                {
                  "id": "INT-G.4_O4",
                  "value": "4",
                  "label": "Apoyo para certificaciones y estándares internacionales",
                  "raw": "4. Apoyo para certificaciones y estándares internacionales"
                },
                {
                  "id": "INT-G.4_O5",
                  "value": "5",
                  "label": "Conexión con redes de inversionistas o socios estratégicos",
                  "raw": "5. Conexión con redes de inversionistas o socios estratégicos"
                },
                {
                  "id": "INT-G.4_O6",
                  "value": "6",
                  "label": "Reducción de costos logísticos y mejora de transporte",
                  "raw": "6. Reducción de costos logísticos y mejora de transporte"
                },
                {
                  "id": "INT-G.4_O7",
                  "value": "7",
                  "label": "Simplificación de trámites aduaneros y regulatorios",
                  "raw": "7. Simplificación de trámites aduaneros y regulatorios"
                },
                {
                  "id": "INT-G.4_O8",
                  "value": "8",
                  "label": "Apoyo para desarrollo de marca en mercados externos",
                  "raw": "8. Apoyo para desarrollo de marca en mercados externos"
                }
              ],
              "row": 407
            },
            {
              "id": "INT-G.5",
              "text": "¿Cómo califica la empresa su capacidad para competir en mercados internacionales en los próximos 3 años?",
              "type": "single",
              "typeLabel": "▸  Selección única — marque solo una opción",
              "options": [
                {
                  "id": "INT-G.5_O1",
                  "value": "1",
                  "label": "Muy alta — plenamente preparada y competitiva",
                  "raw": "1. Muy alta — plenamente preparada y competitiva"
                },
                {
                  "id": "INT-G.5_O2",
                  "value": "2",
                  "label": "Alta — competitiva con mejoras menores",
                  "raw": "2. Alta — competitiva con mejoras menores"
                },
                {
                  "id": "INT-G.5_O3",
                  "value": "3",
                  "label": "Media — potencial pero requiere preparación significativa",
                  "raw": "3. Media — potencial pero requiere preparación significativa"
                },
                {
                  "id": "INT-G.5_O4",
                  "value": "4",
                  "label": "Baja — enfrenta brechas importantes",
                  "raw": "4. Baja — enfrenta brechas importantes"
                },
                {
                  "id": "INT-G.5_O5",
                  "value": "5",
                  "label": "Muy baja — no se considera preparada",
                  "raw": "5. Muy baja — no se considera preparada"
                }
              ],
              "row": 419
            }
          ]
        }
      ]
    }
  ],
  "stats": [
    {
      "node": "INN",
      "name": "Innovación",
      "modules": 4,
      "questions": 65,
      "options": 348,
      "types": {
        "single": 63,
        "multiple": 2
      }
    },
    {
      "node": "INV",
      "name": "Inversión",
      "modules": 5,
      "questions": 17,
      "options": 97,
      "types": {
        "single": 15,
        "multiple": 2
      }
    },
    {
      "node": "INT",
      "name": "Internacionalización",
      "modules": 7,
      "questions": 40,
      "options": 232,
      "types": {
        "single": 34,
        "multiple": 6
      }
    }
  ]
};
