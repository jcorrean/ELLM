load("~/Documents/GitHub/ELLM/HistoricalData.RData")
library(quanteda)
summary(Textos)
docvars(Textos, "Month") <- History$Month
summary(Textos)
ave <- tokens(Textos, remove_numbers = TRUE, remove_punct = TRUE) %>%  dfm()
ave2 <- dfm(ave, remove = stopwords("english"))
topfeatures(ave2, 50) 


# Let's split the corpus into pieces of information
# by month, as follows
December <- corpus_subset(Textos, Month == "December")
Dec <- tokens(December, remove_numbers = TRUE, remove_punct = TRUE) %>%  dfm()
Dec2 <- dfm(Dec, remove = stopwords("english"))
topfeatures(Dec2, 50) 

January <- corpus_subset(Textos, Month == "January")
February <- corpus_subset(Textos, Month == "February")
March <- corpus_subset(Textos, Month == "March")
April <- corpus_subset(Textos, Month == "April")
May <- corpus_subset(Textos, Month == "May")

