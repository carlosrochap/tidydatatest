mergeData <- function () {
  
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
  
  features <- read.table("UCI HAR Dataset/features.txt")
  
  labels <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  #1. Merges the training and the test sets to create one data set
    
  x <- rbind(x_train, x_test)
  
  
  #2. Extracts only the measurements on the mean and standard deviation 
  #for each measurement. 
  
  logicVector <- with( features, grepl("std()", V2) | grepl("mean()", V2) )
  xreduce <- x[,logicVector]
  
  #3. Uses descriptive activity names to name the activities in the data set
  #4. Appropriately labels the data set with descriptive activity names. 
  
  names(xreduce) <- features$V2[logicVector]
  
  
  y <- rbind(y_train, y_test)
  y <- as.data.frame(labels$V2[y$V1])
  
  subject <- rbind(subject_train, subject_test)
  
  names(y) <- c("Activity")
  names(subject) <- c("Subject")
  
  xreduce <- cbind(subject, y, xreduce)
  
  #5. Creates a second, independent tidy data set with the average 
  #of each variable for each activity and each subject.
  
  write.table(xreduce, file = "tidydataset.txt", sep = " ", row.names = FALSE)
  
  xreduce
  
}