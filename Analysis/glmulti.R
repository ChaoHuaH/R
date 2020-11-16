
# use pkg:glmulti to select best lm model ####
# return best model Y~X1+X2+X3+...

# load testing data 'mtcars'
data("mtcars")
head(mtcars)

# define the class
sapply(mtcars, class)
mtcars = dplyr::mutate(mtcars
                       , vs = factor(vs, levels = c(0,1))
                       , am = factor(am, levels = c(0,1)))


# func: best_lm ####
# data: data frame
# auto: whether apply the fun:glmulit, if FALSE then return the original model
# y: Dependent Variable
# variables: variables want to put in the model (Independent Variable)
best_lm = function(data
                 , auto = TRUE
                 , y = "qty"
                 , variables = c("X1", "X2", "X3", "X4", "X5")){

  # each variable needs to have at least two kind of values to put in model
  # NA excluded
  keepVariables = sapply(1:length(variables),
                         function(i) {
                           ifelse(length(stats::na.omit(
                             unique(data[,variables[i]]))) >=2, 1, 0)})

  variables = variables[keepVariables == 1]

  if(auto){
    selection = glmulti::glmulti(data = data, plotty = F, level = 1
                                 , stats::as.formula(
                                   paste(y, "~", paste(variables, collapse = "+")))
                                 , report = F # don't show the variables selecting process
    )
    bm = summary(selection)$bestmodel

  } else {
    bm = paste(y, "~ 1 + ", paste(variables, collapse = " + "))
  }

  return(bm)
}


## apply mtcars to best_lm
fit1 = best_lm(data = mtcars,
               y = "mpg",
               variables =
                 c("cyl", "disp", "hp", "drat", "wt",
                   "qsec", "vs", "am", "gear", "carb")
               )
fit2 = best_lm(data = mtcars,
               auto = FALSE,
               y = "mpg",
               variables =
                 c("cyl", "disp", "hp", "drat", "wt",
                   "qsec", "vs", "am", "gear", "carb")
)
fit3 = best_lm(data = mtcars,
               auto = FALSE,
               y = "mpg",
               variables =
                 c("cyl", "disp", "hp", "drat", "wt")
)
print(fit1)
print(fit2)
print(fit3)












