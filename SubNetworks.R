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
January <- as.matrix(January)
February <- as.matrix(February)
March <- as.matrix(March)
April <- as.matrix(April)
May <- as.matrix(May)

net1 <- graph_from_edgelist(December, directed = FALSE)
net2 <- graph_from_edgelist(January, directed = FALSE)
net3 <- graph_from_edgelist(February, directed = FALSE)
net4 <- graph_from_edgelist(March, directed = FALSE)
net5 <- graph_from_edgelist(April, directed = FALSE)
net6 <- graph_from_edgelist(May, directed = FALSE)


summary(net1)
summary(net2)
summary(net3)
summary(net4)
summary(net5)
summary(net6)

library(grid)
par(mfrow = c(2, 3))

set.seed(123)
plot(net1, 
     displaylabels = TRUE, 
     edge.width=0.5,
     vertex.label.cex=0.6,
     vertex.shape = "none",
     vertex.color = "white",
     vertex.frame.color = "gray",
     vertex.label.font=0.5, 
     layout =   layout_with_fr)

plot(net2, 
     displaylabels = TRUE, 
     edge.width=0.5,
     vertex.label.cex=0.6,
     vertex.shape = "none",
     vertex.color = "white",
     vertex.frame.color = "gray",
     vertex.label.font=0.5, 
     layout =   layout_with_fr)

plot(net3, 
     displaylabels = TRUE, 
     edge.width=0.5,
     vertex.label.cex=0.6,
     vertex.shape = "none",
     vertex.color = "white",
     vertex.frame.color = "gray",
     vertex.label.font=0.5, 
     layout =   layout_with_fr)

plot(net4, 
     displaylabels = TRUE, 
     edge.width=0.5,
     vertex.label.cex=0.6,
     vertex.shape = "none",
     vertex.color = "white",
     vertex.frame.color = "gray",
     vertex.label.font=0.5, 
     layout =   layout_with_fr)

plot(net5, 
     displaylabels = TRUE, 
     edge.width=0.5,
     vertex.label.cex=0.6,
     vertex.shape = "none",
     vertex.color = "white",
     vertex.frame.color = "gray",
     vertex.label.font=0.5, 
     layout =   layout_with_fr)

plot(net6, 
     displaylabels = TRUE, 
     edge.width=0.5,
     vertex.label.cex=0.6,
     vertex.shape = "none",
     vertex.color = "white",
     vertex.frame.color = "gray",
     vertex.label.font=0.5, 
     layout =   layout_with_fr)

