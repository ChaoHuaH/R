# dip test: qty is unimodal or non-unimodal
## H0:unimodal
library(diptest)
diptest.p = dip.test(data$qty)$p.value

# ANOVA: test mean
## H0: the means of different types qty are the same
aov.p = summary(stats::aov(data = data, qty~type))[[1]][[1,"Pr(>F)"]]









