

# number ####
# log, exp, log10, log2, sin, cos, tan, asin, acos, atan, abs, sqrt
log10(x)
# the smallest integer which >= x
ceiling(x)
# the biggest integer which <= x
floor(x)
# round to nth
round(x,n)
# return the integer part of x
trunc(x)
# return x with kth number
signif(0.3331, 2)

# set ####
# union of a and b
union(a,b)
# intersection of a and b
intersect(a,b)
# difference of  a and b
setdiff(a,b)
# examine whether set a and set b are equal
setequal(a,b)
# check if 12 is an element in set a
is.element(12, a)
# check if set a include set c
all(c %in% a)

# stat func ####
sum(x)
prod(x)
max(x)
min(x)
pmin(x, y) # return vector x, y' s min
pmax(x, y) # retrun vector x, y's max
range(x)
length(x)
mean(x)
median(x)
var(x); cov(x)
cor(x)	# x is data frame, then return x's correlation matrix; x is vector, then return 1
var(x,y); cov(x,y)	# Covariance matrix
cor(x,y)	# correlation coefficient
summary(x)	# min, Q1, median, mean, Q3, max, x can be vector or data frame
rev(x)	# reverse elements' order of a vector
sort(x)	# sort the elements
rev(sort(x))	# sort the elements decreasing
rank(x)	# return the rank
log(x,base)
choose(n,k)	# n!/[(n-k)!k!]
factorial(x)	# 相當於prod(1:x)














