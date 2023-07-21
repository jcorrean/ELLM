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
