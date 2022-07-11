library(rsvg)
library(magick)
library(DatawRappr)
library(zip)
library(RCurl)
library(lubridate)


setwd("C:/Users/sw/OneDrive/R/infografiken/Inflation")
datawrapper_auth("BMcG33cGBCp2FpqF1BSN5lHhKrw2W8Ait4AYbDEjkjVgCiWe07iqoX5pwHXdW36g", overwrite = TRUE)

###Grafik Europa
chart_id <- "klNuM"

setwd("./Grafiken")

#Monat und Jahr
month <- month(Sys.Date()-30,label = TRUE,abbr=FALSE)
year <- format(Sys.Date()-30,"%Y")


###Flexible Grafik-Bausteine erstellen
undertitel_text <- paste0("<b>Harmonisierter Verbraucherpreisindex der Eurozone, ",month," ",year,"</b><br>
                           Die Schweizer Inflation wurde zwecks Vergleichbarkeit an die Eurostat-Methodik angepasst.")

#Text in Grafik anpassen
text_grafik <- paste0("EU Gesamt\n",
                      gsub("[.]",",",eu_gesamt),"%\n\n",
                      "Eurozone\n",
                      gsub("[.]",",",eurozone),"%\n\n",
                      "Schweiz\n",
                      gsub("[.]",",",schweiz),"%"
                      )

chart_metadata <- dw_retrieve_chart_metadata(chart_id)

adapted_list <- chart_metadata[["content"]][["metadata"]][["visualize"]]
adapted_list$`text-annotations`[[1]]$text <- text_grafik

dw_edit_chart(chart_id,
              intro = undertitel_text,
              visualize = adapted_list)

#Create Folder
folder_name <- paste0(year,"_",month,"_Teuerung_Europa_all")
dir.create(folder_name)

setwd(paste0("./",folder_name))

#Als JPEG
map <- dw_export_chart(chart_id, plain=FALSE,border_width = 20)
image_write(map,path="preview.jpg",format="jpeg")


#Als SVG &  EPS
map <- dw_export_chart(chart_id , type="svg",plain=FALSE,border_width = 20)
cat(map,file="Teuerung_Europa_all.svg")
map <- charToRaw(map)
rsvg_eps(map,"Teuerung_Europa_all.eps",width=4800)


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
zip::zip(zipfile = 'Teuerung_Europa_all_DEU.zip', 
         c("Teuerung_Europa_all.eps","Teuerung_Europa_all.svg","preview.jpg","metadata.properties"), mode="cherry-pick")

#Daten hochladen
#ftp_adress <- "ftp://ftp.keystone.ch/Teuerung_Europa_DEU.zip"
#ftpUpload("Teuerung_Europa_DEU.zip", ftp_adress,userpwd="keyg_in:5r6368vz")

setwd("..")
setwd("..")

