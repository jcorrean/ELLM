load("~/Documents/GitHub/ELLM/TopTerms.RData")
# Let's split the corpus into pieces of information
# by month, as follows
library(quanteda)
Dec2022 <- corpus_subset(Textos, Month == "December") %>% tokens(remove_numbers = TRUE, remove_punct = TRUE)
Jan2023 <- corpus_subset(Textos, Month == "January") %>% tokens(remove_numbers = TRUE, remove_punct = TRUE)
Feb2023 <- corpus_subset(Textos, Month == "February") %>% tokens(remove_numbers = TRUE, remove_punct = TRUE)
Mar2023 <- corpus_subset(Textos, Month == "March") %>% tokens(remove_numbers = TRUE, remove_punct = TRUE)
Apr2023 <- corpus_subset(Textos, Month == "April") %>% tokens(remove_numbers = TRUE, remove_punct = TRUE)
May2023 <- corpus_subset(Textos, Month == "May") %>% tokens(remove_numbers = TRUE, remove_punct = TRUE)

# Remove tokens matching the website URL pattern
# This will remove tokens that start with "http://" or "https://" followed by any characters
dec2022 <- tokens_remove(Dec2022, pattern = c("http", "https", "http://*", "https://*", "www.*", "*.htm", "*.html", "*.com"))
jan2023 <- tokens_remove(Jan2023, pattern = c("http", "https", "http://*", "https://*", "www.*", "*.htm", "*.html", "*.com"))
feb2023 <- tokens_remove(Feb2023, pattern = c("http", "https", "http://*", "https://*", "www.*", "*.htm", "*.html", "*.com"))
mar2023 <- tokens_remove(Mar2023, pattern = c("http", "https", "http://*", "https://*", "www.*", "*.htm", "*.html", "*.com"))
apr2023 <- tokens_remove(Apr2023, pattern = c("http", "https", "http://*", "https://*", "www.*", "*.htm", "*.html", "*.com"))
may2023 <- tokens_remove(May2023, pattern = c("http", "https", "http://*", "https://*", "www.*", "*.htm", "*.html", "*.com"))

Dec <- dec2022 %>% dfm()
Dec2 <- dfm_remove(Dec, stopwords("english"))
TFdec <- data.frame(topfeatures(Dec2, length(Dec2)))
TFdec$Term <- rownames(TFdec) 
colnames(TFdec)[1] ="Freq"
TFdec$Month <- "December"

Jan <- jan2023 %>% dfm()
Jan2 <- dfm_remove(Jan, stopwords("english"))
TFjan <- data.frame(topfeatures(Jan2, length(Jan2)))
TFjan$Term <- rownames(TFjan) 
colnames(TFjan)[1] ="Freq"
TFjan$Month <- "January"

Feb <- feb2023 %>% dfm()
Feb2 <- dfm_remove(Feb, stopwords("english"))
TFfeb <- data.frame(topfeatures(Feb2, length(Feb2)))
TFfeb$Term <- rownames(TFfeb) 
colnames(TFfeb)[1] ="Freq"
TFfeb$Month <- "February"

Mar <- mar2023 %>% dfm()
Mar2 <- dfm_remove(Mar, stopwords("english"))
TFmar <- data.frame(topfeatures(Mar2, length(Mar2)))
TFmar$Term <- rownames(TFmar) 
colnames(TFmar)[1] ="Freq"
TFmar$Month <- "March"

Apr <- apr2023 %>% dfm()
Apr2 <- dfm_remove(Apr, stopwords("english"))
TFapr <- data.frame(topfeatures(Apr2, length(Apr2)))
TFapr$Term <- rownames(TFapr) 
colnames(TFapr)[1] ="Freq"
TFapr$Month <- "April"

May_ <- may2023 %>% dfm()
May2 <- dfm_remove(May_, stopwords("english"))
TFmay <- data.frame(topfeatures(May2, length(May2)))
TFmay$Term <- rownames(TFmay) 
colnames(TFmay)[1] ="Freq"
TFmay$Month <- "May"


TopTermsByMonths <- list(TFdec, TFjan, TFfeb, TFmar, TFapr, TFmay)
TopTermsByMonths <- do.call(rbind, TopTermsByMonths)
