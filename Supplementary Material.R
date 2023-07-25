# This is the supplementary material of the 
# paper titled: "Chat GPT: A data-driven analysis of its
# public understanding."

# Authors' Disclaimer: 
# This script has the explicit goal of making the paper
# as reproducible as possible for other researchers. 
# We declare that this research has received no financial 
# support and the authors have no conflict of interests
# regarding the results of this research. 

#### FIRST STEP: Open and parse collected PDF documents
# from our official GitHub repo: 
# https://github.com/jcorrean/ELLM
# Let's call our first script

source("/home/jc/Documents/GitHub/ELLM/OpenPDFs.R")
# The result has the following two dataframes:
# "listado" and "textos". These dataframes are
# saved as "Results_Step1.RData"

#### SECOND STEP: Pre-process the PDF documents
source("/home/jc/Documents/GitHub/ELLM/PreProcessPDFs.R")
# The result from this second step generates the 
# following single data frame: History with
# 480 rows and 7 variables
variable.names(History)
head(History)
