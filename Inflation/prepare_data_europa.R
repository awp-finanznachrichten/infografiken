library(readxl)
library(dplyr)
library(xlsx)
library(readr)

setwd("C:/Users/sw/OneDrive/R/infografiken/Inflation")

###Inflation in Europa
europe_data <- read_csv("Daten/prc_hicp_manr__custom_118059_page_linear.csv")

month <- format(Sys.Date()-30,"%m")
year <- format(Sys.Date()-30,"%Y")
monat <- paste0(year,"-",month,"-01")

europe_data_month <- europe_data %>%
  filter(TIME_PERIOD == substring(monat,1, nchar(monat)-3)) %>%
  select(geo,OBS_VALUE)

eu_gesamt <- as.numeric(europe_data_month[europe_data_month$geo == "EU",2])
eurozone <- as.numeric(europe_data_month[europe_data_month$geo == "EA",2])
schweiz <- as.numeric(europe_data_month[europe_data_month$geo == "CH",2])

write.csv(europe_data_month,file="Output/inflation_europa.csv",row.names = FALSE,fileEncoding="UTF-8")

