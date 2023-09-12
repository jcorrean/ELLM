load("Results_Step1.RData")
library(quanteda)
Textos <- corpus(textos$text)
docvars(Textos, "Date") <- textos$Date
library(lubridate)
textos <- textos %>% 
   mutate(Month = month(Date, label = TRUE, abbr = FALSE))
docvars(Textos, "Month") <- textos$Month
summary(Textos)

library(quanteda.textstats)
readability <- textstat_readability(
   Textos,
   measure = "SMOG",
   remove_hyphens = TRUE,
   min_sentence_length = 1,
   max_sentence_length = 10000,
   intermediate = FALSE)

textos$SMOG <- readability$SMOG


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

# Bigrams Identification
bigrams <- tokens(Dec, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE, 
                  what = "word") %>%  
   tokens_remove(stopwords("english"))

toks <- tokens(c(text1 = "the quick brown fox jumped over the lazy dog"))
tokens_ngrams(toks, n = c(2,4), concatenator = " ")
tokens_ngrams(bigrams, n = 1:3)
