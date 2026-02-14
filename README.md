# Eduard F. Martinez-Gonzalez - Personal Academic Website

Sitio web personal construido con [Jekyll](https://jekyllrb.com/) usando el tema [al-folio](https://github.com/alshedivat/al-folio). Se publica automaticamente en [https://eduard-martinez.github.io](https://eduard-martinez.github.io).

---

## Estructura del repositorio

### Archivos que DEBES modificar a mano

| Archivo / Carpeta | Que hace | Cuando modificarlo |
|---|---|---|
| `_config.yml` | Configuracion general del sitio: nombre, URL, opciones habilitadas | Cambiar nombre, URL, habilitar/deshabilitar features (dark mode, blog, etc.) |
| `_pages/about.md` | **Pagina principal (About)**. Contiene tu bio, subtitulo y configuracion del perfil | Actualizar tu descripcion profesional, foto, afiliacion |
| `_pages/publications.md` | Pagina de **Research**. Muestra las publicaciones del archivo `.bib` | Cambiar titulo o descripcion de la seccion |
| `_pages/teaching.md` | Pagina de **Teaching**. Lista de cursos y talleres | Agregar/quitar cursos, actualizar links de syllabi |
| `_pages/blog.md` | Pagina del **Blog**. Muestra los posts | Cambiar descripcion del blog |
| `_pages/cv.md` | Pagina del **CV**. Renderiza el CV desde datos YAML/JSON | Cambiar link al PDF del CV |
| `_bibliography/papers.bib` | **Todas tus publicaciones** en formato BibTeX | Agregar nuevos papers, working papers, cambiar `selected = {true/false}` para que aparezcan en la pagina About |
| `_data/socials.yml` | **Links de redes sociales** (email, GitHub, Scholar, LinkedIn, ORCID) | Actualizar tus perfiles o agregar nuevas redes |
| `_data/cv.yml` | **Datos del CV** (educacion, experiencia, etc.) | Actualizar tu CV |
| `_data/coauthors.yml` | **Coautores** con sus URLs. Se enlazan automaticamente en las publicaciones | Agregar nuevos coautores |
| `_news/` | **Noticias** que aparecen en la pagina About | Crear archivos `.md` para cada noticia (ver formato abajo) |
| `_posts/` | **Blog posts** | Crear archivos `.md` para cada post (ver formato abajo) |
| `assets/img/prof_pic.jpg` | **Tu foto de perfil** (3072x3072) | Reemplazar con una nueva foto |
| `assets/img/favicon.png` | **Favicon** (icono de la pestana del navegador) | Reemplazar si cambias la foto de perfil |
| `assets/img/publication_preview/` | **Miniaturas** de cada paper. Se muestran al lado de cada publicacion | Reemplazar los SVG placeholder con imagenes reales de tus papers |
| `assets/pdf/CV-Eduard_F_Martinez_G.pdf` | **PDF de tu CV** descargable | Reemplazar cuando actualices tu CV |
| `assets/json/resume.json` | **Datos del CV en JSON** (formato JSONResume) | Actualizar si usas la version JSON del CV |

---

### Archivos que normalmente NO necesitas modificar

| Archivo / Carpeta | Que hace | Modificar solo si... |
|---|---|---|
| `_layouts/` | Templates HTML de cada tipo de pagina (about, page, post, cv, bib) | Quieres cambiar la estructura visual de una pagina |
| `_includes/` | Componentes HTML reutilizables (header, footer, news, etc.) | Quieres cambiar el menu de navegacion (`header.liquid`) o el footer (`footer.liquid`) |
| `_sass/` | Hojas de estilo SCSS | Quieres cambiar colores, tamanos, espaciados |
| `_plugins/` | Plugins Ruby para Jekyll | Nunca, a menos que necesites funcionalidad nueva |
| `assets/css/` | CSS compilado y librerias (Bootstrap, academicons, etc.) | Nunca |
| `assets/js/` | JavaScript (Bootstrap, MathJax, search, etc.) | Nunca |
| `assets/webfonts/` | Fuentes Font Awesome 7 (iconos) | Nunca |
| `assets/fonts/` | Fuentes Academicons (iconos academicos) | Nunca |
| `Gemfile` / `Gemfile.lock` | Dependencias Ruby/Jekyll | Solo si agregas plugins nuevos |
| `robots.txt` | Configuracion para buscadores | Nunca |
| `_site/` | **Sitio generado** (output). Se regenera automaticamente | Nunca (es auto-generado) |
| `.github/` | Configuracion de GitHub Actions para deploy | Nunca, a menos que cambies el deploy |

---

### Carpetas de contenido estatico (legacy)

Estas carpetas contienen archivos HTML/slides/datos que se sirven directamente. No son procesadas por Jekyll como templates.

| Carpeta | Que contiene |
|---|---|
| `blog/` | Posts en HTML (materiales de R, tutoriales con output) |
| `teaching/` | Slides y materiales de cursos (Quarto HTML, extensiones webR) |
| `research/` | PDFs y visualizaciones de investigacion |
| `data/` | Archivos de datos auxiliares |
| `project/` | Proyectos interactivos (ej. mapas de votaciones) |
| `cv/` | Archivos del CV |
| `images/` | Imagenes legacy (anteriores a la migracion al tema al-folio) |

---

## Guia rapida: tareas comunes

### Agregar un nuevo paper

Edita `_bibliography/papers.bib` y agrega una entrada BibTeX:

```bibtex
@unpublished{clave_unica,
  author    = {Martinez-Gonzalez, Eduard F. and Coautor, Nombre},
  title     = {Titulo del Paper},
  year      = {2025},
  note      = {Working Paper},
  abstract  = {Resumen del paper...},
  pdf       = {https://link-al-pdf.com/paper.pdf},
  preview   = {nombre_miniatura.svg},
  selected  = {true}
}
```

- `selected = {true}`: aparece en la pagina About
- `preview`: nombre del archivo en `assets/img/publication_preview/`
- Campos opcionales: `doi`, `html`, `code`, `slides`, `video`, `poster`

### Agregar una noticia

Crea un archivo en `_news/` con el formato:

```markdown
---
layout: post
date: 2025-06-01
inline: true
related_posts: false
---

Texto de la noticia con **formato Markdown** y [links](https://ejemplo.com).
```

### Agregar un blog post

Crea un archivo en `_posts/` con nombre `YYYY-MM-DD-titulo-del-post.md`:

```markdown
---
layout: post
title: Titulo del Post
date: 2025-06-01
description: Descripcion breve
tags: r data-science
categories: tutorials
---

Contenido del post en Markdown...
```

### Agregar un coautor

Edita `_data/coauthors.yml`:

```yaml
apellido_en_minusculas:
  firstname: Nombre
  lastname: Apellido
  url: https://sitio-del-coautor.com
```

El apellido debe coincidir (sin acentos, en minusculas) con el que aparece en el `.bib`.

### Agregar una red social

Edita `_data/socials.yml`. Claves disponibles:

```yaml
email: correo@ejemplo.com          # Icono de sobre
scholar_userid: ABC123              # Google Scholar (solo el ID)
github_username: usuario            # GitHub
linkedin_username: usuario          # LinkedIn (slug del perfil)
orcid_id: 0000-0002-1234-5678      # ORCID
x_username: usuario                 # X/Twitter
instagram_id: usuario               # Instagram
```

Mas opciones: `researchgate_profile`, `scopus_id`, `youtube_id`, `mastodon_username`, etc.

### Actualizar el CV

1. Reemplaza `assets/pdf/CV-Eduard_F_Martinez_G.pdf` con el nuevo PDF
2. Edita `_data/cv.yml` para actualizar la version web del CV
3. Opcionalmente, edita `assets/json/resume.json` para el formato JSON

### Cambiar la foto de perfil

1. Reemplaza `assets/img/prof_pic.jpg` con la nueva foto
2. Regenera el favicon: redimensiona la foto a 180x180px y guardala como `assets/img/favicon.png`

---

## Menu de navegacion

El menu se controla desde el `nav_order` en el front matter de cada pagina en `_pages/`:

| Pagina | `nav_order` | URL |
|---|---|---|
| About | (es la raiz `/`) | `/` |
| Research | 2 | `/research/` |
| Teaching | 3 | `/teaching/` |
| Blog | 4 | `/blog/` |
| CV | 5 | `/cv/` |

Para agregar/quitar paginas del menu, cambia `nav: true/false` en el front matter.

---

## Desarrollo local

```bash
# Instalar dependencias (primera vez)
bundle install

# Servir localmente
bundle exec jekyll serve

# El sitio estara en http://127.0.0.1:4000/
```

Requiere Ruby 4.x (instalado via Homebrew en `/opt/homebrew/Cellar/ruby/4.0.1/bin/`).

---

## Archivos clave de estilo (SCSS)

Si necesitas ajustar la apariencia visual:

| Archivo | Que controla |
|---|---|
| `_sass/_variables.scss` | Colores, fuentes, tamanos base |
| `_sass/_themes.scss` | Temas claro/oscuro |
| `_sass/_navbar.scss` | Barra de navegacion superior |
| `_sass/_components.scss` | Iconos sociales, cards, perfiles, etc. |
| `_sass/_publications.scss` | Estilo de la lista de publicaciones |
| `_sass/_blog.scss` | Estilo del blog |
| `_sass/_typography.scss` | Tipografia general |
| `_sass/_layout.scss` | Layout general, max-width, margenes |
| `_sass/_footer.scss` | Pie de pagina |

---

## Tecnologias utilizadas

- **Jekyll** - Generador de sitios estaticos
- **al-folio** - Tema academico para Jekyll
- **Font Awesome 7** - Iconos (redes sociales, UI)
- **Academicons** - Iconos academicos (Scholar, ORCID, etc.)
- **Bootstrap 4** - Framework CSS
- **jekyll-scholar** - Gestion de bibliografias BibTeX
- **jekyll-socials** - Links de redes sociales
- **MathJax** - Formulas matematicas
- **GitHub Pages** - Hosting y deploy automatico
