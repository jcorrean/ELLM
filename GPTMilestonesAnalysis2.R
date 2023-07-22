load("~/Documents/GitHub/ELLM/HistoricalData.RData")
library(quanteda)
summary(Textos)
docvars(Textos, "Month") <- History$Month
summary(Textos)
textos <- tokens(Textos)
textos
# Remove tokens matching the website URL pattern
# This will remove tokens that start with "http://" or "https://" followed by any characters
textos <- tokens_remove(textos, pattern = c("http://*", "https://*", "www.*", "*.htm", "*.html", "*.com"))


ave <- tokens(textos, remove_numbers = TRUE, remove_punct = TRUE) %>%  dfm()
ave2 <- dfm_remove(ave, stopwords("english"))
TF <- data.frame(topfeatures(ave2, length(ave2)))
colnames(TF)[1] <- "Freq"
TF$Ngram <- rownames(TF)
