# func used for flow control ####

# Message #####
#  Error
data = data.frame(x = rnorm(10), y = runif(10))
if(dim(data)[1] == 0){stop("NO Data !!! Check the data")}

data = data[-c(1:10)]
if(dim(data)[2] == 0){stop("NO Data !!! Check the data")}

# print message
message(":D")


# track the progress ####
list1 = 1:10

i = 1
total = 0
for(i in 1:length(list1)){
  svMisc::progress(i, max.value = length(list1))

  total = total + list1[i]

  i = i+1
  Sys.sleep(sample(1:3, size = 1))
}


# file & dir ####
# create dir
dir.create("FlowControl/log")

# compress file
data = data.frame(x = 1:10, y = 11:20)
write.table(data, file = "FlowControl/log/testfile.csv", sep = ",", row.names = FALSE)

utils::zip(zipfile = "FlowControl/testfile.zip", files = "FlowControl/log/testfile.csv")

# move or rename file
file.rename(from = "FlowControl/testfile.zip", to = "FlowControl/testfile2.zip")

# remove file and dir
# file
if(file.exists("FlowControl/log/testfile.csv")){
  file.remove("FlowControl/log/testfile.csv")}
if(file.exists("FlowControl/testfile2.zip")){
  file.remove("FlowControl/testfile2.zip")}

# dir
if(file.exists("FlowControl/log")){
  unlink("FlowControl/log", recursive=TRUE)}


# create error log file ####
if(!file.exists("log")){dir.create("log")}
errorlog_filename = paste("log/errorlog_"
                          , format(Sys.time(), "%Y%m%d_%H%M%OS3")
                          , ".csv"
                          , sep = "")
sink(errorlog_filename, append = TRUE)
cat(paste("type,yyyymmdd,hhmmss.000,message\n",sep = ""))
sink()


# tryCatch ####
# need to create a error log file first
tryCatch(
  {
    print(aaaaa)

  }, warning = function(war){

      sink(errorlog_filename, append = TRUE)
      cat(paste("WARNING"
                , ","
                , format(Sys.time(), "%Y%m%d")
                , ","
                , format(Sys.time(), "%H%M%OS3")
                , ","
                , gsub(",",replacement = "/",
                       paste(war, collapse = ""))
                , sep = ""
      ))
      sink()

  }, error = function(err){

    sink(errorlog_filename, append = TRUE)
    cat(paste("ERROR"
              , ","
              , format(Sys.time(), "%Y%m%d")
              , ","
              , format(Sys.time(), "%H%M%OS3")
              , ","
              , gsub(",",replacement = "/",
                     paste(err, collapse = ""))
              , sep = ""
    ))
    sink()

  }
)






