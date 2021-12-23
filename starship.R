library(dplyr)
library(tidyverse)

# question 1

filter(starwars, lengths(starwars$starships) > 0 )

# question 2

arrange(starwars %>% count(eye_color), desc(n))

# question 3

by_spby <- group_by(starwars, species)
by_spby_arr <- summarize(by_spby, age = mean(birth_year, na.rm = TRUE))
by_spby_sum<-arrange(by_spby_arr, desc(by_spby_arr$age))
by_spby_sum


by_spby_sum[1,1]
by_spby_sum[2,1]
by_spby_sum[3,1]

#question 4

onur<-rbind(starwars ,c("onur",213,11,"lilac", "lilac", "lilac", 1500, "male", "masculine","Naboo","Mirialan", "Attack Of The Clones","Tsmeu-6 personal wheel bike","strongest onuristik starship" )) 

#question 5


onurbmi<-cbind(onur ,BMI=c(strtoi(onur$mass)/((strtoi(onur$height)/100)*(strtoi(onur$height)/100))))


onurbmi<-onurbmi %>% 
  mutate(BMIC=cut(BMI,breaks=c(-Inf,18.5,24.99,29.99, Inf),labels=c("underweight","healthy","overweight","obese")))

#question 6

a<-filter(onurbmi, strtoi(onurbmi$birth_year)<100)

ggplot(data = a)+
  geom_point(mapping = aes(x=birth_year,y=BMIC))

#question 7

ggplot(data = a)+
       geom_point(mapping = aes(x=strtoi(birth_year), y=BMI))+
       geom_smooth(mapping = aes(x=strtoi(birth_year), y=BMI))

