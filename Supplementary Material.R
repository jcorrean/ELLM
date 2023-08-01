# This is the supplementary material of the 
# paper titled: "Chat GPT: A data-driven analysis of its
# public understanding."

# INSTRUCTIONS FOR REPRODUCING THIS SCRIPT
# FIRST: You can clone our GitHub repo and 
# set the cloned folder as your working directory
# SECOND: Make sure you have installed R and RStudio
# in your computer. In addition, make sure to have 
# installed the following libraries: 
# 1) readtext
# 2) tm
# 3) dplyr
# 4) quanteda
# 5) lubridate
# 6) ggplot2
# 7) 


# Authors' Disclaimer: 
# This script has the explicit goal of making the paper
# as reproducible as possible for other researchers. 
# We declare that this research has received no financial 
# support and the authors have no conflict of interests
# regarding the results of this research. 

#### FIRST STEP: 
# Clone our official GitHub repo: 
# https://github.com/jcorrean/ELLM
# and open its unique Project, by 
# double clicking on ELLM.RProj

source("OpenPDFs.R")
# The result has the following two dataframes:
# "listado" and "textos". We
# saved as the results as "Results_Step1.RData"


#### SECOND STEP: Pre-process the PDF documents
source("PreProcessPDFs.R")
# The result from this second step generates the 
# following single data frame: History with
# 480 rows and 7 variables
variable.names(History)
head(History)
save.image(file = "StructuredData.RData")
# This data frame is saved with the name
# StructuredData.RData which is the input for 
# our next step

#### THIRD STEP: GPT Milestone Analysis
source("GPTMilestonesAnalysis.R")
# The result from this third step generates the 
# figure inserted as Figure 2 in our published document.
# It conveys the message that the documentation
# of Chat GPT increased its length as captured by
# the number of sentences of wikipedia's revisions

#### FOURTH STEP: Keywords-in-context search by month
source("/home/jc/Documents/GitHub/ELLM/SelectedKeywordsByMonths.R")
# The result from this fourth step is an extended data frame (df)
# that shows where our selected keywords occurred in each 
# sampled document. We will take this data frame as input
# for our next step, This data frame is saved as
# SelectedKeywords.RData which is used as input in the
# next step.

#### FIFTH STEP: Pre-Processing Network Data
source("/home/jc/Documents/GitHub/ELLM/PreProcessingNetworkData.R")
# The result from this fifth step is a bipartite network that 
# shows how some selected terms (regardless of they are unigrams,
# bigrams, or ngrams) are selectively tied to specific months.
