# Open the dataset
load("StructuredData.RData")
# Keyword-in-context search
library(quanteda)
summary(Textos)

Dec5 <- corpus_subset(Textos, Date == "2022-12-05")
dec5 <- tokens(Dec5, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE) %>%  
  tokens_remove(stopwords("english"))

Dec6 <- corpus_subset(Textos, Date == "2022-12-06")
dec6 <- tokens(Dec6, 
               remove_numbers = TRUE, 
               remove_punct = TRUE, 
               remove_url = TRUE, 
               remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english"))

Textos2 <- dec5

# Our Keyword-in-context search is 
# organized as follows: 1) unigrams, 2) bigrams, and 
# 3) trigrams.
# UNIGRAMS
k1 <- data.frame(kwic(Textos2, pattern = "ai"))
k2 <- data.frame(kwic(Textos2, pattern = "api"))
k3 <- data.frame(kwic(Textos2, pattern = "algorithm"))
k4 <- data.frame(kwic(Textos2, pattern = "android"))
k5 <- data.frame(kwic(Textos2, pattern = "architecture"))
k6 <- data.frame(kwic(Textos2, pattern = "bias"))
k7 <- data.frame(kwic(Textos2, pattern = "chat"))
k8 <- data.frame(kwic(Textos2, pattern = "chatbot"))
k9 <- data.frame(kwic(Textos2, pattern = "data"))
k10 <- data.frame(kwic(Textos2, pattern = "hallucinat", valuetype = "regex"))
k11 <- data.frame(kwic(Textos2, pattern = "prototype"))
k12 <- data.frame(kwic(Textos2, pattern = "platform"))
k13 <- data.frame(kwic(Textos2, pattern = "plagiarism"))
k14 <- data.frame(kwic(Textos2, pattern = "jailbreak"))
k15 <- data.frame(kwic(Textos2, pattern = "risk"))
k16 <- data.frame(kwic(Textos2, pattern = "jobs"))
k17 <- data.frame(kwic(Textos2, pattern = "cybersecurity"))
k18 <- data.frame(kwic(Textos2, pattern = "prompt"))
k19 <- data.frame(kwic(Textos2, pattern = "racist"))
k20 <- data.frame(kwic(Textos2, pattern = "sexist"))
k21 <- data.frame(kwic(Textos2, pattern = "InstructGPT"))
k22 <- data.frame(kwic(Textos2, pattern = "Meta"))
k23 <- data.frame(kwic(Textos2, pattern = "LLaMA"))
k24 <- data.frame(kwic(Textos2, pattern = "robotics"))
k25 <- data.frame(kwic(Textos2, pattern = "human-like"))
k26 <- data.frame(kwic(Textos2, pattern = "SearchGPT"))
k27 <- data.frame(kwic(Textos2, pattern = "usability"))
k28 <- data.frame(kwic(Textos2, pattern = "plugins"))
k29 <- data.frame(kwic(Textos2, pattern = "HuggingChat"))


### BIGRAMS
kb1 <- data.frame(kwic(Textos2, pattern = phrase("algorithmic bias")))
kb2 <- data.frame(kwic(Textos2, pattern = phrase("artificial intelligence")))
kb3 <- data.frame(kwic(Textos2, pattern = phrase("hugging face")))
kb4 <- data.frame(kwic(Textos2, pattern = phrase("language model")))
kb5 <- data.frame(kwic(Textos2, pattern = phrase("natural language")))
kb6 <- data.frame(kwic(Textos2, pattern = phrase("machine learning")))
kb7 <- data.frame(kwic(Textos2, pattern = phrase("supervised learning")))
kb8 <- data.frame(kwic(Textos2, pattern = phrase("unsupervised learning")))
kb9 <- data.frame(kwic(Textos2, pattern = phrase("reinforcement learning")))
kb10 <- data.frame(kwic(Textos2, pattern = phrase("reward models")))
kb11 <- data.frame(kwic(Textos2, pattern = phrase("bing chat")))
kb12 <- data.frame(kwic(Textos2, pattern = phrase("goodhart's law")))
kb13 <- data.frame(kwic(Textos2, pattern = phrase("cloud computing")))
kb14 <- data.frame(kwic(Textos2, pattern = phrase("human intelligence")))
kb15 <- data.frame(kwic(Textos2, pattern = phrase("virtual assistant")))
kb16 <- data.frame(kwic(Textos2, pattern = phrase("open assistant")))
kb17 <- data.frame(kwic(Textos2, pattern = phrase("microsoft azure")))
kb18 <- data.frame(kwic(Textos2, pattern = phrase("academic plagiarism")))
kb19 <- data.frame(kwic(Textos2, pattern = phrase("microsoft azure")))
kb20 <- data.frame(kwic(Textos2, pattern = phrase("fine-tun")))
kb21 <- data.frame(kwic(Textos2, pattern = phrase("detailed responses")))
kb22 <- data.frame(kwic(Textos2, pattern = phrase("deceitful assistant")))
kb23 <- data.frame(kwic(Textos2, pattern = phrase("factual accuracy")))
kb24 <- data.frame(kwic(Textos2, pattern = phrase("virtual assistant")))
kb25 <- data.frame(kwic(Textos2, pattern = phrase("significant drawback")))
kb26 <- data.frame(kwic(Textos2, pattern = phrase("human trainers")))
kb27 <- data.frame(kwic(Textos2, pattern = phrase("Google Bard")))
kb28 <- data.frame(kwic(Textos2, pattern = phrase("Bing Chat")))
kb29 <- data.frame(kwic(Textos2, pattern = phrase("limited knowledge")))

# TRIGRAMS
kt1 <- data.frame(kwic(Textos2, pattern = phrase("application programming interface")))
kt2 <- data.frame(kwic(Textos2, pattern = phrase("proximal policy optimization")))
kt3 <- data.frame(kwic(Textos2, pattern = phrase("generative pre-trained transformer")))
kt4 <- data.frame(kwic(Textos2, pattern = phrase("large language models")))

dataframes_list <- mget(ls(pattern = "^k"))
all_objects <- ls()

# Use do.call with rbind to merge all the dataframes
selectedkeywords <- do.call(rbind, dataframes_list)



rm(list = setdiff(all_objects, "selectedkeywords"))
rm(all_objects)
selectedkeywords$Edits <- "05-12-2022"


DecemberKeywords <- selectedkeywords
all_objects <- ls()
rm(list = setdiff(all_objects, "DecemberKeywords"))
rm(all_objects)
save.image("DecemberKeywords.RData")

