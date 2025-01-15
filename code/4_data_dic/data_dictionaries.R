# More info on making data dictionaries
# https://github.com/audhalbritter/dataDocumentation
# Note that we're using a script modified by HRD, not the originals by Aud

# load functions
source("code/functions/get_started_data_dic.R")
source("code/functions/make_data_dic.R")
library(tidyverse)

# Download description tables ----
# install.packages("remotes")
# remotes::install_github("Between-the-Fjords/dataDownloader")
library(dataDownloader)

## Microclimate
get_file(
  # Which repository is it in?
  node = "hk2cy",
  # Which file do you want?
  file = "description_table_microclimate.csv",
  # Where do you want the file to go to?
  path = "data_dic",
  # Where is the file stored within the OSF repository?
  remote_path = "raw_data/raw_microclimate_data")

## Fluxes
get_file(
  # Which repository is it in?
  node = "hk2cy",
  # Which file do you want?
  file = "description_table_flux.csv",
  # Where do you want the file to go to?
  path = "data_dic",
  # Where is the file stored within the OSF repository?
  remote_path = "raw_data/raw_flux_data")

# Microclimate data dic ----
# (Start by creating a template CSV)
# Download from OSF instead
# get_started(data = read.csv("clean_data/PFTC7_SA_clean_microclimate_2023.csv"))

description_table_microclimate = read.csv("data_dic/description_table_microclimate.csv") |>
  mutate(TableID = as.character(TableID))

data_dic_microclimate <- make_data_dictionary(data = read.csv("clean_data/PFTC7_microclimate_south_africa_2023.csv"),
                                      description_table = description_table_microclimate,
                                      table_ID = "microclimate",
                                      keep_table_ID = FALSE)
write.csv(data_dic_microclimate, "data_dic/dataDic_microclimate.csv")

# Flux data dic ----
# Start by creating a template CSV
flux.data = read.csv("clean_data/pftc7_ecosystem_fluxes_south_africa_2023.csv",
                     na.strings = c("", " ", "NA"))

get_started(data = flux.data)

description_table_flux = read.csv("data_dic/description_table_flux.csv") |>
  mutate(TableID = as.character(TableID))

data_dic_flux <- make_data_dictionary(data = flux.data,
                                              description_table = description_table_flux,
                                              table_ID = "flux",
                                              keep_table_ID = FALSE)
write.csv(data_dic_flux, "data_dic/dataDic_flux.csv")
