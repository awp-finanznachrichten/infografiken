library(rsvg)
library(magick)
library(DatawRappr)
library(zip)
library(RCurl)
library(lubridate)


setwd("C:/Users/sw/OneDrive/R/infografiken/Inflation")
datawrapper_auth("BMcG33cGBCp2FpqF1BSN5lHhKrw2W8Ait4AYbDEjkjVgCiWe07iqoX5pwHXdW36g", overwrite = TRUE)

chart_id <- "atjlB"

month <- month(Sys.Date()-30,label = TRUE,abbr=FALSE)
year <- format(Sys.Date(),"%Y")

###Flexible Grafik-Bausteine erstellen
undertitel_text <- paste0("Im ",month," ",year," waren die Konsumgüter in der Schweiz<b>",
                          gsub("[.]",",",inflation_last_five_years$values[nrow(inflation_last_five_years)]),"%</b> teurer als vor einem Jahr")

###Vorlage kopieren
#new_chart <-dw_copy_chart("atjlB")

#Grafik anpassen
dw_edit_chart(chart_id,
              intro=undertitel_text)

###Bilddaten speichen 

setwd("./Grafiken")

#Create Folder
folder_name <- paste0(year,"_",month,"_Teuerung_Entwicklung")
dir.create(folder_name)

setwd(paste0("./",folder_name))

#Als JPEG
map <- dw_export_chart(chart_id, plain=FALSE,border_width = 20)
image_write(map,path="preview.jpg",format="jpeg")


#Als SVG &  EPS
map <- dw_export_chart(chart_id , type="svg",plain=FALSE,border_width = 20)
cat(map,file="Teuerung_Entwicklung.svg")
map <- charToRaw(map)
rsvg_eps(map,"Teuerung_Entwicklung.eps",width=4800)


#Metadata
metadata <- paste0("i5_object_name=GRAFIK TEUERUNG IN DER SCHWEIZ D\n",
                   "i55_date_created=",format(Sys.Date(),"%Y%m%d"),"\n",
                   "i120_caption=INFOGRAFIK - Entwicklung der Teuerung in der Schweiz in den letzten fünf Jahren. Diese Infografik wurde automatisiert vom Schreibroboter Lena erstellt.\n",
                   "i103_original_transmission_reference=\n",
                   "i90_city=\n",
                   "i100_country_code=CHE\n",
                   "i15_category=N\n",
                   "i105_headline=Wirtschaft\n",
                   "i40_special_instructions=Die Infografik kann im Grafikformat EPS und SVG bezogen werden. Diese Infografik wurde automatisiert vom Schreibroboter Lena erstellt.\n",
                   "i110_credit=KEYSTONE\n",
                   "i115_source=KEYSTONE\n",
                   "i80_byline=Lena\n",
                   "i122_writer=Lena\n")

cat(metadata,file="metadata.properties")

#Zip-File erstellen
zip::zip(zipfile = 'Teuerung_Entwicklung.zip', 
         c("Teuerung_Entwicklung.eps","Teuerung_Entwicklung.svg","preview.jpg","metadata.properties"), mode="cherry-pick")

#Daten hochladen
#ftp_adress <- paste0("ftp://ftp.keystone.ch/",paste0('LENA_Kantone_',vorlagen_short[i],'_DEU.zip'))
#ftpUpload(paste0('LENA_Kantone_',vorlagen_short[i],'_DEU.zip'), ftp_adress,userpwd="keyg_in:5r6368vz")

setwd("..")
setwd("..")
