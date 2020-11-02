# Use Boxplot to identify outliers.
# when qi beyond (Q1-IQR*1.5, Q3+IQR*1.5), then qi = outlier
# return data frame which outliers removed
# data_set: data frame with column QTY
# rm: whether to remove outliers.
# rate: default 1.5

Box_outlier = function(data_set, rm = TRUE, rate = 1.5){
  lower_bound = stats::quantile(data_set$SALE_QTY, 0.25) - rate*stats::IQR(data$SALE_QTY)
  upper_bound = stats::quantile(data_set$SALE_QTY, 0.75) + rate*stats::IQR(data$SALE_QTY)

  if(rm == TRUE){
    data = data_set[which(data_set$SALE_QTY>= lower_bound &
                        data_set$SALE_QTY <= upper_bound),]
  } else { data_set = data_set }

  return(data_set)
}
