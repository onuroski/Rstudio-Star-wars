library(tidyverse)
library(dplyr)


set.seed(2017555049)
data_one <- read.table("R/project2/covid-data-2020.txt", header = TRUE, sep = '\t')
thousand_data <- data_one[sample(1: nrow(data_one),size = 1000),]

#part1, first question *************************************************
tdg <- group_by(thousand_data, location, month)
tdg <- summarise(tdg, min=min(new_cases),
                  q1=quantile(new_cases,probs=0.25, na.rm = TRUE),
                  q2=quantile(new_cases,probs=0.5, na.rm = TRUE),
                  q3=quantile(new_cases,probs=0.75, na.rm = TRUE),
                  max=max(new_cases))

tdg                                             #alfabetik sıralı
tdg1 <- tdg[sample(1: nrow(tdg),size = 429),]   #Karmaşık olarak sıralı
tdg1

#Part1, second question *************************************************

tdg2<-group_by(thousand_data ,location)
tdg2<-summarize(tdg2, max_case=max(new_cases, na.rm = TRUE),
                max_death=max(new_deaths, na.rm = TRUE))
tdg2

#part1, third question **************************************************

third <- group_by(thousand_data, location, month)
third1 <- summarise(third, meanofdailycases = mean(new_cases))
third2 <- filter(third1, meanofdailycases==max(meanofdailycases, na.rm = TRUE))
third2

#part1, fourth question *************************************************

fourth <- filter(thousand_data, thousand_data$location=="Croatia" | thousand_data$location=="Finland" | thousand_data$location=="Bulgaria")
fourth


ggplot(data = fourth) +
  geom_smooth(mapping = aes(x = month, y = new_cases, color = location))
