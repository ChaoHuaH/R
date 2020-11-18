
# using Regression to evaluate the efficiency of promotions. ####

# Model ####
# Y: log(sales)
# X: control variables
# MM: promotions (set dummy)
# log(Y) = b +aX + m*MM(promotion)

# Explanation ####
# if Pormotion then MM = 1; no promo then MM = 0

# regresion model: log(Y) = b + aX + m*MM
# fix X = x, with promotion MM = 1, without promotion MM = 0
# compare the sales
# w/  promo: log(Y1) = b +a*x + m*1 = b+a*x +m
# w/o promo: log(Y2) = b +a*x + m*0 = b+a*x
# -------------------------------------------------(deduct)
# log(Y1) - log(Y2) = m
# log(Y1/Y2) = m
# exp() >>> Y1/Y2 = exp(m)
# the sale in promotion = the sale w/o promotion times exp(m)
# sales(MM1) = sales(no Pormo)*exp(m)


load("Analysis/PromotionEfficiency.Rdata")

# fit the regression model
fit = lm(log(QTY) ~ WEEKDAY + MM, data = promo)
(m1 = summary(fit))

# estimate
b1 = m1$coef[,1] # coefficient estimate
se.b1 = m1$coef[,2] # standard dev
ci = data.frame(cbind(b1, se.b1))

ci$cil = b1 - se.b1*qt(0.975, m1$df[2])  # lower bond of 95% Confidcne interval
ci$ciu = b1 + se.b1*qt(0.975, m1$df[2])  # upper bond of 95% Confidcne interval)


# take exp()
exp(ci["MM1",-2])
#          b1      cil      ciu
# MM1 1.176075 1.109168 1.247019

# b1 = estimate of promotion efficiency
# in this case means sales w/ mm is 1.18 times of sales w/o mm

# (cil, ciu) the estimate interval of the promotion
# 95% confidence that real efficiency is between (1.11, 1.25)




