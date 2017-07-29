

#Setting the working Directory, downloading the file and unzipping it.

setwd("./DataCleaning")

fname <- "assign_dataset.zip"

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileurl, fname)

unzip(fname)

#Reading the test dataset

test <- read.table("./UCI HAR Dataset/test/X_test.txt")

testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt")

testsubjects <- read.table ("./UCI HAR Dataset/test/subject_test.txt")

# reading the training dataset

train <- read.table("./UCI HAR Dataset/train/X_train.txt")

trainlabels <- read.table("./UCI HAR Dataset/train/y_train.txt")

trainsubjects <- read.table ("./UCI HAR Dataset/train/subject_train.txt")




#####1. Merges the training and the test sets to create one data set

##Assigning column names and merging it into single dataset


colnames(testsubjects) <- "subject"

colnames(trainsubjects) <- "subject"

colnames(testlabels) <- "activityid"

colnames(trainlabels) <- "activityid"

colnames(test) <- features[,2]

colnames(train) <- features[,2]


test_dataset <- cbind(testsubjects,testlabels,test)


train_dataset <- cbind(trainsubjects,trainlabels,train)

#merging into single dataset


final_dataset <- rbind(test_dataset,train_dataset)



#####2. Extracts only the measurements on the mean and standard deviation for each measurement

##Reading the features file for extracting the mean and standard deviation

features <- read.table("./UCI HAR Dataset/features.txt")

feature_nmes <- features[grep(".*mean.*|.*std.*", features[,2]),]

feature_nmes1 <- data.frame(gsub('[()]', '', feature_nmes[,2]))

#extracting the data for the selected measures

fdata1 <- final_dataset[,which(names(final_dataset) %in% feature_nmes[,2])]

colnames(fdata1) <- feature_nmes1[,1]

fdata2 <- final_dataset[,1:2]

fnl_data_reqd <- cbind(fdata2,fdata1)


#####3.Uses descriptive activity names to name the activities in the data set
#####4.Appropriately labels the data set with descriptive variable names.
##the below code is to have the activity and other variable names in a proper order

activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt")

colnames(activity_label) <- c("activityid", "activity")

fnl_dataset_actylbl <- merge(fnl_data_reqd,activity_label , by.x="activityid", by.y="activityid")


activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt")

colnames(activity_label) <- c("activityid", "activity")

fnl_dataset_actylbl <- merge(fnl_data_reqd,activity_label , by.x="activityid", by.y="activityid")
  
fnl_dataset_actylbl <- select(fnl_dataset_actylbl ,2,82,3:81)



#####5.From the data set in step 4, creates a second, independent tidy data set with the average of 
#each variable for each activity and each subject.


newdataset_mean <- fnl_dataset_actylbl %>% group_by(subject,activity) %>% summarise_all( .funs= funs(mean))

write.table(newdataset_mean,"./tidydata.txt", row.names = FALSE, col.names = TRUE)

