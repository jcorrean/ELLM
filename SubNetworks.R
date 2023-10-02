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

library(ggplot2)
library(ggraph)
library(dplyr)

# Function to convert an igraph object to a data frame
igraph_to_data_frame <- function(net) {
   edges_df <- as.data.frame(get.edgelist(net))
   names(edges_df) <- c("from", "to")
   return(edges_df)
}

# Convert the networks to data frames
net1_df <- igraph_to_data_frame(net1)
net2_df <- igraph_to_data_frame(net2)
net3_df <- igraph_to_data_frame(net3)
net4_df <- igraph_to_data_frame(net4)
net5_df <- igraph_to_data_frame(net5)
net6_df <- igraph_to_data_frame(net6)

# Add a column to identify the network
net1_df$network <- "December"
net2_df$network <- "January"
net3_df$network <- "February"
net4_df$network <- "March"
net5_df$network <- "April"
net6_df$network <- "May"

# Combine all data frames into a single data frame
all_networks_df <- bind_rows(net1_df, net2_df, net3_df, net4_df, net5_df, net6_df)

# Plot the networks using ggraph and facet_wrap
ggraph(all_networks_df, aes(x = from, y = to)) +
   geom_edge_link() +
   geom_node_point() +
   facet_grid(~network, scales = "free") +
   theme_minimal()





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

