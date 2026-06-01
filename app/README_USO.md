# Aplicativo Diagnóstico Empresarial 3i — Versión 3

Esta versión incorpora gestión por perfiles, envío individual por nodo, consolidación incremental limpia, diccionario empresarial y panel administrador.

## 1. Archivos incluidos

- `index.html`: abre el aplicativo.
- `styles.css`: diseño visual con colores Icesi.
- `data.js`: instrumento vigente extraído del Excel original.
- `config.js`: usuarios autorizados, diccionario empresarial y colores institucionales.
- `app.js`: lógica del aplicativo local.
- `apps-script.gs`: código que debe pegarse en Google Apps Script.
- `README_USO.md`: esta guía.

## 2. Perfiles de acceso

El ingreso se hace con los últimos tres dígitos de la cédula.

| Perfil | Código | Rol |
|---|---:|---|
| LEONARDO | 879 | Entrevistador |
| JESSICA | 681 | Entrevistador |
| STEFANNY | 158 | Entrevistador |
| CIENFI | 652 | Administrador |

El sistema autocompleta el nombre del entrevistador en mayúscula y usa el código como ID operativo.

## 3. Cómo abrir el aplicativo

### Uso local

1. Descargue y descomprima el ZIP.
2. Abra la carpeta extraída.
3. Haga doble clic sobre `index.html`.
4. Ingrese con su código de tres dígitos.

### Uso compartido por red

1. Ubique la carpeta del aplicativo en una carpeta compartida de red.
2. Cada encuestador abre `index.html` desde su computador.
3. Todos enviarán al mismo Apps Script configurado en `data.js`.

### Publicación online

Puede subir la carpeta completa a Netlify o GitHub Pages. Deben publicarse juntos todos los archivos: `index.html`, `styles.css`, `data.js`, `config.js` y `app.js`.

## 4. Cómo funciona la sincronización

La sincronización ya no ocurre al escribir ni al responder una pregunta.

El aplicativo guarda localmente en el navegador, pero solo envía a Google Sheets cuando el usuario hace clic en:

- **Enviar nodo actual**
- **Enviar empresa completa**
- **Eliminar nodo actual**
- **Eliminar entrevista completa**

Si no hay internet, el envío queda en cola y puede reintentarse con **Sincronizar pendientes**.

## 5. ID de entrevista

El sistema usa dos identificadores:

- `id_entrevista_base`: `ID_EMPRESA_ID_ENTREVISTADOR`, por ejemplo `001_879`.
- `id_nodo_envio`: `ID_EMPRESA_ID_ENTREVISTADOR_NODO`, por ejemplo `001_879_INN`.

La hoja consolidada queda en una sola fila por empresa y entrevistador.

## 6. Nodos

La versión queda preparada para cuatro nodos:

- `P`: Perfilamiento
- `INN`: Innovación
- `INV`: Inversión
- `INT`: Internacionalización

Si el instrumento actual todavía no trae un nodo P en `data.js`, el aplicativo crea un nodo P operativo con los campos de perfilamiento de la sección de datos de empresa. Cuando se entregue la nueva versión resumida del instrumento, se debe regenerar/reemplazar `data.js` para cargar las preguntas definitivas del nodo P.

## 7. Hoja consolidada limpia

El Apps Script escribe únicamente en la hoja:

- `Consolidado_Limpio`

La hoja contiene:

- ID base de entrevista.
- ID empresa.
- Razón social.
- ID entrevistador.
- Nombre del entrevistador.
- Estado por nodo: `P`, `INN`, `INV`, `INT`.
- Porcentaje de avance.
- Indicador de entrevista completa.
- Última modificación.
- Preguntas en columnas y respuestas en las celdas.

No se guardan objetos JSON, logs, colas, variables internas ni estructuras temporales.

## 8. Instalación de Apps Script

1. Abra el Google Sheet institucional.
2. Vaya a **Extensiones → Apps Script**.
3. Borre el contenido de `Código.gs`.
4. Pegue el contenido completo de `apps-script.gs`.
5. Cambie esta línea si usa un nuevo Sheet institucional:

```javascript
const SHEET_ID = 'ID_DEL_SHEET_INSTITUCIONAL';
```

6. Guarde.
7. Ejecute `pruebaManual` para autorizar permisos.
8. Vaya a **Implementar → Nueva implementación → Aplicación web**.
9. Configure:
   - Ejecutar como: **Yo**
   - Quién tiene acceso: **Cualquier persona**
10. Copie la URL que termina en `/exec`.
11. Si la URL cambió, reemplácela en `data.js`, en la propiedad `scriptUrl`.

## 9. Cómo usar el panel del encuestador

1. Ingrese con su código.
2. Escriba el ID de empresa.
3. El sistema autocompleta la razón social desde el diccionario.
4. Cree la entrevista.
5. Complete el nodo P y luego los nodos 3i.
6. Para enviar, use **Enviar nodo actual**.
7. Para cerrar todo, use **Enviar empresa completa**.

## 10. Cómo usar el panel administrador

1. Ingrese con el código del administrador.
2. Haga clic en **Actualizar consolidado**.
3. Revise:
   - empresas en consolidado,
   - nodos enviados,
   - porcentaje de avance,
   - entrevistas completas e incompletas,
   - última modificación.

El panel administrador muestra lo que ya fue enviado a Google Sheets. Las respuestas que aún estén solo guardadas localmente en el computador del entrevistador no aparecen hasta que el nodo se envíe.

## 11. Eliminación de datos

Desde una entrevista el encuestador puede:

- eliminar el nodo actual;
- eliminar la entrevista completa.

Si el dato ya había sido enviado, el aplicativo manda una actualización al consolidado para marcar el nodo como `NA` o eliminar la fila de la entrevista.

## 12. Respaldo y recuperación

Use **Descargar respaldo** para guardar una copia JSON de las entrevistas locales y la cola pendiente.

Use **Restaurar respaldo** para recuperar entrevistas en otro navegador o computador.

## 13. Nota sobre la nueva versión resumida del instrumento

En este paquete todavía se conserva el instrumento vigente contenido en `data.js`. No se recibió la nueva versión resumida del instrumento ni el archivo oficial del logo. La lógica ya quedó preparada para reemplazar `data.js` cuando se entregue el nuevo Excel y para usar el nodo P como parte del flujo de cuatro nodos.


## 12. Solución si el aplicativo se ve sin colores o como texto plano

Si al abrir el aplicativo se ve como una página básica, sin colores, sin tarjetas y aparecen visibles varias secciones al mismo tiempo, significa que el navegador no cargó `styles.css` y/o los archivos JavaScript. Esto ocurre casi siempre cuando se abre el `index.html` directamente dentro del ZIP o cuando se copia solo el `index.html` sin los demás archivos.

Soluciones:

1. Haga clic derecho sobre el ZIP y seleccione **Extraer todo**.
2. Abra la carpeta extraída, no el ZIP.
3. Verifique que `index.html`, `styles.css`, `app.js`, `data.js` y `config.js` estén en la misma carpeta.
4. Abra `index.html` desde esa carpeta.
5. Si persiste, abra `index_STANDALONE.html`, que trae el diseño, datos y lógica incorporados en un solo archivo para evitar problemas de carga local.

Para trabajo de campo se recomienda usar `index_STANDALONE.html` si los encuestadores tienen dificultades al descomprimir o abrir el aplicativo.


## Corrección V3.2 para hoja limpia

Esta versión corrige el problema de escritura en la hoja anterior. La base limpia se guarda en la pestaña **Respuestas** con columnas de identificación, estado de nodos y preguntas/respuestas. No guarda `datosEmpresa_json`, `respuestas_json`, `submissionId`, logs ni estructuras internas.

Si en el Google Sheet ya existe una pestaña **Respuestas** creada con versiones anteriores y contiene columnas como `recibido_en`, `datosEmpresa_json` o `respuestas_json`, el Apps Script la renombra automáticamente como **Respuestas_Anterior_FECHA** y crea una nueva pestaña **Respuestas** limpia.

Después de pegar este `apps-script.gs` en `Código.gs`, debe hacer una **nueva implementación**. Al abrir la URL `/exec` debe verse `version: 3.2.0`.
