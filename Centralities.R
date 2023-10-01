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
centralities <- Centralities
Centralities$Month <- rep(1:6, each = 10)
Centralities$Rank <- 1:10
Centralities <- Centralities[order(Centralities$Nodes), ]
Centralities <- Centralities[c(1,6,7)]

library(tidyverse)
library(ggplot2)
library(ggbump)
library(ggrepel)
library(cowplot)
custom_labels <- c("December 2022", "January 2023", "February 2023", "March 2023", "April 2023", "May 2023")
# Modify the ggplot code to use custom labels
ggplot(Centralities, aes(Month, Rank, color = Nodes)) +
   geom_bump(size = 2) +
   geom_text_repel(aes(label = Nodes), nudge_y = 0.2, size = 4) +  # Add non-overlapping labels
   theme_cowplot() +
   scale_x_continuous(breaks = 1:6, labels = custom_labels) +  # Use custom labels
   scale_y_reverse(breaks = 1:10, labels = 1:10) +  # Reverse the Y-axis and set breaks/labels from 1 to 10
   labs(x = "Months", y = "Rank") +
   theme(legend.position = "none")

ggsave("F4.pdf", dpi = "print", width = 28, height = 20, units = "cm")

save.image("CentralitiesTOP10.RData")
