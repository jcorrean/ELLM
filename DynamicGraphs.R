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
zero_columns <- apply(Month1, 2, function(col) all(col == 0))
Month1 <- Month1[, !zero_columns]
Month2 <- as.matrix(january)
zero_columns <- apply(Month2, 2, function(col) all(col == 0))
Month2 <- Month2[, !zero_columns]

Month3 <- as.matrix(february)
zero_columns <- apply(Month3, 2, function(col) all(col == 0))
Month3 <- Month3[, !zero_columns]

Month4 <- as.matrix(march)
zero_columns <- apply(Month4, 2, function(col) all(col == 0))
Month4 <- Month4[, !zero_columns]

Month5 <- as.matrix(april)
zero_columns <- apply(Month5, 2, function(col) all(col == 0))
Month5 <- Month5[, !zero_columns]

Month6 <- as.matrix(may)
zero_columns <- apply(Month6, 2, function(col) all(col == 0))
Month6 <- Month6[, !zero_columns]

library(igraph)
bn1 <- graph.incidence(Month1)
bn2 <- graph.incidence(Month2)
bn3 <- graph.incidence(Month3)
bn4 <- graph.incidence(Month4)
bn5 <- graph.incidence(Month5)
bn6 <- graph.incidence(Month6)

bn1.pr <- bipartite.projection(bn1)
keywords1 <- bn1.pr$proj2

bn2.pr <- bipartite.projection(bn2)
keywords2 <- bn2.pr$proj2

bn3.pr <- bipartite.projection(bn3)
keywords3 <- bn3.pr$proj2

bn4.pr <- bipartite.projection(bn4)
keywords4 <- bn4.pr$proj2

bn5.pr <- bipartite.projection(bn5)
keywords5 <- bn5.pr$proj2

bn6.pr <- bipartite.projection(bn6)
keywords6 <- bn6.pr$proj2

plot(keywords, 
     vertex.label.color = "black", 
     vertex.label.cex = 1, 
     vertex.color = "white", 
     vertex.size = 5, 
     vertex.shape = "none",
     edge.width = 1, 
     edge.color = "lightgray", 
     layout = layout_in_circle, 
     main = "")


save.image("~/Documents/GitHub/ELLM/ResultsDynamicGraphs.RData")