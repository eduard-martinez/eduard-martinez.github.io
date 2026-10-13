# Sobre sellado · Semana 7: escenarios y decisión

Analítica Predictiva y Prescriptiva · TIC-60286 · Semana 7 · Sobre sellado. Se publica en Canvas al vencer la entrega del task 7. Las cifras salen de `datasets/week-07/cifras_week07.txt` (generador `_generar_vpn_latitud.R`; verificación `_verificacion_week07.R`) y se reproducen con las celdas de R de la teoría (sección "La plantilla en R") o con la práctica 7: "Cargar los escenarios de referencia", local 1, dos tramos. Millones de pesos; decimales con punto.

La regla del sobre: la cifra del equipo (o del asistente) vale cuando coincide con la del sobre dentro de **± 1 millón**, o cuando la diferencia se explica en el acta (otro local, otros tramos, otro parámetro declarado en la tabla de supuestos).

## 1. La plantilla y los parámetros de referencia

La plantilla de la gerencia financiera de Latitud: horizonte 5 años, flujos anuales al final de cada año, sin valor terminal; tasa de descuento 12 % (factor de anualidad 3.6048); impuesto 30 % sobre la utilidad operativa cuando es positiva. Un millón mensual de ventas de la tienda vale 12 × 0.30 × 0.70 × 3.6048 = 9.08 ≈ 9 millones de VPN.

| Alternativa | Parámetros de referencia |
|---|---|
| A, la primera tienda en Barranquilla | Inversión 700. Ventas base del árbol de la semana 6: local 1 147.0, local 2 207.2, local 3 63.3 (banda ± 22.6: [124.4, 169.7], [184.5, 229.8], [40.6, 85.9]). Margen de contribución 30 %, después del costo de la mercancía y de la nómina de la tienda. Arriendo 16.5 / 27 / 8. Costos fijos 4 al mes. Crecimiento de ventas 0 y variación del arriendo 0 en el base |
| B, el Club Latitud por tramos | 150 por tramo; 1.000 / 750 / 500 suscriptores nuevos por tramo; retención anual 70 %; ingreso 0.08 al mes por suscriptor (la cuota de la canasta); margen 25 %; fijos 2 al mes por tramo |
| C, el piloto (un punto de formato reducido durante seis meses) | 120 hoy; A se abre en el año 1 solo si su VPN en ese escenario es positivo: VPN_C = −120 + max(0, VPN_A) / 1.12 |
| D, esperar | 0 |

## 2. El escenario base (lo que se compara con la parte 2 del task)

A con el local 1, línea a línea: ventas anuales 1.764.0 · margen de contribución 529.2 · arriendo 198.0 · fijos 48.0 · utilidad operativa 283.2 · impuesto 85.0 · flujo 198.2 · × 3.6048 = 714.6 · − 700 = **14.6**. Las ventas mensuales de equilibrio del local 1 son 145.4: 1.6 por debajo de la predicción del árbol, cuyo error promedio es 22.6.

| Alternativa | VPN base |
|---|---|
| A, local 1 | **14.6** |
| A, local 2 | **243.5** (extrapolado: arriendo 27 fuera del rango del estudio y hoja de diez puntos de venta; calidad baja) |
| A, local 3 | **−488.3** |
| B, 1 tramo | **151.3** |
| B, 2 tramos | **212.1** (el óptimo; el segundo tramo suma 60.8) |
| B, 3 tramos | **182.5** (el tercer tramo resta 29.6) |
| C | **−107.0** |
| D | **0** |

Orden del base: B 2 tramos > B 1 tramo > A local 1 > D > C.

## 3. El análisis de banda (local 1)

| Ventas base | A | C | D |
|---|---|---|---|
| Banda baja, 124.4 | −190.7 | −120.0 | 0 |
| Base, 147.0 | 14.6 | −107.0 | 0 |
| Banda alta, 169.7 | 220.8 | 77.2 | 0 |

El piloto limita el peor caso de A (de −190.7 a −120.0) y conserva 77.2 de los 220.8 de la banda alta.

## 4. Los escenarios de referencia y su tabla de robustez (A local 1, B 2 tramos)

Eje 1, gasto de los hogares: crece (ventas +4 % anual, suscriptores × 1, retención 70 %) o se estanca (−3 %, × 0.75, 65 %). Eje 2, costos (arriendo e inflación de alimentos): estables (arriendo 0, margen de la tienda 30 %, margen del Club 25 %) o suben (arriendo +18 % desde el año 1; la inflación de alimentos no se traslada completa al precio y los márgenes bajan a 27 % y 20 %). Tasa 12 % en los cuatro.

| | E1 Viento a favor | E2 Crecimiento caro | E3 Apretón | E4 Calma chicha | Peor caso | Arrepentimiento máximo |
|---|---|---|---|---|---|---|
| A, local 1 | 113.0 | −120.3 | −271.1 | −54.5 | −271.1 | 271.1 |
| B, 2 tramos | 212.1 | 85.5 | −71.0 | 17.1 | −71.0 | **71.0** |
| C | −19.1 | −120.0 | −120.0 | −120.0 | −120.0 | 231.2 |
| D | 0 | 0 | 0 | 0 | 0 | 212.1 |
| Gana | B | B | D | B | | robusta: **B** |

B por tramos (1 / 2 / 3): E1 151.3 / 212.1 / 182.5; E2 78.9 / 85.5 / 19.7; E3 −10.2 / −71.0 / −183.3; E4 39.9 / 17.1 / −68.2. A por local (1 / 2 / 3): E1 113.0 / 382.3 / −446.0; E2 −120.3 / 33.0 / −551.3; E3 −271.1 / −179.5 / −616.2; E4 −54.5 / 146.1 / −518.1.

## 5. El choque de la sesión: arriendos +18 % y tasa 14 % sobre el base

A local 1 **−105.1** (solo el arriendo: −75.3; solo la tasa: −19.4) · local 2 58.4 · local 3 −539.9 · B 1 tramo 140.8 · **2 tramos 194.5** · 3 tramos 161.1 · C −120.0 · D 0. Sobreviven B y D.

## 6. Ponerle ruido a los supuestos (opcional; semilla 7, 1.000 corridas)

Ventas base ~ Normal(147, 28), crecimiento ~ U(−3 %, +4 %), margen ~ U(27 %, 32 %), arriendo ~ U(0, +18 %), retención ~ U(0.62, 0.75), suscriptores × U(0.75, 1.10). A local 1: P10 −364.7, P50 −50.1, P90 308.1, pierde en 58.6 % de las corridas. B 2 tramos: P10 62.5, P50 156.7, P90 251.8, pierde en 0.1 %. Tornado de A: las ventas base recorren 651.9; el margen 222.6; el crecimiento 167.5; el arriendo 89.9. La práctica usa otro generador de números aleatorios: sus percentiles difieren de estos en unos pocos millones, y eso no se califica.
