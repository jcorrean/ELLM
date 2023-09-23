# Open the dataset
load("StructuredData.RData")
# Keyword-in-context search
library(quanteda)
summary(Textos)

Dec <- corpus_subset(Textos, Month == "December")
dec <- tokens(Dec, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE) %>%  
  tokens_remove(stopwords("english"))

# Our Keyword-in-context search is 
# organized as follows: 1) unigrams, 2) bigrams, and 
# 3) trigrams.

# UNIGRAMS
k1 <- data.frame(kwic(dec, pattern = "ai"))
k2 <- data.frame(kwic(dec, pattern = "api"))
k3 <- data.frame(kwic(dec, pattern = "algorithm"))
k4 <- data.frame(kwic(dec, pattern = "android"))
k5 <- data.frame(kwic(dec, pattern = "architecture"))
k6 <- data.frame(kwic(dec, pattern = "bias"))
k7 <- data.frame(kwic(dec, pattern = "chat"))
k8 <- data.frame(kwic(dec, pattern = "chatbot"))
k9 <- data.frame(kwic(dec, pattern = "data"))
k10 <- data.frame(kwic(dec, pattern = "hallucinat", valuetype = "regex"))
k11 <- data.frame(kwic(dec, pattern = "prototype"))
k12 <- data.frame(kwic(dec, pattern = "platform"))
k13 <- data.frame(kwic(dec, pattern = "plagiarism"))
k14 <- data.frame(kwic(dec, pattern = "jailbreak"))
k15 <- data.frame(kwic(dec, pattern = "risk"))
k16 <- data.frame(kwic(dec, pattern = "jobs"))
k17 <- data.frame(kwic(dec, pattern = "cybersecurity"))
k18 <- data.frame(kwic(dec, pattern = "prompt"))
k19 <- data.frame(kwic(dec, pattern = "racist"))
k20 <- data.frame(kwic(dec, pattern = "sexist"))
k21 <- data.frame(kwic(dec, pattern = "InstructGPT"))
k22 <- data.frame(kwic(dec, pattern = "Meta"))
k23 <- data.frame(kwic(dec, pattern = "LLaMA"))
k24 <- data.frame(kwic(dec, pattern = "robotics"))
k25 <- data.frame(kwic(dec, pattern = "human-like"))
k26 <- data.frame(kwic(dec, pattern = "SearchGPT"))
k27 <- data.frame(kwic(dec, pattern = "usability"))
k28 <- data.frame(kwic(dec, pattern = "plugins"))
k29 <- data.frame(kwic(dec, pattern = "HuggingChat"))


### BIGRAMS
kb1 <- data.frame(kwic(dec, pattern = phrase("algorithmic bias")))
kb2 <- data.frame(kwic(dec, pattern = phrase("artificial intelligence")))
kb3 <- data.frame(kwic(dec, pattern = phrase("hugging face")))
kb4 <- data.frame(kwic(dec, pattern = phrase("language model")))
kb5 <- data.frame(kwic(dec, pattern = phrase("natural language")))
kb6 <- data.frame(kwic(dec, pattern = phrase("machine learning")))
kb7 <- data.frame(kwic(dec, pattern = phrase("supervised learning")))
kb8 <- data.frame(kwic(dec, pattern = phrase("unsupervised learning")))
kb9 <- data.frame(kwic(dec, pattern = phrase("reinforcement learning")))
kb10 <- data.frame(kwic(dec, pattern = phrase("reward models")))
kb11 <- data.frame(kwic(dec, pattern = phrase("bing chat")))
kb12 <- data.frame(kwic(dec, pattern = phrase("goodhart's law")))
kb13 <- data.frame(kwic(dec, pattern = phrase("cloud computing")))
kb14 <- data.frame(kwic(dec, pattern = phrase("human intelligence")))
kb15 <- data.frame(kwic(dec, pattern = phrase("virtual assistant")))
kb16 <- data.frame(kwic(dec, pattern = phrase("open assistant")))
kb17 <- data.frame(kwic(dec, pattern = phrase("microsoft azure")))
kb18 <- data.frame(kwic(dec, pattern = phrase("academic plagiarism")))
kb19 <- data.frame(kwic(dec, pattern = phrase("microsoft azure")))
kb20 <- data.frame(kwic(dec, pattern = phrase("fine-tun")))
kb21 <- data.frame(kwic(dec, pattern = phrase("detailed responses")))
kb22 <- data.frame(kwic(dec, pattern = phrase("deceitful assistant")))
kb23 <- data.frame(kwic(dec, pattern = phrase("factual accuracy")))
kb24 <- data.frame(kwic(dec, pattern = phrase("virtual assistant")))
kb25 <- data.frame(kwic(dec, pattern = phrase("significant drawback")))
kb26 <- data.frame(kwic(dec, pattern = phrase("human trainers")))
kb27 <- data.frame(kwic(dec, pattern = phrase("Google Bard")))
kb28 <- data.frame(kwic(dec, pattern = phrase("Bing Chat")))
kb29 <- data.frame(kwic(dec, pattern = phrase("limited knowledge")))

# TRIGRAMS
kt1 <- data.frame(kwic(dec, pattern = phrase("application programming interface")))
kt2 <- data.frame(kwic(dec, pattern = phrase("proximal policy optimization")))
kt3 <- data.frame(kwic(dec, pattern = phrase("generative pre-trained transformer")))
kt4 <- data.frame(kwic(dec, pattern = phrase("large language models")))

dataframes_list <- mget(ls(pattern = "^k"))
all_objects <- ls()

# Use do.call with rbind to merge all the dataframes
dec5 <- do.call(rbind, dataframes_list)
rm(list = setdiff(all_objects, "dec5"))
rm(all_objects)

library(igraph)
Dec <- dec5[c(1,7)]
bn2 <- graph.data.frame(Dec,directed=FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "green", "red")
V(bn2)$shape <- ifelse(V(bn2)$type, "square", "circle")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.5, 1)
V(bn2)$size <- sqrt(igraph::degree(bn2))
E(bn2)$color <- "lightgrey"

bn2.pr <- bipartite.projection(bn2)
Terms <- bn2.pr$proj2
matTerms <- as.matrix(get.adjacency(Terms))

# Plot the network with node colors based on centrality
plot(Terms, vertex.label.color = "black", 
     vertex.label.cex = 1.5, 
     vertex.color = "white", 
     vertex.size = 6, 
     vertex.shape = "none",
     edge.width = 1, 
     edge.color = "gray30", 
     layout = layout_components, main = "")

#DecemberKeywords <- selectedkeywords
#all_objects <- ls()
#rm(list = setdiff(all_objects, "DecemberKeywords"))
#rm(all_objects)
#save.image("DecemberKeywords.RData")

