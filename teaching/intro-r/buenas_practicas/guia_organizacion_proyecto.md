# Guía de organización de proyectos — Curso Nivelatorio de R

**CIENFI · Universidad Icesi · Prof. Eduard F. Martínez-González**

Cómo se organiza una carpeta de análisis de datos para que el trabajo sea
**reproducible**: que otra persona (o usted en seis meses) pueda tomar la
carpeta, correr los scripts en orden y obtener exactamente los mismos
resultados. Esta estructura se usa en las tareas y se **califica** en el
proyecto final.

---

## 1. Un análisis = un proyecto de RStudio

- Cree siempre un proyecto: `File → New Project → New Directory`.
- El archivo `.Rproj` fija el working directory en la raíz de la carpeta:
  por eso **todas las rutas del código son relativas** a esa raíz.
- La prueba definitiva: la carpeta completa debe poder copiarse a otro
  computador y correr **sin cambiar una sola línea**.

## 2. Estructura básica (tareas del curso)

```
nivelacion_r/
├── nivelacion_r.Rproj
├── datos/
│   ├── originales/        # datos crudos: NUNCA se modifican
│   └── procesados/        # bases limpias generadas por scripts
├── scripts/               # codigo numerado en orden de ejecucion
│   ├── 01_limpieza.R
│   ├── 02_descriptivas.R
│   └── 03_regresiones.R
├── output/
│   ├── figuras/           # .png exportados con ggsave()
│   └── tablas/            # .docx/.tex exportados con msummary()
└── README.md              # que hace el proyecto y como correrlo
```

## 3. Estructura extendida (proyectos de investigación)

Para proyectos más grandes (tesis, trabajo de asistente de investigación), cada
**etapa** del pipeline se vuelve una carpeta numerada con sus propias
subcarpetas `code / input / output`:

```
mi_proyecto/
├── 01_import_data/
│   ├── code/              # scripts que importan
│   ├── input/             # datos originales (intocables)
│   └── output/            # datos importados
├── 02_process_data/
│   ├── code/              # limpieza y estandarizacion
│   └── output/            # bases procesadas
├── 03_combine_data/
│   ├── code/              # cruces (joins) entre fuentes
│   └── output/            # base final de analisis
├── 04_main_regressions/
│   ├── code/              # modelos y tablas
│   └── output/            # resultados finales
├── 99_others/             # material complementario (PDFs, notas)
├── README.md
└── mi_proyecto.Rproj
```

La lógica es la misma en ambas estructuras: **el número dice el orden de
ejecución** y el output de una etapa es el input de la siguiente.

## 4. Las cinco reglas que no se negocian

1. **Los datos originales son intocables.** Nunca se editan a mano, nunca se
   sobreescriben. Toda transformación ocurre en un script y su resultado se
   guarda en `procesados/` (u `output/` de la etapa). Si mañana descubre un
   error de limpieza, vuelve a correr; si dañó el original, no hay vuelta.
2. **Los scripts se numeran en orden de ejecución** (`01_`, `02_`, ...). Correr
   `01 → 02 → 03` en una sesión limpia debe reproducir todo.
3. **Ningún script depende de la memoria de otro.** Cada script **lee de
   disco** lo que necesita (con `import()`) y **escribe a disco** lo que
   produce (con `export()`). Nada de "ese objeto quedó en el Environment".
4. **Todo resultado del informe nace de un script.** Figuras con `ggsave()` a
   `output/figuras/`, tablas con `msummary()`/`export()` a `output/tablas/`.
   Prohibido el pantallazo de la consola y el copiar-pegar.
5. **README.md siempre.** Mínimo: qué hace el proyecto, qué datos usa (y de
   dónde salen), en qué orden se corren los scripts, y qué produce cada uno.

## 5. Convenciones de nombres de archivos y columnas

- Minúsculas, sin espacios, sin tildes, palabras con `_` (**snake_case**):
  `innovacion_empresas.csv`, `firmas_limpias.rds`, `tasa_innovacion_sector.png`.
- Nombres de columnas igual: `janitor::clean_names()` inmediatamente después de
  importar cualquier base.
- Datos procesados en **`.rds`** (conserva los tipos de columna: lo que guardó
  es lo que recupera). El `.csv` es para compartir con otros programas.
- Fechas en formato `YYYY-MM-DD` (ordenan solas y no hay ambigüedad).

## 6. La prueba de fuego (antes de entregar)

1. `Session → Restart R` (sesión limpia, Environment vacío)
2. Correr los scripts **en orden**, completos
3. ¿Se regeneraron `datos/procesados/` y `output/` sin errores?

Si algo falló, encontró exactamente lo que hay que arreglar: una ruta absoluta,
un objeto fantasma que vivía en la memoria, un paquete que no estaba en
`p_load()`.

## 7. Plantilla lista para usar

La carpeta [`plantilla_proyecto/`](plantilla_proyecto.html) de este curso trae la
estructura básica ya armada (carpetas + esqueletos de los tres scripts +
README). Cópiela, renómbrela y trabaje sobre ella — así arranca el proyecto
final.
