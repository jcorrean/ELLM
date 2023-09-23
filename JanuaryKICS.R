# Open the dataset
load("StructuredData.RData")
# Keyword-in-context search
library(quanteda)
summary(Textos)

Jan <- corpus_subset(Textos, Month == "January")
jan <- tokens(Jan, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english"))


# Our Keyword-in-context search is 
# organized as follows: 1) unigrams, 2) ngrams, and 
# 3) companies or commercial words.

k1 <- data.frame(kwic(jan, pattern = "ai"))
k2 <- data.frame(kwic(jan, pattern = "api"))
k3 <- data.frame(kwic(jan, pattern = "algorithm"))
k4 <- data.frame(kwic(jan, pattern = "android"))
k5 <- data.frame(kwic(jan, pattern = "architecture"))
k6 <- data.frame(kwic(jan, pattern = "bias"))
k7 <- data.frame(kwic(jan, pattern = "chat"))
k8 <- data.frame(kwic(jan, pattern = "chatbot"))
k9 <- data.frame(kwic(jan, pattern = "data"))
k10 <- data.frame(kwic(jan, pattern = "hallucinat", valuetype = "regex"))
k11 <- data.frame(kwic(jan, pattern = "prototype"))
k12 <- data.frame(kwic(jan, pattern = "platform"))
k13 <- data.frame(kwic(jan, pattern = "plagiarism"))
k14 <- data.frame(kwic(jan, pattern = "jailbreak"))
k15 <- data.frame(kwic(jan, pattern = "risk"))
k16 <- data.frame(kwic(jan, pattern = "jobs"))
k17 <- data.frame(kwic(jan, pattern = "cybersecurity"))
k18 <- data.frame(kwic(jan, pattern = "prompt"))
k19 <- data.frame(kwic(jan, pattern = "racist"))
k20 <- data.frame(kwic(jan, pattern = "sexist"))
k21 <- data.frame(kwic(jan, pattern = "InstructGPT"))
k22 <- data.frame(kwic(jan, pattern = "Meta"))
k23 <- data.frame(kwic(jan, pattern = "LLaMA"))
k24 <- data.frame(kwic(jan, pattern = "robotics"))
k25 <- data.frame(kwic(jan, pattern = "human-like"))
k26 <- data.frame(kwic(jan, pattern = "SearchGPT"))
k27 <- data.frame(kwic(jan, pattern = "usability"))
k28 <- data.frame(kwic(jan, pattern = "plugins"))
k29 <- data.frame(kwic(jan, pattern = "HuggingChat"))


### BIGRAMS
kb1 <- data.frame(kwic(jan, pattern = phrase("algorithmic bias")))
kb2 <- data.frame(kwic(jan, pattern = phrase("artificial intelligence")))
kb3 <- data.frame(kwic(jan, pattern = phrase("hugging face")))
kb4 <- data.frame(kwic(jan, pattern = phrase("language model")))
kb5 <- data.frame(kwic(jan, pattern = phrase("natural language")))
kb6 <- data.frame(kwic(jan, pattern = phrase("machine learning")))
kb7 <- data.frame(kwic(jan, pattern = phrase("supervised learning")))
kb8 <- data.frame(kwic(jan, pattern = phrase("unsupervised learning")))
kb9 <- data.frame(kwic(jan, pattern = phrase("reinforcement learning")))
kb10 <- data.frame(kwic(jan, pattern = phrase("reward models")))
kb11 <- data.frame(kwic(jan, pattern = phrase("bing chat")))
kb12 <- data.frame(kwic(jan, pattern = phrase("goodhart's law")))
kb13 <- data.frame(kwic(jan, pattern = phrase("cloud computing")))
kb14 <- data.frame(kwic(jan, pattern = phrase("human intelligence")))
kb15 <- data.frame(kwic(jan, pattern = phrase("virtual assistant")))
kb16 <- data.frame(kwic(jan, pattern = phrase("open assistant")))
kb17 <- data.frame(kwic(jan, pattern = phrase("microsoft azure")))
kb18 <- data.frame(kwic(jan, pattern = phrase("academic plagiarism")))
kb19 <- data.frame(kwic(jan, pattern = phrase("microsoft azure")))
kb20 <- data.frame(kwic(jan, pattern = phrase("fine-tun")))
kb21 <- data.frame(kwic(jan, pattern = phrase("detailed responses")))
kb22 <- data.frame(kwic(jan, pattern = phrase("deceitful assistant")))
kb23 <- data.frame(kwic(jan, pattern = phrase("factual accuracy")))
kb24 <- data.frame(kwic(jan, pattern = phrase("virtual assistant")))
kb25 <- data.frame(kwic(jan, pattern = phrase("significant drawback")))
kb26 <- data.frame(kwic(jan, pattern = phrase("human trainers")))
kb27 <- data.frame(kwic(jan, pattern = phrase("Google Bard")))
kb28 <- data.frame(kwic(jan, pattern = phrase("Bing Chat")))
kb29 <- data.frame(kwic(jan, pattern = phrase("limited knowledge")))

# TRIGRAMS
kt1 <- data.frame(kwic(jan, pattern = phrase("application programming interface")))
kt2 <- data.frame(kwic(jan, pattern = phrase("proximal policy optimization")))
kt3 <- data.frame(kwic(jan, pattern = phrase("generative pre-trained transformer")))
kt4 <- data.frame(kwic(jan, pattern = phrase("large language models")))


dataframes_list <- mget(ls(pattern = "^k"))
all_objects <- ls()

# Use do.call with rbind to merge all the dataframes
selectedkeywords <- do.call(rbind, dataframes_list)



rm(list = setdiff(all_objects, "selectedkeywords"))
rm(all_objects)
selectedkeywords$Month <- "January 2023"
JanuaryKeywords <- selectedkeywords
all_objects <- ls()
rm(list = setdiff(all_objects, "JanuaryKeywords"))
rm(all_objects)
save.image("JanuaryKeywords.RData")
