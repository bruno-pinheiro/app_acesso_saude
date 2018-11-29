# CARREGAR PACOTES ------------------------------------------------------------
library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(leaflet)
library(sf)

# IMPORTAR DADOS --------------------------------------------------------------
load("data/ubs_malhas_ok.rda")


# recodifica
ubs_malhas <- ubs_malhas %>%
  mutate(ac_classes_ubs = factor(ac_classes_ubs))

# guardar nomes das variáveis --------------------------------------------------------------
vars_modelo <- c(
  "Modelo vigente" = "vigente",
  "Modelo experimento" = "proximidade"
)

vars_setor <- c(
  "População" = "pessoas_setor",
  "Distâncias" = "distancias_setor",
  "Tempo até a UBS" = "minutos_setor",
  "Categoria de tempo até a UBS" = "minutos_classes_setor",
  "Quintis de AC" = "ac_classes_ubs",
  "Decimais de %AV" = "av_prop_decimais_ubs",
  "Setor no raio AV?" = "av_setor",
  "Número de enfermeiros" = "total_enf_ubs",
  "Número de médicos" = "total_med_ubs",
  "Opotunidades" = "oportunidades_ubs",
  "Demanda" = "demanda_ubs",
  "Acessibilidade competitiva" = "ac_ubs",
  "% População no raio AV" = "av_prop_ubs",
  "Tempo médio de caminhada até a UBS" = "media_minutos_ubs",
  "Distância média até a UBS" = "media_distancia_ubs"
)
