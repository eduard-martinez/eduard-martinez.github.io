# Actividad con IA — Unidad 1: "Primero tú, luego la IA"

**Nivel de uso de IA:** N4 (actividad diseñada para usar IA) · **Modalidad:** individual · **Tiempo estimado:** 45 min

## Objetivo

Aprender a usar la IA como **tutor de errores** — no como oráculo — y comprobar
de primera mano que puede equivocarse con total seguridad.

## Parte A — La escalera de depuración (30 min)

Los cuatro fragmentos de abajo producen **error o warning**. Para cada uno siga
los tres escalones **en orden** (no salte al 3):

1. **Usted solo:** ejecute el fragmento, lea el mensaje completo y escriba como
   comentario su hipótesis de qué pasó.
2. **La documentación:** consulte la ayuda (`?mean`, `?data.frame`, ...) y
   ajuste su hipótesis si hace falta.
3. **La IA como tutor:** pregunte usando la plantilla de la
   [Guía de uso de IA](../ia/guia_uso_ia.html) (sección 5), pidiendo
   **explicación, no solución**. Compare con su hipótesis.

```r
## fragmento 1
ingresos <- c(1200000, 950000, NA, 800000)
promedio <- mean(ingresos)
promedio * 12

## fragmento 2
mean(ingresos, narm = TRUE)

## fragmento 3
personas <- data.frame(nombre = c("Ana", "Luis", "Sara"),
                       edad = c(28, 45))

## fragmento 4
Ingresos_2024 <- 1500000
ingresos_2024 + 100000
```

**Entregable:** un script `actividad_ia1_SuCodigo.R` con los cuatro fragmentos
y, para cada uno, tres comentarios:

```r
## mi hipotesis: ...
## que decia la ayuda/documentacion: ...
## que dijo la IA y en que coincidio (o no) conmigo: ...
```

## Parte B — Caza de alucinaciones (15 min)

1. Pregúntele a su chat de IA: *"¿Qué paquete de R me recomiendas para
   [elija: leer archivos de Stata / hacer mapas de Colombia / limpiar nombres
   de columnas]? Dame el nombre del paquete y una función concreta con sus
   argumentos."*
2. **Verifique cada afirmación:** ¿el paquete existe en CRAN? ¿la función
   existe (`?funcion` tras instalarlo, o búsquela en la documentación web)?
   ¿los argumentos que citó son reales?
3. Anote el resultado en su script como comentarios: qué verificó, qué era
   cierto y qué no.

> En estudios recientes, ~20% de los paquetes que los LLMs citan en código
> generado **no existen**. Si nunca lo ha visto pasar, hoy es el día.

## Qué se evalúa

| Criterio | Peso |
|---|---|
| Hipótesis propia ANTES de consultar la IA (escalón 1 honesto) | 40% |
| Verificación contra la documentación (escalón 2) | 30% |
| Comparación crítica con la respuesta de la IA (¿coincidió?, ¿inventó algo?) | 30% |

**Regla de oro que deja esta actividad:** la IA explica bien la mayoría de los
errores de R — y aún así usted debe poder distinguir *cuándo no*. Eso solo se
logra intentando primero.
