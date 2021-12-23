install.packages("nycflights13")

library(nycflights13)
library(tidyverse)
flights


# to get subset observations based on their values, use filter().
filter(flights, month == 1, day == 1)
# to assign the result to a variable
jan1 <- filter(flights, month == 1, day == 1)
# to print the result  of the assignment, use ()
(dec25 <- filter(flights, month == 12, day == 25))

# the easiest mistake to make is to use = instead of ==
filter(flights, month = 1)

# Boolean operators can be used
filter(flights, month == 11 | month == 12)
# %in% can be used for selection
nov_dec <- filter(flights, month %in% c(11, 12))
# De Morgan’s law, !(x | y) is the same as !x & !y
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# arrange() works similarly to filter() except that instead of selecting
# rows, it changes their order
arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))

# Missing values (NA) are always sorted at the end
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

# to get a subset of data using operations based on the names of the variables, use select()
select(flights, year, month, day)
select(flights, year:day)  # same as the previous one. 
# selecting all columns except those from year to day 
select(flights, -(year:day))

# to rename variables, use rename()
rename(flights, tail_num = tailnum)

# to move variables to the start of the data frame use everything()
select(flights, time_hour, air_time, everything())

# to add new columns to data set, use mutate()
flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
)
# created columns can be used for creating new ones.
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)
# to keep only the new variables, use transmute()
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

# to collapses a data frame to a single row, use summarize()
summarize(flights, delay = mean(dep_delay, na.rm = TRUE))
# to get the average delay per date
by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))
# to explore the relationship between the distance and average delay for each location
by_dest <- group_by(flights, dest)
delay <- summarize(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
# to see the relationship between distance and delay 
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# to omit Honolulu which is too far from NY.
delay <- filter(delay, count > 20, dest != "HNL")
# to see the relationship between distance and delay 
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# same commands with using pipe property ( %>% )
delays <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")

# to see the relationship between distance and delay 
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

# including NAs in the calculation
flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

# excluding NAs
flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay, na.rm = TRUE))

# removing the cancelled flights
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))
# getting the average value of the delays for all dates
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

# using logical subsetting
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    # average delay:
    avg_delay1 = mean(arr_delay),
    # average positive delay:
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )

# to get standard deviation of the distance
not_cancelled %>%
  group_by(dest) %>%
  summarize(delay_mean = mean(arr_delay), delay_sd = sd(arr_delay)) %>%
  arrange(desc(delay_sd))


# having the number of flights to a specific destination
not_cancelled %>%
  count(dest)

# having the number of the flights left before 5 am
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(n_early = sum(dep_time < 500))

# Grouping by multiple variables
daily <- group_by(flights, year, month, day)
(per_day <- summarize(daily, flights = n()))

(per_month <- summarize(per_day, flights = sum(flights)))
(per_year <- summarize(per_month, flights = sum(flights)))

# ungrouping the data
daily %>%
  ungroup() %>% # no longer grouped by date
  summarize(flights = n()) # all flights

# finding the worst members of each group
flights %>%
  group_by(year, month, day) %>%
  arrange(desc(arr_delay)) %>%
  select(year,month,day,dest,dep_delay,arr_delay)

# finding the popular destinations
popular_dests <- flights %>%
  group_by(dest) %>%
  filter(n() > 365) %>%
  select(year,month,day,dest,dep_delay,arr_delay)
popular_dests

# standardizing the number of delays to compare destinations
popular_dests %>%
  filter(arr_delay > 0) %>%
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  arrange(desc(prop_delay))

# adding a row to a tibble
df <- tibble(x = 1:3, y = 3:1)
df %>% add_row(x = 4, y = 0)
df %>% add_case(x = 4, y = 0)
df %>% rows_insert(tibble(x = 4, y = 0))

# You can specify where to add the new rows
df %>% add_row(x = 4, y = 0, .before = 2)

# deleting a row from a tibble
df %>% rows_delete(tibble(x=3))
#  filter() is more useful for omitting rows
df %>% filter(x!=3)


# to convert from numeric to categorical, use cut() function
cat_flights<-flights %>% 
  mutate(delay_gr=cut(arr_delay,breaks=c(-Inf,0,Inf),labels=c("Early arrivals","Delayed arrivals"))) %>%
  select(dest,delay_gr)

# to get the count of levels of a factor
gather(cat_flights,dest,delay_gr) %>%
  count(dest,delay_gr) %>%
  spread(delay_gr,n,fill=0)



