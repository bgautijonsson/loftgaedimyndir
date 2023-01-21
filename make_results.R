library(dplyr)
library(tidyr)
library(purrr)
library(readr)
library(clock)
library(glue)
library(janitor)
library(lubridate)
library(ggtext)
library(geomtextpath)
library(vroom)
library(ggplot2)
library(metill)
library(stringr)
library(slider)
library(loftgaedi)
theme_set(theme_metill())

caption <- str_c(
  "Byggt á gögnum frá loftgaedi.is",
  "\n",
  "Gögn og kóði: https://github.com/bgautijonsson/loftgaedimyndir"
)

if (!file.exists("Data/loftgaedi_reykjavik.csv")) {
  source("R/get_data.R")
} else {
  source("R/update_data.R")
}

source("R/make_figures.R")


