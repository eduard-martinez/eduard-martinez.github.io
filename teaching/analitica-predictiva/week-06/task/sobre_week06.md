# Sobre sellado · Semana 6: el árbol de regresión

Analítica Predictiva y Prescriptiva · TIC-60286 · Semana 6 · Sobre sellado. Se publica en Canvas al vencer la entrega del task 6. Las cifras salen de `datasets/aperturas/cifras_week06.txt` (generador `_generar_estudio_aperturas.R`, semilla de datos 18560 y semilla de partición 4; las derivadas, de `week-06/input/cifras_derivadas_week06.txt`) y se reproducen con la práctica 6 en su configuración por defecto: profundidad 3, mínimo 10 puntos de venta por hoja, la partición fija del curso (360 de entrenamiento y 120 de validación), las doce columnas de antes de abrir, método `anova` (`rpart.control(maxdepth = 3, cp = 0.001, minbucket = 10, xval = 0)`), el local 1 y la regla del sector como vara. El árbol de profundidad 2 sale con el mismo mínimo y profundidad 2.

La regla del sobre: la cifra del equipo (o del asistente) vale cuando coincide con la del sobre dentro del margen, o cuando la diferencia se explica en el acta (otra configuración, otra partición).

## 1. Los árboles de referencia

Raíz, en las dos profundidades: `arriendo_mes < 14.15`. Entrenados con los 360 puntos de venta de entrenamiento.

**Profundidad 2** (cuatro hojas; MAE 23.5, RMSE 31.7 en validación):

| Regla | Ventas promedio | n |
|---|---|---|
| `arriendo_mes < 14.15` y `trafico_peatonal < 225.5` | 74.9 | 146 |
| `arriendo_mes < 14.15` y `trafico_peatonal >= 225.5` | 101.0 | 126 |
| `arriendo_mes >= 14.15` y `trafico_peatonal < 317.5` | 118.0 | 53 |
| `arriendo_mes >= 14.15` y `trafico_peatonal >= 317.5` | 164.2 | 35 |

**Profundidad 3** (el árbol de referencia; ocho hojas; MAE 22.6, RMSE 32.2):

| Regla | Ventas promedio | n |
|---|---|---|
| `arriendo_mes < 14.15` y `trafico_peatonal < 225.5` y `arriendo_mes < 10.05` | 63.3 | 68 |
| `arriendo_mes < 14.15` y `trafico_peatonal < 225.5` y `arriendo_mes >= 10.05` | 85.0 | 78 |
| `arriendo_mes < 14.15` y `trafico_peatonal >= 225.5` y `area_m2 < 69.5` | 88.7 | 43 |
| `arriendo_mes < 14.15` y `trafico_peatonal >= 225.5` y `area_m2 >= 69.5` | 107.4 | 83 |
| `arriendo_mes >= 14.15` y `trafico_peatonal < 317.5` y `trafico_peatonal < 212` | 102.9 | 25 |
| `arriendo_mes >= 14.15` y `trafico_peatonal < 317.5` y `trafico_peatonal >= 212` | 131.5 | 28 |
| `arriendo_mes >= 14.15` y `trafico_peatonal >= 317.5` y `ticket_promedio < 13650` | 147.0 | 25 |
| `arriendo_mes >= 14.15` y `trafico_peatonal >= 317.5` y `ticket_promedio >= 13650` | **207.2** | **10** |

La hoja más pequeña es la más alta: n = 10, promedio 207.2 (puntos de venta de entrenamiento 215, 151, 44, 270, 111, 280, 5, 147, 90 y 452; suma 2.071.8). Es el **tope**: el árbol no predice por encima de 207.2. Las ventas máximas del estudio son 259.0.

## 2. La tabla del líder en pesos (validación, 120 puntos de venta)

| Predicción de ventas | MAE | Margen (2 EE) | RMSE | MAE en VPN (× 9) |
|---|---|---|---|---|
| Mediana del entrenamiento (93.1) | 31.1 | ± 5.7 | 43.9 | 280 |
| Regla del sector: 8 × arriendo | 22.4 | ± 3.7 | 30.0 | 201 |
| Consultora A | 22.9 | ± 3.7 | 30.6 | 206 |
| Consultora B | 17.9 | ± 3.4 | 25.9 | 161 |
| Árbol de profundidad 2 | 23.5 | ± 3.9 | 31.7 | 212 |
| Árbol de profundidad 3 | 22.6 | ± 4.2 | 32.2 | 204 |

El MAE de **entrenamiento** del árbol de profundidad 3 es 17.8 (RMSE 23.4) y el de profundidad 2, 20.3: no se reportan como desempeño. Una tabla que ponga 17.8 en la fila del árbol y concluya que le gana a B (17.9) tiene el error sembrado de la sesión.

## 3. Las comparaciones pareadas (error de la regla menos error del modelo, punto por punto)

| Regla menos… | Media | Margen (2 sd / √n) | Veredicto |
|---|---|---|---|
| Árbol de profundidad 2 | −1.19 | ± 3.35 | empate técnico |
| Árbol de profundidad 3 | −0.29 | ± 3.55 | empate técnico |
| Consultora A | −0.57 | ± 3.97 | empate técnico |
| Consultora B | 4.44 | ± 2.76 | gana B |

## 4. Los diez peores (árbol de profundidad 3)

| id | Zona | Observado | Predicho | Error |
|---|---|---|---|---|
| 52 | mixta | 250.2 | 102.9 | +147.3 |
| 458 | oficinas | 252.0 | 147.0 | +105.0 |
| 402 | oficinas | 237.3 | 147.0 | +90.3 |
| 54 | mixta | 197.6 | 107.4 | +90.2 |
| 332 | oficinas | 220.3 | 131.5 | +88.8 |
| 366 | oficinas | 133.5 | 207.2 | −73.7 |
| 191 | oficinas | 212.2 | 147.0 | +65.2 |
| 36 | oficinas | 144.7 | 207.2 | −62.5 |
| 245 | residencial | 120.3 | 63.3 | +57.0 |
| 176 | oficinas | 145.2 | 88.7 | +56.5 |

Concentran el **61.8 %** del error cuadrático (10 de 120 puntos de venta). Ocho subestimados, dos sobreestimados (los dos en la hoja de 207.2). Seis venden más de 150. Zonas: oficinas 7, mixta 2, residencial 1. MAE sin los diez: 17.1 (diagnóstico, no desempeño).

## 5. Las ventas base con banda de los tres locales (profundidad 3, ± MAE 22.6) y la regla 8 × arriendo

| Local | Ventas base | Banda | Banda en VPN (× 9) | Regla 8× | Nota de extrapolación |
|---|---|---|---|---|---|
| local_1 | 147.0 | [124.4, 169.7] | [1.120, 1.527] | 132 | * Barranquilla no está en el estudio |
| local_2 | 207.2 | [184.5, 229.8] | [1.661, 2.068] | 216 | * Barranquilla no está en el estudio; `arriendo_mes` = 27 fuera del rango [4.5, 25]; cae en la hoja del tope (n = 10) |
| local_3 | 63.3 | [40.6, 85.9] | [366, 773] | 64 | * Barranquilla no está en el estudio |

Con profundidad 2 (± 23.5): local 1 y local 2 caen en la misma hoja, 164.2 [140.7, 187.8]; local 3, 74.9 [51.3, 98.4]. La regla del sector cae dentro de la banda del árbol de referencia en los tres locales.

Rangos del lote de entrenamiento: arriendo [4.5, 25]; tráfico [51, 900]; área [40, 220]; competidores [0, 10]; experiencia [0, 25]; ticket promedio [7.600, 16.000] pesos.

## 6. El factor de VPN

Cada millón mensual de ventas (o de error en ventas) mueve 9 millones de VPN a cinco años (hoja de costos de la semana 4). El MAE del árbol de referencia equivale a ≈ 204 millones de VPN; el de B, a 161.

## 7. La estabilidad (otras particiones, profundidad 3, mínimo 10)

- Semilla 101: raíz `arriendo_mes < 14.15`, 7 hojas, MAE 22.6, RMSE 31.8; locales 145.6 / 200.4 / 62.6.
- Semilla 202: raíz `arriendo_mes < 14.45`, 7 hojas, MAE 23.2, RMSE 32.0; locales 139.2 / 173.7 / 61.0.

La raíz aguanta; el segundo y el tercer nivel cambian, y la predicción del local 2 es la que más se mueve (hasta 33.5 millones): es el local fuera de rango.

## 8. El giro de la sesión

Si el arriendo del local 2 sube 30 % (27 → 35.1), la regla del sector pasa de 216 a 280.8 y el árbol sigue diciendo 207.2 (misma hoja). Ninguno de los dos mecánicamente: el árbol no extrapola y la regla ignora todo lo demás.
