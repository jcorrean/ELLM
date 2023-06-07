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
DATA_DIR <- system.file("extdata/", package = "readtext")
textos <- readtext(listado$dir..)
textos$doc_id <- gsub("[^0-9-]", "", textos$doc_id)
textos$doc_id <- paste0("doc_", seq_along(textos$doc_id))
Textos <- corpus(textos, docid_field = "doc_id")
summary(Textos)
docvars(Textos, "Date") <- listado$dir..
aja <- data.frame(summary(Textos, n = length(Textos)))
aja1 = aja #copia de seguridad
aja1$Date <- gsub("\\s+", " ", aja1$Date)  # Eliminar espacios extra
aja1$Date <- parse_date_time(aja1$Date, "%H:%M, %d-%m-%Y") #dar formato
#aja1$Date <- format(aja1$Date, "%d %B %Y %H:%M") #Cambiaar orden en el formato
library(lubridate)
aja1$Date <- ymd_hms(aja1$Date)  # Convertir a clase "POSIXct"
aja2 <- aja1 %>% arrange(Text)

ggplot(data = aja2, aes(x = Date, y = Sentences)) +
   geom_line() + geom_point() + theme_bw() +
   scale_x_datetime(labels = date_format("%b %Y"), 
                    breaks = date_breaks("3 months")) +
   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


