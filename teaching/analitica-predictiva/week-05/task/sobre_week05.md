# Sobre sellado · Semana 5: el árbol de clasificación

Analítica Predictiva y Prescriptiva · TIC-60286 · Semana 5 · Sobre sellado. Se publica en Canvas al vencer la entrega del task 5. Las cifras salen de `datasets/aperturas/cifras_week05.txt` (generador `_generar_estudio_aperturas.R`, semilla de datos 18560 y semilla de partición 4) y se reproducen con la práctica 5 en su configuración por defecto: profundidad 2, mínimo 15 puntos de venta por hoja, la partición fija del curso, sin las columnas de después de abrir, umbral 0.5.

La regla del sobre: la cifra del equipo (o del asistente) vale cuando coincide con la del sobre dentro del margen, o cuando la diferencia se explica en el acta (otra configuración, otra partición, otro umbral).

## 1. El árbol de referencia

Raíz: `trafico_peatonal < 164.5`. Cuatro hojas. Entrenado con los 360 puntos de venta de entrenamiento y las doce columnas de antes de abrir.

| Regla | Cierran | p | n | Predice |
|---|---|---|---|---|
| `trafico_peatonal >= 164.5` y `trafico_peatonal >= 224.5` | 1 de cada 10 | 0.06 | 187 | abierto |
| `trafico_peatonal >= 164.5` y `trafico_peatonal < 224.5` | 2 de cada 10 | 0.23 | 74 | abierto |
| `trafico_peatonal < 164.5` y `experiencia_operador >= 8.5` | 1 de cada 10 | 0.12 | 24 | abierto |
| `trafico_peatonal < 164.5` y `experiencia_operador < 8.5` | 5 de cada 10 | 0.55 | 75 | **cerró** |

Como las variables son enteras, los cortes equivalen a 165, 225 personas por hora y 9 años.

## 2. La matriz y las métricas en validación (120 puntos de venta, 24 cierres; umbral 0.5)

| TP | FP | FN | TN | Exactitud | Margen (2 EE) | Precisión | Sensibilidad |
|---|---|---|---|---|---|---|---|
| 15 | 11 | 9 | 85 | 0.833 | ± 0.068 | 0.577 | 0.625 |

## 3. La tabla del líder (exactitud, sensibilidad)

| Regla o modelo | Exactitud | Sensibilidad |
|---|---|---|
| Nadie cierra | 0.800 | 0.000 |
| Consultora A | 0.858 | 0.417 |
| Consultora B | 0.792 | 0.500 |
| Árbol de dos niveles | 0.833 | 0.625 |
| Árbol podado (regla 1-SE) | 0.800 | 0.000 |
| Memorizador | 0.767 | 0.458 |

El memorizador (`cp = 0.0001`, `minsplit = 2`, `minbucket = 1`) tiene 50 hojas: exactitud 1.000 en entrenamiento y 0.767 en validación. La regla 1-SE (tope 1.105, cp 0.04861) poda hasta una hoja: el tocón.

## 4. El umbral con los costos

p\* = c ÷ (u × V) = 12 ÷ (0.5 × 250) = **0.096** con u = 0.5; **0.192** con u = 0.25. Con u = 0.5 quedan por debajo de p\* (no requieren evaluación a fondo) los locales 1 y 2. Orden por riesgo con cupo: local 3 > local 1 > local 2 (1 y 2 empatados en probabilidad).

## 5. Los tres locales de Barranquilla

| Local | Probabilidad de cierre del árbol | Nota de extrapolación |
|---|---|---|
| local_1 | 0.059 | * Barranquilla no está en el estudio |
| local_2 | 0.059 | * Barranquilla no está en el estudio; `arriendo_mes` = 27 fuera del rango [4.5, 25] |
| local_3 | 0.547 | * Barranquilla no está en el estudio |

## 6. La estabilidad y la fuga

- Con otras semillas de partición (101, 202, 303) la raíz es siempre `trafico_peatonal` (cortes 164.5, 160.5 y 164.5); los cortes de segundo nivel cambian (ticket promedio y competidores; tráfico y competidores; experiencia).
- Con las columnas de después de abrir, la raíz pasa a `meses_atraso_arriendo < 2.5` y la exactitud en validación sube a 0.942 (sensibilidad 0.833) frente a 0.833 sin la fuga. Esa cifra no se reporta.
