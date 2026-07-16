## ============================================================
##  Introducción al Business Analytics (06278-ECO) — Semana 08
##  Generador del proyecto de la práctica: Tiendas Andinas S.A.S.
##  Base de ventas DELIBERADAMENTE sucia (semilla fija = reproducible).
##  Uso:  Rscript week-08/input/_generar_proyecto.R
## ============================================================

set.seed(2026)

n <- 300

ciudades <- c("Cali", "Bogotá", "Medellín")
tiendas  <- list(
  "Cali"     = c("Andina Granada", "Andina Ciudad Jardín"),
  "Bogotá"   = c("Andina Chapinero", "Andina Cedritos"),
  "Medellín" = c("Andina Laureles", "Andina Envigado")
)
categorias <- c("Alimentos", "Bebidas", "Aseo", "Snacks")
productos  <- list(
  Alimentos = c("Arroz 1kg", "Huevos x30", "Pan tajado", "Leche 1L", "Aceite 1L"),
  Bebidas   = c("Gaseosa 1.5L", "Jugo de caja", "Agua 600ml", "Café molido 500g"),
  Aseo      = c("Jabón de manos", "Detergente 1kg", "Papel higiénico x4"),
  Snacks    = c("Papas fritas", "Galletas dulces", "Chocolatina", "Maní salado")
)
precios_base <- c("Arroz 1kg"=4200, "Huevos x30"=18500, "Pan tajado"=6800, "Leche 1L"=4900,
  "Aceite 1L"=12800, "Gaseosa 1.5L"=6500, "Jugo de caja"=3200, "Agua 600ml"=2500,
  "Café molido 500g"=15900, "Jabón de manos"=5400, "Detergente 1kg"=13500,
  "Papel higiénico x4"=9800, "Papas fritas"=3400, "Galletas dulces"=2900,
  "Chocolatina"=2200, "Maní salado"=4100)

ciudad  <- sample(ciudades, n, replace = TRUE, prob = c(0.4, 0.35, 0.25))
tienda  <- vapply(ciudad, function(c) sample(tiendas[[c]], 1), character(1))
categoria <- sample(categorias, n, replace = TRUE, prob = c(0.35, 0.3, 0.15, 0.2))
producto  <- vapply(categoria, function(k) sample(productos[[k]], 1), character(1))
precio    <- round(precios_base[producto] * runif(n, 0.95, 1.08), -1)
unidades  <- pmax(1, rpois(n, 3))
fecha     <- as.Date("2026-03-01") + sample(0:60, n, replace = TRUE)
canal     <- sample(c("Tienda", "Online"), n, replace = TRUE, prob = c(0.75, 0.25))

df <- data.frame(fecha = as.character(fecha), tienda, ciudad, categoria,
                 producto, precio, unidades = as.character(unidades), canal,
                 stringsAsFactors = FALSE)

## ---- ensuciar (posiciones deterministas gracias a la semilla) ----
idx <- function(k) sample(seq_len(n), k)

## 1. variantes de ciudad (20 filas)
i <- idx(20)
df$ciudad[i] <- vapply(df$ciudad[i], function(c) {
  switch(c,
    "Cali"     = sample(c("CALI", "cali", "Cali "), 1),
    "Bogotá"   = sample(c("Bogota", "BOGOTA D.C.", "bogotá"), 1),
    "Medellín" = sample(c("medellin", "MEDELLIN"), 1))
}, character(1))

## 2. variantes de canal (25 filas)
i <- idx(25)
df$canal[i] <- vapply(df$canal[i], function(c) {
  if (c == "Tienda") sample(c("tienda", "TIENDA"), 1) else sample(c("online", "En línea"), 1)
}, character(1))

## 3. unidades faltantes o mal codificadas (12 filas: "" y "ND")
i <- idx(12)
df$unidades[i] <- sample(c("", "ND"), 12, replace = TRUE)

## 4. unidades negativas (3 filas: error de digitación)
df$unidades[idx(3)] <- c("-2", "-1", "-3")

## 5. precios con coma decimal como texto (15 filas)
i <- idx(15)
df$precio <- as.character(df$precio)
df$precio[i] <- sub("\\.", ",", format(as.numeric(df$precio[i]) + 0.5, nsmall = 1))

## 6. outliers de precio (4 filas: typo x100)
i <- idx(4)
df$precio[i] <- as.character(as.numeric(sub(",", ".", df$precio[i])) * 100)

## 7. fechas en formato mixto (18 filas: dd/mm/aaaa)
i <- idx(18)
df$fecha[i] <- format(as.Date(df$fecha[i]), "%d/%m/%Y")

## 8. duplicados exactos (10 filas repetidas al final)
df <- rbind(df, df[idx(10), ])

## barajar y guardar
df <- df[sample(seq_len(nrow(df))), ]
rownames(df) <- NULL

dir.create("week-08/input/_build/tiendas_andinas/data", recursive = TRUE, showWarnings = FALSE)
write.csv(df, "week-08/input/_build/tiendas_andinas/data/ventas_tiendas.csv",
          row.names = FALSE)

cat("Filas (con duplicados):", nrow(df), "\n")
cat("Duplicados exactos:", sum(duplicated(df)), "\n")
cat("Unidades no numéricas:", sum(is.na(suppressWarnings(as.numeric(df$unidades)))), "\n")
cat("Precios con coma:", sum(grepl(",", df$precio)), "\n")
cat("Valores únicos de ciudad:", length(unique(df$ciudad)), "\n")
cat("Valores únicos de canal:", length(unique(df$canal)), "\n")
cat("Fechas formato dd/mm:", sum(grepl("/", df$fecha)), "\n")

## ---- cifras de referencia tras una limpieza correcta (para el profesor) ----
clean <- df[!duplicated(df), ]
clean$precio   <- as.numeric(sub(",", ".", clean$precio))
clean$unidades <- suppressWarnings(as.numeric(clean$unidades))
clean <- clean[!is.na(clean$unidades) & clean$unidades > 0, ]
clean <- clean[clean$precio < 100000, ]            # quita outliers x100
norm  <- function(x) { x <- trimws(tolower(x)); x }
clean$ciudad <- ifelse(grepl("bogot", norm(clean$ciudad)), "Bogotá",
               ifelse(grepl("medell", norm(clean$ciudad)), "Medellín", "Cali"))
clean$ingreso <- clean$precio * clean$unidades
cat("\n--- Referencia tras limpieza razonable ---\n")
cat("Filas limpias:", nrow(clean), "\n")
cat("Ingreso total:", format(sum(clean$ingreso), big.mark = "."), "\n")
print(aggregate(ingreso ~ ciudad, clean, sum))
