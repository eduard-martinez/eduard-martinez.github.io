## ============================================
## Taller 10 — Los vendedores de modelos
## SOLUCION DE REFERENCIA (solo para el profesor)
## Correr desde week-10/input/:
##   Rscript _solucion_taller10.R
## (los estudiantes usan data/... en su proyecto;
##  aqui se leen desde ../task/)
## ============================================

## Librerías / Libraries
library(dplyr)

## Cargar datos / Load data
credito <- read.csv("../task/credito_taller10.csv")
notas   <- read.csv("../task/notas_taller10.csv")

## Radiografía / First look
dim(credito)   # 80 x 7
dim(notas)     # 60 x 7

## Punto 0c — credito: target real = decision_real, prediccion = decision_modelo
##            notas:   target real = nota_real,     prediccion = nota_modelo


## ============================================
## Punto 1 — CreditoYa bajo el microscopio
## ============================================

## Punto 1a — la vara
table(credito$decision_real)                              # Aprobado 44 / Rechazado 36
round(max(table(credito$decision_real)) / nrow(credito), 3)  # 0.55
## Clase mayoritaria: Aprobado. "Aprobar a todo el mundo" acierta el 55%.

## Punto 1b — la matriz
table(Real = credito$decision_real, Modelo = credito$decision_modelo)
##            Modelo
## Real        Aprobado Rechazado
##   Aprobado        43         1
##   Rechazado       11        25

## Punto 1c —
## TP = 43 : buen cliente aprobado -> el banco gana la ganancia del credito
## FN =  1 : buen cliente rechazado -> negocio perdido (1 solo caso)
## FP = 11 : moroso aprobado -> credito impago, EL error caro (8 buenos c/u)
## TN = 25 : moroso rechazado -> perdida evitada


## ============================================
## Punto 2 — La letra menuda del 85%
## ============================================

## Punto 2a
tp <- sum(credito$decision_real == "Aprobado"  & credito$decision_modelo == "Aprobado")
fn <- sum(credito$decision_real == "Aprobado"  & credito$decision_modelo == "Rechazado")
fp <- sum(credito$decision_real == "Rechazado" & credito$decision_modelo == "Aprobado")
tn <- sum(credito$decision_real == "Rechazado" & credito$decision_modelo == "Rechazado")
round((tp + tn) / (tp + tn + fp + fn), 3)   # accuracy  0.85
round(tp / (tp + fp), 3)                    # precision 0.796
round(tp / (tp + fn), 3)                    # recall    0.977

## Punto 2b — el folleto dice la verdad... y solo la parte que le conviene:
## accuracy 85% verificada (0.85) y en efecto ~30 pts sobre el baseline (55%).

## Punto 2c — la cifra de la gerente
round(100 * fp / (tp + fp), 1)              # 20.4
## "De cada 100 creditos que el modelo aprueba, unos 20 NO se pagan."

## Punto 2d — el modelo es generosisimo aprobando (recall 97.7%): acierta
## casi todos los buenos y eso sostiene la accuracy. Pero de 54 aprobados,
## 11 son morosos: la PRECISION (79.6%) era la metrica que lo delataba.
## Con el impago costando 8 creditos buenos, 20 impagos por cada 100
## aprobados es inaceptable tal cual.


## ============================================
## Punto 3 — PronosticaU contra la regla tonta
## ============================================

## Punto 3a — baseline: predecir siempre 3.2
round(mean(abs(notas$nota_real - 3.2)), 3)          # MAE  0.4
round(sqrt(mean((notas$nota_real - 3.2)^2)), 3)     # RMSE 0.5

## Punto 3b — proveedor
round(mean(abs(notas$nota_real - notas$nota_modelo)), 3)        # MAE  0.552
round(sqrt(mean((notas$nota_real - notas$nota_modelo)^2)), 3)   # RMSE 0.724

## Punto 3c — "se equivoca por apenas medio punto": 0.552 es MAS de medio
## punto (redondeo generoso del vendedor). "Supera cualquier regla simple":
## FALSO — la regla tonta de predecir 3.2 tiene MAE 0.40 y RMSE 0.50;
## el proveedor pierde en las dos metricas contra no hacer nada.

## Punto 3d — RMSE (0.724) muy por encima del MAE (0.552) => comete
## embarradas grandes ocasionales. Para alertas tempranas es lo peor:
## una nota muy sobreestimada = estudiante en riesgo que NUNCA recibe
## la alerta (y una muy subestimada = alarma falsa que desgasta).


## ============================================
## MEMORANDO FINAL (referencia)
## ============================================
## BancoAndes: NO firmar tal cual. La accuracy del folleto es cierta
## (85% vs 55% del baseline), pero de cada 100 creditos aprobados ~20
## no se pagan (precision 79.6%), y el impago cuesta 8 creditos buenos:
## el modelo concentra su error justo donde mas cuesta. Renegociar:
## exigir mas precision (umbral mas estricto) aunque baje el recall,
## y repetir esta auditoria sobre datos nuevos antes de firmar.
##
## Universidad: NO firmar. El pronosticador pierde contra la regla de
## predecir el promedio historico (MAE 0.552 vs 0.400; RMSE 0.724 vs
## 0.500): aporta menos que no tener modelo. Ademas su brecha MAE-RMSE
## delata errores grandes ocasionales, fatales para alertas tempranas.
##
## Riesgo de la auditoria: las filas de prueba las entrego el propio
## vendedor — no sabemos si su test estaba "gastado" (consultado muchas
## veces) ni si el perfil de solicitantes/estudiantes futuros cambiara.
## Pedir una prueba ciega con datos frescos del cliente.
