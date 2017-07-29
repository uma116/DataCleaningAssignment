# DataCleaningAssignment

==================================================================
Human Activity Recognition Using Smartphones Dataset
==================================================================


##The dataset includes the following files:
===========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


##run_analysis.R is the script which does the following :


New working folder is created and the data is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . 
Unzipped the file that got loaded. it has test and train folders were the datasets are available.

1. Merges the training and the test sets to create one data set.

The Train & Test datasets are read and stored in different variables. Then combined the variables using cbind and rbind to form a single dataset.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

Features.txt file contains the variables names for the signals that are collected from the accelerometer and gyroscope 3-axial raw signals.
Using grep identified the variables with the name Mean and Standard deviation. Then corresponding measuremnets are subsetted from the dataset that is created in the step.
And colnames function used to name the dataset with the variables names by removing the round brackets.


3. Uses descriptive activity names to name the activities in the data set.

Activity_labels.txt file has the activity ids and the corresponding values like 1 walking etc.

The activity values in the dataset are replaced with the names using the merge function with activity id as key column.

4. Appropriately labels the data set with descriptive variable names. 

Need to reorder and label the dataset that is created in the above step.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The dataset which is created above is grouped by subject and activity and then mean of each variable is calculated at activity and subject level. The newly created dataset is written in
tidydataset. For this mean calculation summarise_all is used. 
