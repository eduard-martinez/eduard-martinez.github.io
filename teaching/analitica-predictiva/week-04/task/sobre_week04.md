# Sobre sellado de la semana 4: el juez de modelos

Analítica Predictiva y Prescriptiva · TIC-60286 · Semana 4 · Task 4. Se publica en Canvas al vencer la entrega del task 4. Todas las cifras salen de `datasets/aperturas/cifras_week04.txt` y de las celdas de R de la teoría ("El juez de modelos"), que las producen a partir de los 120 puntos de venta del lote de validación y de la hoja de costos de Latitud (evaluar a fondo un local 12, apertura fallida 250, efectividad 0.5 y 0.25, 9 millones de VPN por millón mensual). Millones de pesos; decimales con punto.

Si una cifra del equipo no coincide con la del sobre, la regla es la del curso: la cifra del agente no vale hasta que coincide o hasta que el acta explica la diferencia ("nuestro agente dijo X, el sobre dice Y, la diferencia venía de...").

## 1. La tabla del líder: cierre

Lote de validación: 120 puntos de venta; 24 cerraron y 96 siguen abiertos. A marca cierre si `prob_A >= 0.5`; B, si `prob_B >= 0.3`.

| | Avisos (evaluaciones) | Cierres encontrados (TP) | Falsas alarmas (FP) | Cierres no detectados (FN) | Viables confirmados (TN) | Exactitud | Precisión | Sensibilidad | Costo de la lista | Beneficio neto, u = 0.5 | Beneficio neto, u = 0.25 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Nadie cierra | 0 | 0 | 0 | 24 | 96 | 0.800 | — | 0.000 | 0 | 0 | 0 |
| Consultora A | 13 | 10 | 3 | 14 | 93 | 0.858 | 0.769 | 0.417 | 156 | **1094** | **469** |
| Consultora B | 25 | 12 | 13 | 12 | 83 | 0.792 | 0.480 | 0.500 | 300 | **1200** | **450** |

- Beneficio neto = cierres encontrados × efectividad × 250 − evaluaciones × 12; nadie = 0.
- Con u = 0.5 gana B (1200 contra 1094). Con u = 0.25 gana A (469 contra 450).
- Costo por cierre encontrado (12 ÷ precisión): A 15.6; B 25.0.
- **Costo marginal de pasar de A a B: 72.0 millones por cierre adicional** (12 evaluaciones más por 2 cierres más).
- **Efectividad de quiebre (A y B empatan): 0.288.** Por debajo gana A; por encima, B.
- Pérdida evitada de quiebre (A y B empatan con u = 0.5): 144.0; con V por debajo gana A, por encima gana B.
- Pérdida evitada mínima para que valga la pena contratar (u = 0.5): A 31.2; B 50.0.
- Umbral en palabras: p* = costo de evaluar ÷ (efectividad × pérdida evitada) = 12 ÷ (0.50 × 250) = 0.096; con u = 0.25: 0.192.

## 2. La tabla del líder: ventas

Millones de pesos al mes, sobre los 120 puntos de venta del lote. La regla del sector es ventas ≈ 8 × arriendo; la mediana del entrenamiento es 93.1.

| | MAE | Margen (2 EE) | RMSE | Pareada: regla menos modelo (media ± margen) | Veredicto |
|---|---|---|---|---|---|
| Mediana del entrenamiento (93.1) | 31.1 | 5.7 | 43.9 | — | pierde con la regla |
| Regla del sector, 8 × arriendo | 22.4 | 3.7 | 30.0 | — | la vara |
| Consultora A | 22.9 | 3.7 | 30.6 | −0.57 ± 3.97 | **empate técnico** |
| Consultora B | 17.9 | 3.4 | 25.9 | 4.44 ± 2.76 | **le gana a la regla** |

- Cada millón mensual de error mueve el VPN a cinco años en 9 millones; el MAE de B equivale a 161 millones de VPN.

## 3. Las líneas de `cifras_week04.txt` que se califican

```
matriz_A: TP = 10, FP = 3, FN = 14, TN = 93 ; exactitud = 0.858 ; precision = 0.769 ; sensibilidad = 0.417
matriz_B: TP = 12, FP = 13, FN = 12, TN = 83 ; exactitud = 0.792 ; precision = 0.480 ; sensibilidad = 0.500
matriz_nadie: TP = 0, FP = 0, FN = 24, TN = 96 ; exactitud = 0.800 ; precision = NA ; sensibilidad = 0.000
evaluaciones_A = 13 ; evaluaciones_B = 25
costo_lista_A = 156 ; costo_lista_B = 300  (evaluaciones x 12)
costo_por_cierre_encontrado_A = 15.6 ; _B = 25.0  (12 / precision)
costo_marginal_de_A_a_B = 72.0 por cierre adicional (12 evaluaciones mas por 2 cierres mas)
beneficio_u_0.5: A = 1094.0 ; B = 1200.0 ; gana B
beneficio_u_0.25: A = 469.0 ; B = 450.0 ; gana A
efectividad_de_quiebre (A y B empatan) = 0.288
perdida_evitada_de_quiebre (A y B empatan con u = 0.5) = 144.0 ; con V por debajo gana A, por encima gana B
ventas_A: MAE = 22.9 (margen 2EE = 3.7) ; RMSE = 30.6
ventas_B: MAE = 17.9 (margen 2EE = 3.4) ; RMSE = 25.9
ventas_regla_8x_arriendo: MAE = 22.4 (margen 2EE = 3.7) ; RMSE = 30.0
ventas_mediana_entrenamiento (93.1): MAE = 31.1 (margen 2EE = 5.7) ; RMSE = 43.9
pareada regla menos A: media = -0.57 ; margen (2 sd/raiz n) = 3.97 ; empate tecnico
pareada regla menos B: media = 4.44 ; margen (2 sd/raiz n) = 2.76 ; gana el modelo
```

## 4. Dónde se reproducen

En la teoría de la semana 4, las celdas "La tabla del líder: cierre" y "La tabla del líder: ventas" producen las dos tablas; la celda de la función `beneficio(c, V, u)` produce los beneficios netos y la efectividad de quiebre. En el repositorio de datos, `datasets/aperturas/_verificacion_aperturas.R` rehace cada cifra con `stopifnot`.
