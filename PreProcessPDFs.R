load("~/Documents/GitHub/ELLM/DataPreOpen.RData")
library(stringr)
# Extract the hour, day, month, and year from the string
textos$hour <- str_sub(textos$doc_id, start = 1, end = 2)
textos$minute <- str_sub(textos$doc_id, start = 3, end = 4)
textos$date <- str_sub(textos$doc_id, start = 5)
textos$date <- as.Date(textos$date, format = "%d-%m-%Y")
library(quanteda)
Textos <- corpus(textos$text)
docvars(Textos, "Date") <- textos$date
docvars(Textos, "Hour") <- textos$hour
docvars(Textos, "Minute") <- textos$minute
summary(Textos)
versions <- data.frame(summary(Textos, n = length(Textos)))

# By looking at the data, we noticed we had some typos 
# in the name of the following rows, so we edit them manually
# to make them coincide with their original dates
versions$Date[69] <- "2022-12-06"
versions$Date[72] <- "2022-12-06"
versions$Date[79] <- "2022-12-06"
versions$Date[83] <- "2022-12-06"
versions$Date[94] <- "2022-12-06"
versions$Date[478] <- "2022-12-06"

