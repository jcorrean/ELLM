setwd("/home/jc/Documents/ChatGPT from Wikipedia")
listado <- data.frame(dir())
library(readtext)
library(tm)
DirSource()

# Get the data directory from readtext
DATA_DIR <- system.file("extdata/", package = "readtext")
textos <- readtext(listado$dir..)
textos$doc_id <- gsub("[^0-9-]", "", textos$doc_id)


library(quanteda)
Textos <- corpus(textos)
summary(Textos)
docvars(Textos, "Date") <- listado$dir..
aja <- data.frame(summary(Textos, n = length(Textos)))
aja$Text <- as.numeric(aja$Text)
summary(Textos)
library(tidyverse)
aja2 <- aja %>% arrange(Text)
if (require(ggplot2)) ggplot(data = aja2, aes(x = Text, y = Sentences)) +
  geom_line() + geom_point() + theme_bw()
