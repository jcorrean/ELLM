rm(list = ls())
load("SelectedKeywords.RData")
df$keyword <- tolower(df$keyword)
Network <- df[,c(7,8)]
terms <- data.frame(table(Network$pattern))
library(dplyr)
# concern refers to terms that suggest 
# (un)desirable usages
Network$Category <- Network %>%
   mutate(category = case_when(
      terms %in% c("hallucinat", "jobs",
                   "racist", "sexist",
                   "bias", "factual accuracy",
                   "plagiarism", "jailbreak",
                   "risk", "cybersecurity",
                   "academic plagiarism",
                   "significant drawback",
                   "limited knowledge",
                   "") ~ "concern",
      terms %in% c("prototype", "api",
      "prompt", "InstructGPT",
      "architecture", "algorithmic bias",
      "artificial intelligence", "language model",
      "machine learning", "reinforcement learning",
      "proximal policy optimization",
      "reward models", "supervised learning",
      "generative pre-trained transformer",
      "large language models",
      "algorithm") ~ "roles",
      terms %in% c("ai", "information",
      "knowledge", "human-like",
      "usability", "chatbot", "data",
      "goodhart's law", "detailed responses",
      "human trainers", "chat",
      "virtual assistant",
      "microsoft azure",
      "Meta", "robotics",
      "SearchGPT","bing chat",
      "Google Bard", "Bing Chat",
      "") ~ "generic use",
      TRUE ~ NA_character_  # Default case, in case a term doesn't match any category
   ))