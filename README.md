# Rstudio-Star-wars
R language projects
PROJECT 1 starship.R:

With using “starwars” tibble in dplyr package, please answer the following questions:

How many characters do have at least one starship? List the names of the characters having at least one starship.
Get the frequencies of the eye color of the characters. Rank them from most to least.
According to the data available, what are the mean (average) age values across each species? Find the 3 oldest species. Note that in the data, there is no age column, instead there is a birth_year column. This column represents how many years before the Battle of Yavin the character was born. So take this column as the ages of characters at the Battle of Yavin and calculate the mean.
Create a new data set by adding a new observation to this data. This observation should be based on your own character (your name or nickname, your weight and height, your homeworld, your starships etc). Note that you can pick one or more than one Star Wars films in which you played as a movie star.
Calculate the body mass index (BMI) values (dividing the mass value in kg to the square of the height value in meter) for all observations and categorize the observations as underweight (BMI below 18.5), healthy (BMI between 18.5-24.99), overweight (BMI between 25.0-29.99) and obese (BMI above 30.0). Add these two variables to your new data created at the 4th question.
Plot the distribution of ages less than 100 by BMI groups. (i.e. use filter function to select the ages less then 100)
By plotting a graph, show the relationship between age and BMI values (use point and line at the same time). Re-plot the same graph after filtering the data as both age and BMI less than 100.


PROJECT 2

set.seed allows the user to set the initial seed for variate generators. Use your student id as a seed number. You should write set.seed(your student id) at the beginning of your code. For example if your student id is 2020555001 then write set.seed(2020555001). This will provide that everyone has different generated numbers from each other.

Save your codes for part 1 and part 2 in two different R files.

Part 1

Save the attached file (covid-data-2020) as an Excel file (.csv, .xls or .xlsx format), then import this data to R. (You can supply an inline CSV file instead of importing, if you like).

Take a random sample of 1000 observations from this data (you can use sample() function), and save this sample as a new data. Answer the following questions using this sample.

Calculate the five-number summary statistics (minimum-Q1-median-Q3-maximum) of covid-19 daily new cases for each country within each month. (you can use quantile() function to get the quartiles)
Find the highest daily cases and deaths separately for each country. 
Identify the month in which the mean daily cases is the highest for each country.
Select 3 country and plot the distribution of daily cases by month. Use location as clusters (i.e., color=location) to show the difference between countries.
 

Part 2

Answer the following questions by using the sentences, which are provided in stringr::sentences.

Take a random sample of 100 sentences from this data, then split these sentences into words and take each word as a member of a vector. After removing duplicated words (you can use unique() function to remove duplicated words), save this sample as a new data. With this new data, provide the answers for
Find words which are starting with “a” and ending with “e”.
Calculate the number of words which have more than 3 vowels.
List the five longest word in your data
Try to find word(s) which contain any of these words: age, any, day, exp, her, pro, the.
