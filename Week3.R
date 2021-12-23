# to clear the console click CTRL+L

install.packages("tidyverse")
library(tidyverse)   # collection of some R packages (ggplot2, tibble, tidyr,..)

mpg  # data contain observations collected 
     # by the US Environment Protection Agency on 38 models of cars

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))


ggplot(data = mpg)  # shows nothing

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# size aesthetic
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# alpha aesthetic
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# shape aesthetic
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# pick a color for all points, important! this property should be written 
# outside the aes(). 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# + sign should be at the end of the first line. If not, you'll get an error.
ggplot(data = mpg)
+ geom_point(mapping = aes(x = displ, y = hwy))

# use of facets, i.e. subplots
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

# subplots on the combination of two variables, type of drive train and 
# number of cylinders
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# to get a smooth line fitted the data
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# to separate data into parts based on a variable (drv). 
# Different linetypes represent the levels of the variable.
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# Different colors represent the levels of the variable
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))

# to display multiple geoms in the same plot
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# to avoid duplication in the code
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

# to display different aesthetics in different layers
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

# different display (if se = FALSE, we have only line without confidence limits)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE
  )

# to draw a bar chart
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

# to colorize bar chart
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))
           

# to display two variables in a bar chart
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

# instead of using a stacked bar, use position adjustment
# identity position is not very useful due to overlapping
# to minimize the effect of overlapping, use small values of alpha
ggplot(
  data = diamonds, mapping = aes(x = cut, fill = clarity) ) +
  geom_bar(alpha = 1/5, position = "identity")
# or completely transparent by setting fill = NA.
ggplot(
  data = diamonds, mapping = aes(x = cut, color = clarity) ) +
  geom_bar(fill = NA, position = "identity")

# fill position works like stacking, but it converts the counts to proportions
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# dodge position places objects beside one another.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity),position = "dodge")



# to draw boxplot
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
# to flip the coordinates of a box plot
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

