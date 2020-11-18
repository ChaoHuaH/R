
# basic ####

# turn data variables into a contingency table
table(dat)
xtabs(formula, dat)

# Splits the data into subsets
# computes summary statistics for each, and returns the result in a convenient form
aggregate()

# group data, derive new variables, similar to aggregate()
tapply()

# apply func to column or row: apply(X, MARGIN, FUN)
apply(dat,1,mean) # by row
apply(dat,2,mean) # by column
apply( dat,2,mean(x[x>0]) )

sapply(x,f) # return vector
lapply(x,f)	# return list

# grouping by indices, and apply to FUN, similar apply
by(data, INDICES, FUN)

# repeat expr
replicate(n, expr)
# compare rep() and replicate()
rep(sample(1:9, 2, replace = T),2)
replicate(2, sample(1:9, 2, replace = T)) # repeat the action but not produce same values

# sum/avg of column and row
# na.rm = T means ignore NA
colSums (x, na.rm, dims)
rowSums ( )
colMeans( )
rowMeans( )

# examine two data set
match()

# sort
# return the value
sort(c(3,2,1,7))
# return the order of the value in the vector
rank(c(3,2,1,7))
# return the position of the valuein vector
order(c(3,2,1,7))

# conbine table
merge(x,y)

# add vector to row/ column
cbind() # add column
rbind() # add row

# get subset: subset(x, select = -c())
subset( data, select = -c(iden, name, x_serv, m_serv) )


# missing values ####

# if x include NA, then return Error
# if not, then return x
na.fail(x)
# keep NA
na.pass(x)
# exclude NA
na.omit(x)
na.exclude(x)	# when using func: lm(), automatically add NA
# examine is NA or not, return TRUE of FALSE
is.na(x)
# can apply in some func, remove NA when calculate
na.rm = T


# pkg: dplyr ####
library(dplyr)

# pipe: %>%
data %>% select(V1, V2)
data %>% group_by(V2) %>%
  summarise(size_g = n(), m_V3 = mean(V3), s_V1 = sum(V1))

# filter: filter(dat, dots)
filter(dat, V1 == 8)
filter(dat, V1 < 6 & V2 == 1)

# data sort: arrange(dat, dots)
# dat[order(dat$COUNT, decreasing = T),]
arrange(dat, desc(COUNT))

# select partial columns: select(dat, dots)
# dat[, c("V1","V2")]
select(dat, V1, V2)

# create columns: mutate(dat, dots)
mutate(dat, new = V1/sum(V1))

# Group a tbl by one/more variables: group_by(dat, …, add = FALSE)
by.type = group_by(dat, V1)

# Summarise multiple values to a single value: summarise()
summarise(by.type, n = n(),
          counts = sum(COUNT))	# can go with group_by()

# draw n samples
sample_n(dat, n)

# draw p% of sample
sample_frac(dat, p)


# pkg: reshape ####
# transformation btwn 'wide' format and 'long' format
library(reshape)

# wide >> long: melt(dat, id, measure.vars)
melt(mydata, id=c("id","time"))
# aggregate the melted table: cast(dat, formula, fun)
cast(mdata, id~variable, mean)


# string ####

# paste strings: paste()
paste("A","B",sep="")

# split the string: strsplit()
strsplit("A.B",split=".",fixed=T)

# filter the string
# ignore.case = F ignore Case
grep(pattern, text, ignore.case) # return which
grepl( ) # return T or F

# return position of string pattern
regexpr(pattern,text,ignore.case) # retrun vector
gregexpr( ) # return list
x = c("B","AAA","CCB", "BcB", "cBBb")
regexpr("B",x)  # 1 -1  3  1  2

# subset of string: substr()
substr("human123456",start=1,stop=5)

# replace w/ specific chac: sub()
x = "AABB"
sub("A", replacement = "C", x)

# replace all: gsub()
x = "AABB"
gsub("A", replacement = "C", x)

# calculate number of the characters: nchar()
x = c("A","AAA","AAAAA")
nchar(x)

# paste char in matrix
x = matrix(letters[1:6],2,3)
apply(x,1,paste,collapse="")
apply(x,2,paste,collapse="")

# reverse the string
x = c("A B","*.")
sapply(lapply(strsplit(as.character(x), NULL), rev), paste, collapse="")

# check the char
x = c("A B","*.")
unique(unlist(strsplit(as.character(x), split="",fixed=T)))





















