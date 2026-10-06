# Diccionario de datos — Caso Cóndor

Fecha de corte: **31 de marzo de 2026**. Los predictores se miden hasta esa fecha; las
variables objetivo (🎯) se refieren a lo que ocurre en o después de ella. Todas las tablas
se unen por `cliente_id`. Fuente: contexto del caso Cóndor (curso 06327-ECO, Icesi).

## `base_clientes.csv` — una fila por cliente (8.000 filas, 29 columnas)

### Identificación y demografía

| Variable | Tipo | Descripción |
|---|---|---|
| `cliente_id` | id | Identificador único del cliente. Llave para unir la base con los anexos. |
| `edad` | entero | Edad del cliente, en años. |
| `genero` | categórica | Género del cliente: F, M u Otro. |
| `ciudad` | categórica | Ciudad de residencia declarada. |
| `departamento` | categórica | Departamento o región de residencia. |
| `ocupacion` | categórica | Ocupación: empleado, independiente, estudiante o pensionado. |
| `ingreso_declarado` | continua | Ingreso mensual declarado al registrarse, en COP. |
| `kyc_nivel` | ordinal | Nivel de verificación de identidad (nivel_1, nivel_2 o nivel_3): a mayor nivel, más datos validados. |
| `canal_adquisicion` | categórica | Cómo llegó el cliente: organico, ads_meta, ads_google, referido o influencer. |
| `antiguedad_meses` | entero | Meses desde el registro hasta la fecha de corte. |

### Comportamiento transaccional (RFM)

| Variable | Tipo | Descripción |
|---|---|---|
| `recencia_dias` | entero | Días desde la última transacción hasta el corte (la **R** de RFM: menos días = cliente más reciente). |
| `frecuencia_tx` | entero | Número total de transacciones del cliente (la **F** de RFM). |
| `monto_total` | continua | Suma de todos los montos transados, en COP (la **M** de RFM). |
| `monto_promedio` | continua | Monto promedio por transacción, en COP. |
| `ticket_mediano` | continua | Mediana del monto de sus transacciones, en COP; no se distorsiona con transacciones muy grandes. |
| `pct_tx_internacional` | continua | Proporción de transacciones internacionales, entre 0 y 1. |
| `num_categorias_mcc` | entero | Cantidad de rubros distintos en los que ha comprado. |
| `canal_preferido` | categórica | Canal más frecuente: app_qr, tarjeta, pse o link. |

### Uso de la app, soporte y saldo

| Variable | Tipo | Descripción |
|---|---|---|
| `num_sesiones_ult30d` | entero | Sesiones en la app en los últimos 30 días antes del corte. |
| `duracion_sesion_promedio` | continua | Duración promedio de una sesión, en segundos. **Vacía** si no tuvo sesiones recientes. |
| `os_principal` | categórica | Sistema operativo principal: Android o iOS. |
| `num_tickets` | entero | Tickets de soporte abiertos por el cliente. |
| `csat_promedio` | continua | Satisfacción promedio con el soporte (1 a 5). **Vacía** si nunca abrió un ticket. |
| `gasto_promedio_mensual` | continua | Gasto mensual histórico promedio, en COP. |
| `saldo_promedio_ult3m` | continua | Saldo promedio en la cuenta los últimos 3 meses, en COP. |

### Crédito

| Variable | Tipo | Descripción |
|---|---|---|
| `tiene_credito` | binaria | 1 si ha solicitado al menos un crédito; 0 si nunca. |
| `score_buro` | continua | Puntaje de buró (300 a 850) de su última solicitud. **Vacía** si nunca pidió crédito. |

### Variables objetivo

| Variable | Tipo | Descripción |
|---|---|---|
| 🎯 `abandono` | binaria | **Ruta de clasificación.** 1 si el cliente se vuelve inactivo (deja de usar Cóndor), 0 si sigue activo. Definida para todos los clientes. |
| 🎯 `gasto_proximo_trim` | continua | **Ruta de regresión.** Gasto total del cliente, en COP, durante el trimestre siguiente al corte. |

## `anexo_transacciones.csv` — una fila por transacción (185.582 filas, 11 columnas)

| Variable | Tipo | Descripción |
|---|---|---|
| `transaccion_id` | id | Identificador único de la transacción. |
| `cliente_id` | id | Cliente que realizó la operación. Llave para unir con la base. |
| `comercio_id` | id | Comercio de la compra. **Vacío** cuando la operación no es una compra (transferencia, retiro, recarga o pago de servicio). |
| `timestamp` | fecha-hora | Fecha y hora exactas de la transacción. |
| `monto` | continua | Valor de la transacción, en COP. |
| `tipo` | categórica | Tipo de operación: compra, transferencia, retiro, recarga o pago_servicio. |
| `canal` | categórica | Medio de la operación: app_qr, tarjeta, pse o link. |
| `rubro` | categórica | Rubro del comercio (supermercado, restaurante, gasolinera…). **Vacío** cuando no es una compra. |
| `es_internacional` | binaria | 1 si la transacción fue internacional; 0 si nacional. |
| `estado` | categórica | Resultado: aprobada o rechazada. |
| 🎯 `etiqueta_fraude` | binaria | **Objetivo (clasificación).** 1 si la transacción fue fraudulenta, 0 si legítima. |

## `anexo_creditos.csv` — una fila por solicitud de crédito (4.071 filas, 11 columnas; 2.721 clientes distintos)

| Variable | Tipo | Descripción |
|---|---|---|
| `credito_id` | id | Identificador único de la solicitud. |
| `cliente_id` | id | Cliente que solicitó el crédito. Llave para unir con la base. |
| `fecha_solicitud` | fecha | Fecha de la solicitud. |
| `monto_aprobado` | continua | Monto aprobado, en COP. |
| `plazo_meses` | entero | Plazo pactado, en meses. |
| `tasa` | continua | Tasa de interés mensual. |
| `score_buro` | continua | Puntaje de buró (300 a 850) al momento de la solicitud. |
| `destino` | categórica | Uso declarado: consumo, educación, negocio, salud u otros. |
| 🎯 `default_90d` | binaria | **Objetivo (clasificación).** 1 si cayó en mora de 90+ días, 0 si pagó al día. |
| `dias_mora` | entero | Días de mora acumulados (0 si no hubo). *Solo se conoce después de otorgar el crédito.* |
| 🎯 `monto_recuperado` | continua | **Objetivo (regresión).** Cartera en mora recuperada, en COP. *Solo se conoce después de otorgar el crédito.* |

## `anexo_campanas.csv` — una fila por envío de campaña (13.467 filas, 7 columnas; 6.386 clientes distintos)

| Variable | Tipo | Descripción |
|---|---|---|
| `campana_id` | id | Identificador único del envío. |
| `cliente_id` | id | Cliente que recibió la campaña. Llave para unir con la base. |
| `fecha_envio` | fecha | Fecha del envío. |
| `canal` | categórica | Medio del envío: push, email o sms. |
| `tipo_oferta` | categórica | Oferta enviada: cashback, descuento, upgrade_credito o generico. |
| `costo` | continua | Costo del envío para Cóndor, en COP. |
| 🎯 `convertido` | binaria | **Objetivo (clasificación).** 1 si el cliente respondió a la oferta, 0 si no. |

## Advertencia sobre fugas de información

No usar como predictor ninguna variable que solo se conoce **después** del evento que se
quiere explicar o predecir. Por ejemplo, `dias_mora` y `monto_recuperado` no sirven para
explicar `default_90d` (al aprobar el crédito todavía no existen), y `gasto_proximo_trim`
no sirve para explicar `abandono` (se mide después del corte). Cuando una variable
"predice demasiado bien", sospechar de esto.
