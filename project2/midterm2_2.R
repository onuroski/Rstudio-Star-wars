library(tidyverse)
library(dplyr)

#part2, first question
set.seed(2017555049)
sentenc <- stringr::sentences
hundred <- sample(sentenc, size=100)

hundreds <- hundred %>%
  str_split(" ")

hundreds <- unlist(hundreds)
hundreds <- unique(hundreds)
hundreds

#part2, second question

hundredsae <- hundreds[str_detect(hundreds,"^a")]
hundredsae <- hundredsae[str_detect(hundredsae,"e$")]
hundredsae                           #benim veri setimde hiç yok

#part2, third question

hundredsv <- str_count(hundreds,  pattern = "[aeiou]")
hundredsv <- hundredsv[hundredsv>3]
hundredsv <- length(hundredsv)
hundredsv

#part2, fourth question
hundredsf<-hundreds
str_length(hundredsf)
rank(-str_length(hundredsf)) 
hundredsf[rank(-str_length(hundredsf)) <= 15]

#part2, fifth question

hundreds_sub <- str_subset(hundreds, "age|any|day|exp|her|pro|the")
hundreds_sub

