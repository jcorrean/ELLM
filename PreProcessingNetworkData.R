rm(list = ls())
load("SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
rownames(Network) <- 1:length(Network$pattern)

table(Network$pattern)
table(Network$Month)

library(dplyr)
# Find terms appearing only once
terms1 <- Network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 1) 

# Find terms appearing only twice
terms2 <- Network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 2) 

# Find terms appearing three times
terms3 <- Network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 3) 

# Find terms appearing four times
terms4 <- Network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 4) 

# Find terms appearing five times
terms5 <- Network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 5) 

# Find terms appearing six times
terms6 <- Network %>%
  group_by(pattern) %>%
  summarise(unique_months = n_distinct(Month)) %>%
  filter(unique_months == 6) 

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
# Let's remove the nodes corresponding to the months
# and keep those of the concepts associated with
# ChatGPT development that did not appeared 
# on Figure 4. 
Centralities <- subset(Centralities, !Nodes %in% c("December 2022", "January 2023", "February 2023", "March 2023", "April 2023", "May 2023"))
Centralities <- subset(Centralities, 
                       !Nodes %in% 
                          c("ai", "chatbot", 
                            "chat", "data", 
                            "artificial intelligence", 
                            "proximal policy optimization",
                            "large language models",
                            "hallucinat",
                            "reinforcement learning",
                            "InstructGPT",
                            "prompt",
                            "human trainers",
                            "risk",
                            "application programming interface",
                            "bing chat"))


library(ggplot2)
ggplot(Centralities, aes(x = reorder(Nodes, eigenvector), y = eigenvector)) +
   geom_bar(stat = "identity", fill = "#7113CF") +
   labs(x = "Nodes", y = "Eigenvector Centrality") +
   theme_minimal() +
   theme(axis.text.y = element_text(hjust = 0, size = 12, color = "black"),  
         axis.text.x = element_text(size = 12, color = "black")) + 
   coord_flip()


ggsave("F5.pdf", dpi = "print", width = 24, height = 20, units = "cm")


save.image("ResultsPreProcessingNetworkData.RData")