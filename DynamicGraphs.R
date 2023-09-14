load("StructuredData.RData")
library(quanteda)
summary(Textos)
December <- corpus_subset(Textos, Date=="2022-12-31")
Textos2 <- tokens(December, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english")) %>% dfm()
dict <- dictionary(list(ChatGPT = c("ChatGPT"),
   OpenAI = c("OpenAI"),
   prototype = c("prototype"),
   artificial_intelligece = c("artificial intelligence"),
   LLM = c("large language model"),
   chatbot = c("chatbot")))


pave <- as.matrix(dfm_lookup(Textos2, dict, valuetype = "glob"))
library(igraph)
bn <- graph.incidence(pave)
shapes <- c("circle","square")
colors <- c("blue","red")
plot(bn,vertex.color=colors[V(bn)$type+1],
     vertex.shape=shapes[V(bn)$type+1],
     vertex.size=10,vertex.label.degree=-pi/2,
     vertex.label.dist=1.2,vertex.label.cex=0.9)     




January <- corpus_subset(Textos, Date=="2023-01-31")
Textos3 <- tokens(January, 
                  remove_numbers = TRUE, 
                  remove_punct = TRUE, 
                  remove_url = TRUE, 
                  remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english")) %>% dfm()

pave2 <- as.matrix(dfm_lookup(Textos3, dict, valuetype = "glob"))
library(igraph)
bn <- graph.incidence(pave2)
shapes <- c("circle","square")
colors <- c("blue","red")
plot(bn,vertex.color=colors[V(bn)$type+1],
     vertex.shape=shapes[V(bn)$type+1],
     vertex.size=10,vertex.label.degree=-pi/2,
     vertex.label.dist=1.2,vertex.label.cex=0.9)     
