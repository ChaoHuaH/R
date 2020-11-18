
# comparison between base r and dplyr ####
library(dplyr)
data("mtcars")


# Filtering rows ####
#base r
mtcars[mtcars$vs == 1 & mtcars$am == 0,]
#dplyr
filter(mtcars, vs == 1, am == 0)

# Arranging and ordering ####
#base r
mtcars[order(mtcars$mpg, decreasing = TRUE),]
#dplyr
arrange(mtcars, desc(mpg))

# Selecting columns ####
#base r
mtcars[, c("mpg", "cyl")]
#dplyr
select(mtcars, mpg, cyl)

# Creating new columns ####
#base r
mtcars$new_column1 = mtcars$mpg*3
#dplyr
mtcars = mutate(mtcars,
                new_column2 = mpg*3)

# Aggregation and summarization ####
#base r
summary1 = aggregate(mpg ~ am,
                     data = mtcars,
                     FUN = sum)
summary2 = aggregate(mpg ~ am,
                     data = mtcars,
                     FUN = length)
summary.mtcars = merge(summary1, summary2,
                              by = "am")
#dplyr
by.type = group_by(mtcars, am)
summary.mtcars = summarise(by.type,
                           num.types = n(),
                           counts = sum(mpg),
                           .groups = 'drop')





