rm(list = ls())
load("SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
terms <- data.frame(table(Network$pattern))
library(dplyr)
Network$Category <- Network %>%
   mutate(category = case_when(
      terms %in% c("hallucinat", "jobs", "") ~ "concern",
      terms %in% c("prototype", "api", "") ~ "roles",
      terms %in% c("ai", "information", "knowledge", ) ~ "generic use",
      TRUE ~ NA_character_  # Default case, in case a term doesn't match any category
   ))