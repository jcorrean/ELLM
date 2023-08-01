rm(list = ls())
load("StructuredData.RData")

library(quanteda)
Textos <- corpus(History$revision)
summary(Textos)
docvars(Textos, "Date") <- History$Date
aja <- data.frame(summary(Textos, n = length(Textos)))
summary(Textos)
library(tidyverse)
library(ggplot2)
ggplot(data = aja, aes(x = Date, y = Sentences)) +
  geom_line() + geom_point() + theme_bw() + 
  scale_x_date(date_labels = "%Y-%m", date_breaks = "1 month") +
  theme(axis.text.x = element_text(size = 12, color = "black"),  
        axis.text.y = element_text(size = 12, color = "black"),  
        axis.title.x = element_text(size = 13, color = "black"), 
        axis.title.y = element_text(size = 13, color = "black")) 

ggsave("Figure2.pdf", dpi = "print", width = 22, height = 15, units = "cm")
