library(readxl)
library(dplyr)
library(xlsx)
library(readr)
library(httr)

setwd("C:/Users/sw/OneDrive/R/infografiken/Energiepreise")

###Verlauf Jahresteuerung
month <- format(Sys.Date()-30,"%m")
year <- format(Sys.Date()-30,"%Y")
monat <- paste0(year,"-",month,"-01")

#Get Inflationsdaten
inflation_data_get <- GET("https://dam-api.bfs.admin.ch/hub/api/dam/assets/22987807/master")
inflation_data_raw <- content(inflation_data_get)

filename <- tempfile(fileext = ".xlsx")
writeBin(inflation_data_raw,filename)
energy_prices <- read_xlsx(path=filename,
                           skip=4)

energy_prices$`Monat / Mois` <- as.Date(energy_prices$`Monat / Mois`)

###Benzin letzte 3 Jahre
fuel_last_three_years <- energy_prices %>%
  filter(`Monat / Mois` > as.Date(paste0(as.numeric(year)-3,"-",month,"-01")),
         `Monat / Mois` <= as.Date(monat)) %>%
  select(`Monat / Mois`,
         `Bleifrei 95 / sans plomb 95`,
         Diesel)

write.csv(fuel_last_three_years,file="Output/fuel_last_three_years.csv",row.names = FALSE)
