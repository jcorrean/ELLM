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
plotweb(am, method = "normal", 
        col.high = c("green4", "red", "orange"), 
        bor.col.high = "white",
        col.low = "#7113CF", 
        bor.col.low = "white",
        col.interaction = "grey90",
        bor.col.interaction = "grey90",
        low.lablength = 30,
        text.rot = 90,
        labsize = 1.1,
        low.plot = TRUE, 
        text.high.col="black",
        low.spacing = 0.005,
        y.width.low=0.1, y.width.high=0.05, 
        y.lim=c(0,3), arrow="both", adj.high=c(0.5,1.5),
        high.lablength=11,high.lab.dis=0)


plotweb(am, col.high = c("green4", "red", "orange"), 
        bor.col.high = "white",
        col.low = "#7113CF", 
        bor.col.low = "white",
        col.interaction = "grey90",
        bor.col.interaction = "grey90",
        y.width.low=0.1, y.width.high=0.05,method="normal", 
        y.lim=c(0,3), arrow="up.center", adj.high=c(0.5,1.5),
        high.lablength=10,high.lab.dis=0)



visweb(t(AM), type = "diagonal", square="b", circles = FALSE, box.col="#7113CF",box.border="#5464C8", labsize = 4, textsize = 4, plotsize = 6)

V(bn2)$color <- ifelse(V(bn2)$type, "lightblue1", "#5464C8")
V(bn2)$shape <- ifelse(V(bn2)$type, "none", "none")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 5, 2)
# Set the label size for the vertices (you can adjust this as needed)

# Set the color of the edges
E(bn2)$color <- "lightgrey"

# Create a layout for the graph with the desired rotation
layout <- layout_as_bipartite(bn2)
rotated_layout <- cbind(layout[, 2], -layout[, 1])  # Swap x and y coordinates and negate y
pdf("F6.pdf", width = 35, height = 40)
plot(bn2, vertex.label = V(bn2)$name, layout = rotated_layout, main = "",
     vertex.label.color = ifelse(V(bn2)$color == "lightblue1", "#7113CF", "#5464C8"))
dev.off()
save.image("ResultsF6.RData")