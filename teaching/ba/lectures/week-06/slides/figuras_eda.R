## ============================================
## Semana 6 — El EDA de Cóndor, paso a paso
## Cifras y figuras de la presentación week-06.tex
## Curso: Analítica para los negocios (06327-ECO)
## Autor: Eduard F. Martínez González
## ============================================
## Todo se lee desde las URL vigentes del proyecto final (lineamientos 202620);
## no se guarda ninguna copia local de los datos. Correr desde esta carpeta
## (lectures/week-06/slides/): escribe las figuras en pic/ y las cifras que
## usan las láminas en cifras_eda.txt.

## -------------------------------------------- ##
## 1. Librerías
require(pacman)
p_load(dplyr, tidyr, ggplot2, scales)
## al correr con Rscript desde la terminal el locale puede no ser UTF-8 y los
## acentos de las figuras salen rotos; en RStudio esta línea no cambia nada
invisible(Sys.setlocale("LC_ALL", "en_US.UTF-8"))

## -------------------------------------------- ##
## 2. Datos (URL vigentes del caso Cóndor)
url_base <- "https://eduard-martinez.github.io/teaching/ba/final_project/data/"
clientes <- read.csv(paste0(url_base, "base_clientes.csv"))
campanas <- read.csv(paste0(url_base, "anexo_campanas.csv"))
transacciones <- read.csv(paste0(url_base, "anexo_transacciones.csv"))

## -------------------------------------------- ##
## 3. Estilo común de las figuras
azul    <- "#1F4E79"
naranja <- "#E87722"
gris    <- "#9AA0A6"
tema <- theme_minimal(base_size = 13) +
        theme(plot.title = element_text(face = "bold", size = 14),
              plot.subtitle = element_text(color = "grey35"),
              panel.grid.minor = element_blank(),
              legend.position = "top")
pct  <- function(x, acc = 0.1) percent(x, accuracy = acc, decimal.mark = ",", big.mark = ".", suffix = " %")
num  <- function(x, acc = 1) number(x, accuracy = acc, big.mark = ".", decimal.mark = ",")
dir.create("pic", showWarnings = FALSE)
guardar <- function(g, nombre, ancho = 7.5, alto = 4.6) {
  ggsave(file.path("pic", nombre), g, width = ancho, height = alto, dpi = 200, bg = "white")
}

## -------------------------------------------- ##
## 4. Cifras: todo lo que dicen las láminas sale de aquí
sink("cifras_eda.txt")
cat("CIFRAS DEL EDA DE CÓNDOR — generadas por figuras_eda.R el", format(Sys.time(), "%Y-%m-%d %H:%M"), "\n\n")

## Paso 1 — qué es una fila y cuántas hay
cat("== Paso 1: la radiografía ==\n")
cat("base_clientes:", nrow(clientes), "filas x", ncol(clientes), "columnas\n")
cat("cliente_id únicos:", n_distinct(clientes$cliente_id), "| filas duplicadas:", sum(duplicated(clientes)), "\n")
cat("anexo_campanas:", nrow(campanas), "filas (envíos) de", n_distinct(campanas$cliente_id), "clientes\n")
cat("anexo_transacciones:", nrow(transacciones), "filas de", n_distinct(transacciones$cliente_id), "clientes\n")
## la base ya trae el RFM calculado desde el anexo: se verifica en vez de creerlo
rfm <- transacciones %>% group_by(cliente_id) %>% summarise(n_tx = n(), suma = sum(monto), .groups = "drop")
chequeo <- inner_join(select(clientes, cliente_id, frecuencia_tx, monto_total), rfm, by = "cliente_id")
cat("frecuencia_tx == conteo del anexo en", mean(chequeo$frecuencia_tx == chequeo$n_tx) * 100, "% de los clientes\n")
cat("monto_total == suma del anexo en", mean(chequeo$monto_total == chequeo$suma) * 100, "% de los clientes\n\n")

## Paso 2 — qué falta y por qué
cat("== Paso 2: faltantes ==\n")
na_col <- colSums(is.na(clientes)); print(na_col[na_col > 0])
cat("sin sesiones (num_sesiones_ult30d == 0):", sum(clientes$num_sesiones_ult30d == 0),
    "| duracion NA exactamente en esos:", all(is.na(clientes$duracion_sesion_promedio) == (clientes$num_sesiones_ult30d == 0)), "\n")
cat("sin tickets (num_tickets == 0):", sum(clientes$num_tickets == 0),
    "| csat NA exactamente en esos:", all(is.na(clientes$csat_promedio) == (clientes$num_tickets == 0)), "\n")
cat("sin crédito (tiene_credito == 0):", sum(clientes$tiene_credito == 0),
    "| score NA exactamente en esos:", all(is.na(clientes$score_buro) == (clientes$tiene_credito == 0)), "\n\n")

## Paso 3 — el target
cat("== Paso 3: el target ==\n")
cat("abandono = 1:", sum(clientes$abandono), "de", nrow(clientes), "=", pct(mean(clientes$abandono), 0.01), "\n")
cat("clientes con recencia > 90 días:", sum(clientes$recencia_dias > 90),
    "| de ellos abandonan:", sum(clientes$abandono[clientes$recencia_dias > 90]),
    "=", pct(mean(clientes$abandono[clientes$recencia_dias > 90])), "\n\n")

## Paso 4 — distribuciones
cat("== Paso 4: distribuciones ==\n")
cat("recencia_dias: mediana", median(clientes$recencia_dias), "| media", round(mean(clientes$recencia_dias), 1),
    "| p90", quantile(clientes$recencia_dias, .9), "| máx", max(clientes$recencia_dias), "\n")
cat("monto_total: mediana", num(median(clientes$monto_total)), "| media", num(mean(clientes$monto_total)),
    "| p99", num(quantile(clientes$monto_total, .99)), "| máx", num(max(clientes$monto_total)), "\n")
cat("num_sesiones_ult30d: mediana", median(clientes$num_sesiones_ult30d), "| media", round(mean(clientes$num_sesiones_ult30d), 1), "\n\n")

## Paso 5 — quiénes abandonan más (señales de comportamiento)
cat("== Paso 5: comparaciones por grupo ==\n")
tramos_rec <- clientes %>%
  mutate(tramo = cut(recencia_dias, c(-1, 7, 30, 60, 90, Inf),
                     labels = c("1–7 días", "8–30", "31–60", "61–90", "más de 90"))) %>%
  group_by(tramo) %>% summarise(n = n(), tasa = mean(abandono), .groups = "drop")
print(tramos_rec)
tramos_ses <- clientes %>%
  mutate(tramo = cut(num_sesiones_ult30d, c(-1, 0, 3, 10, 20, Inf),
                     labels = c("0 sesiones", "1–3", "4–10", "11–20", "más de 20"))) %>%
  group_by(tramo) %>% summarise(n = n(), tasa = mean(abandono), .groups = "drop")
print(tramos_ses)
cat("\n")

## Paso 6 — lo que "debería" importar y no discrimina
cat("== Paso 6: hipótesis que no se sostienen ==\n")
por_canal <- clientes %>% group_by(canal_adquisicion) %>% summarise(n = n(), tasa = mean(abandono), .groups = "drop")
print(por_canal)
por_ciudad <- clientes %>% group_by(ciudad) %>% summarise(n = n(), tasa = mean(abandono), .groups = "drop") %>% arrange(desc(tasa))
print(por_ciudad)
cat("rango por ciudad:", pct(min(por_ciudad$tasa)), "a", pct(max(por_ciudad$tasa)), "\n")
for (v in c("genero", "os_principal", "kyc_nivel", "ocupacion")) {
  t <- clientes %>% group_by(.data[[v]]) %>% summarise(tasa = mean(abandono), .groups = "drop")
  cat(v, ": de", pct(min(t$tasa)), "a", pct(max(t$tasa)), "\n")
}
cat("\n")

## Paso 7 — las dos señales se complementan
cat("== Paso 7: relación entre señales ==\n")
cat("correlación recencia vs sesiones:", round(cor(clientes$recencia_dias, clientes$num_sesiones_ult30d), 2), "\n")
cruce <- clientes %>%
  mutate(rec = cut(recencia_dias, c(-1, 7, 30, 90, Inf), labels = c("1–7 días", "8–30", "31–90", "más de 90")),
         ses = cut(num_sesiones_ult30d, c(-1, 0, 3, 10, Inf), labels = c("0", "1–3", "4–10", "más de 10"))) %>%
  group_by(rec, ses) %>% summarise(n = n(), tasa = mean(abandono), .groups = "drop")
print(cruce, n = 20)
cat("\n")

## Paso 8 — el anexo de campañas: agregar y luego unir
cat("== Paso 8: campañas (agregar antes de unir) ==\n")
cat("envíos:", nrow(campanas), "| conversión global:", pct(mean(campanas$convertido)), "| costo promedio por envío:", num(mean(campanas$costo)), "\n")
print(campanas %>% group_by(tipo_oferta) %>% summarise(n = n(), conversion = mean(convertido), .groups = "drop") %>% arrange(desc(conversion)))
camp_cli <- campanas %>% group_by(cliente_id) %>% summarise(n_campanas = n(), n_convertidas = sum(convertido), .groups = "drop")
base <- left_join(clientes, camp_cli, by = "cliente_id") %>%
  mutate(n_campanas = coalesce(n_campanas, 0L), n_convertidas = coalesce(n_convertidas, 0L),
         grupo_camp = case_when(n_campanas == 0 ~ "Sin campañas",
                                n_convertidas == 0 ~ "Recibió y no respondió",
                                TRUE ~ "Respondió al menos una"))
cat("filas tras el join (deben seguir siendo", nrow(clientes), "):", nrow(base), "\n")
cat("filas si se une SIN agregar:", nrow(left_join(clientes, campanas, by = "cliente_id")), "\n")
por_camp <- base %>% group_by(grupo_camp) %>% summarise(n = n(), tasa = mean(abandono), .groups = "drop")
print(por_camp)
cat("\n")

## Paso 9 — lo raro que quedó y la fuga de información
cat("== Paso 9: colas largas, atípicos y fuga ==\n")
g <- clientes$gasto_proximo_trim
q <- quantile(g, c(.25, .5, .75)); lim <- q[3] + 1.5 * (q[3] - q[1])
cat("gasto_proximo_trim: mediana", num(q[2]), "| Q3", num(q[3]), "| límite Q3 + 1,5 IQR", num(lim),
    "| por encima:", sum(g > lim), "=", pct(mean(g > lim)), "| máximo", num(max(g)), "\n")
cat("fila del máximo:\n"); print(clientes[which.max(g), c("cliente_id", "antiguedad_meses", "recencia_dias", "frecuencia_tx",
                                                          "monto_total", "gasto_promedio_mensual", "num_sesiones_ult30d", "abandono", "gasto_proximo_trim")])
cat("¿gasto_proximo_trim predice abandono? (es del futuro: NO se usa) mediana por grupo:\n")
print(clientes %>% group_by(abandono) %>% summarise(mediana_gasto_prox = median(gasto_proximo_trim), .groups = "drop"))
sink()

## -------------------------------------------- ##
## 5. Figuras
## 5.1 El target: la tasa base
d <- clientes %>% count(abandono) %>% mutate(p = n / sum(n), etiqueta = ifelse(abandono == 1, "Se vuelve inactivo", "Sigue activo"))
g1 <- ggplot(d, aes(x = etiqueta, y = p, fill = etiqueta)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = paste0(pct(p), "\n", num(n), " clientes")), vjust = -0.3, size = 4.2, lineheight = 0.9) +
  scale_fill_manual(values = c("Sigue activo" = gris, "Se vuelve inactivo" = naranja), guide = "none") +
  scale_y_continuous(labels = pct, limits = c(0, 1), expand = expansion(mult = c(0, 0.02))) +
  labs(title = "Uno de cada cinco clientes se vuelve inactivo", subtitle = "variable abandono en base_clientes (8.000 clientes)",
       x = NULL, y = "Proporción de clientes") + tema
guardar(g1, "fig_target.png", ancho = 6, alto = 4.4)

## 5.2 Distribuciones sesgadas: la media no representa al cliente típico
g2 <- ggplot(clientes, aes(x = recencia_dias)) +
  geom_histogram(binwidth = 15, boundary = 0, fill = azul, color = "white") +
  geom_vline(xintercept = median(clientes$recencia_dias), color = naranja, linewidth = 1) +
  geom_vline(xintercept = mean(clientes$recencia_dias), color = "grey30", linetype = "dashed", linewidth = 0.9) +
  annotate("text", x = median(clientes$recencia_dias) + 8, y = Inf, vjust = 1.5, hjust = 0, color = naranja, size = 4,
           label = paste0("mediana: ", median(clientes$recencia_dias), " días")) +
  annotate("text", x = mean(clientes$recencia_dias) + 8, y = Inf, vjust = 3.4, hjust = 0, color = "grey30", size = 4,
           label = paste0("media: ", round(mean(clientes$recencia_dias)), " días")) +
  scale_y_continuous(labels = num) +
  labs(title = "Días desde la última transacción: una cola larga hacia la derecha",
       subtitle = "la mitad transó hace 15 días o menos; unos pocos llevan más de un año",
       x = "recencia_dias", y = "Clientes") + tema
guardar(g2, "fig_recencia_hist.png")

g3 <- ggplot(clientes, aes(x = monto_total / 1e6)) +
  geom_histogram(binwidth = 0.1, boundary = 0, fill = azul, color = "white") +
  geom_vline(xintercept = median(clientes$monto_total) / 1e6, color = naranja, linewidth = 1) +
  geom_vline(xintercept = mean(clientes$monto_total) / 1e6, color = "grey30", linetype = "dashed", linewidth = 0.9) +
  annotate("text", x = median(clientes$monto_total) / 1e6 + 0.08, y = Inf, vjust = 1.5, hjust = 0, color = naranja, size = 4,
           label = paste0("mediana: $", num(median(clientes$monto_total) / 1e3), " mil")) +
  annotate("text", x = mean(clientes$monto_total) / 1e6 + 0.08, y = Inf, vjust = 3.4, hjust = 0, color = "grey30", size = 4,
           label = paste0("media: $", num(mean(clientes$monto_total) / 1e3), " mil")) +
  scale_x_continuous(labels = function(x) paste0("$", x, " M")) + scale_y_continuous(labels = num) +
  labs(title = "Monto total transado: la media queda arrastrada por la cola",
       subtitle = "en colas largas el resumen honesto es la mediana (o los tramos)",
       x = "monto_total (millones de COP)", y = "Clientes") + tema
guardar(g3, "fig_monto_hist.png")

## 5.3 Quiénes abandonan más: las señales de comportamiento
barras_tasa <- function(d, titulo, subtitulo, xlab) {
  ggplot(d, aes(x = tramo, y = tasa)) +
    geom_col(fill = naranja, width = 0.7) +
    geom_hline(yintercept = mean(clientes$abandono), linetype = "dashed", color = "grey30") +
    geom_text(aes(label = pct(tasa)), vjust = -0.4, size = 4.2, fontface = "bold") +
    geom_text(aes(y = 0, label = paste0("n = ", num(n))), vjust = 1.6, size = 3.3, color = "grey35") +
    annotate("text", x = 0.55, y = mean(clientes$abandono), label = paste0("tasa global ", pct(mean(clientes$abandono))),
             vjust = -0.5, hjust = 0, size = 3.5, color = "grey30") +
    scale_y_continuous(labels = pct, limits = c(0, 0.72), expand = expansion(mult = c(0.08, 0.02))) +
    labs(title = titulo, subtitle = subtitulo, x = xlab, y = "Tasa de abandono") + tema
}
guardar(barras_tasa(tramos_rec, "A más días sin transar, más abandono", "tasa de abandono por tramo de recencia_dias", "Días desde la última transacción"),
        "fig_abandono_recencia.png", ancho = 6.2, alto = 4.6)
guardar(barras_tasa(tramos_ses, "Quien no abre la app ya casi se fue", "tasa de abandono por tramo de num_sesiones_ult30d", "Sesiones en la app en los últimos 30 días"),
        "fig_abandono_sesiones.png", ancho = 6.2, alto = 4.6)

## 5.4 Lo que "debería" importar y no discrimina
plano <- function(d, var, titulo, subtitulo, xlab) {
  ggplot(d, aes(x = reorder(.data[[var]], -tasa), y = tasa)) +
    geom_col(fill = gris, width = 0.7) +
    geom_hline(yintercept = mean(clientes$abandono), linetype = "dashed", color = naranja, linewidth = 0.9) +
    geom_text(aes(label = pct(tasa)), vjust = -0.4, size = 3.8) +
    scale_y_continuous(labels = pct, limits = c(0, 0.72), expand = expansion(mult = c(0, 0.02))) +
    labs(title = titulo, subtitle = subtitulo, x = xlab, y = "Tasa de abandono") + tema +
    theme(axis.text.x = element_text(angle = ifelse(var == "ciudad", 35, 0), hjust = ifelse(var == "ciudad", 1, 0.5)))
}
guardar(plano(por_canal, "canal_adquisicion", "El canal por el que llegaron no cambia casi nada", "misma escala que las figuras anteriores; línea: tasa global", "Canal de adquisición"),
        "fig_abandono_canal.png", ancho = 6.2, alto = 4.6)
guardar(plano(por_ciudad, "ciudad", "Tampoco la ciudad: todas entre 20 % y 24 %", "misma escala que las figuras anteriores; línea: tasa global", NULL),
        "fig_abandono_ciudad.png", ancho = 6.2, alto = 4.6)

## 5.5 Las dos señales se complementan (cruce)
g6 <- ggplot(cruce, aes(x = ses, y = rec, fill = tasa)) +
  geom_tile(color = "white", linewidth = 1) +
  geom_text(aes(label = paste0(pct(tasa, 1), "\nn = ", num(n))), size = 3.6, lineheight = 0.9,
            color = ifelse(cruce$tasa > 0.45, "white", "black")) +
  scale_fill_gradient(low = "#FDEBDD", high = naranja, labels = pct, name = "Tasa de abandono") +
  labs(title = "Recencia y sesiones no miden lo mismo: se refuerzan",
       subtitle = "cero sesiones dispara el abandono aun con transacción reciente;\nsin transar ni abrir la app, 3 de cada 4 se van",
       x = "Sesiones en la app (últimos 30 días)", y = "Días desde la última transacción") +
  tema + theme(panel.grid = element_blank(), legend.position = "right")
guardar(g6, "fig_cruce.png", ancho = 7.8, alto = 4.6)

## 5.6 El anexo de campañas, agregado al nivel del cliente
por_camp <- por_camp %>% mutate(grupo_camp = factor(grupo_camp, levels = c("Sin campañas", "Recibió y no respondió", "Respondió al menos una")))
g7 <- ggplot(por_camp, aes(x = grupo_camp, y = tasa)) +
  geom_col(fill = azul, width = 0.62) +
  geom_hline(yintercept = mean(clientes$abandono), linetype = "dashed", color = "grey30") +
  geom_text(aes(label = pct(tasa)), vjust = -0.4, size = 4.2, fontface = "bold") +
  geom_text(aes(y = 0, label = paste0("n = ", num(n))), vjust = 1.6, size = 3.3, color = "grey35") +
  scale_y_continuous(labels = pct, limits = c(0, 0.32), expand = expansion(mult = c(0.1, 0.02))) +
  labs(title = "Quien respondió alguna campaña abandona la mitad", subtitle = "anexo_campanas agregado por cliente y unido a base_clientes",
       x = NULL, y = "Tasa de abandono") + tema
guardar(g7, "fig_campanas.png", ancho = 7, alto = 4.4)

## 5.7 Colas largas: el "atípico" que no es error
g8 <- ggplot(clientes, aes(x = gasto_proximo_trim)) +
  geom_histogram(bins = 40, fill = azul, color = "white") +
  geom_vline(xintercept = lim, color = naranja, linewidth = 1) +
  annotate("text", x = lim * 1.15, y = Inf, vjust = 1.5, hjust = 0, color = naranja, size = 3.8,
           label = paste0("límite Q3 + 1,5 IQR = $", num(lim / 1e3), " mil\n", num(sum(g > lim)), " clientes (", pct(mean(g > lim)), ") por encima")) +
  annotate("text", x = max(g), y = 0, vjust = -0.8, hjust = 1, size = 3.8, color = "grey25",
           label = paste0("máximo: $", num(max(g) / 1e6, 0.1), " M")) +
  scale_x_log10(labels = function(x) ifelse(x >= 1e6, paste0("$", x / 1e6, " M"), paste0("$", x / 1e3, " mil"))) +
  scale_y_continuous(labels = num) +
  labs(title = "Con colas largas, la regla del IQR marca al 11 % de la base",
       subtitle = "gasto_proximo_trim en escala logarítmica: aquí «atípico» no significa «error»",
       x = "gasto_proximo_trim (escala log)", y = "Clientes") + tema
guardar(g8, "fig_gasto_cola.png")

cat("Listo: figuras en pic/ y cifras en cifras_eda.txt\n")
