
# use two dim to determine a product's capacity
# use member card to track how customer buying a particular product
# sperad rate: how many new product = #of new customer/tot customer
# retention rate: how many repurchase customers = #of repurchase/total customer on previous stage
# use two dim's (max + min)/2 as standard
# separte different product into different category
#  X axis: Spread * Y axis: Retention
#    -----------------------
#    | Main    | Ideal     |
#    -----------------------
#    | Improve | Potential |
#    -----------------------

library(reshape)
library(ggplot2)
library(scales)

# calculate the S & R ####
load("Analysis/ProductPower.Rdata")

# column class
# make sure the column date is Date
ProductPower$date = as.Date(ProductPower$date, "%Y%m%d")
sapply(ProductPower, class)
#    shop_no     card_no        date  product_no         qty
# "character" "character"      "Date" "character"   "integer"

# set the parameters
data = ProductPower
start_date = min(unique(data$date))
end_date = max(unique(data$date))
TimeInterval = "week"

# build the time zone index
index.time.zone = data.frame(
  start = seq(from = start_date, to = end_date, by = TimeInterval)  )
index.time.zone$end = c((index.time.zone$start -1)[-1], end_date)
index.time.zone$time.zone = paste("zone", seq(1, length= nrow(index.time.zone)), sep = "")

# mapping time.zone to data
data$time.zone = 0
j = 1
for (j in 1: nrow(index.time.zone)){
  data$time.zone[
    which(index.time.zone$start[j] <= data$date &
            data$date <= index.time.zone$end[j])] =
    index.time.zone$time.zone[j]
  j = j+1
}

# qty consumed in each time zone (by product_no)
data = cast(data[,c("product_no", "card_no", "time.zone", "qty")], product_no+card_no~time.zone, sum)



# func: SprRet ####
# calculate one item's spread and retention rate
# data: data frame with columns as follow (first 2 columns are necessity)
## product_no card_no zone1 zone2 zone3 zone4 zone5 zone6 zone7 zone8
##    1111       1     1     0     0     0     0     0     0     0
# product_no
SprRet = function(data, product_no)
{
  temp = data[which(data$product_no == product_no),-c(1,2)]

  tt = proc.time()
  ### calculate spread = # of new customers/ # of total cutomer
  t = 2
  spread = NULL
  for (t in 2:dim(temp)[2]){

    if(t == 2){
      new.cus = length(which(temp[,1] == 0 & temp[,t] != 0 ))
    } else {
      new.cus = length(which( rowSums(temp[,1:(t-1)]) == 0 & temp[,t] != 0 ))
    }

    total.cus.t2 = length(which(temp[,t] != 0))

    spread = c(spread, round((new.cus/total.cus.t2)*100,2))

    t = t+1

  }

  ### calculate retention =  # of repurchase/ # of total cutomer(previous zone)
  t = 2
  retention = NULL
  for (t in 2:dim(temp)[2]){

    repurchase = length(which(temp[,(t-1)] != 0 & temp[,t] != 0))

    total.cus.t1 = length(which(temp[,(t-1)] != 0))

    retention = c(retention,round((repurchase/total.cus.t1)*100,2))

    t = t+1

  }


  ### calculate qty (each zone)
  t = 2
  qty = NULL
  for(t in 2:dim(temp)[2]){

    qty = c(qty, sum(temp[,t]))
    t = t+1

  }

  print("spreads, retentions and qty consumed are calculated :D ")
  print(proc.time() -tt )

  return(list(Spread = spread, Retention = retention, Qty = qty))

}

# apply func:SprRet to calculate many products at once
productList = c("1111", "2222", "3333", "4444", "5555", "6666", "7777")

output = list(SprRet(data, product_no = productList[1]))
i = 2
for(i in 2:length(productList)){

  output[i] = list(SprRet(data, product_no = productList[i]))

  i = i+1
}
names(output) = productList


# plot ####
## arrange the data for ploting
output2 = data.frame()

j = 1
for(j in 1:length(output[[1]]$Spread)){

  a = data.frame()
  i = 1
  for(i in 1: length(output)){
    a = rbind(a, data.frame(item.name = names(output)[i],
                            spread    = output[[i]]$Spread[j],
                            retention = output[[i]]$Retention[j],
                            qty       = output[[i]]$Qty[j])
    )
    i = i+1
  }

  a$time.zone = j
  output2 = rbind(output2,a)
  j = j+1
}

# calcualte the mid (standard line)
max.sp = max(output2$spread, na.rm = T)
min.sp = min(output2$spread, na.rm = T)
v = (min.sp+max.sp)/2
max.re = max(output2$retention, na.rm = T)
min.re = min(output2$retention, na.rm = T)
h = (min.re+max.re)/2
# ggplot
ggplot(output2, aes(x = spread, y = retention)) +
  geom_point(
    aes(colour = item.name, size = qty, alpha= factor(rescale(time.zone, c(0.8,1))) )
  ) +
  geom_vline(xintercept = v) +
  geom_hline(yintercept = h) +
  theme(
    plot.title = element_text(vjust = -62, hjust = 1),
    legend.title = element_text(size = 14, face = "plain"),
    legend.text  = element_text(size = 14),
    axis.title  = element_text(size = 16),
    axis.text   = element_text(size = 14),
    panel.background = element_rect(fill = "white", colour = "black"),
    aspect.ratio=1/1.8
  ) +
  # adjust the size of legend symbol
  guides(
    shape=guide_legend(override.aes=list(size=5)),
    colour = guide_legend(order = 1)
  ) +
  labs(x = "Spread(%)", y = "Retention(%)")  +
  # raise the size and set the legend breaks
  scale_size_continuous(range = c(10,30), "Qty", breaks=c(500, 2000, 20000, 70000))  +
  # assign the colors
  scale_colour_manual(values = c("red3", "orange", "forestgreen",
                                 "blue4", "magenta4", "purple", "blue"),
                      "Product") +
  # time.zone
  scale_alpha_discrete(labels = c(1:7), "Time_zone") +
  scale_x_continuous(limits=c(min.sp-0.5,max.sp+0.5)) +
  scale_y_continuous(limits=c(min.re-0.5,max.re+0.5))










