load("Results_Step1.RData")
library(quanteda)
Textos <- corpus(textos$text)
docvars(Textos, "Date") <- textos$Date
library(lubridate)
textos <- textos %>% 
   mutate(Month = month(Date, label = TRUE, abbr = FALSE))
docvars(Textos, "Month") <- textos$Month
summary(Textos)

Dec <- corpus_subset(Textos, Month == "December")
Textos2 <- tokens(Dec, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE, 
                  what = "word") %>%  
   tokens_remove(stopwords("english")) %>% dfm()
max(col(Textos2))
topfeatures(Textos2, n = 2030)
TFDec <- data.frame(topfeatures(Textos2, n = 2030))
