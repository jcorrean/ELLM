load("StructuredData.RData")
# Keyword-in-context search
library(quanteda)
summary(Textos)

Dec5 <- corpus_subset(Textos, Date == "2022-12-05")
Dec6 <- corpus_subset(Textos, Date == "2022-12-06")
Textos1 <- tokens(Dec5, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english"))

Textos2 <- tokens(Dec6, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english"))

Textos <- Textos1 + Textos2 

library(igraph)
Dec <- DecemberKeywords[c(1,7)]
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
plot(Programs, vertex.label.color = "black", 
     vertex.label.cex = 1.5, 
     vertex.color = "white", 
     vertex.size = 6, 
     edge.width = 3.5, 
     edge.color = "gray30", 
     layout = layout_components, main = "")
