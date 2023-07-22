load("~/Documents/GitHub/ELLM/HistoricalData.RData")
library(quanteda)
summary(Textos)
docvars(Textos, "Month") <- History$Month
summary(Textos)
Textos2 <- tokens(Textos, remove_numbers = TRUE, remove_punct = TRUE) %>%  
  tokens_remove(stopwords("english")) %>% dfm()
Textos4 <- dfm_remove(Textos2, c("http://*", 
                                 "https://*", 
                                 "www.*", 
                                 "*.htm", 
                                 "*.html", 
                                 "*.com", 
                                 "wikipedia", 
                                 "url", 
                                 "*:*",
                                 "$",
                                 "htt",
                                 "http",
                                 "https"))

TF <- data.frame(topfeatures(Textos4, length(Textos4)))
colnames(TF)[1] <- "Freq"
TF$Ngram <- rownames(TF)

Dec <- corpus_subset(Textos, Month == "December")
Jan <- corpus_subset(Textos, Month == "January")
Feb <- corpus_subset(Textos, Month == "February")
Mar <- corpus_subset(Textos, Month == "March")
Apr <- corpus_subset(Textos, Month == "April")
May <- corpus_subset(Textos, Month == "May")

summary(Dec)
summary(Jan)


DEC_dfm <- tokens(Dec, remove_punct = TRUE, remove_numbers = TRUE) %>%
  tokens_remove(c("http://*", 
                  "https://*", 
                  "www.*", 
                  "*.htm", 
                  "*.html", 
                  "*.com", 
                  "wikipedia", 
                  "url", 
                  "*:*",
                  "$",
                  "htt",
                  "http",
                  "https", stopwords("english"))) %>%
  tokens_group(groups = Date) %>%
  dfm()

DecemberTopFeatures <- data.frame(topfeatures(DEC_dfm, n = length(DEC_dfm), groups = Date))

#library(quanteda.textstats)
# Calculate keyness and determine Trump as target group
#result_keyness <- textstat_keyness(DEC_dfm, target = "2022-12-31")

#library(quanteda.textplots)
# Plot estimated word keyness
#textplot_keyness(result_keyness) 

#DecemberTopFeatures <- data.frame(topfeatures(DEC_dfm, n = length(DEC_dfm), groups = Date))


#DecemberTopFeatures$Diff <- DecemberTopFeatures$X2022.12.05 - DecemberTopFeatures$X2022.12.31

#hist(DecemberTopFeatures$Diff)