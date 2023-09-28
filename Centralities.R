rm(list = ls())
load("CentralitiesDEC.RData")
load("CentralitiesJAN.RData")
load("CentralitiesFEB.RData")
load("CentralitiesMAR.RData")
load("CentralitiesAPR.RData")
load("CentralitiesMAY.RData")
rm(bn1)
Centralities <- list(CentralitiesDEC, 
                     CentralitiesJAN,
                     CentralitiesFEB,
                     CentralitiesMAR,
                     CentralitiesAPR,
                     CentralitiesMAY)
Centralities <- do.call(rbind.data.frame, Centralities)
rm(list=setdiff(ls(), "Centralities"))
rownames(Centralities) <- 1:60
Centralities$Month <- rep(1:6, each = 10)
Centralities$Rank <- 1:10
Centralities <- Centralities[order(Centralities$Nodes), ]
Centralities <- Centralities[c(1,6,7)]

library(ggplot2)
library(ggbump)
library(ggrepel)
ggplot(Centralities, aes(Month, Rank, color = Nodes)) +
   geom_bump(size = 2) +
   geom_text_repel(aes(label = Nodes), nudge_y = 0.2, size = 4) +  # Add non-overlapping labels
   theme_bw() +
   scale_x_continuous(breaks = unique(Centralities$Month)) +
   scale_y_reverse(breaks = 1:10, labels = 1:10) +  # Reverse the Y-axis and set breaks/labels from 1 to 10
   labs(x = "Months", y = "Rank") +
   theme(legend.position = "none")