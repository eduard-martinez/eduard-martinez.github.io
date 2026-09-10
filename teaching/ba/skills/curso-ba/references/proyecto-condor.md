# El proyecto final: el caso Cóndor

## La empresa y el encargo

**Cóndor** es una fintech **ficticia** con sede en Colombia y operación incipiente en Perú y
Ecuador. Opera una plataforma de pagos y crédito: una billetera para que las personas paguen con QR
y tarjeta, transfieran, recarguen y pidan microcréditos, y un lado de comercios que aceptan esos
pagos (datáfonos, QR, adelantos de capital de trabajo).

Cinco años de crecimiento acelerado dejaron datos abundantes pero desarticulados: cada área
(crédito, fraude, marketing, operaciones, finanzas, servicio) registró lo suyo por separado. La
Gerencia sospecha que la empresa gana usuarios pero pierde rentabilidad por varios flancos (fraude,
mora de crédito, clientes que se vuelven inactivos, campañas poco efectivas, comercios que dejan de
transaccionar, ingresos difíciles de proyectar) y no logra cuantificar dónde ni por qué. **El grupo
es el equipo de analistas contratado** para elegir un frente, formular una pregunta de negocio y
responderla con las herramientas del curso.

El proyecto **no evalúa código perfecto**: evalúa plantear una buena pregunta, elegir la tarea
analítica adecuada, ejecutarla con orden e **interpretar** los resultados para que alguien sin
conocimientos técnicos pueda decidir y actuar.

## Frentes y rutas

Cada grupo elige **un** frente y **una** ruta, que mantiene en las tres entregas:

| Frente (área) | Pregunta típica | Ruta natural |
|---|---|---|
| Retención (Growth) | ¿Qué clientes se van a volver inactivos? | Clasificación |
| Finanzas / Planeación | ¿Cuánto va a gastar un cliente el próximo trimestre? | Regresión |
| Segmentación (Marketing) | ¿Qué grupos de clientes existen y cómo se comportan? | Segmentación |
| Fraude y Seguridad | ¿Qué transacciones son fraudulentas? | Clasificación |
| Riesgo de Crédito | ¿Qué solicitudes de crédito caerán en mora? | Clasificación / Regresión |
| Marketing (campañas) | ¿Quién va a responder a una campaña? | Clasificación |

**Primero la pregunta, luego la técnica.** Clasificación (predecir una categoría): `abandono` en la
base, o `etiqueta_fraude`, `default_90d`, `convertido` en los anexos. Regresión (predecir un
número): `gasto_proximo_trim` en la base, o `monto_recuperado` en el anexo de créditos.
Segmentación (agrupar sin objetivo): el bloque RFM de la base; un segmento solo sirve si se puede
**describir y accionar** ("clientes jóvenes de alto gasto y baja antigüedad", no "grupo 3").

## Los datos

Una base principal y tres anexos, todos unidos por `cliente_id`, publicados como `.csv` en
`https://eduard-martinez.github.io/teaching/ba/final_project/data/`. Fecha de corte: **31 de marzo de 2026**.

| Tabla | Grano | Uso |
|---|---|---|
| `base_clientes.csv` | una fila por cliente | **Ruta fácil**: alcanza para las tres rutas |
| `anexo_transacciones.csv` | una fila por transacción (la más grande) | Ruta avanzada: fraude, feature engineering |
| `anexo_creditos.csv` | una fila por solicitud de crédito | Ruta avanzada: riesgo de crédito |
| `anexo_campanas.csv` | una fila por envío de campaña | Ruta avanzada: respuesta a campañas |

Variables de `base_clientes` por bloque: perfil (`cliente_id`, `edad`, `genero`, `ciudad`,
`departamento`, `ocupacion`, `ingreso_declarado`, `kyc_nivel`, `canal_adquisicion`,
`antiguedad_meses`); comportamiento transaccional / RFM (`recencia_dias`, `frecuencia_tx`,
`monto_total`, `monto_promedio`, `ticket_mediano`, `pct_tx_internacional`, `num_categorias_mcc`,
`canal_preferido`); uso de la app (`num_sesiones_ult30d`, `duracion_sesion_promedio`,
`os_principal`); servicio (`num_tickets`, `csat_promedio`); finanzas (`gasto_promedio_mensual`,
`saldo_promedio_ult3m`, `tiene_credito`, `score_buro`); **objetivos**: `abandono` (binaria,
clasificación) y `gasto_proximo_trim` (continua, regresión).

```r
## cargar los datos (ruta fácil: solo la base principal)
url_base <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes <- read.csv(paste0(url_base, "base_clientes.csv"))

## anexos (opcionales, ruta avanzada); el de transacciones es grande: filtrarlo apenas se cargue
transacciones <- read.csv(paste0(url_base, "anexo_transacciones.csv"))
```

### Reglas de los datos

1. **Fecha de corte**: los predictores se miden hasta el 31 de marzo de 2026; los objetivos se
   refieren a lo que ocurre en o después de esa fecha. Usar información posterior al corte como
   predictor es *leakage*.
2. **Entrenamiento y prueba**: separar los datos, entrenar solo con la parte de entrenamiento y
   medir en la de prueba, siempre contra un **baseline** (clase mayoritaria en clasificación; media
   o mediana en regresión).
3. **Cuidado con el grano al unir tablas**: la base tiene una fila por cliente; los anexos tienen
   muchas. Para llevar un anexo al nivel de cliente hay que **agregar primero** (contar, sumar,
   promediar por `cliente_id`) y luego unir; unir sin agregar duplica filas.

## Las entregas

Grupos de **exactamente 3**, conformados antes de la Entrega 1; no se permiten cambios después. No
entregar a tiempo sin excusa válida = 0.0 y quedan inhabilitadas las siguientes entregas. Desde la
Entrega 2 no hay documento escrito: se evalúan diapositivas y sustentación oral.

### Entrega 1 — formulación de la pregunta (0%, prerrequisito) · semana 6 · nivel IAG 2

PDF de máximo 3 páginas sin contar portada, con: portada (grupo, integrantes, problema, fecha);
línea de análisis (2–3 oraciones que justifican el enfoque); pregunta de negocio en sus palabras
(clara, accionable, traducible a una tarea analítica); traducción a tarea analítica (tipo, variable
que se predice o agrupa, salida esperada); roles del equipo (Data Engineer, Data Analyst, Data
Scientist, Data Translator, con responsabilidades); al menos 5 variables de interés con
justificación. **No requiere análisis de datos.** La IA solo para explorar ideas; la pregunta la
redacta el grupo.

### Entrega 2 — base depurada y EDA (5%) · semana 9 · nivel IAG 3

Sustentación oral con 8–10 diapositivas + script de R adjunto (`.R`, `.Rmd` o `.qmd`). En el
script: diccionario de variables; tabla de faltantes por variable (número y %); descriptivos
(media, mediana, SD, mín, máx) de las numéricas; distribución de las variables clave (histogramas o
boxplots); tratamiento de faltantes y atípicos con las decisiones justificadas. En las
diapositivas: contexto de los datos (observaciones, variables, unidad de análisis); tabla-resumen
de descriptivos y faltantes relevantes; mínimo 2 visualizaciones de distribución; un gráfico de la
variable objetivo; un gráfico de la relación entre una explicativa y el objetivo que motive el
modelado; mínimo 3 hallazgos en lenguaje de negocio y las limitaciones. Todo gráfico debe estar
etiquetado y se interpreta oralmente: "un gráfico sin interpretación no tiene validez".

### Entrega 3 — análisis final y sustentación (20%) · semana 16 · nivel IAG 3

Oral 15% · diapositivas 4% · script 1%. 10–12 diapositivas + script que reproduzca todos los
resultados; el profesor puede elegir al azar quién sustenta. En el script: preparación final sin
leakage; (C) y (R) división train/test, al menos dos modelos y sus métricas; (S) estandarización,
al menos dos valores de k y perfiles; todos los resultados, tablas y gráficos. En las diapositivas:
pregunta de negocio y decisión; resumen del EDA que orienta el modelado; (C) tabla de métricas
(accuracy, precisión, recall, F1) contra el baseline y matriz de confusión en lenguaje de negocio,
gráfico de variables importantes (ROC/AUC recomendada); (R) RMSE, MAE y R² contra el baseline,
gráfico de predichos vs. observados y de variables importantes; (S) tabla de perfiles (nombre,
tamaño N y %, estadísticos), gráfico de codo o silueta con el k elegido y una visualización de los
segmentos; interpretación y recomendación (qué acción concreta, para qué grupo); limitaciones y
conclusiones.

### Simulacro · semana 15 · obligatorio, sin nota

Versión preliminar de la sustentación con retroalimentación de fondo y forma del profesor y los
monitores.

## Regla de oro y uso de IA

"Si no pueden explicar y reproducir, no cuenta": en la sustentación se puede preguntar por
cualquier decisión; no poder explicarla equivale a no haberla hecho. La IA se usa como apoyo
declarado (qué herramienta y para qué), llevando registro de prompts e interacciones en E2 y E3.
Como asistente: ayuda a explorar, limpiar, modelar y ordenar la presentación; no redactes la
pregunta de la Entrega 1 ni la recomendación final por el grupo, y asegúrate de que **cada**
integrante pueda sustentar lo que produzcan juntos.
