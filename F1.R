rm(list = ls())
load("SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
network <- unique( Network[ , c('pattern','Month') ] )
keywords <- c("ai", "architecture", "jobs", "algorithmic bias", "detailed responses", "human trainers", 
              "large language models", "jailbreak", "generative pre-trained transformer", 
              "bing chat", "algorithm", "hugging face", "application programming interface", 
              "natural language", "platform", "human intelligence")
library(dplyr)
library(stringr)
# Filtering the dataframe
network <- network %>%
   filter(str_detect(pattern, paste(keywords, collapse = "|", sep = "")))

library(igraph)
bn2 <- graph.data.frame(network, directed = FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
Centralities <- data.frame(degree = igraph::degree(bn2),
                           closeness =igraph::closeness(bn2),
                           betweenness = igraph::betweenness(bn2),
                           Eigen.vector = igraph::eigen_centrality(bn2))
Centralities <- Centralities[1:4]
Centralities <- Centralities[order(-Centralities$Eigen.vector.vector), ]
colnames(Centralities)[4] <- "eigenvector"
Centralities$Nodes <- rownames(Centralities)
# Set the color and shape of the vertices based on the 'type'
V(bn2)$color <- ifelse(V(bn2)$type, "lightblue1", "#5464C8")
V(bn2)$shape <- ifelse(V(bn2)$type, "none", "none")

# Set the label size for the vertices (you can adjust this as needed)
V(bn2)$label.cex <- ifelse(V(bn2)$type, 1, 1)

# Set the color of the edges
E(bn2)$color <- "lightgrey"

# Create a layout for the graph with the desired rotation
layout <- layout_as_tree(bn2)
rotated_layout <- cbind(layout[, 2], -layout[, 1])  # Swap x and y coordinates and negate y

# Plot the graph with the rotated layout and vertex labels
plot(bn2, vertex.label = V(bn2)$name, layout = rotated_layout, main = "",
     vertex.label.color = ifelse(V(bn2)$shape == "circle", "red", "black"))

layout <- layout_as_bipartite(bn2)
rotated_layout <- cbind(layout[, 2], -layout[, 1])  # Swap x and y coordinates and negate y
plot(bn2, vertex.label = V(bn2)$name, layout = rotated_layout, main = "",
     vertex.label.color = ifelse(V(bn2)$shape == "circle", "red", "black"))
 
save.image(file = "F1.RData")
