library(rsvg)
library(magick)
library(DatawRappr)
library(zip)
library(RCurl)
library(lubridate)


setwd("C:/Users/sw/OneDrive/R/infografiken/Inflation")
datawrapper_auth("BMcG33cGBCp2FpqF1BSN5lHhKrw2W8Ait4AYbDEjkjVgCiWe07iqoX5pwHXdW36g", overwrite = TRUE)

###Grafik Letzte 5 Jahre

chart_id <- "atjlB"

month <- month(Sys.Date()-30,label = TRUE,abbr=FALSE)
year <- format(Sys.Date(),"%Y")


###Flexible Grafik-Bausteine erstellen
undertitel_text <- paste0("Im ",month," ",year," waren die Konsumgüter in der Schweiz<b>",
                          gsub("[.]",",",inflation_last_five_years$values[nrow(inflation_last_five_years)]),"%</b> teurer als vor einem Jahr")

#Grafik anpassen
dw_edit_chart(chart_id,
              intro=undertitel_text)

#Bilddaten speichen 

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
metadata <- paste0("i5_object_name=GRAFIK TEUERUNG IN DER SCHWEIZ IN DEN LETZTEN FÜNF JAHREN D\n",
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
#ftp_adress <- "ftp://ftp.keystone.ch/Teuerung_Entwicklung_DEU.zip"
#ftpUpload("Teuerung_Entwicklung_DEU.zip", ftp_adress,userpwd="keyg_in:5r6368vz")

setwd("..")
setwd("..")

###Grafik langjährige Entwicklung
chart_id <- "K22wH"

setwd("./Grafiken")

#Create Folder
folder_name <- paste0(year,"_",month,"_Teuerung_Entwicklung_Langzeit")
dir.create(folder_name)

setwd(paste0("./",folder_name))

#Als JPEG
map <- dw_export_chart(chart_id, plain=FALSE,border_width = 20)
image_write(map,path="preview.jpg",format="jpeg")


#Als SVG &  EPS
map <- dw_export_chart(chart_id , type="svg",plain=FALSE,border_width = 20)
cat(map,file="Teuerung_Entwicklung_Langzeit.svg")
map <- charToRaw(map)
rsvg_eps(map,"Teuerung_Entwicklung_Langzeit.eps",width=4800)


#Metadata
metadata <- paste0("i5_object_name=GRAFIK TEUERUNG IN DER SCHWEIZ IM LANGJÄHRIGEN ÜBERBLICK D\n",
                   "i55_date_created=",format(Sys.Date(),"%Y%m%d"),"\n",
                   "i120_caption=INFOGRAFIK - Entwicklung der Konsumentenpreise seit 1984. Diese Infografik wurde automatisiert vom Schreibroboter Lena erstellt.\n",
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
zip::zip(zipfile = 'Teuerung_Entwicklung_Langzeit.zip', 
         c("Teuerung_Entwicklung_Langzeit.eps","Teuerung_Entwicklung_Langzeit.svg","preview.jpg","metadata.properties"), mode="cherry-pick")

#Daten hochladen
#ftp_adress <- "ftp://ftp.keystone.ch/Teuerung_Entwicklung_Langzeit_DEU.zip"
#ftpUpload("Teuerung_Entwicklung_Langzeit_DEU.zip", ftp_adress,userpwd="keyg_in:5r6368vz")

setwd("..")
setwd("..")


###Grafik Hauptkatogorien
chart_id <- "JKbiz"

setwd("./Grafiken")

#Create Folder
folder_name <- paste0(year,"_",month,"_Teuerung_Hauptkategorien")
dir.create(folder_name)

setwd(paste0("./",folder_name))

#Als JPEG
map <- dw_export_chart(chart_id, plain=FALSE,border_width = 20)
image_write(map,path="preview.jpg",format="jpeg")


#Als SVG &  EPS
map <- dw_export_chart(chart_id , type="svg",plain=FALSE,border_width = 20)
cat(map,file="Teuerung_Hauptkategorien.svg")
map <- charToRaw(map)
rsvg_eps(map,"Teuerung_Hauptkategorien.eps",width=4800)


#Metadata
metadata <- paste0("i5_object_name=GRAFIK ENTWICKLUNG DER SCHWEIZER PREISE IM ",toupper(month)," ",year," D\n",
                   "i55_date_created=",format(Sys.Date(),"%Y%m%d"),"\n",
                   "i120_caption=INFOGRAFIK - Teuerung in den zwölf Hauptgruppen des Landesindex der Konsumentenpreise. Diese Infografik wurde automatisiert vom Schreibroboter Lena erstellt.\n",
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
zip::zip(zipfile = 'Teuerung_Hauptkategorien.zip', 
         c("Teuerung_Hauptkategorien.eps","Teuerung_Hauptkategorien.svg","preview.jpg","metadata.properties"), mode="cherry-pick")

#Daten hochladen
#ftp_adress <- "ftp://ftp.keystone.ch/Teuerung_Hauptkategorien_DEU.zip"
#ftpUpload("Teuerung_Hauptkategorien_DEU.zip", ftp_adress,userpwd="keyg_in:5r6368vz")

setwd("..")
setwd("..")


###Grafik Inflationstreiber
chart_id <- "txIFJ"

setwd("./Grafiken")

#Create Folder
folder_name <- paste0(year,"_",month,"_Teuerung_Treiber")
dir.create(folder_name)

setwd(paste0("./",folder_name))

#Als JPEG
map <- dw_export_chart(chart_id, plain=FALSE,border_width = 20)
image_write(map,path="preview.jpg",format="jpeg")


#Als SVG &  EPS
map <- dw_export_chart(chart_id , type="svg",plain=FALSE,border_width = 20)
cat(map,file="Teuerung_Treiber.svg")
map <- charToRaw(map)
rsvg_eps(map,"Teuerung_Treiber.eps",width=4800)


#Metadata
metadata <- paste0("i5_object_name=GRAFIK DIE ZEHN GRÖSSTEN TEUERUNGSTREIBER IM ",toupper(month)," ",year," D\n",
                   "i55_date_created=",format(Sys.Date(),"%Y%m%d"),"\n",
                   "i120_caption=INFOGRAFIK - Die zehn Kategorien mit dem grössten Anteil an der Gesamtteuerung in der Schweiz. Diese Infografik wurde automatisiert vom Schreibroboter Lena erstellt.\n",
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
zip::zip(zipfile = 'Teuerung_Treiber.zip', 
         c("Teuerung_Treiber.eps","Teuerung_Treiber.svg","preview.jpg","metadata.properties"), mode="cherry-pick")

#Daten hochladen
#ftp_adress <- "ftp://ftp.keystone.ch/Teuerung_Treiber_DEU.zip"
#ftpUpload("Teuerung_Treiber_DEU.zip", ftp_adress,userpwd="keyg_in:5r6368vz")

setwd("..")
setwd("..")

###Grafik Europa
chart_id <- "Bql2R"

setwd("./Grafiken")

#Create Folder
folder_name <- paste0(year,"_",month,"_Teuerung_Europa")
dir.create(folder_name)

setwd(paste0("./",folder_name))

#Als JPEG
map <- dw_export_chart(chart_id, plain=FALSE,border_width = 20)
image_write(map,path="preview.jpg",format="jpeg")


#Als SVG &  EPS
map <- dw_export_chart(chart_id , type="svg",plain=FALSE,border_width = 20)
cat(map,file="Teuerung_Europa.svg")
map <- charToRaw(map)
rsvg_eps(map,"Teuerung_Europa.eps",width=4800)


#Metadata
metadata <- paste0("i5_object_name=GRAFIK INFLATION IN EUROPA D\n",
                   "i55_date_created=",format(Sys.Date(),"%Y%m%d"),"\n",
                   "i120_caption=INFOGRAFIK - Harmonisierter Verbraucherpreisindex im ",month," ",year,". Diese Infografik wurde automatisiert vom Schreibroboter Lena erstellt.\n",
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
zip::zip(zipfile = 'Teuerung_Europa.zip', 
         c("Teuerung_Europa.eps","Teuerung_Europa.svg","preview.jpg","metadata.properties"), mode="cherry-pick")

#Daten hochladen
#ftp_adress <- "ftp://ftp.keystone.ch/Teuerung_Europa_DEU.zip"
#ftpUpload("Teuerung_Europa_DEU.zip", ftp_adress,userpwd="keyg_in:5r6368vz")

setwd("..")
setwd("..")

