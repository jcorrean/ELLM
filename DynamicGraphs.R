load("StructuredData.RData")
library(quanteda)
dict <- dictionary(list(ChatGPT = c("ChatGPT"),
                        OpenAI = c("OpenAI"),
                        prototype = c("prototype"),
                        AI = c("AI", "artificial intelligence"),
                        Bias = c("bias"),
                        Plugins = c("plugins"),
                        LLM = c("large language model"),
                        chatbot = c("chatbot"),
                        Reward_Model = c("reward model"),
                        GPT = c("Generative Pre-trained Transformer"),
                        fine_tuned = c("fine-tuned", "fine-tuning"),
                        supervised_learning = c("supervised learning"),
                        reinforcement_learning = c("reinforcement learning"),
                        detailed_responses = c("detailed responses"),
                        deceitful_responses = c("deceitful responses"),
                        factual_accuracy = c("factual accuracy"),
                        significant_drawback = c("significant drawback"),
                        human_trainers = c("human trainers"),
                        hallucination = c("hallucination"),
                        Google_Bard = c("Google Bard"),
                        Bing_Chat = c("Bing Chat"),
                        human_feedback = c("human feedback"),
                        proximal_policy_optimization = c("proximal policy optimization"),
                        Microsoft_Azure = c("Microsoft Azure"),
                        Nvidia = c("nvidia"),
                        API = c("API", "application programming interface", "APIs"),
                        Amazon = c("Amazon"),
                        Expedia = c("Expedia"),
                        OpenTable = c("OpenTable"),
                        Zapier = c("Zapier"),
                        Shopify = c("Shopify"),
                        Slack = c("Slack"),
                        Wolfram = c("Wolfram"),
                        Goodhart_law = c("Goodhart's law"),
                        limited_knowledge = c("limited knowledge"),
                        factual_content = c("factual content"),
                        prompt = c("prompt", "prompts"),
                        academic_plagiarism = c("academic plagiarism"),
                        robotics = c("robotics"),
                        natural_language = c("natural language"),
                        human_like = c("human-like"),
                        hugging_face = c("hugging face"),
                        jailbreak = c("jailbreak", "jailbreaking"),
                        LLaMA = c("LLaMA"),
                        Baidu = c("Baidu"),
                        SearchGPT = c("SearchGPT"),
                        Yandex = c("YaLM"),
                        Ernie_Bot = c("Ernie Bot"),
                        Naver = c("Naver"),
                        HuggingChat = c(""),
                        Open_Assistant = c("Open Assistant"),
                        Virtual_Assistant = c("Virtual Assistant"),
                        Meta = c("Meta"),
                        Cloud_Computing = c("Cloud Computing"),
                        InstructGPT = c("InstructGPT"),
                        racist = c("racist"),
                        sexist = c("sexist")))


summary(Textos)
December <- corpus_subset(Textos, Month=="December")
January <- corpus_subset(Textos, Month=="January")
February <- corpus_subset(Textos, Month=="February")
March <- corpus_subset(Textos, Month=="March")
April <- corpus_subset(Textos, Month=="April")
May <- corpus_subset(Textos, Month=="May")

december <- tokens(December, 
       remove_numbers = TRUE, 
       remove_punct = TRUE, 
       remove_url = TRUE, 
       remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english")) |>
   tokens_lookup(dictionary = dict) |>
   dfm()

january <- tokens(January, 
                   remove_numbers = TRUE, 
                   remove_punct = TRUE, 
                   remove_url = TRUE, 
                   remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english")) |>
   tokens_lookup(dictionary = dict) |>
   dfm()

february <- tokens(February, 
                   remove_numbers = TRUE, 
                   remove_punct = TRUE, 
                   remove_url = TRUE, 
                   remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english")) |>
   tokens_lookup(dictionary = dict) |>
   dfm()

march <- tokens(March, 
                   remove_numbers = TRUE, 
                   remove_punct = TRUE, 
                   remove_url = TRUE, 
                   remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english")) |>
   tokens_lookup(dictionary = dict) |>
   dfm()

april <- tokens(April, 
                   remove_numbers = TRUE, 
                   remove_punct = TRUE, 
                   remove_url = TRUE, 
                   remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english")) |>
   tokens_lookup(dictionary = dict) |>
   dfm()

may <- tokens(May, 
                   remove_numbers = TRUE, 
                   remove_punct = TRUE, 
                   remove_url = TRUE, 
                   remove_symbols = TRUE) %>%  
   tokens_remove(stopwords("english")) |>
   tokens_lookup(dictionary = dict) |>
   dfm()

Month1 <- as.matrix(december)
Month2 <- as.matrix(january)
library(igraph)
bn <- graph.incidence(pave)
shapes <- c("circle","square")
colors <- c("blue","red")
plot(bn,vertex.color=colors[V(bn)$type+1],
     vertex.shape=shapes[V(bn)$type+1],
     vertex.size=10,vertex.label.degree=-pi/2,
     vertex.label.dist=1.2,vertex.label.cex=0.9)     

bn2.pr <- bipartite.projection(bn)
Programs <- bn2.pr$proj2

plot(Programs, vertex.label.color = "black", 
     vertex.label.cex = 1.2, 
     vertex.color = "pink", 
     vertex.size = 40, 
     edge.width = 5, 
     edge.color = "gray30", 
     layout = layout_components, 
     main = "")

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

bn3.pr <- bipartite.projection(bn)
Programs <- bn3.pr$proj2

plot(Programs, vertex.label.color = "black", 
     vertex.label.cex = 1.2, 
     vertex.color = "pink", 
     vertex.size = 40, 
     edge.width = 5, 
     edge.color = "gray30", 
     layout = layout_components, 
     main = "")


save.image("~/Documents/GitHub/ELLM/ResultsDynamicGraphs.RData")