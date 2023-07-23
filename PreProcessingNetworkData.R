load("/home/jc/Documents/GitHub/ELLM/SelectedKeywords.RData")
#a <- data.frame(summary(Textos, n = length(Textos)))
#table(a$Month)
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
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

toks_inside <- tokens_keep(TOKS, pattern = SoftSkills, window = 0)
DTM2 <- dfm(toks_inside)

DTM3 <- as.matrix(DTM2)
colnames(DTM3)

library(bipartite)
plotweb(DTM3, method = "normal", col.high = "lightgreen", col.low = "pink", col.interaction = "lightgrey")



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


