rm(list = ls())
load("April2023.RData")
library(igraph)
CentralitiesAPR <- data.frame(degree = igraph::degree(bn1),
                              closeness =igraph::closeness(bn1),
                              betweenness = igraph::betweenness(bn1),
                              Eigen.vector = igraph::eigen_centrality(bn1))
CentralitiesAPR <- CentralitiesAPR[1:4]
CentralitiesAPR <- CentralitiesAPR[order(-CentralitiesAPR$Eigen.vector.vector), ]
colnames(CentralitiesAPR)[4] <- "eigenvector"
CentralitiesAPR$Nodes <- rownames(CentralitiesAPR)
CentralitiesAPR <- CentralitiesAPR[!grepl("text", CentralitiesAPR$Nodes),]
CentralitiesAPR$Month <- "April 2023" 
library(dplyr)
CentralitiesAPR <- CentralitiesAPR %>% relocate(Nodes)

save.image("CentralitiesAPR.RData")

#https://github.com/davidsjoberg/ggbump
# To plot the ggbump, I need to create 
# an adhoc table with months in one column
# and the corresponding Eigenvector 

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
