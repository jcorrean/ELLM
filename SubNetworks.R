rm(list = ls())
load("SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
Network <- Network[!duplicated(Network), ]
Network <- Network[,c(ncol(Network),1:(ncol(Network)-1))]

December <- dplyr::filter(Network, grepl("December 2022",Month))
January  <- dplyr::filter(Network, grepl("January 2023",Month))
February  <- dplyr::filter(Network, grepl("February 2023",Month))
March  <- dplyr::filter(Network, grepl("March 2023",Month))
April  <- dplyr::filter(Network, grepl("April 2023",Month))
May  <- dplyr::filter(Network, grepl("May 2023",Month))

library(igraph)
December <- as.matrix(December)
net1 <- graph_from_edgelist(December, directed = FALSE)
summary(net1)
plot(net1, 
     displaylabels = TRUE, 
     edge.width=0.5,
     vertex.label.cex=0.6,
     vertex.shape = "none",
     vertex.color = "white",
     vertex.frame.color = "gray",
     vertex.label.font=0.5, 
     layout =   layout_components)

