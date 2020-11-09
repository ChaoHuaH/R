
# Use Boxplot method to detect outliers. ####
# when qty beyond (Q1-IQR*rate, Q3+IQR*rate), then qty = outlier
# return data frame (outliers removed)

# create test data
data = data.frame(id = 1:1000,
                  qty = round(rnorm(1000, mean = 10, sd = 2),0))
# add some outliers
data = rbind(data,
             data.frame(id = 1001:1003,
                        qty = c(-2, 66, 133)))
# hist(data$qty, breaks = seq(from = -5, to = 150, by = 2))

# func: Box_outlier ####
# data: data frame with column qty
# rm: whether to remove outliers.
# rate: default 1.5
Box_outlier = function(data, rm = TRUE, rate = 1.5){
  lower_bound = stats::quantile(data$qty, 0.25) - rate*stats::IQR(data$qty)
  upper_bound = stats::quantile(data$qty, 0.75) + rate*stats::IQR(data$qty)

  if(rm == TRUE){
    data = data[which(data$qty>= lower_bound &
                        data$qty <= upper_bound),]
  } else { data = data }

  return(data)
}

# apply data to Box_outlier
data_new = Box_outlier(data, rate = 3)

# compare
quantile(data$qty); sd(data$qty)
quantile(data_new$qty); sd(data_new$qty)




