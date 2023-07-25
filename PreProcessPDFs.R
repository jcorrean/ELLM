load("~/Documents/GitHub/ELLM/Results_Step1.RData")
library(quanteda)
Textos <- corpus(textos$text)
docvars(Textos, "Date") <- textos$Date
summary(Textos)

library(tidyverse)
December2022 <- textos %>% filter(, grepl("-12-",Date)) 
December2022$Month <- "December"
January2023 <- textos %>% filter(, grepl("-01-", Date))
January2023$Month <- "January"
February2023 <- textos %>% filter(, grepl("-02-",Date))
February2023$Month <- "February"
March2023 <- textos %>% filter(, grepl("-03-",Date))
March2023$Month <- "March"
April2023 <- textos %>% filter(, grepl("-04-",Date))
April2023$Month <- "April"
May2023 <- textos %>% filter(, grepl("-05-",Date))
May2023$Month <- "May"


versions <- data.frame(summary(Textos, n = length(Textos)))
versions$revision <- textos$text

versions <- versions %>% 
  mutate(Month = month(Date, label = TRUE, abbr = FALSE))


History <- list(December2022, January2023, February2023, March2023, April2023, May2023)
History <- do.call(rbind, History)
docvars(Textos, "Month") <- History$Month
docvars(Textos, "Date") <- History$Date
summary(Textos)
library(lubridate)
History$date <- as_date(History$Date)  # Convert to Date object
History$Day <- day(History$date)
library(dplyr)
textos <- arrange(textos, Date)
History <- arrange(textos, Date)
rm(list = setdiff(ls(), "History"))


