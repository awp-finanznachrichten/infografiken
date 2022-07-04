library(readxl)
library(dplyr)
library(xlsx)
library(readr)

setwd("C:/Users/sw/OneDrive/R/infografiken/Inflation")

###Verlauf Jahresteuerung
monat <- "2022-06-01"
inflation_months <- read_excel("Daten/su-d-05.02.67.xlsx", 
                            sheet = "VAR_m-12")

#Letzte 5 Jahre
sequence_months <- seq(as.Date("2017-06-01"),as.Date(monat),by="month")
values <- unlist(inflation_months[4,(ncol(inflation_months)-(length(sequence_months)-1)):ncol(inflation_months)])


inflation_last_five_years <- data.frame(sequence_months,values)
inflation_last_five_years$values <- format(round(as.numeric(inflation_last_five_years$values),1),nsmall=1)

write.csv(inflation_last_five_years,file="Output/inflation_last_five_years.csv",row.names = FALSE)

#Seit 1984
sequence_months <- seq(as.Date("1984-01-01"),as.Date(monat),by="month")
values <- unlist(inflation_months[4,(ncol(inflation_months)-(length(sequence_months)-1)):ncol(inflation_months)])


inflation_history <- data.frame(sequence_months,values)
inflation_history$values <- format(round(as.numeric(inflation_history$values),1),nsmall=1)

write.csv(inflation_history,file="Output/inflation_history.csv",row.names = FALSE)

###Teuerung 12 Kategorien
inflation_categories <- read_excel("Daten/su-d-05.02.11.xlsx", skip = 3)

inflation_main_groups <- inflation_categories %>%
  filter(PosType == "2") %>%
  distinct(Position_D,.keep_all = TRUE) %>%
  select(Position_D,Position_F,Posizione_I,`% m-12`) %>%
  mutate(`% m-12` = as.numeric(`% m-12` )) %>%
  arrange(desc(`% m-12`))

#Kategorien Anpassung
categories_adapt <- read_excel("Daten/Inflation_ListeHauptkategorien.xlsx")

inflation_main_groups <- merge(inflation_main_groups,categories_adapt,by="Position_D",all.x = TRUE)

inflation_main_groups$Position_D <- paste0("<b>",inflation_main_groups$Begriff_vereinfacht_D,"</b><br>",inflation_main_groups$Beispiele_D)
inflation_main_groups$Position_F.x <- paste0("<b>",inflation_main_groups$Begriff_vereinfacht_F,"</b><br>",inflation_main_groups$Beispiele_F)
inflation_main_groups$Posizione_I.x <- paste0("<b>",inflation_main_groups$Begriff_vereinfacht_I,"</b><br>",inflation_main_groups$Beispiele_I)

inflation_main_groups <- inflation_main_groups[,1:4]
inflation_main_groups$Position_D <- gsub("NA","",inflation_main_groups$Position_D)
inflation_main_groups$Position_F.x <- gsub("NA","",inflation_main_groups$Position_F.x)
inflation_main_groups$Posizione_I.x  <- gsub("NA","",inflation_main_groups$Posizione_I.x)

write.csv(inflation_main_groups,file="Output/inflation_main_groups.csv",row.names = FALSE,fileEncoding="UTF-8")

###Inflationstreiber
inflation_treiber <- inflation_categories %>%
  filter(Level == "4",
         `Contrib m-1` > 0) %>%
  distinct(Position_D,.keep_all = TRUE) %>%
  select(Position_D,Position_F,Posizione_I,`Contrib m-1`) %>%
  mutate(`Contrib m-1` = as.numeric(`Contrib m-1` )) %>%
  arrange(desc(`Contrib m-1`))

inflation_treiber$anteil <- round((inflation_treiber$`Contrib m-1`*100)/sum(inflation_treiber$`Contrib m-1`),1)
#write.xlsx(inflation_treiber,"inflation_treiber_kategorien_2.xlsx")
inflation_treiber <- inflation_treiber[1:10,]

categories_small_adapt <- read_excel("Daten/Inflation_ListeKategorien_Stufe4.xlsx")

inflation_treiber <- merge(inflation_treiber,categories_small_adapt,by="Position_D",all.x = TRUE)

inflation_treiber$Position_D <- inflation_treiber$Begriff_vereinfacht_D
inflation_treiber$Position_F.x <- inflation_treiber$Begriff_vereinfacht_F
inflation_treiber$Posizione_I.x <- inflation_treiber$Begriff_vereinfacht_I
inflation_treiber <- inflation_treiber[,1:4]

write.csv(inflation_treiber,file="Output/inflation_treiber.csv",row.names = FALSE,fileEncoding="UTF-8")

###Inflation in Europa
europe_data <- read_csv("Daten/prc_hicp_manr__custom_118059_page_linear.csv")

europe_data_month <- europe_data %>%
  filter(TIME_PERIOD == substring(monat,1, nchar(monat)-3)) %>%
  select(geo,OBS_VALUE)

eu_gesamt <- as.numeric(europe_data_month[europe_data_month$geo == "EU",2])
eurozone <- as.numeric(europe_data_month[europe_data_month$geo == "EA",2])
schweiz <- as.numeric(europe_data_month[europe_data_month$geo == "CH",2])

write.csv(europe_data_month,file="Output/inflation_europa.csv",row.names = FALSE,fileEncoding="UTF-8")

