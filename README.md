#Getting and Cleaning Data Project

My code consists in just one function (mergeData) which creates and returns the tidy data set.  All the steps are described below.

I load all the datasets from both the test and train samples, in addition I also load the fetures and activity labels.
  
    x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
    y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  
    x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
    y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
  
    features <- read.table("UCI HAR Dataset/features.txt")
  
    labels <- read.table("UCI HAR Dataset/activity_labels.txt")

Here I merge the x_train and X_test data sets for latter filtering.
    
    #1. Merges the training and the test sets to create one data set
    
    x <- rbind(x_train, x_test)
  
I select all the colunms that are mean or standard deviation using a vectorized implementation 

    #2. Extracts only the measurements on the mean and standard deviation 
    #for each measurement. 
  
    logicVector <- with( features, grepl("std()", V2) | grepl("mean()", V2) )
    xreduce <- x[,logicVector]

I apply the original names to the reduced dataset columns and append two more colunms to the dataset, which are Subject and Activity

    #3. Uses descriptive activity names to name the activities in the data set
    #4. Appropriately labels the data set with descriptive activity names. 
  
    names(xreduce) <- features$V2[logicVector]
  
    y <- rbind(y_train, y_test)
    y <- as.data.frame(labels$V2[y$V1])
  
    subject <- rbind(subject_train, subject_test)
  
    names(y) <- c("Activity")
    names(subject) <- c("Subject")
  
    xreduce <- cbind(subject, y, xreduce)

Finally I save the dataset to a new file and return it

    #5. Creates a second, independent tidy data set with the average 
    #of each variable for each activity and each subject.
  
    write.table(xreduce, file = "tidydataset.txt", sep = " ", row.names = FALSE)
  
    xreduce
  
