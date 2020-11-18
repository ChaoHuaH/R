

# RODBC ####
# connect R and SQL w/ RODBC
library(RODBC)

# channel for R and SQL
# Create data source at ODBC Data Source Administrator
odbcConnect()

# import data from SQL to R
# * as.is = TRUE匯入格式為char.
sqlFetch(channel, sqtable)  # whole table
sqlQuery(channel, query)	  # SQL query

# Rdata to SQL
sqlSave(channel, dat, tablename,
        rownames = F, colnames = F, safer = F, fast = T)

# close ODBC channel
close(channel)


# ROracle ####
# connect to Oracle
# need to install ROracle, can't use R install package
library(ROracle)
library(DBI)

# assign to use Oracle
drv = dbDriver("Oracle")
con = dbConnect(drv, "account", "password", "DB name")

# insert data
data = dbGetQuery(con, "sql.code")













