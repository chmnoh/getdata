# 1. merges 'test','train' HAR data files into one,
# 2. extract mean(),std() columns from that and 
# 3. output average values for each activity, subject.
# also, make a tidy data set file with descriptive variable names.
library(data.table)

#########################################################
# global variable
#########################################################
g_data_dir <- './UCI HAR Dataset'  
#########################################################

##############################################
# make raw-files path list for each folder
##############################################
fileList <- function(folder_name) {
    folder <- paste(g_data_dir,folder_name,sep='/')
    names <- sapply(c('subject','X','y'),
                    function(x) paste(x,'_',folder_name,'.txt',sep=''))
    sapply(names, function(x) paste(folder,x,sep='/'))
}
#####################################################################
# read folder's raw-data('subject','X','y') into data.tables, 
# and return a (big) merged data.table
#####################################################################
readTables <- function(folder_name,features,activity_labels) {
    # read data into data.tables
    D <- sapply(fileList(folder_name), 
                    function(x) as.data.table(read.table(x)))
    
    # aliasing with some preprocessing(ex. labeling, extracting, ...)
    subject <- D[[1]]
    ft_val <- D[[2]][,features$idx,with=FALSE] # only interestring features
    activity <- activity_labels[D[[3]]] # join with labels
    
    # set table variable names(not V1,V2,...) as codebook's label
    setnames(subject,c("subject"))
    setnames(ft_val,as.character(features$nm))
    
    # make the big table
    cbind(subject,activity,ft_val)
}
#####################################################################
# program entry-point 
#####################################################################
main <- function() {
    ###############################
    # pre-processing feature info
    ###############################
    ft_data <- as.data.table(
        read.table(paste(g_data_dir,'features.txt',sep='/')))
    mean_std_idx <- grep('-mean|-std', ft_data$V2, ignore.case=TRUE)
    features <- ft_data[mean_std_idx]
    setnames(features,c("idx","nm"))
    ##################################
    # pre-processing activity labels
    ##################################
    activity_labels <- as.data.table(
        read.table(paste(g_data_dir,'activity_labels.txt',sep='/')))
    setnames(activity_labels,c("activity_code","activity_label"))
    setkey(activity_labels,activity_code)
    ####################################
    # merge & extract for each 'test','train'.
    ####################################
    big_tab <- rbind(readTables('train',features,activity_labels),
                     readTables('test',features,activity_labels))
    #################################################
    ## group-by (subject,activity) & result writing
    #################################################
    result_tab <- big_tab[,lapply(.SD,mean),
                          by=list(subject,activity_label)]
    write.table(result_tab, file="result.txt", row.names=FALSE)
    write.table(data.table(names(result_tab)),file="code.lst",
                col.names=FALSE,quote=FALSE)
}