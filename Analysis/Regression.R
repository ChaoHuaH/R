
# Fit the Model ####

# multiple Linear Regression
fit = lm(y ~ x1 + x2 + x3, data= mydata)
summary(fit)
coefficients(fit)	# model coefficients
confint(fit, level = 0.95)	# CIs for model parameters
fitted(fit)	# predicted values
residuals(fit)	# residuals
anova(fit)	# anova table
vcov(fit)	# covariance matrix for model parameters
influence(fit)	# regression diagnostics
# testing data in model
prediect(lm(Y~X1+X2, data = traingData), newdata = testingData)


# Comparing Models ####
fit1 = lm(y ~ x1 + x2 + x3 + x4, data = mydata)
fit2 = lm(y ~ x1 + x2)
anova(fit1, fit2)


# ariable Selection ####

# performs stepwise model selection by exact AIC
library(MASS)
fit =lm(y ~ x1 + x2 + x3, data = mydata)
step = stepAIC(fit, direction="both") # direction: forward, backward, both
step$anova        # data select process
summary(step)     # final model

# All Subsets Regression
library(leaps)
leaps = regsubsets(y~x1+x2+x3+x4, data = mydata, nbest = 10)
summary(leaps)
# plot a table of models showing variables in each model.
# models are ordered by the selection statistic.
# Other options for plot() are bic, Cp, and adjr2.
plot(leaps, scale="r2")
# plot statistic by subset size
# Other options for plotting with subset() are bic, cp, adjr2, and rss
library(car)
subsets(leaps, statistic="rsq")


# Cross Validation ####

# K-fold cross-validation:
DAAG:: cv.lm()

# Assessing R2 shrinkage using 10-Fold Cross-Validation: crossval()
library(bootstrap)
fit =lm(y~x1+x2+x3,data=mydata)
# define functions
theta.fit = function(x,y){lsfit(x,y)}
theta.predict = function(fit,x){cbind(1,x)%*%fit$coef}
# matrix of predictors
X = as.matrix(mydata[c("x1","x2","x3")])
# vector of predicted values
y = as.matrix(mydata[c("y")])
results =crossval(X,y,theta.fit,theta.predict,ngroup=10)
cor(y, fit$fitted.values)**2 # raw R2
cor(y,results$cv.fit)**2 # cross-validated R2


# Relative Importance	####
# provides measures of relative importance for each of the predictors in the model
library(relaimpo)
# Calculate Relative Importance for Each Predictor
calc.relimp(fit,type=c("lmg","last","first","pratt"), rela=TRUE)
# Bootstrap Measures of Relative Importance (1000 samples)
boot = boot.relimp(fit, b = 1000,
                   type = c("lmg", "last", "first", "pratt"),
                   rank = TRUE, diff = TRUE, rela = TRUE)
# print result
booteval.relimp(boot)
# plot result
plot(booteval.relimp(boot,sort=TRUE))












