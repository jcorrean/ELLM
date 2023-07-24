load("/home/jc/Documents/GitHub/ELLM/SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]

library(igraph)
bn2 <- graph.data.frame(Network,directed=FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "red", "green")
V(bn2)$shape <- ifelse(V(bn2)$type, "circle", "square")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.8, 1)
#V(bn2)$size <- sqrt(igraph::degree(bn2))
E(bn2)$color <- "lightgrey"
plot(bn2, 
     vertex.label = NA, 
     layout = layout_as_bipartite, 
     main = "")

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
                               Betweennes = betweenness(Keywords),
                               Eigen = eigen_centrality(Keywords))
KeywordsCentrality <- KeywordsCentrality[1:4]




#Network <- Network[!duplicated(Network[c(1,2)]),]

load("StructuredData.RData")
library(quanteda)
TOKS <- corpus(History$text) %>% 
  tokens(remove_numbers = TRUE, 
         remove_punct = TRUE, 
         remove_url = TRUE,
         remove_symbols = TRUE) %>% 
  tokens_remove(stopwords("en"))
DTM <- dfm(TOKS, tolower = TRUE)

keywords <- c("ai", "api", "algorithm", "prompt", "architecture",
"bias","chat","chatbot","data","hallucination","information","knowledge",
"prototype","platform","plagiarism","misinformation","jailbreak","risk",
"jobs","cybersecurity","algorithmic bias",
"application programming interface", "language model",
"proximal policy optimization", "large language model", 
"natural language","generative pre-trained transformer ",
"machine learning", "supervised learning", "unsupervised learning", 
"reinforcement learning","reward models", "bing chat", "cloud computing", 
"human intelligence", "virtual assistant", "apple","android", "baidu",
"expedia", "facebook", "freemium", "google", "hugging face", "ios",
"meta", "microsoft", "microsoft azure", "naver", "nvidia", 
"opentable", "openai", "reddit", "snapchat", "shopify", "wolfram",
"yandex", "zapier", "goodhart's law") 

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
bn2 <- graph.data.frame(Network,directed=FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "red", "green")
V(bn2)$shape <- ifelse(V(bn2)$type, "circle", "square")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.8, 1)
V(bn2)$size <- sqrt(igraph::degree(bn2))
E(bn2)$color <- "lightgrey"
plot(bn2, 
     vertex.label = NA, 
     layout = layout_components, 
     main = "")

table(Network$keyword)
Network <- Network[!duplicated(Network[c(1,2)]),]


library(igraph)
bn2 <- graph.data.frame(Network,directed=FALSE)
bipartite.mapping(bn2)
V(bn2)$type <- bipartite_mapping(bn2)$type
V(bn2)$color <- ifelse(V(bn2)$type, "red", "green")
V(bn2)$shape <- ifelse(V(bn2)$type, "circle", "square")
V(bn2)$label.cex <- ifelse(V(bn2)$type, 0.5, 1)
V(bn2)$size <- sqrt(igraph::degree(bn2))
E(bn2)$color <- "lightgrey"

bn2.pr <- bipartite.projection(bn2)
Terms <- bn2.pr$proj2

centrality_scores <- degree(Terms)

# Normalize the centrality scores to a range between 0 and 1
normalized_scores <- (centrality_scores - min(centrality_scores)) / (max(centrality_scores) - min(centrality_scores))

# Create a color palette with different colors
color_palette <- colorRampPalette(c("red", "pink", "lightgreen", "green"))(length(unique(normalized_scores)))

# Assign colors to nodes based on their normalized centrality scores
node_colors <- color_palette[rank(normalized_scores)]

# Plot the network with node colors based on centrality
plot(Terms, vertex.label.color = "black", vertex.label.cex = 0.8, vertex.color = node_colors, vertex.size = 15, edge.width = 0.5, edge.color = "lightgray", layout = layout_components, main = "")


