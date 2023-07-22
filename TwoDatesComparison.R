load("~/Documents/GitHub/ELLM/TopTermsByMonth.RData")
summary(Textos[479:482])

DecMay <- corpus_subset(Textos, 
                             Date %in% c("2022-12-05", "2023-05-30"))

remover <- list(textos)

pres_dfm <- tokens(DecMay, remove_punct = TRUE) %>%
  tokens_remove(c(remover, stopwords("english"))) %>%
  tokens_group(groups = Date) %>%
  dfm()

library(quanteda.textstats)
# Calculate keyness and determine Trump as target group
result_keyness <- textstat_keyness(pres_dfm, target = "2023-05-30")

library(quanteda.textplots)
# Plot estimated word keyness
textplot_keyness(result_keyness) 

pave <- data.frame(topfeatures(pres_dfm, n = length(pres_dfm), groups = Date))
