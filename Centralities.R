rm(list = ls())
load("SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
rownames(Network) <- 1:length(Network$pattern)
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
colnames(Centralities)[4] <- "eigenvector"
Centralities$Nodes <- rownames(Centralities)
