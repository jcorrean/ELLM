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
#https://github.com/davidsjoberg/ggbump


ggplot(df, aes(year, rank, color = country)) +
   geom_point(size = 7) +
   geom_text(data = df %>% filter(year == min(year)),
             aes(x = year - .1, label = country), size = 5, hjust = 1) +
   geom_text(data = df %>% filter(year == max(year)),
             aes(x = year + .1, label = country), size = 5, hjust = 0) +
   geom_bump(size = 2, smooth = 8) +
   scale_x_continuous(limits = c(2010.6, 2013.4),
                      breaks = seq(2011, 2013, 1)) +
   theme_minimal_grid(font_size = 14, line_size = 0) +
   theme(legend.position = "none",
         panel.grid.major = element_blank()) +
   labs(y = "RANK",
        x = NULL) +
   scale_y_reverse() +
   scale_color_manual(values = wes_palette(n = 4, name = "GrandBudapest1"))
