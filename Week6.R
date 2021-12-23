library(tidyverse)

# to convert a data frame to a tibble
as_tibble(iris)

# to create a tibble
tibble(
  x = 1:5,
  y = 1,
  z = x ^ 2 + y
)

# with using ``, any kind of column names can be created
tb <- tibble(
  `:)` = "smile",
  ` ` = "space",
  `2000` = "number"
)
tb

# another way to create a tibble
tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)

# to print more output than the default display
nycflights13::flights %>%
  print(n = 10, width = Inf)

# to print more output than the default display
options(tibble.print_min = 15, tibble.width = 100)
nycflights13::flights


df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
# Extract by name
df$x
df[["x"]]
# Extract by position
df[[1]]

# To use these in a pipe, use the special placeholder .
df %>% .$x
df %>% .[["x"]]


x1 <- c("Dec", "Apr", "Jan", "Mar")

x2 <- c("Dec", "Apr", "Jam", "Mar")  

# sorting alphabetically
sort(x1)

# to create a factor
month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)
y1 <- factor(x1, levels = month_levels)
y1

# sorting correctly
sort(y1)

# any values not in the levels will be NA
y2 <- factor(x2, levels = month_levels)
y2

# to check whether there is an error, use parse_factor
y2 <- parse_factor(x2, levels = month_levels)

# omiting levels
factor(x1)

# date and time
library(lubridate)

# To get the current date or date-time 
today()
now()

# to create a date from strings
ymd("2021-11-25")
mdy("November 25th, 2021")
dmy("25-Nov-2021")
ymd(20211125)

# to create a date-time from a string
ymd_hms("2021-11-25 13:45:59")
mdy_hm("11/25/2021 13:46")


library(nycflights13)
flights %>%
  select(year, month, day, hour, minute)

# To create a date/time from multiple columns, use make_date() for dates, or make_datetime() for date-times:
flights %>%
  select(year, month, day, hour, minute) %>%
  mutate(
    departure = make_datetime(year, month, day, hour, minute)
  )

# to pull out individual parts of the date, use functions like year, month, hour, etc.
datetime <- ymd_hms("2021-11-25 13:54:56")

year(datetime)
month(datetime)
mday(datetime)
yday(datetime)
wday(datetime)
hour(datetime)

# to get the name of month or day, use label = TRUE and to get the full name set abbr = FALSE
month(datetime, label = TRUE)
wday(datetime, label = TRUE, abbr = FALSE)


# to set the components of a date/time, use year, month functions.
year(datetime) <- 2021
datetime
month(datetime) <- 12
datetime
hour(datetime) <- hour(datetime) + 1
datetime

# to set multiple values at once, use update()
update(datetime, year = 2021, month = 2, mday = 2, hour = 20)

# If values are too big, it will be rolled over
ymd("2015-02-01") %>%
  update(mday = 30)
ymd("2015-02-01") %>%
  update(hour = 400)

# The age of our university, 
Uni_age <- today() - ymd(19731130)
Uni_age

as.duration(Uni_age)

# to contruct a date/time, use period functions
seconds(15)
minutes(10)
hours(c(12, 24))
days(7) 
months(1:6)
weeks(3)
years(1)

# we can add and multiply periods
10 * (months(6) + days(1))
days(50) + hours(25) + minutes(2)


