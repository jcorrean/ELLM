setwd("/home/jc/Documents/GitHub/ELLM/ELLM-ALRIER/Datas")
listado <- data.frame(dir())
# Original file names should be changed as follows:
# Instead of "ChatGPT1.pdf" it should be the
# "December52022.pdf" or as it is more convenient
# to analyze the series with the best time format
# Time formats in R is a topic I don't know anything
# about, so we need to understand that.
library(readtext)
library(tm)
DirSource()

# Get the data directory from readtext
DATA_DIR <- system.file("extdata/", package = "readtext")
textos <- readtext(listado$dir..)
textos$doc_id <- gsub("[^0-9-]", "", textos$doc_id)


library(quanteda)
Textos <- corpus(textos$text)
summary(Textos)
docvars(Textos, "Date") <- listado$dir..
aja <- data.frame(summary(Textos, n = length(Textos)))
aja$Text <- as.numeric(aja$Text)
summary(Textos)
library(tidyverse)
aja2 <- aja %>% arrange(Text)
if (require(ggplot2)) ggplot(data = aja2, aes(x = Text, y = Sentences)) +
  geom_line() + geom_point() + theme_bw()
