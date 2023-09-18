# Open the dataset
load("StructuredData.RData")
# Keyword-in-context search
library(quanteda)
summary(Textos)

Dec6 <- corpus_subset(Textos, Date == "2022-12-06")
dec6 <- tokens(Dec6, 
               remove_numbers = TRUE, 
               remove_punct = TRUE, 
               remove_url = TRUE, 
               remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english"))



# Our Keyword-in-context search is 
# organized as follows: 1) unigrams, 2) bigrams, and 
# 3) trigrams.
# UNIGRAMS
k1 <- data.frame(kwic(dec6, pattern = "ai"))
k2 <- data.frame(kwic(dec6, pattern = "api"))
k3 <- data.frame(kwic(dec6, pattern = "algorithm"))
k4 <- data.frame(kwic(dec6, pattern = "android"))
k5 <- data.frame(kwic(dec6, pattern = "architecture"))
k6 <- data.frame(kwic(dec6, pattern = "bias"))
k7 <- data.frame(kwic(dec6, pattern = "chat"))
k8 <- data.frame(kwic(dec6, pattern = "chatbot"))
k9 <- data.frame(kwic(dec6, pattern = "data"))
k10 <- data.frame(kwic(dec6, pattern = "hallucinat", valuetype = "regex"))
k11 <- data.frame(kwic(dec6, pattern = "prototype"))
k12 <- data.frame(kwic(dec6, pattern = "platform"))
k13 <- data.frame(kwic(dec6, pattern = "plagiarism"))
k14 <- data.frame(kwic(dec6, pattern = "jailbreak"))
k15 <- data.frame(kwic(dec6, pattern = "risk"))
k16 <- data.frame(kwic(dec6, pattern = "jobs"))
k17 <- data.frame(kwic(dec6, pattern = "cybersecurity"))
k18 <- data.frame(kwic(dec6, pattern = "prompt"))
k19 <- data.frame(kwic(dec6, pattern = "racist"))
k20 <- data.frame(kwic(dec6, pattern = "sexist"))
k21 <- data.frame(kwic(dec6, pattern = "InstructGPT"))
k22 <- data.frame(kwic(dec6, pattern = "Meta"))
k23 <- data.frame(kwic(dec6, pattern = "LLaMA"))
k24 <- data.frame(kwic(dec6, pattern = "robotics"))
k25 <- data.frame(kwic(dec6, pattern = "human-like"))
k26 <- data.frame(kwic(dec6, pattern = "SearchGPT"))
k27 <- data.frame(kwic(dec6, pattern = "usability"))
k28 <- data.frame(kwic(dec6, pattern = "plugins"))
k29 <- data.frame(kwic(dec6, pattern = "HuggingChat"))


### BIGRAMS
kb1 <- data.frame(kwic(dec6, pattern = phrase("algorithmic bias")))
kb2 <- data.frame(kwic(dec6, pattern = phrase("artificial intelligence")))
kb3 <- data.frame(kwic(dec6, pattern = phrase("hugging face")))
kb4 <- data.frame(kwic(dec6, pattern = phrase("language model")))
kb5 <- data.frame(kwic(dec6, pattern = phrase("natural language")))
kb6 <- data.frame(kwic(dec6, pattern = phrase("machine learning")))
kb7 <- data.frame(kwic(dec6, pattern = phrase("supervised learning")))
kb8 <- data.frame(kwic(dec6, pattern = phrase("unsupervised learning")))
kb9 <- data.frame(kwic(dec6, pattern = phrase("reinforcement learning")))
kb10 <- data.frame(kwic(dec6, pattern = phrase("reward models")))
kb11 <- data.frame(kwic(dec6, pattern = phrase("bing chat")))
kb12 <- data.frame(kwic(dec6, pattern = phrase("goodhart's law")))
kb13 <- data.frame(kwic(dec6, pattern = phrase("cloud computing")))
kb14 <- data.frame(kwic(dec6, pattern = phrase("human intelligence")))
kb15 <- data.frame(kwic(dec6, pattern = phrase("virtual assistant")))
kb16 <- data.frame(kwic(dec6, pattern = phrase("open assistant")))
kb17 <- data.frame(kwic(dec6, pattern = phrase("microsoft azure")))
kb18 <- data.frame(kwic(dec6, pattern = phrase("academic plagiarism")))
kb19 <- data.frame(kwic(dec6, pattern = phrase("microsoft azure")))
kb20 <- data.frame(kwic(dec6, pattern = phrase("fine-tun")))
kb21 <- data.frame(kwic(dec6, pattern = phrase("detailed responses")))
kb22 <- data.frame(kwic(dec6, pattern = phrase("deceitful assistant")))
kb23 <- data.frame(kwic(dec6, pattern = phrase("factual accuracy")))
kb24 <- data.frame(kwic(dec6, pattern = phrase("virtual assistant")))
kb25 <- data.frame(kwic(dec6, pattern = phrase("significant drawback")))
kb26 <- data.frame(kwic(dec6, pattern = phrase("human trainers")))
kb27 <- data.frame(kwic(dec6, pattern = phrase("Google Bard")))
kb28 <- data.frame(kwic(dec6, pattern = phrase("Bing Chat")))
kb29 <- data.frame(kwic(dec6, pattern = phrase("limited knowledge")))

# TRIGRAMS
kt1 <- data.frame(kwic(dec6, pattern = phrase("application programming interface")))
kt2 <- data.frame(kwic(dec6, pattern = phrase("proximal policy optimization")))
kt3 <- data.frame(kwic(dec6, pattern = phrase("generative pre-trained transformer")))
kt4 <- data.frame(kwic(dec6, pattern = phrase("large language models")))

dataframes_list <- mget(ls(pattern = "^k"))
all_objects <- ls()

# Use do.call with rbind to merge all the dataframes
dec6 <- do.call(rbind, dataframes_list)
rm(list = setdiff(all_objects, "dec6"))
rm(all_objects)

library(igraph)
Dec <- dec6[c(1,7)]
bn2 <- graph.data.frame(Dec,directed=FALSE)
#bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "green", "red")
V(bn2)$shape <- ifelse(V(bn2)$type, "square", "circle")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.5, 1)
V(bn2)$size <- sqrt(igraph::degree(bn2))
E(bn2)$color <- "lightgrey"
#
bn2.pr <- bipartite.projection(bn2)
Terms2 <- bn2.pr$proj2
save.image("December6.RData")
#matTerms <- as.matrix(get.adjacency(Terms))
#
# Plot the network with node colors based on centrality
#plot(Terms, vertex.label.color = "black", 
#     vertex.label.cex = 1.5, 
#     vertex.color = "white", 
#     vertex.size = 6, 
#     vertex.shape = "none",
#     edge.width = 1, 
#     edge.color = "gray30", 
#     layout = layout_components, main = "")

#summary(Terms)
#graph.density(Terms)
#V(Terms)$name