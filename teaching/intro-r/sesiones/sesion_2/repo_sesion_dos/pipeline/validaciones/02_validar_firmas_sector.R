## R version 4.4.0
## Last run 2026-07-21

##==: 0. Initial setup :==##
rm(list = ls())
source("config/config.R")

##==: 1. Import data :==##
firmas        <- import("data/processed/01_cleaned/firmas_limpia.rds")
firmas_sector <- import("data/processed/02_joined/firmas_sector.rds")
sectores      <- import("data/raw/sectores_agregado.csv") %>%
                 clean_names()

##==: 2. Quality checks :==##
## la llave del referente no debe estar duplicada
stopifnot(sectores %>% count(cod_sector) %>% filter(n > 1) %>% nrow() == 0)

## el join no debe cambiar el numero de firmas
stopifnot(nrow(firmas_sector) == nrow(firmas))

## sectores sin referente nacional (NA tras el join)
firmas_sector %>% filter(is.na(sector_desc)) %>% distinct(cod_sector)
