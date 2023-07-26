library(alluvial)
source("/home/jc/Documents/GitHub/ELLM/PreProcessingNetworkData.R")
library(dplyr)
WF <- Network %>%
  group_by(pattern, Month) %>%
  count()
colnames(WF)[3] <- "Frequency"
WF <- WF %>%
  mutate(Month = case_when(
    Month == "December 2022" ~ 1,
    Month == "January 2023" ~ 2,
    Month == "February 2023" ~ 3,
    Month == "March 2023" ~ 4,
    Month == "April 2023" ~ 5,
    Month == "May 2023" ~ 6,
    TRUE ~ NA_integer_  # Add a default value in case none of the conditions match
  ))

unique(WF$pattern)

library(alluvial)
set.seed(4421266) # for nice colours
num_colors <- 53
cols <- hsv(h = runif(num_colors), s = runif(num_colors, 0.1, 1), v = runif(num_colors, 0.1, 1))
alluvial_ts(WF, wave = .3, ygap = 5, col = cols, plotdir = 'centred', alpha=.9,
            grid = TRUE, grid.lwd = 5, xmargin = 0.2, lab.cex = .7, xlab = '',
            ylab = '', border = NA, axis.cex = .8, leg.cex = .7,
            leg.col='white', 
            title = "Keywords associated with Chat GPT")

unique(WF$pattern)
length(unique(WF$pattern))
