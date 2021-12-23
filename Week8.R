library(tidyverse)

string1 <- "This is a string"
string2 <- 'To put a "quote" inside a string, use single quotes'
string2

"This is a string without a closing quote"

?'"'


x <- "\u00b5"
x

c("one", "two", "three")

str_length(c("a", "R for data science", NA))

str_c("x", "y")
str_c("x", "y", "z")

str_c("Letter", letters, sep = ": ")

x <- c("abc", NA)
str_c("|-", x, "-|")
str_c("|-", str_replace_na(x), "-|")

str_c("prefix-", c("a", "b", "c"), "-suffix")

name <- "Data"
time_of_day <- "afternoon"
birthday <- FALSE
str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY",
  "."
)

str_c(letters, collapse = "")

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)

str_sub("a", 1, 5)

str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x

str_to_upper(x)

str_to_upper(c("i", "ı"))
str_to_upper(c("i", "ı"), locale = "tr")

x <- c("inci", "ışık", "ıslak")
str_sort(x, locale = "en") # English
str_sort(x, locale = "tr") # Turkish

x <- c("apple", "banana", "pear")
str_view(x, "an")

str_view(x, ".a.")

str_view(c("abc", "a.c", "bef"), "\\.")

x <- "a\\b"
str_view(x, "\\\\")

x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")


x <- c("apple", "banana", "pear")
str_detect(x, "e")

sum(str_detect(words, "^t"))
mean(str_detect(words, "[aeiou]$"))


no_vowels_1 <- !str_detect(words, "[aeiou]")
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")
identical(no_vowels_1, no_vowels_2)

words[str_detect(words, "x$")]
str_subset(words, "x$")

df <- tibble(
  word = words,
  i = seq_along(word)
)
df %>%
  filter(str_detect(words, "x$"))


x <- c("apple", "banana", "pear")
str_count(x, "a")

mean(str_count(words, "[aeiou]"))

df %>%
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )

str_count("abababa", "aba")
str_view_all("abababa", "aba")



colors <- c("red", "orange", "yellow", "green", "blue", "purple")
color_match <- str_c(colors, collapse = "|")
color_match

has_color <- str_subset(sentences, color_match)
matches <- str_extract(has_color, color_match)
head(matches)


more <- sentences[str_count(sentences, color_match) > 1]
str_view_all(more, color_match)
str_extract(more, color_match)

str_extract_all(more, color_match)

str_extract_all(more, color_match, simplify = TRUE)
x <- c("a", "a b", "a b c")
str_extract_all(x, "[a-z]", simplify = TRUE)


noun <- "(a|the) ([^ ]+)"
has_noun <- sentences %>%
  str_subset(noun) %>%
  head(10)
has_noun %>%
  str_extract(noun)

has_noun %>%
  str_match(noun)


tibble(sentence = sentences) %>%
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ ]+)",
    remove = FALSE
  )

has_noun %>%
  str_match_all(noun)


x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")
str_replace_all(x, "[aeiou]", "-")

x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

sentences %>%
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>%
  head(5)

head(sentences,5)

sentences %>%
  head(5) %>%
  str_split(" ")


"a|b|c|d" %>%
  str_split("\\|") %>%
  .[[1]]

sentences %>%
  head(5) %>%
  str_split(" ", simplify = TRUE)


fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>% str_split(": ", n = 2, simplify = TRUE)


x <- "This is a sentence. This is another sentence."
str_view_all(x, boundary("word"))
str_split(x, " ")[[1]]
str_split(x, boundary("word"))[[1]]


str_view(fruit, "nana")
str_view(fruit, regex("nana"))

bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")
str_view(bananas, regex("banana", ignore_case = TRUE))


phone <- regex("
\\(?           # optional opening parens
(\\d{3})    # area code
[)- ]?         # optional closing parens, dash, or space
(\\d{3})    # another three numbers
[ -]?          # optional space or dash
(\\d{2})   # two more numbers
[ -]?         # optional space or dash
(\\d{2})   # two more numbers
", comments = TRUE)
str_match("532-123-4567", phone)
str_match("(532)9876543", phone)

