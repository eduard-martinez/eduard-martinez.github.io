## R version 4.4.0
## Last run 2026-07-21

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
firmas   <- import("data/processed/01_cleaned/firmas_limpia.rds")
sectores <- import("data/raw/sectores_agregado.csv") %>%
            clean_names()

##==: 2. Cruzar firmas con el referente sectorial :==##
## left_join conserva todas las firmas y les pega su sector (llave: cod_sector)
firmas_sector <- firmas %>%
                 left_join(sectores, by = "cod_sector")

##==: 3. Export :==##
export(firmas_sector, "data/processed/02_joined/firmas_sector.rds")
