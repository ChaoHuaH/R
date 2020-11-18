

# read table from outer data sources
# default as character
read.table(header, sep)

# read csv
read.csv(file, header, sep)
read.csv2()

# save as Rdata
save(data, file)

# load Rdata
load(file)

# read data, it's complicated but more efficient
scan()

# export data
write.table()
write.csv()
write.table(data, file = "")


# xlsx ####
# connect w/ Excel
# chinese need to add encoding = "UTF-8"
library(xlsx)

# export Excel
write.xlsx(x, file, sheetName, col.names, row.names, append, showNA)
# read Excel
read.xlsx(file, sheetIndex, sheetName=NULL, encoding = "UTF-8")














