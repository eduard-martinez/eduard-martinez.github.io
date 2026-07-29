# Sesiones sincrónicas

Una carpeta por sesión. Todo lo de una sesión (script, repo de ejemplo,
diapositivas) vive dentro de su carpeta; nada suelto en este nivel.

```
sesiones/
├── sesion_1/
│   └── sesion_1.R                  script de clase (esta sesión no tiene repo)
├── sesion_2/
│   ├── repo_sesion_dos/            repo de la sesión (proyecto RStudio completo)
│   └── sesion_2.R                  script lineal de clase (respaldo, no se publica)
└── sesion_3/
    ├── diapositivas/
    │   ├── sesion_3_diapositivas.pdf
    │   └── sesion_3_diapositivas.tex
    ├── repo_sesion_tres/           repo de la sesión (proyecto RStudio completo)
    └── sesion_3.R                  script lineal de clase (respaldo, no se publica)
```

## Reglas

- **Una carpeta por sesión**: `sesion_N/`.
- **El repo de la sesión se llama `repo_sesion_<numero en letras>`**, y su
  `.Rproj` lleva el mismo nombre que la carpeta.
- **Si la sesión tiene repo, el repo es el material que se publica.** El script
  lineal `sesion_N.R` se conserva aquí como respaldo, pero en la web se enlaza
  el repo, no el script.
- **Diapositivas siempre en `sesion_N/diapositivas/`**, nunca sueltas.
- **Los repos van limpios**: sin `.Rproj.user/`, `.Rhistory` ni `.RData`.
- **Nada de `.zip`**: se comparte la carpeta del repo por Dropbox y el estudiante
  usa el botón *Descargar* de Dropbox.

## Al agregar una sesión nueva

1. Cree `sesion_N/` con el repo `repo_sesion_<numero>/` (o el script si no hay
   repo) y `sesion_N/diapositivas/` si hubo presentación.
2. Limpie el repo (sin `.Rproj.user/`, `.Rhistory`, `.RData`).
3. Comparta por Dropbox la carpeta del repo y el PDF de las diapositivas, y
   actualice la tabla *Grabaciones y material de las sesiones* en `index.qmd`
   (grabación, diapositivas, material).
4. Replique la misma estructura en `Tutoriales_RA/curso_intro_r/sesiones/`.
