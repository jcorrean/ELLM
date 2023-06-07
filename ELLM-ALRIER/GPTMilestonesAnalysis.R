pkg <- function(pkg){
   new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
   if (length(new.pkg)) 
      install.packages(new.pkg, dependencies = TRUE)
   sapply(pkg, require, character.only = TRUE)
}

packages <- c("tidyverse","readtext","raster","sf","ggspatial","cluster","factoextra",
              "NbClust","tidyr","forecast","semTools","corrplot",
              "corrr","haven","psych","dplyr","lavaan","readr","cvms","tm",
              "NLP","SnowballC","RColorBrewer","wordcloud","wordcloud2",
              "RefManageR","bibliometrix","GGally","quanteda","ggplot2",
              "ggpubr","Factoshiny","syuzhet","RColorBrewer","tokenizers",
              "stringr","sentimentr","stringi","stopwords","twitteR",
              "mscstexta4r","plyr","psych","corrr","latticeExtra",
              "semPlot","lavaan","readr","lme4","sjPlot","gvlma","Rcmdr",
              "tidymodels","caret","lmtest","gapminder","png","rtweet","knitr")

pkg(packages)
setwd("/home/alrier/Documentos/ChatGPT/ELLM/ELLM-ALRIER/Datas")
listado <- data.frame(dir())
# Obtener la información de los archivos
file_info <- file.info(listado$dir)
# Extraer la columna "mtime" (fecha y hora de modificación)
listado$date <- file_info$mtime
colnames(listado)[colnames(listado) == "dir.."] <- "Texto"
DirSource()
# Obtener el directorio de datos de readtext
DATA_DIR <- system.file("extdata/", package = "readtext")
textos <- readtext(listado$Texto)
textos$doc_id <- gsub("[^0-9-]", "", textos$doc_id)
# Crear la columna "texto" con el nombre del documento
# Assign unique document names
textos$doc_id <- paste0("doc_", seq_along(textos$doc_id))
Textos <- corpus(textos, docid_field = "doc_id")
summary(Textos)
docvars(Textos, "Date") <- listado$Texto
aja <- data.frame(summary(Textos, n = length(Textos)))

aja1 = aja

aja1$Date <- as.POSIXct(aja1$Date, format = "%H:%M, %d %B %Y")

#aja$Text <- as.numeric(aja$Text)
merged_df <- listado$date

# Si deseas reemplazar la columna "date" existente en "aja" con la columna fusionada
aja$date <- merged_df$date
+aja2 <- aja %>% arrange(Text)
ggplot(data = aja2, aes(x = Text, y = Sentences)) +
  geom_line() + geom_point() + theme_bw()
