
# run the parallel process ####

# define a func
g4_func = function(){
  for(i in 1:nrow(g4)){

    if((g4[i, 'c1']+g4[i, 'c2']+g4[i,'c3']+g4[i, 'c4'])>4){

      g4[i, 5] <- "greater_than_4"

    }else{

      g4[i, 5] <- "lesser_than_4"

    }
  }
  return(g4)
}


# non-parallel process ####
t1 = proc.time()

# create data
c1 = runif (12^5, 0, 2)
c2 = rnorm (12^5, 0, 2)
c3 = rpois (12^5, 3)
c4 = rchisq (12^5, 2)
g4 = data.frame (c1, c2, c3, c4)

# run the loop
new1 = g4_func()
t2 = proc.time() -t1




# parallel porcess ####
t3 = proc.time()

# cores to run parallel, use # of cores -1
# no_cores = parallel::detectCores() - 1
no_cores = 3

# parallel start
message("Start Cluster")

cl = parallel::makeCluster(no_cores) # set the number of parallel cores
doParallel::registerDoParallel(cl)

# nIteration = length(list)
new2 = foreach::foreach(i= 1:length(list)
                          , .combine = 'rbind'
                          , .inorder = FALSE
                          # , .packages = c('tcltk') ## for tracking
                          , .export = c("g4_func") ## function used
                          # , .verbose = TRUE # show progress
) %dopar% {
  # if(!exists("pb")) pb = tcltk::tkProgressBar("Parallel task", min=1, max=length(list))
  # tcltk::setTkProgressBar(pb, i)

  c1 = runif (12^5, 0, 2)
  c2 = rnorm (12^5, 0, 2)
  c3 = rpois (12^5, 3)
  c4 = rchisq (12^5, 2)
  g4 = data.frame (c1, c2, c3, c4)

  g4_func()

  }

parallel::stopCluster(cl)
doParallel::stopImplicitCluster()

# parallel stop
message("Stop Cluster")
t4 = proc.time() -t3


##
t2
# > t2
# user  system elapsed
# 199.657 104.992 306.832
t4
# t4
# user  system elapsed
# 0.515   0.449 203.528



