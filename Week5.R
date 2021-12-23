library(tidyverse)


# visualize the distribution of a categorical variable
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

# how many observations occured with each category
diamonds %>%
  count(cut)

# To examine the distribution of a continuous variable
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

# Calculate the height of the bars in a histogram
diamonds %>%
  count(cut_width(carat, 0.5))

# explore a variety of binwidths
smaller <- diamonds %>%
  filter(carat < 3)
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

# to understand overlapping lines than bars:
ggplot(data = smaller, mapping = aes(x = carat, color = cut)) +
  geom_freqpoly(binwidth = 0.1)

# sometimes hard to see outliers
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5)

# To make it easy to see the unusual values, use coord_cartesian() to zoom in
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))

# to get the outliers
unusual <- diamonds %>%
  filter(y < 3 | y > 20) %>%
  arrange(y)
unusual

# to deal with outliers, option 1: drop the entire row
diamonds2 <- diamonds %>%
  filter(between(y, 3, 20))

# to deal with outliers, option 2: replace outliers with NA
diamonds2 <- diamonds %>%
  mutate(y = ifelse(y < 3 | y > 20, NA, y))

diamonds2 %>%
  filter(is.na(y))

# plots warn that NAs were removed
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) +
  geom_point()

# To suppress that warning, set na.rm = TRUE:
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) +
  geom_point(na.rm = TRUE)


# to compare the scheduled departure times for cancelled and noncancelled times
nycflights13::flights %>%
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>%
  ggplot(mapping = aes(sched_dep_time)) +
  geom_freqpoly(
    mapping = aes(color = cancelled),
    binwidth = 1/4
  )

# explore how the price of a diamond varies with its quality:
ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)

# hard to see the difference in distribution because the overall counts differ so much:
ggplot(diamonds) +
  geom_bar(mapping = aes(x = cut))


# Instead of displaying count, to display density
ggplot(data = diamonds,mapping = aes(x = price, y = ..density..)) +
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)

#  distribution of continuous variable by categorical variable 
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()

# when a categorical variable is not ordered variable, plot may be hard to interpret
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

# To make the trend easier to see, use reorder()
ggplot(data = mpg) +
  geom_boxplot(
    mapping = aes(
      x = reorder(class, hwy, FUN = median),
      y = hwy
    )
  )

# To visualize the covariation between categorical variables
  ggplot(data = diamonds) +
    geom_count(mapping = aes(x = cut, y = color))

# to compute the count
  diamonds %>%
    count(color, cut)

# to visualize the covariation with a different plot
  diamonds %>%
    count(color, cut) %>%
    ggplot(mapping = aes(x = color, y = cut)) +
    geom_tile(mapping = aes(fill = n))
  
# To visualize the covariation between continuous variables
ggplot(data = diamonds) +
    geom_point(mapping = aes(x = carat, y = price))

# to see overplotted points use alpha
ggplot(data = diamonds) +
  geom_point(
    mapping = aes(x = carat, y = price),
    alpha = 1 / 100
  )

# bin one continuous variable so it acts like a categorical variable
ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))

# to display approximately the same number of points in each bin
ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))

