# Curso Nivelatorio de R — Versión final

**CIENFI · Universidad Icesi · Prof. Eduard F. Martínez-González · Julio 2026**

Curso de nivelación en R para estudiantes que ingresan a la Maestría en
Economía (y Ciencias Administrativas / Econometría I), orientado al análisis
de datos aplicado: manejo de bases, descriptivas, visualización, regresiones
básicas y flujos de trabajo empírico reproducibles, con integración crítica de
IA generativa.

**Punto de entrada:** [index.html](index.html) — la página de presentación del
curso (bienvenida, materiales por unidad, calendario, evaluación, datos). El
detalle completo está en [programa/programa_curso.md](programa/programa_curso.md).

## Estructura de la carpeta

```
version_final_curso/
├── index.qmd / index.html       # pagina de presentacion del curso
├── programa/                    # el syllabus completo
├── datos/                       # las 3 bases + diccionario + script de la GEIH
├── unidad-1-fundamentos/        # R, RStudio, objetos, proyectos y estilo
├── unidad-2-manejo-datos/       # tidyverse: importar, limpiar, agrupar, cruzar
├── unidad-3-visualizacion/      # ggplot2 y estadisticas descriptivas
├── unidad-4-regresiones/        # lm, fixest, modelsummary, pipeline empirico
├── buenas_practicas/            # guia de estilo, guia de proyectos, plantilla
├── ia/                          # guia de uso de IA + informe de investigacion
├── proyecto_final/              # enunciado y rubrica
├── soluciones/                  # SOLO DOCENTES: soluciones y claves
└── curso_nivelacion_r.Rproj     # abrir esto para correr cualquier script
```

**Cada unidad** tiene la misma estructura interna:

```
unidad-X-nombre/
├── teoria/teoria_unidad-X.qmd   # documento de teoria (Quarto + webR interactivo)
├── practica/practica_unidad-X.R # practica guiada (se completa en RStudio)
├── tarea/tarea_unidad-X.R       # tarea evaluable, formato "PREGUNTA N"
├── tarea/cuestionario_unidad-X.md  # cuestionario asociado a la tarea
└── actividad_ia_unidad-X.md     # actividad de IA de la unidad
```

## Cómo usar este material

**Para dictar el curso:**

1. Publique los HTML de teoría (ver "Renderizar" abajo) y las bases de `datos/`
   en la plataforma del curso.
2. Cada unidad sigue el ciclo **ver → replicar → aplicar**: teoría (+ video) →
   práctica guiada → tarea + cuestionario + actividad IA.
3. Los cuestionarios (`.md`) están listos para portar a Google Forms o a la
   plataforma web (el Apps Script de la versión anterior sirve para recibir
   resultados).
4. Las claves de calificación están en `soluciones/` (no distribuir).

**Para correr los scripts de este repositorio:** abrir
`curso_nivelacion_r.Rproj` en RStudio; todos los scripts de `soluciones/` y
`datos/` usan rutas relativas a esta raíz.

**Los estudiantes** trabajan en SU propio proyecto (creado en la Tarea 1 a
partir de `buenas_practicas/plantilla_proyecto/`), con las bases copiadas en
`datos/originales/`. Por eso los scripts de estudiantes leen
`datos/originales/...`.

## Renderizar la teoría

Cada carpeta `teoria/` es un proyecto Quarto autocontenido (con la extensión
webR y los estilos del curso). Para regenerar el HTML:

```bash
cd unidad-1-fundamentos/teoria && quarto render teoria_unidad-1.qmd
```

La página de presentación se regenera desde la raíz con `quarto render index.qmd`.
En las teorías, las mini-bases de los ejercicios webR se crean en un chunk
oculto (`#| context: setup`) que corre al abrir la página: las celdas visibles
contienen solo código de análisis.

Los chunks `webr-r` quedan ejecutables en el navegador del estudiante (igual
que en el curso de Business Analytics). Para publicar, suba la carpeta
`teoria/` completa: el HTML generado necesita los recursos que quedan junto a
él (`styles.css`, la carpeta `*_files/` y `figures/` si aplica).

## Datos

| Base | Grano | Origen |
|---|---|---|
| `innovacion_empresas.csv` | firma (506) | Ficticia (tipo EDIT), generada con semilla fija — deliberadamente sucia |
| `sectores_agregado.csv` | sector (7) | Ficticia, limpia (referente para joins) |
| `geih_nivelacion.csv` | ocupado (21.821) | **Real**: extracto GEIH/DANE construido por `datos/_preparar_geih.R` |

Detalle variable a variable: [datos/diccionario_datos.md](datos/diccionario_datos.md).

**Nota de publicación:** si quiere que los estudiantes carguen las bases por
URL (como en Business Analytics: `read.csv("https://eduard-martinez.github.io/databases/...")`),
suba los tres CSV a su repositorio `databases` y agregue la URL como
alternativa en las tareas.

## Qué falta decidir (pendientes menores)

- **Fechas definitivas** del calendario (sección 6 del programa: hoy es una
  propuesta sobre la semana del 13 de julio de 2026).
- **Plataforma:** conectar los cuestionarios al Apps Script / Google Sheets
  (la infraestructura de la versión de Andrea es reutilizable).
- **Copilot educativo:** decidir si se gestiona GitHub Education para
  habilitar Copilot gratuito en RStudio (recomendado en la guía de IA).
