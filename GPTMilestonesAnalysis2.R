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
TFdec <- data.frame(topfeatures(Dec2, 100))
TFdec$Term <- rownames(TFdec) 
colnames(TFdec)[1] ="Freq"
TFdec$Month <- "December"

January <- corpus_subset(Textos, Month == "January")
Jan <- tokens(January, remove_numbers = TRUE, remove_punct = TRUE) %>%  dfm()
Jan2 <- dfm(Jan, remove = stopwords("english"))
TFjan <- data.frame(topfeatures(Jan2, 100))
TFjan$Term <- rownames(TFjan) 
colnames(TFjan)[1] ="Freq"
TFjan$Month <- "January"

February <- corpus_subset(Textos, Month == "February")
Feb <- tokens(February, remove_numbers = TRUE, remove_punct = TRUE) %>%  dfm()
Feb2 <- dfm(Feb, remove = stopwords("english"))
TFfeb <- data.frame(topfeatures(Feb2, 100))
TFfeb$Term <- rownames(TFfeb) 
colnames(TFfeb)[1] ="Freq"
TFfeb$Month <- "February"


March <- corpus_subset(Textos, Month == "March")
Mar <- tokens(March, remove_numbers = TRUE, remove_punct = TRUE) %>%  dfm()
Mar2 <- dfm(Mar, remove = stopwords("english"))
TFmar <- data.frame(topfeatures(Mar2, 100))
TFmar$Term <- rownames(TFmar) 
colnames(TFmar)[1] ="Freq"
TFmar$Month <- "March"

April <- corpus_subset(Textos, Month == "April")
Apr <- tokens(April, remove_numbers = TRUE, remove_punct = TRUE) %>%  dfm()
Apr2 <- dfm(Apr, remove = stopwords("english"))
TFapr <- data.frame(topfeatures(Apr2, 100))
TFapr$Term <- rownames(TFapr) 
colnames(TFapr)[1] ="Freq"
TFapr$Month <- "April"

May <- corpus_subset(Textos, Month == "May")
May <- tokens(May, remove_numbers = TRUE, remove_punct = TRUE) %>%  dfm()
May2 <- dfm(May, remove = stopwords("english"))
TFmay <- data.frame(topfeatures(May2, 100))
TFmay$Term <- rownames(TFmay) 
colnames(TFmay)[1] ="Freq"
TFmay$Month <- "May"
