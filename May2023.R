# Open the dataset
load("StructuredData.RData")
# Keyword-in-context search
library(quanteda)
summary(Textos)

SixthMonth <- corpus_subset(Textos, Month == "February")
sixthmonth <- tokens(SixthMonth, 
                     remove_numbers = TRUE, 
                     remove_punct = TRUE, 
                     remove_url = TRUE, 
                     remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english"))

# Our Keyword-in-context search is 
# organized as follows: 1) unigrams, 2) bigrams, and 
# 3) trigrams.
# UNIGRAMS
k1 <- data.frame(kwic(sixthmonth, pattern = "ai"))
k2 <- data.frame(kwic(sixthmonth, pattern = "api"))
k3 <- data.frame(kwic(sixthmonth, pattern = "algorithm"))
k4 <- data.frame(kwic(sixthmonth, pattern = "android"))
k5 <- data.frame(kwic(sixthmonth, pattern = "architecture"))
k6 <- data.frame(kwic(sixthmonth, pattern = "bias"))
k7 <- data.frame(kwic(sixthmonth, pattern = "chat"))
k8 <- data.frame(kwic(sixthmonth, pattern = "chatbot"))
k9 <- data.frame(kwic(sixthmonth, pattern = "data"))
k10 <- data.frame(kwic(sixthmonth, pattern = "hallucinat", valuetype = "regex"))
k11 <- data.frame(kwic(sixthmonth, pattern = "prototype"))
k12 <- data.frame(kwic(sixthmonth, pattern = "platform"))
k13 <- data.frame(kwic(sixthmonth, pattern = "plagiarism"))
k14 <- data.frame(kwic(sixthmonth, pattern = "jailbreak"))
k15 <- data.frame(kwic(sixthmonth, pattern = "risk"))
k16 <- data.frame(kwic(sixthmonth, pattern = "jobs"))
k17 <- data.frame(kwic(sixthmonth, pattern = "cybersecurity"))
k18 <- data.frame(kwic(sixthmonth, pattern = "prompt"))
k19 <- data.frame(kwic(sixthmonth, pattern = "racist"))
k20 <- data.frame(kwic(sixthmonth, pattern = "sexist"))
k21 <- data.frame(kwic(sixthmonth, pattern = "InstructGPT"))
k22 <- data.frame(kwic(sixthmonth, pattern = "Meta"))
k23 <- data.frame(kwic(sixthmonth, pattern = "LLaMA"))
k24 <- data.frame(kwic(sixthmonth, pattern = "robotics"))
k25 <- data.frame(kwic(sixthmonth, pattern = "human-like"))
k26 <- data.frame(kwic(sixthmonth, pattern = "SearchGPT"))
k27 <- data.frame(kwic(sixthmonth, pattern = "usability"))
k28 <- data.frame(kwic(sixthmonth, pattern = "plugins"))
k29 <- data.frame(kwic(sixthmonth, pattern = "HuggingChat"))


### BIGRAMS
kb1 <- data.frame(kwic(sixthmonth, pattern = phrase("algorithmic bias")))
kb2 <- data.frame(kwic(sixthmonth, pattern = phrase("artificial intelligence")))
kb3 <- data.frame(kwic(sixthmonth, pattern = phrase("hugging face")))
kb4 <- data.frame(kwic(sixthmonth, pattern = phrase("language model")))
kb5 <- data.frame(kwic(sixthmonth, pattern = phrase("natural language")))
kb6 <- data.frame(kwic(sixthmonth, pattern = phrase("machine learning")))
kb7 <- data.frame(kwic(sixthmonth, pattern = phrase("supervised learning")))
kb8 <- data.frame(kwic(sixthmonth, pattern = phrase("unsupervised learning")))
kb9 <- data.frame(kwic(sixthmonth, pattern = phrase("reinforcement learning")))
kb10 <- data.frame(kwic(sixthmonth, pattern = phrase("reward models")))
kb11 <- data.frame(kwic(sixthmonth, pattern = phrase("bing chat")))
kb12 <- data.frame(kwic(sixthmonth, pattern = phrase("goodhart's law")))
kb13 <- data.frame(kwic(sixthmonth, pattern = phrase("cloud computing")))
kb14 <- data.frame(kwic(sixthmonth, pattern = phrase("human intelligence")))
kb15 <- data.frame(kwic(sixthmonth, pattern = phrase("virtual assistant")))
kb16 <- data.frame(kwic(sixthmonth, pattern = phrase("open assistant")))
kb17 <- data.frame(kwic(sixthmonth, pattern = phrase("microsoft azure")))
kb18 <- data.frame(kwic(sixthmonth, pattern = phrase("academic plagiarism")))
kb19 <- data.frame(kwic(sixthmonth, pattern = phrase("microsoft azure")))
kb20 <- data.frame(kwic(sixthmonth, pattern = phrase("fine-tun")))
kb21 <- data.frame(kwic(sixthmonth, pattern = phrase("detailed responses")))
kb22 <- data.frame(kwic(sixthmonth, pattern = phrase("deceitful assistant")))
kb23 <- data.frame(kwic(sixthmonth, pattern = phrase("factual accuracy")))
kb24 <- data.frame(kwic(sixthmonth, pattern = phrase("virtual assistant")))
kb25 <- data.frame(kwic(sixthmonth, pattern = phrase("significant drawback")))
kb26 <- data.frame(kwic(sixthmonth, pattern = phrase("human trainers")))
kb27 <- data.frame(kwic(sixthmonth, pattern = phrase("Google Bard")))
kb28 <- data.frame(kwic(sixthmonth, pattern = phrase("Bing Chat")))
kb29 <- data.frame(kwic(sixthmonth, pattern = phrase("limited knowledge")))

# TRIGRAMS
kt1 <- data.frame(kwic(sixthmonth, pattern = phrase("application programming interface")))
kt2 <- data.frame(kwic(sixthmonth, pattern = phrase("proximal policy optimization")))
kt3 <- data.frame(kwic(sixthmonth, pattern = phrase("generative pre-trained transformer")))
kt4 <- data.frame(kwic(sixthmonth, pattern = phrase("large language models")))

dataframes_list <- mget(ls(pattern = "^k"))
all_objects <- ls()

# Use do.call with rbind to merge all the dataframes
firstmonth <- do.call(rbind, dataframes_list)
rm(list = setdiff(all_objects, "firstmonth"))
rm(all_objects)

library(igraph)
Dec <- firstmonth[c(1,7)]
bn1 <- graph.data.frame(Dec,directed=FALSE)
#bipartite.mapping(bn1)
V(bn1)$type <- bipartite_mapping(bn1)$type
V(bn1)$color <- ifelse(V(bn1)$type, "green", "red")
V(bn1)$shape <- ifelse(V(bn1)$type, "square", "circle")
V(bn1)$label.cex <- ifelse(V(bn1)$type, 0.5, 1)
V(bn1)$size <- sqrt(igraph::degree(bn1))
E(bn1)$color <- "lightgrey"

bn1.pr <- bipartite.projection(bn1)
Terms4 <- bn1.pr$proj2
rm(list = setdiff(ls(), "bn1"))
save.image("May2023.RData")
#matTerms <- as.matrix(get.adjacency(Terms))

# Plot the network with node colors based on centrality
#plot(Terms1, vertex.label.color = "black", 
#     vertex.label.cex = 1.5, 
#     vertex.color = "white", 
#     vertex.size = 6, 
#     vertex.shape = "none",
#     edge.width = 1, 
#     edge.color = "gray30", 
#     layout = layout_components, main = "")

#summary(Terms)
#DecemberKeywords <- selectedkeywords
#all_objects <- ls()
#rm(list = setdiff(all_objects, "DecemberKeywords"))
#rm(all_objects)
#save.image("DecemberKeywords.RData")