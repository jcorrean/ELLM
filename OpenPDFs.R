library(readtext)
library(tm)
library(dplyr)
textos <- readtext("ELLM-ALRIER/Datas/")
textos$Date <- substr(textos$doc_id, 6, nchar(textos$doc_id))
textos$Date <- gsub("[^0-9-]", "", textos$Date)
textos$Date <- as.Date(textos$Date, format = "%d-%m-%Y")
textos$Doc_id <- 1:length(textos$doc_id)
textos <- arrange(textos, Date)
head(textos, 10)
# By looking at the data, we noticed we had some typos 
# in the name of the following rows, so we edit them manually
# to make them coincide with their original dates
textos$Date[1:4] <- "2022-12-06"

textos <- arrange(textos, Date)
head(textos, 10)
textos$Doc_id <- 1:length(textos$doc_id)
textos <- textos %>% relocate(Doc_id)
save.image(file = "/home/jc/Documents/GitHub/ELLM/Results_Step1.RData")
