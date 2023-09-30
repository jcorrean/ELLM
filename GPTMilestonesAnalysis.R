rm(list = ls())
load("StructuredData.RData")

library(quanteda)
Textos <- corpus(History$revision)
summary(Textos)
docvars(Textos, "Date") <- History$Date
aja <- data.frame(summary(Textos, n = length(Textos)))
summary(Textos)

library(quanteda.textstats)
readability <- textstat_readability(
   Textos,
   measure = "SMOG",
   remove_hyphens = TRUE,
   min_sentence_length = 1,
   max_sentence_length = 10000,
   intermediate = FALSE)

aja$SMOG <- readability$SMOG


library(tidyverse)
library(ggplot2)
ggplot(aja, aes(x=Sentences, y=SMOG)) + 
   geom_point(color="#7113CF") +
   theme_classic()

ggplot(aja, aes(x=Date, y=SMOG)) +
   geom_line(color="#7113CF") +
   geom_point(color="#7113CF") +
   scale_x_date(date_labels = "%Y-%m", date_breaks = "1 month") +
   theme_bw() +
   theme(axis.text.x = element_text(size = 12, color = "black"),  
         axis.text.y = element_text(size = 12, color = "black"))

ggsave("F2.pdf", dpi = "print", width = 22, height = 15, units = "cm")

ggplot(data = aja, aes(x = Date, y = Sentences)) +
  geom_line() + geom_point(color="#7113CF") + theme_bw() + 
  scale_x_date(date_labels = "%Y-%m", date_breaks = "1 month") +
  theme(axis.text.x = element_text(size = 12, color = "black"),  
        axis.text.y = element_text(size = 12, color = "black"),  
        axis.title.x = element_text(size = 13, color = "black"), 
        axis.title.y = element_text(size = 13, color = "black")) 

library(ggTimeSeries)
p1 = ggplot_calendar_heatmap(
   aja,
   'Date',
   'Sentences'
) + theme(
   legend.position=c(0.75,0.75), 
   legend.background=element_blank(),
   legend.direction = "horizontal")

p1 +
   xlab("Time") +
   ylab("Daily Wikipedia edits") +
   scale_fill_continuous(low = 'blue2', high = 'red', limits = c(0, 1500)) +
   facet_wrap(~Year, ncol = 1)

ggsave("F3.pdf", dpi = "print", width = 24, height = 20, units = "cm")

ggplot_waterfall(aja, cXColumnName = 'Date', cYColumnName = 'Tokens', nArrowSize = -0.2) + 
   scale_x_date(date_labels = "%Y-%m", date_breaks = "1 month") + 
   theme_minimal()

save.image("~/Documents/GitHub/ELLM/ResultsMilestones.RData")
