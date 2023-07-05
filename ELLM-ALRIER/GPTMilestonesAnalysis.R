##calling packages --------
pkg <- function(pkg){
   new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
   if (length(new.pkg)) 
      install.packages(new.pkg, dependencies = TRUE)
   sapply(pkg, require, character.only = TRUE)
}

packages <- c("tidyverse","readtext","raster","sf","ggspatial","cluster","factoextra",
              "NbClust","tidyr","forecast","semTools","corrplot",
              "corrr","haven","psych","dplyr","lavaan","readr","cvms","tm",
              "RefManageR","quanteda","ggplot2","scales",
              "ggpubr","Factoshiny","RColorBrewer","tokenizers")

pkg(packages)
#Setwd----
setwd("/home/alrier/Documentos/ChatGPT/ELLM/ELLM-ALRIER/Datas")
listado <- data.frame(dir())
DATA_DIR <- system.file("extdata/", package = "readtext")
textos <- readtext(listado$dir..)
textos$doc_id <- gsub("[^0-9-]|@\\w+|https?://.+|\\d+\\w*\\d*|#\\w+|[^\x01-\x7F]|[[:punct:]]|\n|^\\s+|\\s+$|[ |\t]+|http\\w+|[ |\t]{2,}", "", textos$doc_id)
# Verificar duplicados
duplicados <- duplicated(textos$doc_id)
if (any(duplicados)) {
   # Generar nuevos nombres únicos
   nuevos_nombres <- make.unique(textos$doc_id, sep = "_")
   
   # Actualizar los nombres en el dataframe
   textos$doc_id <- nuevos_nombres
}

# Crear corpus
Textos <- corpus(textos, docid_field = "doc_id")
summary = summary(Textos)
docvars(Textos, "Date") <- listado$dir..
aja <- data.frame(summary(Textos, n = length(Textos)))
aja1 = aja #copia de seguridad
aja1$Date <- gsub("\\s+", " ", aja1$Date)  # Eliminar espacios extra
aja1$Date <- parse_date_time(aja1$Date, "%H:%M, %d-%m-%Y") #dar formato
#aja1$Date <- format(aja1$Date, "%d %B %Y %H:%M") #Cambiaar orden en el formato
library(lubridate)
aja1$Date <- ymd_hms(aja1$Date)  # Convertir a clase "POSIXct"
textos_df <- as.data.frame(texts(Textos))
aja2$text <- textos_df$text # Asigno aja2 con la columna texto incluida.

### PLOT cambio en los documentos----
ggplot(data = aja2, aes(x = Date, y = Sentences)) +
   geom_line() + geom_point() + theme_bw() +
   scale_x_datetime(labels = date_format("%b %Y"), 
                    breaks = date_breaks("3 months")) +
   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

#Explorando el dataframe en su longitud ------

#Descriptivos de la longitud: ------
# Verificar si hay NA en el dataframe (versión booleana)
# sentences=aja2$Sentences
# any(is.na(sentences))
# sum(is.na(sentences))
# as.numeric(sentences)
# Cálculo de descriptivos
# descriptivos <- summary(sentences)
# maximo <- max(sentences)
# minimo <- min(sentences)
# media <- mean(sentences)
# moda <- names(which.max(sentences))
# mediana <- median(sentences)
# quartiles <- quantile(sentences, probs = c(0.25, 0.5, 0.75, 0.99))
# descriptivos <- data.frame(Variable = c("Máximo", "Mínimo", "Media", "Mediana", "q1", "q2", "q3", "q4"),
#                            Valor = c(maximo, minimo, media, mediana, quartiles[1], quartiles[2], quartiles[3], quartiles[4]))
# boxplot(sentences, main = "Distribución de Sentences", ylab = "sentences")
# q1 <- descriptivos[5, "Valor"]
# mediana <- descriptivos[6, "Valor"]
# q3 <- descriptivos[7, "Valor"]
# q4 <- descriptivos[8, "Valor"]
# diferencia_q <- q4 - q1
# diferencia_mediana <- q3 - mediana
# num_grupos <- max(4, ceiling(diferencia_q / diferencia_mediana))
aja2$grupo <- cut(aja2$Sentences, breaks = 4, labels = FALSE)
tabla_grupos <- table(aja2$grupo)
print(tabla_grupos)

#Dividiendo aja2 en 4 dataframes:
grupo1 <- subset(aja2, grupo == 1)
grupo2 <- subset(aja2, grupo == 2)
grupo3 <- subset(aja2, grupo == 3)
grupo4 <- subset(aja2, grupo == 4)
grupo1 <- as.data.frame(grupo1)
grupo2 <- as.data.frame(grupo2)
grupo3 <- as.data.frame(grupo3)
grupo4 <- as.data.frame(grupo4)

prepare_text <- function(text) {
   tokens <- tokens(text, 
                    what = "word", 
                    remove_punct = TRUE, 
                    remove_symbols = TRUE, 
                    remove_numbers = TRUE, 
                    remove_url = TRUE, 
                    remove_separators = TRUE, 
                    split_hyphens = TRUE)
   tokens <- tokens_remove(tokens, stopwords("english"))
   dfm <- dfm(tokens)
   return(dfm)
}

dfm1 <- prepare_text(grupo1$text)
dfm2 <- prepare_text(grupo2$text)
dfm3 <- prepare_text(grupo3$text)
dfm4 <- prepare_text(grupo4$text)

top1 <- topfeatures(dfm1, n = 50)
top2 <- topfeatures(dfm2, n = 50)
top3 <- topfeatures(dfm3, n = 50)
top4 <- topfeatures(dfm4, n = 50)

top1[1:50]
top2[1:50]
top3[1:50]
top4[1:50]
# ----------------------------
   porfechas = describe.by(aja1$Types, group = aja1$grupo, mat = T)
#Quanteda----















































# Exportar Textos -------------------
# Extract the text from the Textos corpus
textos_df <- as.data.frame(texts(Textos))
# Add the text column to the aja dataframe
aja1$text <- textos_df$text
# Export the updated aja dataframe to a CSV file
write.csv(aja1, file = "aja1_data.csv", row.names = FALSE)

