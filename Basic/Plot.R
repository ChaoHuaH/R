

# indep func ####
# each func can draw a complete plot

# plot()
# use different parameters to draw different plots
# scatter plot of x and y
# x, y are all vector; xy is a two column matrix
plot(x,y); plot(xy)
# x is time series variable, then draw a time series plot
# x is vector, then draw x = element order * y = elements' value
plot(x)
# f is factor, then draw a bar chart
plot(f)
# f is factor, y is a vector of number w/ same length
# Vertical box plot of f in axis x of category * y
plot(f,y)
# y, x1, ..., xk is vector, draw k x-y scatter plot
plot(~x1+...+xk)
# y vs x1,..., xk scatter plot
plot(y~x1+…xk)

# Draw a curve of a given function
curve()

# scatter plot
pairs()

# x-y scatter plot in given z
coplot(x~y|z)

# normal probability plot
qqnorm(x)
qqline(x) # go w/ qqnorm(x), draw the best slope
qqplot(x,y)

# other
hist()
dotplot()
barplot()
boxplot()
pie()
contour(x,y,z)
image(x,y,z)
persp(x,y,z,theta,phi,box)


# layout ####
# multiple plot in one screen
mar();mar()	# set the width of chart; mai is in ince and mar is in text
# multiple plot in one screen: mfcol(); mfrow()
par(mfcol = c(2,3))
# similar to mfrow and mfcol, but capable of asymmetrical layout
layout(M,widths,heights,respect)


# Auxiliary parameters ####
add = TURE	# overlay on previous plot (not all func can use this parameter)
axes = FALSE	# no axis
log = "x"; log = "y"; log = "xy"	#take log of x, y, xy
type = "p" # only dots
type = "l" # only line
type = "b" # Solid origin and line
type = "o" # Hollow origin and line
type = "s" # the top of the ladder
type = "S" # the bottom of the ladder
type = "h" # Draw a vertical line from the point to the horizontal axis
type = "n" # only axix
xlab = "text"; ylab = "text" # text of axis x and y
xlim = c(xmin, xmax); ylime = c()	# set max and min of axis x and y
xaxt = "n"; yaxt = "n"	# don't draw the grid
main = "text"; sub = "text"	# title and subtitle


# dependent func ####
# work on independent func
point(x,y) # add point
ine(x,y) # add line
text(x,y,text) # add text
abline(a,b) # add diagonal line, a is intercept and b is slope
abline(h = y) # add horizontal line
abline(v = x)	# add vertical line
polygon(x,y,density,angle,col)	# Draw a polygon
legend(x,y, legend = text)	# add text
title(main = "",sub = "")	# title and subtitle
axis(side,at,tick,labels)	# add extra axis



# pkg: ggplot ####
qplot()
ggplot() + geom_
ggplot() + layer

# show partial data
scale_x_continuous(limit = ) # delete points if not included
coord_cartesian(); coor_flip() # don't delete points but not show on the plot

# export plot
# when plot include chinese, svg() + dev.off() won't work
# use ggsave and family = "GB1
ggsave(plot, filename, width, height, family="GB1")
ggsave(p, file = names, width = 12, height = 10, family="GB1")

# + theme()
# remove item
element_blank()
# edit text setting
element_text(family , face , colour , size , hjust , vjust , angle , lineheight , color , margin , debug )
# edit line setting
element_line(colour , size , linetype , lineend , color )
# edit backbrounds and borders
element_rect(fill , colour , size , linetype , color )
# remove axis's title
axis.title = element_blank()
# Rotate the label on axis x
axis.text.x = element_text(angle = 90)


# color ####
# Gradient color: grDevices:: colorRampPalette(colors,...)
t1 = colorRampPalette(c("red", "blue"))
plot(rep(1,6), col = t1(6), pch = 19, cex = 3)

# display color code
scales::show_col(hue_pal()(8))











