load("~/Documents/GitHub/ELLM/TopTermsByMonth.RData")

library(quanteda)
k1 <- data.frame(kwic(dec2022, pattern = phrase("artificial intelligence")))
k2 <- data.frame(kwic(dec2022, pattern = phrase("prototype")))
k3 <- data.frame(kwic(dec2022, pattern = phrase("large language model")))
k4 <- data.frame(kwic(dec2022, pattern = phrase("generative pre-trained transformer")))
k5 <- data.frame(kwic(dec2022, pattern = phrase("GPT-3.5 architecture")))
k6 <- data.frame(kwic(dec2022, pattern = phrase("architecture")))
k7 <- data.frame(kwic(mar2023, pattern = phrase("Microsoft Azure")))

k1$docname <- as.numeric(gsub("[^0-9]", "", k1$docname))


library(quanteda.textstats)
freq_table <- textstat_frequency(Jan2)

# Sort the frequency table by frequency (descending)
freq_table <- freq_table[order(-freq_table$frequency), ]

freq_table$rank <- seq_along(freq_table$frequency)

# Plot the frequency distribution on a log-log scale
plot(log(freq_table$rank), log(freq_table$frequency),
     type = "o", pch = 16, col = "blue", xlab = "Log Rank",
     ylab = "Log Frequency", main = "Zipf-like Distribution")
