library(readxl)
library(dplyr)
library(xlsx)
library(readr)
library(httr)
library(rvest)
library(stringr)

setwd("C:/Users/simon/OneDrive/R/infografiken/Energiepreise")

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

###Heizöl letzte 3 Jahre
oil_last_three_years <- energy_prices %>%
  filter(`Monat / Mois` > as.Date(paste0(as.numeric(year)-3,"-",month,"-01")),
         `Monat / Mois` <= as.Date(monat))

oil_last_three_years <- oil_last_three_years[,c(1,16)]

write.csv(oil_last_three_years,file="Output/oil_last_three_years.csv",row.names = FALSE)

#Benzinpreise Europa

#Daten holen von TCS-Seite
url <- "https://www.tcs.ch/de/camping-reisen/reiseinformationen/wissenswertes/fahrkosten-gebuehren/benzinpreise.php"

webpage <- read_html(url)
data <- html_text(html_nodes(webpage,"td"))

fuel_prices <- data.frame("Land","Bleifrei 95","Diesel","Letzte Preisanpassung")
colnames(fuel_prices) <- c("Land","Bleifrei 95","Diesel","Letzte Preisanpassung")

for (i in seq(15,176,6)) {
land <- data[i]
bleifrei95 <- data[i+1]
diesel <- data[i+3]
datum <- str_extract(data[i+5], "[0-9]{2}[.][0-9]{2}[.][0-9]{4}")

new_entry <- data.frame(land,bleifrei95,diesel,datum)
colnames(new_entry) <- c("Land","Bleifrei 95","Diesel","Letzte Preisanpassung")
fuel_prices <- rbind(fuel_prices,new_entry)

}

#Gewünschte Länder rausfiltern
fuel_prices <- fuel_prices[-1,]
fuel_prices <- fuel_prices %>%
  filter(Land == "Schweiz" |
           Land == "Deutschland" |
           Land == "Frankreich" |
           Land == "Österreich" |
           Land == "Italien" |
           Land == "Spanien" |
           Land == "Kroatien" |
           Land == "Dänemark"
           )
fuel_prices
fuel_prices$Flagge <- c(":dk:",":de:",":fr:",":it:",":hr:",":at:",":ch:",":es:")

fuel_prices$`Bleifrei 95` <- as.numeric(fuel_prices$`Bleifrei 95`)
fuel_prices$Diesel <- as.numeric(fuel_prices$Diesel)

fuel_prices <- fuel_prices %>%
  arrange(`Bleifrei 95`)

write.csv(fuel_prices,file="Output/fuel_prices_europe.csv",row.names = FALSE)
