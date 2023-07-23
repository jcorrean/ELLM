setwd("/home/jc/Documents/GitHub/ELLM")
load("DecemberSelectedKeywords.RData")
December2022 <- selectedkeywords
rm(selectedkeywords)
load("JanuarySelectedKeywords.RData")
January2023 <- selectedkeywords
rm(selectedkeywords)
load("FebruarySelectedKeywords.RData")
February2023 <- selectedkeywords
rm(selectedkeywords)
load("MarchSelectedKeywords.RData")
March2023 <- selectedkeywords
rm(selectedkeywords)
load("AprilSelectedKeywords.RData")
April2023 <- selectedkeywords
rm(selectedkeywords)
load("MaySelectedKeywords.RData")
May2023 <- selectedkeywords
rm(selectedkeywords)

df <- list(December2022, January2023, February2023, March2023, April2023, May2023)
df <- do.call(rbind, df)

rm(list = setdiff(ls(), "df"))
