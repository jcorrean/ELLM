# Open the dataset
load("StructuredData.RData")
# Keyword-in-context search
library(quanteda)
summary(Textos)

May <- corpus_subset(Textos, Month == "May")
Textos2 <- tokens(May, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english"))


# Our Keyword-in-context search is 
# organized as follows: 1) unigrams, 2) ngrams, and 
# 3) companies or commercial words.

k1 <- data.frame(kwic(Textos2, pattern = "ai"))
k2 <- data.frame(kwic(Textos2, pattern = "api"))
k3 <- data.frame(kwic(Textos2, pattern = "algorithm"))
k4 <- data.frame(kwic(Textos2, pattern = "android"))
k4 <- data.frame(kwic(Textos2, pattern = "architecture"))
k5 <- data.frame(kwic(Textos2, pattern = "bias"))
k6 <- data.frame(kwic(Textos2, pattern = "chat"))
k7 <- data.frame(kwic(Textos2, pattern = "chatbot"))
k8 <- data.frame(kwic(Textos2, pattern = "data"))
k9 <- data.frame(kwic(Textos2, pattern = "hallucinat", valuetype = "regex"))
k10 <- data.frame(kwic(Textos2, pattern = "information"))
k11 <- data.frame(kwic(Textos2, pattern = "knowledge"))
k12 <- data.frame(kwic(Textos2, pattern = "prototype"))
k13 <- data.frame(kwic(Textos2, pattern = "platform"))
k14 <- data.frame(kwic(Textos2, pattern = "plagiarism"))
k15 <- data.frame(kwic(Textos2, pattern = "misinformation"))
k16 <- data.frame(kwic(Textos2, pattern = "jailbreak"))
k17 <- data.frame(kwic(Textos2, pattern = "risk"))
k18 <- data.frame(kwic(Textos2, pattern = "jobs"))
k19 <- data.frame(kwic(Textos2, pattern = "cybersecurity"))

kn1 <- data.frame(kwic(Textos2, pattern = phrase("algorithmic bias")))
kn2 <- data.frame(kwic(Textos2, pattern = phrase("application programming interface")))
kn3 <- data.frame(kwic(Textos2, pattern = phrase("language model")))
kn4 <- data.frame(kwic(Textos2, pattern = phrase("proximal policy optimization")))
kn5 <- data.frame(kwic(Textos2, pattern = phrase("large language model")))
kn6 <- data.frame(kwic(Textos2, pattern = phrase("natural language")))
kn7 <- data.frame(kwic(Textos2, pattern = phrase("generative pre-trained transformer")))
kn8 <- data.frame(kwic(Textos2, pattern = phrase("machine learning")))
kn9 <- data.frame(kwic(Textos2, pattern = phrase("supervised learning")))
kn10 <- data.frame(kwic(Textos2, pattern = phrase("unsupervised learning")))
kn11 <- data.frame(kwic(Textos2, pattern = phrase("reinforcement learning")))
kn12 <- data.frame(kwic(Textos2, pattern = phrase("reward models")))
kn13 <- data.frame(kwic(Textos2, pattern = phrase("bing chat")))
kn14 <- data.frame(kwic(Textos2, pattern = phrase("goodhart's law")))
kn15 <- data.frame(kwic(Textos2, pattern = phrase("cloud computing")))
kn16 <- data.frame(kwic(Textos2, pattern = phrase("human intelligence")))
kn17 <- data.frame(kwic(Textos2, pattern = phrase("virtual assistant")))



kc1 <- data.frame(kwic(Textos2, pattern = "apple"))
kc2 <- data.frame(kwic(Textos2, pattern = "android"))
kc3 <- data.frame(kwic(Textos2, pattern = "baidu"))
kc4 <- data.frame(kwic(Textos2, pattern = "expedia"))
kc5 <- data.frame(kwic(Textos2, pattern = "facebook"))
kc6 <- data.frame(kwic(Textos2, pattern = "freemium"))
kc7 <- data.frame(kwic(Textos2, pattern = "google"))
kc8 <- data.frame(kwic(Textos2, pattern = phrase("hugging face")))
kc9 <- data.frame(kwic(Textos2, pattern = "ios"))
kc10 <- data.frame(kwic(Textos2, pattern = "meta"))
kc11 <- data.frame(kwic(Textos2, pattern = "microsoft"))
kc12 <- data.frame(kwic(Textos2, pattern = "naver"))
kc13 <- data.frame(kwic(Textos2, pattern = "nvidia"))
kc14 <- data.frame(kwic(Textos2, pattern = "opentable"))
kc15 <- data.frame(kwic(Textos2, pattern = "openai"))
kc16 <- data.frame(kwic(Textos2, pattern = "reddit"))
kc17 <- data.frame(kwic(Textos2, pattern = "snapchat"))
kc18 <- data.frame(kwic(Textos2, pattern = "shopify"))
kc19 <- data.frame(kwic(Textos2, pattern = "wolfram"))
kc20 <- data.frame(kwic(Textos2, pattern = "yandex"))
kc21 <- data.frame(kwic(Textos2, pattern = "zapier"))
kc22 <- data.frame(kwic(Textos2, pattern = phrase("microsoft azure")))


dataframes_list <- mget(ls(pattern = "^k"))
all_objects <- ls()

# Use do.call with rbind to merge all the dataframes
selectedkeywords <- do.call(rbind, dataframes_list)



rm(list = setdiff(all_objects, "selectedkeywords"))
rm(all_objects)
selectedkeywords$Month <- "May 2022"
MayKeywords <- selectedkeywords
all_objects <- ls()
rm(list = setdiff(all_objects, "MayKeywords"))
rm(all_objects)
save.image("MayKeywords.RData")
