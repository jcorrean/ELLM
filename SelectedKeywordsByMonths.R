rm(list = ls())
load("DecemberKeywords.RData")
December2022 <- DecemberKeywords
rm(DecemberKeywords)

load("JanuaryKeywords.RData")
January2023 <- JanuaryKeywords
rm(JanuaryKeywords)

load("FebruaryKeywords.RData")
February2023 <- FebruaryKeywords
rm(FebruaryKeywords)

load("MarchKeywords.RData")
March2023 <- MarchKeywords
rm(MarchKeywords)

load("AprilKeywords.RData")
April2023 <- AprilKeywords
rm(AprilKeywords)

load("MayKeywords.RData")
May2023 <- MayKeywords
rm(MayKeywords)

df <- list(December2022, January2023, February2023, March2023, April2023, May2023)
df <- do.call(rbind, df)

rm(list = setdiff(ls(), "df"))
save.image("SelectedKeywords.RData")