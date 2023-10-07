rm(list = ls())
load("SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
terms <- data.frame(table(Network$pattern))
library(dplyr)

categories <- c("concern", "roles", "generic use")
concern <- c("hallucinat", "jobs", "racist", "sexist", "bias", "factual accuracy", "plagiarism", "jailbreak", "risk", "cybersecurity", "academic plagiarism", "significant drawback", "limited knowledge")
roles <- c("ai", "prototype", "prompt", "InstructGPT", "architecture", "algorithmic bias", "artificial intelligence", "language model", "machine learning", "reinforcement learning", "proximal policy optimization", "reward models", "supervised learning", "generative pre-trained transformer", "large language models", "algorithm", "LLaMA", "hugging face", "natural language")
generic <- c("information", "knowledge", "human-like", "usability", "chatbot", "data", "goodhart's law", "detailed responses", "human trainers", "chat", "virtual assistant", "microsoft azure", "Meta", "robotics", "SearchGPT", "bing chat", "Google Bard", "Bing Chat", "platform", "plugins", "open assistant", "application programming interface", "api", "HuggingChat", "cloud computing", "human intelligence")

categorize_term <- function(term) {
   if (term %in% concern) {
      return("concern")
   } else if (term %in% roles) {
      return("roles")
   } else if (term %in% generic) {
      return("generic use")
   } else {
      return(NA)  # Return NA if the term doesn't match any category
   }
}

Network$Category <- apply(Network[, 1, drop = FALSE], 1, categorize_term)
Network$Month <- NULL

library(igraph)
bn2 <- graph.data.frame(Network, directed = FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type

adjacency_matrix <- get.adjacency(bn2, sparse = FALSE)
AM <- adjacency_matrix[1:58, (ncol(adjacency_matrix) - 2):ncol(adjacency_matrix)]
am <- data.frame(AM)
library(dplyr)
am <- am %>%
   arrange_all(desc)

library(bipartite)
pdf("F6.pdf", width = 15, height = 20)
par(srt = 90)  # Reset the rotation to default
plotweb(am, method = "normal", 
        ybig = 6,
        col.high = c("green4", "red", "orange"), 
        bor.col.high = "white",
        col.low = "#7113CF", 
        bor.col.low = "#7113CF",
        col.interaction = "grey70",
        bor.col.interaction = "grey70",
        low.lablength = 35,
        text.rot = 90,
        labsize = 1.7,
        low.plot = TRUE, 
        text.high.col="black",
        low.spacing = 0.005,
        y.width.low=0.1, y.width.high=0.05, 
        y.lim=c(0,3), arrow="up", adj.high=c(0.5,1.5),
        high.lablength=11,high.lab.dis=0)
dev.off()

save.image("ResultsF6.RData")
