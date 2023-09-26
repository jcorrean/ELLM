rm(list = ls())
load("SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
network <- Network[!duplicated(Network[c(1,2)]),]
rownames(network) <- 1:length(network$pattern)

table(Network$pattern)
table(Network$Month)
table(network$pattern)
table(network$Month)

library(dplyr)

# Find terms that did not appear in all six months
terms <- network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 6) 

# Find terms appearing only once
terms1 <- network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 1) 

# Find terms appearing only twice
terms2 <- network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 2) 

# Find terms appearing three times
terms3 <- network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 3) 

# Find terms appearing four times
terms4 <- network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 4) 

# Find terms appearing five times
terms5 <- network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 5) 

# Find terms appearing six times
terms6 <- network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 6) 

# This selection is biased. I need to plot the entire network
# estimate the centrality of all nodes, and then ranked from 
# most central to least central

library(igraph)
bn2 <- graph.data.frame(Network, directed = FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
Centralities <- data.frame(degree = igraph::degree(bn2),
                          closeness =igraph::closeness(bn2),
                          betweenness = igraph::betweenness(bn2),
                          Eigen.vector = igraph::eigen_centrality(bn2))
Centralities <- Centralities[1:4]
Centralities <- Centralities[order(-Centralities$Eigen.vector.vector), ]
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

