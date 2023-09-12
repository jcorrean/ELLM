rm(list = ls())
load("Results_Step1.RData")
library(quanteda)
Textos <- corpus(textos$text)
docvars(Textos, "Date") <- textos$Date
summary(Textos)

versions <- data.frame(summary(Textos, n = length(Textos)))
versions$revision <- textos$text

library(dplyr)
library(lubridate)
versions <- versions %>% 
  mutate(Month = month(Date, label = TRUE, abbr = FALSE))

versions <- versions %>% filter(, Month != "June")
Textos <- corpus(versions$revision)

docvars(Textos, "Month") <- versions$Month
docvars(Textos, "Date") <- versions$Date
summary(Textos)
History <- versions
rm(list = setdiff(ls(), c("History", "Textos")))
save.image(file = "StructuredData.RData")