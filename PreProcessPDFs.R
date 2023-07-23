load("~/Documents/GitHub/ELLM/DataPreOpen.RData")
library(stringr)
# Extract the hour, day, month, and year from the string
textos$hour <- str_sub(textos$doc_id, start = 1, end = 2)
textos$minute <- str_sub(textos$doc_id, start = 3, end = 4)
textos$Date <- str_sub(textos$doc_id, start = 5)
textos$Date <- as.Date(textos$Date, format = "%d-%m-%Y")
# By looking at the data, we noticed we had some typos 
# in the name of the following rows, so we edit them manually
# to make them coincide with their original dates
textos$Date[69] <- "2022-12-06"
textos$Date[72] <- "2022-12-06"
textos$Date[79] <- "2022-12-06"
textos$Date[83] <- "2022-12-06"
textos$Date[94] <- "2022-12-06"
textos$Date[478] <- "2022-12-06"

library(quanteda)
Textos <- corpus(textos$text)
docvars(Textos, "text") <- textos$text
docvars(Textos, "Date") <- textos$date
docvars(Textos, "Hour") <- textos$hour
docvars(Textos, "Minute") <- textos$minute

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



History <- list(December2022, January2023, February2023, March2023, April2023, May2023)
History <- do.call(rbind, History)
Textos <- corpus(History$text)

versions <- data.frame(summary(Textos, n = length(Textos)))

History <- list(December2022, January2023, February2023, March2023, April2023, May2023)
History <- do.call(rbind, History)
docvars(Textos, "Month") <- History$Month
docvars(Textos, "Date") <- History$Date
summary(Textos)
library(lubridate)
History$date <- as.Date(History$Date)  # Convert to Date object
History$Day <- day(History$date)

h <- History[order(History$date), ]
h$doc_id <- 1:482
History <- h
rm(list = setdiff(ls(), "History"))
