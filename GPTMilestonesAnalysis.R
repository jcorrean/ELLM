setwd("/home/jc/Documents/GitHub/ELLM/")
load("~/Documents/GitHub/ELLM/StructuredData.RData")

library(quanteda)
Textos <- corpus(History$text)
summary(Textos)
docvars(Textos, "Date") <- History$Date
aja <- data.frame(summary(Textos, n = length(Textos)))
summary(Textos)
library(tidyverse)
aja2 <- aja %>% arrange(Text)
if (require(ggplot2)) ggplot(data = aja2, aes(x = Text, y = Sentences)) +
  geom_line() + geom_point() + theme_bw()
