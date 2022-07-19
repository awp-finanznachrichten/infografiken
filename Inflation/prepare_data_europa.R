library(readxl)
library(dplyr)
library(xlsx)
library(readr)
library(httr)
setwd("C:/Users/sw/OneDrive/R/infografiken/Inflation")

month <- format(Sys.Date()-30,"%m")
year <- format(Sys.Date()-30,"%Y")
monat <- paste0(year,"-",month,"-01")

#Get Inflationsdaten von Eurostat
get_query <- paste0("https://ec.europa.eu/eurostat/api/dissemination/sdmx/2.1/data/PRC_HICP_MANR/M.RCH_A.CP00.EU+EA+BE+BG+CZ+DK+DE+EE+IE+EL+ES+FR+HR+IT+CY+LV+LT+LU+HU+MT+NL+AT+PL+PT+RO+SI+SK+FI+SE+UK+EEA+IS+NO+CH+MK+RS+TR+US/?format=SDMX-CSV&startPeriod=2015-01&endPeriod=",
                    year,"-",month)
query_output <- GET(get_query)
europe_data <- read_csv(query_output$content)


###Inflation in Europa
#europe_data <- read_csv("Daten/prc_hicp_manr__custom_118059_page_linear.csv")

europe_data_month <- europe_data %>%
  filter(TIME_PERIOD == substring(monat,1, nchar(monat)-3)) %>%
  select(geo,OBS_VALUE)

eu_gesamt <- as.numeric(europe_data_month[europe_data_month$geo == "EU",2])
eurozone <- as.numeric(europe_data_month[europe_data_month$geo == "EA",2])
schweiz <- as.numeric(europe_data_month[europe_data_month$geo == "CH",2])

write.csv(europe_data_month,file="Output/inflation_europa_all.csv",row.names = FALSE,fileEncoding="UTF-8")