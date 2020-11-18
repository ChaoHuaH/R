

# load testing data 'mtcars'
data("mtcars")

# define the class
sapply(mtcars, class)
mtcars = dplyr::mutate(mtcars
                       , vs = factor(vs, levels = c(0,1))
                       , am = factor(am, levels = c(0,1)))


# cart tree ####
library(rpart)
library(rpart.plot)
library(dplyr)
cart.model = rpart(formula = mpg ~ cyl + disp + hp + drat + wt +
                              qsec + vs + am + gear + carb,
                    data = mtcars)

rpart.plot(cart.model         # model
           , faclen=0         # no abbreviation
           , fallen.leaves= T
           , type = 5
           , cex = 0.8
           # , shadow.col="gray"
           # number of correct classifications / number of observations in that node
)

# summary(cart.model)

# prediction
# in normal situation, testing data should come from different data set
test = mtcars[1:10,]
test = mutate(test
              , pred = predict(cart.model, newdata=test)
              , resid = pred - mpg
              , abs.resid = abs(resid)
)
# mape
sum(test$abs.resid)/sum(test$mpg)



# random Forest ####
library(randomForest)
library(dplyr)
tuneRF(mtcars[,-1], mtcars[,1])
# mtry = 3  OOB error = 6.149241
# Searching left ...
# mtry = 2 	OOB error = 5.872584
# 0.04499035 0.05
# Searching right ...
# mtry = 6 	OOB error = 6.404196
# -0.04146133 0.05
# mtry OOBError
# 2    2 5.872584
# 3    3 6.149241
# 6    6 6.404196

rf_model = randomForest(formula = mpg ~ cyl + disp + hp + drat + wt +
                          qsec + vs + am + gear + carb,
                        na.action = na.omit,importance = TRUE,
                        data = mtcars,
                        ntree = 100, mtry = 2
)

print(rf_model)
data.frame(importance(rf_model))
varImpPlot(rf_model)

plot(rf_model)

# prediction
test = mtcars[1:10,]
test = mutate(test
                   , pred = predict(rf_model, newdata=test, type = "class")
                   , resid = pred - mpg
                   , abs.resid = abs(resid)
)
# mape
sum(test$abs.resid)/sum(test$mpg)











