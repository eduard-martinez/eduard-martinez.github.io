# Rúbrica — Proyecto final

**Curso Nivelatorio de R · CIENFI · Universidad Icesi**

Se valora el **proceso completo** más que un único resultado. Nota sobre 5.0.

| Criterio | Peso | Qué se espera (nivel alto) |
|---|---|---|
| **1. Limpieza correcta y justificada** | 25% | Duplicados, categorías, tipos (empleados y ventas con la conversión correcta), faltantes y outliers tratados; cada decisión documentada en el "acta" (comentarios y README). |
| **2. Indicadores por grupo y cruce** | 20% | Agrupación por la llave limpia (`cod_sector`), indicadores bien definidos (medianas donde hay outliers), `left_join` correcto (verificado: 7 filas) e interpretación de la comparación con el referente. |
| **3. Visualización y descriptivas** | 15% | Gráficos que responden una pregunta, ordenados, con títulos/ejes/fuente, exportados por script; tabla descriptiva exportada. |
| **4. Regresión e interpretación** | 15% | Dos especificaciones; magnitud en % con `exp(β)−1`; lenguaje de asociación (cero causalidad injustificada); mención del cambio en N entre modelos. |
| **5. Reproducibilidad y organización** | 15% | Estructura de la plantilla; scripts numerados con encabezado y estilo del curso; rutas relativas; la prueba de fuego pasa (Restart R → 01→02→03 sin errores); README completo. |
| **6. Sustentación oral (sin IA)** | 10% | Explican su código línea a línea cuando se les pregunta; defienden las decisiones de limpieza; responden las preguntas guía con sus resultados. |

## Descuentos y condiciones

- **Apéndice de uso de IA ausente o inconsistente** con lo observado: hasta −0.5.
  El uso declarado y verificado de IA **no descuenta**.
- **Ruta absoluta o script que no corre** en sesión limpia: máximo 3.5 en el
  criterio 5 hasta corregirse.
- **Lenguaje causal injustificado** en la interpretación ("la innovación
  aumenta las ventas"): máximo 2/5 del criterio 4.
- **No poder explicar un bloque del propio código** en la sustentación:
  máximo 2/5 del criterio 6 y revisión de integridad académica si es
  generalizado.

## Referencias de calificación (para el docente)

Los valores esperados del análisis (tasas, coeficientes, N) están en
`soluciones/respuestas_cuestionarios.md`
y el flujo de referencia completo en
`soluciones/solucion_proyecto_final.R`.
Decisiones distintas a las de referencia son válidas si están justificadas y
aplicadas consistentemente (p. ej., winsorizar outliers en lugar de dejarlos).
