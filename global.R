# CARREGAR PACOTES ------------------------------------------------------------
library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(leaflet)
library(sf)
library(RColorBrewer)

# IMPORTAR DADOS --------------------------------------------------------------
load("data/ubs_malhas_ok.rda")
# load("data/setores_sp_ok.rda")

# recodifica
ubs_malhas <- ubs_malhas %>%
  mutate(ac_classes_ubs = factor(ac_classes_ubs))

# guardar nomes das variáveis --------------------------------------------------------------
vars_modelo <- c(
  "Modelo vigente" = "vigente",
  "Modelo experimento" = "proximidade"
)

vars_setor <- c(
  "Tempo até a UBS" = "minutos_classes_setor",
  "Quintis de AC" = "ac_classes_ubs",
  "Decimais de %AV" = "av_prop_decimais_ubs",
  "Setor no raio AV?" = "av_setor"
)
