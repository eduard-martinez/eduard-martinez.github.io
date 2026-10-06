# Guion — Del dato a la gráfica (con IA de copiloto) · 30–40 min

**Solo para el profesor.** El script que se proyecta es `demo_clase.R` (termina en la línea rota
a propósito — la corrección y el pulido están AQUÍ, no en el script, para que la respuesta nunca
esté visible en pantalla).

**Materiales**: RStudio con `demo_clase.R` abierto · pestaña de claude.ai con sesión iniciada
(el skill **monitor-r** ya está instalado en tu cuenta) · proyector. Hoy **no hay quiz**.

**Dinámica**: los estudiantes reciben `demo_clase.R` AL INICIO (compártelo por el enlace que
uses para materiales) y lo van **ejecutando contigo, sección por sección** (Cmd/Ctrl+Enter) —
ejecutan, no transcriben: así todos llegan juntos al error sembrado y el único código que
teclean con sus manos es **la corrección**. La actividad mental no está en copiar: está en las
**tres paradas activas** marcadas abajo con 🖐️ (responder, predecir, corregir).

**Objetivo declarable a los estudiantes**: "al final de esta media hora van a saber (1) leer una
base de datos que nunca han visto, (2) construir una gráfica decente por capas y (3) usar la IA
como *monitor* cuando el código se rompa — que se va a romper."

---

## Minuto a minuto

### 0–3' · El encuadre

- Hoy no hay quiz (semana atípica). El plan: "yo trabajo 35 minutos con ustedes; el resto de la
  clase es de ustedes con el monitor del curso — el humano y el de IA".
- La historia de hoy: **del dato crudo a una gráfica que cuenta algo**, con una parada obligada:
  el primer error. "El error no es el accidente de la clase: es el plato principal."

### 3–8' · Secciones 1 y 2: librerías y datos

- Correr la **sección 1**. Decir: `pacman` instala lo que falte y lo carga — por eso el script
  corre en cualquier computador. Un script es una **receta reproducible**; eso lo diferencia de
  hacer clics.
- Correr la **sección 2**. Los datos llegan por URL desde la página del curso: nadie descarga
  nada a mano, todos cargamos exactamente la misma base.

### 8–16' · Sección 3: la radiografía (leer una base)

🖐️ **Parada activa 1** — ANTES de explicar tú nada: "corran las tres líneas y, en parejas,
respondan en 90 segundos: ¿qué es una fila? ¿cuántas filas hay? ¿cuántas columnas son texto?".
Recoge 2–3 respuestas en voz alta y SOLO entonces recorre tú el output. (Ellos leen primero;
tú confirmas después — así `skim()` se aprende mirándolo, no oyéndote.)

Las tres preguntas de siempre (repetirlas: son el hábito que quiero que se lleven):

1. **¿Qué es una fila?** → una venta: un producto, vendido por alguien, en una región, en un mes.
2. **¿Cuántas filas y columnas?** → `dim()`: **60 filas, 9 columnas**.
3. **¿De qué tipo es cada columna?** → `skim()`: **7 de texto** (mes, trimestre, región,
   categoría, canal, vendedor, producto) y **2 numéricas** (precio: va de **75 a 580**;
   cantidad: de **1 a 12**). Y la joya: **cero valores faltantes** — "disfruten esta base:
   es de las últimas limpias que van a ver en su vida".

Sobre `skim()`: "es el chequeo médico general de la base — un comando y te dice tipos, faltantes
y distribuciones. Siempre antes de tocar nada."

### 16–20' · Sección 4: crear la variable del negocio

- Pregunta a la sala: "quiero graficar ingresos… ¿alguien ve la columna 'ingreso'?" → **No
  existe.** Los datos crudos casi nunca traen la variable que el negocio necesita.
- Correr la sección 4: `ingreso = precio * cantidad` — "esto es economía de primer semestre:
  p por q". Verificar con `head()` que la columna nueva apareció (60 filas, ahora 10 columnas).

### 20–27' · Sección 5: la gráfica por capas… y el error

- ANTES de correr, narrar las capas sobre el código: "capa 1, el lienzo: los datos y quién va en
  cada eje (`aes`). Capa 2, la geometría: barras. Las capas se van sumando."
- 🖐️ **Parada activa 2** — predicción: "antes de correrla, escriban en una esquina del script,
  como comentario, qué región creen que va a ganar". (Predecir antes de ver es lo que convierte
  mirar una gráfica en leerla; además siembra la comparación con el resultado real.)
- Todos corren la sección 5 a la vez. **BOOM** — el error sale en TODAS las pantallas (esa
  sincronía es el motivo del script común):

  ```
  Error in `geom_col()`:
  ! `mapping` must be created by `aes()`.
  ```

- Leerlo EN VOZ ALTA, despacio. Preguntar: "¿alguien entiende qué nos está diciendo R?" (nadie va
  a entender: el mensaje es críptico de verdad — ese es el punto).
- El discurso del error: "esto les va a pasar cien veces este semestre. La reacción profesional
  no es borrar todo ni entrar en pánico: es **leer el error y consultar**. Antes se consultaba a
  un compañero o a Stack Overflow; ustedes tienen un monitor de IA entrenado para este curso."

### 27–33' · El momento Monitor R

1. Abrir claude.ai en la pestaña ya lista. **No menciones el skill**: está diseñado para
   dispararse solo (si por algo no dispara, escribe "usa monitor-r" y sigue).
2. Pegar EXACTAMENTE esto (está probado):

   > Estoy en la clase de Analítica para los negocios y esta línea me da un error:
   >
   > ```
   > ggplot(ventas, aes(x = region, y = ingreso)) %>%
   >   geom_col()
   > ```
   >
   > Error in `geom_col()`: ! `mapping` must be created by `aes()`.
   >
   > ¿Qué está pasando?

3. **Lo que va a responder** (así está diseñado el skill, para que no te tome por sorpresa):
   una respuesta corta en cinco movimientos — dónde está el problema (la línea citada) → qué
   dice R traducido → **por qué** pasa (el `%>%` *pasa datos* de una función a otra; las capas
   de ggplot se *suman* con `+`; al usar pipe, `geom_col()` recibió el gráfico entero donde
   esperaba un `aes()`) → el antes/después cambiando UNA cosa → cómo verificar.
4. Subrayar ante la sala: "fíjense en lo que NO hizo: no me tiró un script nuevo. Me explicó la
   lógica y me cambió una sola cosa. Eso es un monitor; un piloto automático les haría el taller
   y ustedes no aprenderían nada — y en la sustentación se nota".
5. 🖐️ **Parada activa 3** — la corrección la teclean ELLOS: "cada uno corrija su script con lo
   que nos explicó el monitor y córranlo" (cambiar `%>%` por `+`). Es el único código que
   escriben con sus manos en toda la demo — y es el momento "yo lo arreglé". Tú corriges en
   pantalla de último, confirmando: sale la gráfica cruda (gris, sin títulos). "Funciona. Pero
   esto todavía no se lo mando a ningún jefe."

### 33–38' · El pulido: pegar y correr

Pegar este bloque al final del script (es la misma gráfica + dos capas de presentación):

```r
## -------------------------------------------- ##
## 6. El pulido: misma información, otra credibilidad
ggplot(ventas, aes(x = region, y = ingreso)) +
  geom_col(fill = "steelblue") +
  labs(title    = "Oeste lidera el ingreso del año",
       subtitle = "Ingresos totales por región, 2025",
       x = "Región", y = "Ingreso (USD)",
       caption  = "Fuente: ventas_2025.csv — página del curso") +
  theme_minimal()
```

- Mensaje: "el título no dice la variable, dice el **hallazgo**". Y la lectura de negocio (cifras
  verificadas): **Oeste lidera con 16.080 de un total de 53.035 — el 30% del ingreso del año**
  (le siguen Norte 13.485, Sur 12.230 y Este 11.240).
- Cerrar la parte técnica: "en 30 minutos pasamos de un archivo en internet a una frase que un
  gerente puede usar. Ese recorrido — cargar, leer, construir, graficar, interpretar — es el
  taller de hoy."

### 38–40' · El handoff al taller

- Reglas para las dos horas con el monitor: taller **nivel 3** — pueden usar la IA todo lo que
  quieran, PERO (1) todo lo que entreguen deben poder **explicarlo y reproducirlo**, (2) el uso
  se anota en la **Declaración de IA**, y (3) **la interpretación y la postura de negocio la
  escriben ustedes sin IA** — el monitor está entrenado para negarse a redactarla, no insistan.
- "El error de hoy fue sembrado. Los de ustedes van a ser de verdad. Ya saben qué hacer:
  leer, consultar, entender, corregir."

---

## Red de seguridad

- **Plan B de error** (si algo se corrige solo o quieres un segundo round): en la sección 5
  escribe `y = ingresos` (con s final) → `Error: object 'ingresos' not found` — el clásico
  "R no adivina nombres"; Monitor R lo diagnostica igual de bien.
- **Si no hay internet en el salón**: los datos no cargan por URL. Ten el CSV descargado en la
  carpeta del script y cambia la línea por `read.csv("ventas_2025.csv")` (el resto no cambia).
- **Si claude.ai no abre**: el error de la sección 5 se explica a mano con la misma lógica
  (pipe pasa datos / + suma capas) y el momento IA se muestra con el celular de un estudiante.

## Cifras verificadas (no citar otras)

| Dato | Valor |
|---|---|
| Filas × columnas (crudo) | 60 × 9 (10 con `ingreso`) |
| Tipos | 7 texto + 2 numéricas (3 con `ingreso`) |
| Valores faltantes | 0 |
| Rango precio / cantidad | 75–580 USD / 1–12 unidades |
| Ingreso total 2025 | 53.035 |
| Por región | Oeste 16.080 (30%) · Norte 13.485 · Sur 12.230 · Este 11.240 |
| Error de la sección 5 (textual) | `` Error in `geom_col()`: ! `mapping` must be created by `aes()`. `` |
