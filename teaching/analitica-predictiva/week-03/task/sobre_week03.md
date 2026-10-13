# Sobre sellado · Semana 3 · El estudio de aperturas

Analítica Predictiva y Prescriptiva · TIC-60286 · Semana 3

Se publica en Canvas al vencer la entrega del task 3. Las cifras salen de `estudio_aperturas.csv` (480 puntos de venta, la base completa) con R base, exactamente con el código de las celdas de la teoría; cualquiera puede volver a correrlas en la página de la semana 3. Fuente: `datasets/aperturas/cifras_week03.txt` (semilla de datos 18560).

**La regla:** la cifra del agente no vale hasta que coincide con la del sobre o se explica la diferencia. Si la tuya no coincide, corrige el acta con una línea: "el agente dijo X; el sobre dice Y; la diferencia venía de…".

## Las cifras

```
n = 480
columnas = 17 (id_punto, ciudad, zona, area_m2, arriendo_mes, trafico_peatonal, competidores_500m, estrato, parqueadero, terraza, panaderia, ticket_promedio, experiencia_operador, calificacion_google, meses_atraso_arriendo, ventas_mes, estado_3a)
grano = un punto de venta por fila; id_punto de 1 a 480
cierres = 96
tasa_cierre = 0.200
ventas_mediana = 95.0
ventas_media = 100.7
tasa_cierre_atraso_3_o_mas = 0.897 (n = 97)
tasa_cierre_atraso_menos_de_3 = 0.023 (n = 383)
tasa_cierre_por_zona = residencial 0.289 (n = 142) | oficinas 0.106 (n = 123) | mixta 0.179 (n = 151) | universitaria 0.234 (n = 64)
```

## El código que las produce

```r
datos  <- read.csv("estudio_aperturas.csv")
cierre <- datos$estado_3a == "cerró"

nrow(datos); ncol(datos)                       # 480 filas, 17 columnas
length(unique(datos$id_punto))                 # 480: un punto de venta por fila
sum(cierre); mean(cierre)                      # 96 cierres; tasa 0.200
median(datos$ventas_mes)                       # 95.0
mean(datos$ventas_mes)                         # 100.7
atraso <- datos$meses_atraso_arriendo >= 3
tapply(cierre, atraso, mean); table(atraso)    # 0.023 (383) y 0.897 (97)
tapply(cierre, datos$zona, mean); table(datos$zona)
```

## Diferencias que se explican (y las que no)

- **Trabajaste con una parte de la base** (por ejemplo, solo una ciudad o solo los puntos de venta de una zona): la tasa cambia. Se explica si el acta dice qué filtro se aplicó y por qué.
- **El agente "limpió" sin preguntar** (eliminó puntos de venta con ventas altas, con calificación baja o con cualquier otro criterio): la cifra cambia y la regla 8 del proyecto no se cumplió. Se explica, y la parte 4 del task lo anota como "hizo de más".
- **Redondeo:** 0.2, 0.20 y 20 % son la misma cifra que 0.200. 19.8 % no lo es.
- **La media por la mediana:** 100.7 no es "las ventas típicas". Si el hallazgo dice "un punto de venta vende 100 millones al mes", la cifra está, pero el hallazgo se discute en el cierre.
- **Una cifra que el agente dijo antes de correr nada** y que no coincide con ninguna de estas: no se explica. Es la alucinación numérica, y es la razón de este sobre.
