# Material oficial del parcial 1: qué cubre cada semana y qué es examinable

Todo cuelga de la página del curso: https://eduard-martinez.github.io/teaching/business-analytics-es/
La teoría de cada semana es la versión escrita del podcast o del video; es **la fuente** del
simulacro. Los títulos de sección que aparecen abajo son los de la página: úsalos en la clave
(«*Repasa:* …»).

## Semana 2 — Introducción a los LLMs
Teoría: https://eduard-martinez.github.io/teaching/ba/lectures/week-02/theory/week-02.html
Secciones: ¿Qué es un LLM? (el salón oscuro) · Tokens: las piezas del lenguaje (el impuesto del
token) · Embeddings y atención · Memoria y límites: la encimera de la cocina (fecha de corte,
ventana de contexto, lost in the middle, desbordamiento, alucinaciones) · RLHF · Costos y elección
de modelo (familia escalonada, el botón de esfuerzo, la pregunta del economista) · Uso responsable:
las 4 reglas del curso.
Ideas examinables: el modelo predice la siguiente palabra, no consulta ni calcula · el español
consume cerca de un 50 % más tokens y la salida cuesta unas 5 veces la entrada · la nevera (lo
aprendido, con fecha de corte) contra la encimera (la conversación, limitada y desechable) · lo
del centro de un contexto largo se pierde · una alucinación es una respuesta inventada con
seguridad; todo se verifica contra la fuente · RLHF explica por qué suena convincente y por qué
hereda sesgos · elegir modelo y esfuerzo es costo marginal contra beneficio marginal · verifica,
la IA asiste y no analiza, protege los datos, declara el uso.
Errores típicos para distractores: creer que el modelo busca en internet o en una base · pedirle
aritmética · confundir fecha de corte con ventana de contexto · usar el modelo más grande «por si
acaso» · pegar datos confidenciales · tomar la seguridad del tono como señal de verdad.

## Semana 3 — Fundamentos de R
Teoría: https://eduard-martinez.github.io/teaching/ba/lectures/week-03/theory/week-03.html
Secciones: R y RStudio: motor y cabina (los cuatro paneles, la rutina) · R como calculadora
(orden de operaciones, comparar: == contra =) · Tipos de datos (numérico, carácter, lógico; NA,
NULL, Inf, NaN) · Objetos (asignar con la flecha, nombrar, class y str) · La consola te habla:
resultado, warning o error · Vectores (crear, indexar, filtrar con condición, sumar lógicos) ·
Matrices · Data frames (radiografía con str, dim, head; fila, columna; el signo de pesos) ·
Funciones y ayuda · Paquetes: instalar una vez, cargar siempre (pacman) · Environment y proyectos
(rutas relativas, no guardar el workspace).
Ideas examinables: «100» entre comillas es texto y no se puede operar · un promedio con NA
devuelve NA sin avisar; na.rm lo remueve · warning corrió, error se detuvo · el objeto que no está
en el Environment no existe · sumar un vector lógico cuenta los TRUE · fila, columna: la coma
manda · could not find function = paquete no cargado; there is no package = no instalado · ruta
absoluta solo funciona en un computador · el script es la verdad, no el workspace.
Errores típicos: comparar con un solo igual · leer un NA como cero · «arreglar» un warning sin
leerlo · confundir instalar con cargar · guardar el workspace · rutas absolutas.

## Semana 4 — Manipulación y visualización: dplyr y ggplot2
Teoría: https://eduard-martinez.github.io/teaching/ba/lectures/week-04/theory/week-04.html
Secciones: El destino: una tabla de KPIs · La gramática dplyr: select, rename, filter, arrange,
mutate · Resúmenes: summarise, group_by + summarise (granularidad), count, distinct, n_distinct ·
El pipe («y luego») · La gramática de gráficos: datos, aes, geometría; dentro y fuera de aes · La
geometría según la pregunta (comparar → barras, distribuir → histograma, relacionar → puntos,
evolucionar → línea) · Pulir para comunicar (el título dice el mensaje; tres errores del
aficionado) · Los 5 errores de la semana.
Ideas examinables: mutate mantiene las filas, summarise sintetiza · group_by solo marca; el
cálculo lo hace summarise · el resumen tiene una fila por combinación presente · el orden de los
verbos cambia la pregunta · un valor fijo va fuera de aes; una variable, dentro · ticket promedio
= ingreso / transacciones · barras desde cero, pocas categorías, colores con significado.
Errores típicos: filter con un solo igual · usar una columna que aún no existe · esperar que
group_by cambie la tabla · «steelblue» dentro de aes · cuarenta barras · título que describe en
vez de informar.

## Semana 5 — El proceso analítico
Teoría: https://eduard-martinez.github.io/teaching/ba/lectures/week-05/theory/week-05.html
Láminas de la clase (obligatorias): https://eduard-martinez.github.io/teaching/ba/lectures/week-05/slides/week-05.pdf
Qué tomar de ellas: no los casos, sino la intuición de cómo se aplica la teoría. Las láminas
muestran cómo un analista toma un encargo real y lo recorre por las siete etapas: cómo convierte
un tema en una pregunta que cambia una decisión y le pasa el test de la pregunta; cómo el punto de
partida cambia el trabajo cuando la respuesta no está en ningún dato y hay que construirlos, y
cuando los datos ya existen y el reto es definir qué es lo esperado; cómo el producto final se
piensa desde la decisión que va a habilitar, y puede ser un informe o un sistema que corre solo; y
cómo la lectura de negocio, la cuarta pata, es la que le da valor al análisis. Para el simulacro:
sitúa a un analista frente a un encargo de una empresa ficticia y pide ese mismo razonamiento; no
uses las empresas, las cifras ni las preguntas de las láminas.
Secciones: El 87 % que nunca llegó (cuatro razones, una sola técnica) · Cuatro patas de la misma
mesa · Siete etapas y un ciclo (pregunta → datos → limpieza → EDA → modelo → comunicación →
decisión) · Tipos de tareas analíticas (clasificación, predicción, segmentación, anomalías,
optimización; la pregunta que decide: ¿hay ejemplos históricos con la respuesta?) · Roles: quién
lidera qué.
Ideas examinables: el test de la pregunta («si te doy la respuesta, ¿qué haces distinto mañana?»)
· específica, accionable, medible · la limpieza se lleva el 80 % del tiempo · sin baseline el
porcentaje no dice nada · el costo asimétrico del error decide la métrica · comunicar es número,
costo-beneficio y acción · el analista de negocio lidera la pregunta y la decisión; el científico
de datos, solo el modelo · el éxito es cambiar una decisión, no el acierto del modelo.
Errores típicos: confundir tema con pregunta · presentar la métrica en vez de la consecuencia ·
clasificar sin etiquetas históricas · culpar al modelo por una pregunta mal hecha.

## Semana 6 — Fuentes, calidad de datos y EDA
Teoría: https://eduard-martinez.github.io/teaching/ba/lectures/week-06/theory/week-06.html
Láminas de la clase (obligatorias): https://eduard-martinez.github.io/teaching/ba/lectures/week-06/slides/week-06.pdf
Qué tomar de ellas: no el caso, sino el orden en que un analista interroga una base antes de
modelar, guiado por una pregunta de negocio. Primero, qué es una fila y cuántas hay; después, qué
falta y por qué falta, distinguiendo el vacío que significa «no aplica» del dato perdido; cómo se
ve la variable que se quiere explicar; cómo se distribuyen las candidatas y qué resumen las
describe; qué grupos se comportan distinto, leído en tasas por tramo; qué hipótesis razonables no
se sostienen en los datos; si dos señales miden lo mismo; qué aporta una tabla adicional, que se
agrega a una fila por unidad antes de unirla, porque unir sin agregar multiplica las filas; y qué
variable no se puede usar porque se conoce después del evento y filtra el futuro. Al final, qué
produce un EDA: hipótesis y decisiones de limpieza, no respuestas. Para el simulacro: pon una base
ficticia con su pregunta y pide recorrerla con ese mismo orden y ese mismo criterio; no uses
Cóndor, sus tablas ni sus cifras.
Secciones: Los exámenes que llegaron del laboratorio · Fuentes: primaria y secundaria (el origen
dice qué suciedad esperar) · Las cuatro dimensiones de la calidad (completitud, consistencia,
validez, unicidad; la revisión estructural: qué es una fila) · Problema 1: valores faltantes
(contar primero; eliminar, imputar, marcar; ¿por qué faltan?; documentar) · Problema 2: outliers
(reglas de rango, la regla del IQR, mirarlos; ¿error o caso real?) · Problema 3: el error más
silencioso (categorías escritas de varias formas) · Qué es la EDA (distribuciones, resúmenes por
grupo, relaciones, anomalías; el promedio en el valle de una bimodal) · raw → clean →
analysis-ready y el acta de limpieza.
Ideas examinables: los datos sucios no dan error, dan respuestas confiadas y falsas · qué
representa una fila va primero · el faltante que no es aleatorio sesga si se imputa · el vacío que
el negocio confirma como «sin descuento» es un cero documentado · el IQR marca al error y al
cliente valioso por igual; el negocio los distingue · «Norte» y «norte» partén los totales sin
avisar · el promedio de una bimodal no representa a nadie: se resume por segmento · el original
no se toca; el script reproduce la limpieza; toda decisión queda escrita.
Errores típicos: eliminar todo lo que sale de los bigotes · imputar con la mediana sin preguntar
por qué falta · corregir el archivo original a mano · leer «sin error» como «sin problema».

## Lo que NO entra en el parcial 1
Semanas 8 a 13 (agentes de código, machine learning, clasificación, regresión, clustering): no las
uses ni como contexto ni como distractor.
