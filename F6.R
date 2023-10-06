rm(list = ls())
load("SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
terms <- data.frame(table(Network$pattern))
library(dplyr)

categories <- c("concern", "roles", "generic use")
concern <- c("hallucinat", "jobs", "racist", "sexist", "bias", "factual accuracy", "plagiarism", "jailbreak", "risk", "cybersecurity", "academic plagiarism", "significant drawback", "limited knowledge")
roles <- c("prototype", "prompt", "InstructGPT", "architecture", "algorithmic bias", "artificial intelligence", "language model", "machine learning", "reinforcement learning", "proximal policy optimization", "reward models", "supervised learning", "generative pre-trained transformer", "large language models", "algorithm", "LLaMA", "hugging face", "natural language")
generic <- c("ai", "information", "knowledge", "human-like", "usability", "chatbot", "data", "goodhart's law", "detailed responses", "human trainers", "chat", "virtual assistant", "microsoft azure", "Meta", "robotics", "SearchGPT", "bing chat", "Google Bard", "Bing Chat", "platform", "plugins", "open assistant", "application programming interface", "api", "HuggingChat", "cloud computing", "human intelligence")

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
V(bn2)$color <- ifelse(V(bn2)$type, "lightblue1", "#5464C8")
V(bn2)$shape <- ifelse(V(bn2)$type, "none", "none")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 5, 2)
# Set the label size for the vertices (you can adjust this as needed)

# Set the color of the edges
E(bn2)$color <- "lightgrey"

# Create a layout for the graph with the desired rotation
layout <- layout_as_bipartite(bn2)
rotated_layout <- cbind(layout[, 2], -layout[, 1])  # Swap x and y coordinates and negate y
pdf("F6.pdf", width = 15, height = 30)
plot(bn2, vertex.label = V(bn2)$name, layout = rotated_layout, main = "",
     vertex.label.color = ifelse(V(bn2)$color == "lightblue1", "black", "#5464C8"))
dev.off()