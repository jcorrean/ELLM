load("/home/jc/Documents/GitHub/ELLM/SelectedKeywords.RData")
TODAS$keyword <- tolower(TODAS$keyword)
Network <- TODAS[,c(1,5)]
Network <- Network[!duplicated(Network[c(1,2)]),]


