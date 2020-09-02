#load required packages and libraries

library(languageR)
library(ggpubr)
library(reshape2)
library(ggplot2)
library(party)
library(Matrix)
library(Rcpp)
library(tidyverse)
library(partykit)
library(ranger)
library(RColorBrewer)
library(ggmap)
library(janitor)
library(broom)
library(randomForest)
library(randomForestExplainer)
library(knitr)
library(xlsx)

opts_chunk$set(tidy.opts = list(width.cutoff = 80), comment = "", 
               warning = FALSE, message = FALSE, echo = TRUE, 
               tidy = TRUE, size = "small")


#read in dataset
datBigrf1 <- read.csv("Scots.csv")

#make sure 'unknowns' in numeric predictors are ignored
datBigrf1 <- datBigrf1[datBigrf1$Year_of_birth != "Unknown", ]

#treat year, year of birth, publication year etc as numeric

datBigrf1$Year_of_birth <- as.numeric(as.character(datBigrf1$Year_of_birth))

#select columns in the dataset that need to be included (dependent and independent variables)
datBigrf1 <- datBigrf1 %>%
  select(5:7, 10:11, 13:14, 21, 25:26, 37, 39, 44)

#Set seed
set.seed(89788)

#grow ctree with dependent variable (DV) and as many independent variables (IV)
#as you wish to include

scottree <- ctree(DV ~ Iv + Iv + IV, dat = datBigrf1, 
                  controls = ctree_control(mincriterion = 0.999, minbucket = 200, maxdepth = 4)) 

#plot the outcome                                                                                    
plot(scottree)

##to grow a random forest using ranger

#set seed
set.seed(89788)

rf <- ranger(DV ~ IV + Iv + IV, data = datBigrf1, importance = "impurity")

#to plot random forest variable importance measures
varimp.rf <- rf$variable.importance %>%
  tidy() %>%
  arrange(desc(x))

varimp.rf$names <- factor(varimp.rf$names, levels = varimp.rf$names)

varimp.rf %>%
  ggplot(aes(x = names, weight = x, fill = names)) +
  geom_bar() +
  coord_flip() +
  theme_bw() +
  labs(title = "Variable importance predicting Scots")

