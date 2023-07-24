load("/home/jc/Documents/GitHub/ELLM/SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
network <- Network[!duplicated(Network[c(1,2)]),]

library(igraph)
bn2 <- graph.data.frame(network, directed = FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "red", "green")
V(bn2)$shape <- ifelse(V(bn2)$type, "circle", "square")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.8, 1)
E(bn2)$color <- "lightgrey"

# Plot the graph using plot
plot(bn2, vertex.label = NA, layout = layout_as_bipartite, main = "")

# Rotate the plot 90 degrees clockwise
tkplot_rotate(90)


table(igraph::degree(bn2,v=V(bn2)[type==FALSE]))
mean(igraph::degree(bn2,v=V(bn2)[type==FALSE]))
var(igraph::degree(bn2,v=V(bn2)[type==FALSE]))
min(igraph::degree(bn2,v=V(bn2)[type==FALSE]))
max(igraph::degree(bn2,v=V(bn2)[type==FALSE]))
edge_density(bn2)

bn2.pr <- bipartite.projection(bn2)
Months <- bn2.pr$proj2
MonthsCentrality <- data.frame(Degree = degree(Months),
                               Closeness = closeness(Months),
                               Betweennes = betweenness(Months),
                               Eigen = eigen_centrality(Months))

Keywords <- bn2.pr$proj1
KeywordsCentrality <- data.frame(Degree = degree(Keywords),
                               Closeness = closeness(Keywords),
                               Betweenness = betweenness(Keywords),
                               Eigen = eigen_centrality(Keywords))
KeywordsCentrality <- KeywordsCentrality[1:4]
KeywordsCentrality$Term <- rownames(KeywordsCentrality)
Top10Betweenness <- head(KeywordsCentrality[order(-KeywordsCentrality$Betweenness), ], 10)
Top10Closeness <- head(KeywordsCentrality[order(-KeywordsCentrality$Closeness), ], 10)
Top10Eigenvector <- head(KeywordsCentrality[order(-KeywordsCentrality$Eigen.vector), ], 10)

library(ggplot2)
ggplot(KeywordsCentrality, aes(x=reorder(Term, Eigen.vector), y=Eigen.vector)) +
  geom_bar(stat = "identity", fill="lightgreen") + theme_bw() + 
  theme(axis.text.x=element_text(size=15, colour="black")) +
  theme(axis.text.y=element_text(size=15, colour="black")) +
  theme(axis.title.x=element_text(face="italic", colour="black", size=25)) +
  theme(axis.title.y=element_text(face="italic", colour="black", size=25)) +
  coord_flip() + xlab("Keywords") + ylab("Eigenvector Centrality (rescaled 0-1)")

# we spot a list of 26 keywords, so let's use them to depict  
# a bipartite network with them

TopEigenvector <- head(KeywordsCentrality[order(-KeywordsCentrality$Eigen.vector), ], 26)
load("/home/jc/Documents/GitHub/ELLM/StructuredData.RData")

library(quanteda)
TOKS <- corpus(History$text) %>% 
  tokens(remove_numbers = TRUE, 
         remove_punct = TRUE, 
         remove_url = TRUE,
         remove_symbols = TRUE) %>% 
  tokens_remove(stopwords("en"))
DTM <- dfm(TOKS, tolower = TRUE)

keywords <- TopEigenvector$Term

toks_inside <- tokens_keep(TOKS, pattern = keywords, window = 0)
DTM2 <- dfm(toks_inside)
summary(DTM2)

DTM3 <- as.matrix(DTM2)
colnames(DTM3)
row_names <- c(rep("December 2022", 203),
               rep("January 2023", 40),
               rep("February 2023", 47),
               rep("March 2023", 94),
               rep("April 2023", 42),
               rep("May 2023", 56))

rownames(DTM3) <- row_names

library(bipartite)
plotweb(DTM3, method = "normal", 
        col.high = "lightgreen", 
        bor.col.high = "lightgreen",
        col.low = "pink", 
        bor.col.low = "pink",
        col.interaction = "grey90",
        bor.col.interaction = "grey90",
        low.lablength = 0,
        labsize = 2)



library(igraph)
bn2 <- graph.data.frame(network,directed=FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "red", "green")
V(bn2)$shape <- ifelse(V(bn2)$type, "circle", "square")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.8, 1)
V(bn2)$size <- sqrt(igraph::degree(bn2))
E(bn2)$color <- "lightgrey"
plot(bn2, 
     vertex.label = NA, 
     layout = layout_as_bipartite, 
     main = "")

table(Network$keyword)
Network <- Network[!duplicated(Network[c(1,2)]),]


library(igraph)
bn2 <- graph.data.frame(network, directed = FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "red", "green")
V(bn2)$shape <- ifelse(V(bn2)$type, "circle", "square")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.8, 1)
E(bn2)$color <- "lightgrey"

# Create a layout for the graph with the desired rotation
layout <- layout_as_tree(bn2)
rotated_layout <- cbind(layout[, 2], -layout[, 1])  # Swap x and y coordinates and negate y

# Plot the graph with the rotated layout and vertex labels
plot(bn2, vertex.label = V(bn2)$name, layout = rotated_layout, main = "")
