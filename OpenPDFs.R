setwd("/home/jc/Documents/GitHub/ELLM/ELLM-ALRIER/Datas")
listado <- data.frame(dir())
library(readtext)
library(tm)
DirSource()
# Get the data directory from readtext
DATA_DIR <- system.file("extdata/", package = "readtext")
#listado$Date <- str_sub(listado$dir.., str_locate(listado$dir.., ", ")[, 2] + 1)
#listado$Date <- gsub("\\.pdf$", "", listado$Date)

#listado$hour <- str_sub(listado$dir.., start = 1, end = 5)
#textos$minute <- str_sub(textos$doc_id, start = 3, end = 4)
textos <- readtext(listado$dir..)
textos$Date <- substr(listado$dir.., 6, nchar(listado$dir..))
textos$Date <- gsub("[^0-9-]", "", textos$Date)
textos$Date <- as.Date(textos$Date, format = "%d-%m-%Y")
textos$doc_id <- 1:length(textos$doc_id)
textos <- arrange(textos, Date)
head(textos, 10)
# By looking at the data, we noticed we had some typos 
# in the name of the following rows, so we edit them manually
# to make them coincide with their original dates
textos$Date[1:4] <- "2022-12-06"
textos <- arrange(textos, Date)
head(textos, 10)
textos$doc_id <- 1:length(textos$doc_id)
