load("~/Documents/GitHub/ELLM/TopTermsByMonth.RData")

library(quanteda)
k1 <- data.frame(kwic(dec2022, pattern = phrase("artificial intelligence")))
k2 <- data.frame(kwic(dec2022, pattern = phrase("prototype")))
k3 <- data.frame(kwic(dec2022, pattern = phrase("large language model")))
k4 <- data.frame(kwic(dec2022, pattern = phrase("generative pre-trained transformer")))

library(quanteda.textstats)
freq_table <- textstat_frequency(Jan2)

# Sort the frequency table by frequency (descending)
freq_table <- freq_table[order(-freq_table$frequency), ]

freq_table$rank <- seq_along(freq_table$frequency)

# Plot the frequency distribution on a log-log scale
plot(log(freq_table$rank), log(freq_table$frequency),
     type = "o", pch = 16, col = "blue", xlab = "Log Rank",
     ylab = "Log Frequency", main = "Zipf-like Distribution")
