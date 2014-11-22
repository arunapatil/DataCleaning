---
title: Getting and Cleaning Data - Project
output: html_document
---
The data sets used for this project can be found here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Goals of the exercise:

======================

Create one R script called run_analysis.R that does the following:
  1. Merges the training and the test sets to create one data set.
  
	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
	3. Uses descriptive activity names to name the activities in the data set
  
	4. Appropriately labels the data set with descriptive variable names. 
  
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each 
subject.


CodeBook - CodeBook.txt describes the final tidy data set uploaded to Coursera


Approach:

=========

(comments are also in the code, step by step, for a clear understanding of the R code)

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/' : The contents of this folder are not relevant for this project

- 'test/Inertial Signals/' : The contents of this folder are not relevant for this project


 1. Merge the training and the test sets to create one data set.
 
================================================================

1.1 Read X_train.txt and X_test.txt as individual data frames. Assign column names to the data frames by reading names from features.txt (column 2 in features data frame). 
1.2 Read y_train.txt and y_test.txt into Activities data frames.
1.3 Read subject_train.txt and subject_test.txt into Subjects data frames. 
1.4 cbind the corresponding X_, Activities and Subjects data frames to make the training and test data set more complete. The training and the test data frames now have information about the Subject, Activity and all the measurements. 
1.5 To obtain one merged data set, rbind the trainingDataSet and testDataSet together to combine the rows.New data is is in mergedSet.


 2. Extract only the measurements on the mean and standard deviation for each measurement. 
 
==========================================================================================

2.1 Use grep to find the columns with Mean or mean or Std or std in the column names from mergedSet.
2.2 Subset mergedSet to get only the columns returned in step 2.1 along with the first and second columns which have Subject and Activity information. New data is in filteredDataSet.



 3. Use descriptive activity names to name the activities in the dataset
 
==========================================================================================

3.1 Read activity_labels.txt into the activities data frame. This data frame has 2 columns for each activity - activity number and activity name
3.2 Join the activities data frame with filteredDataSet by matching the activity number. This will create a new data frame with the activity name as an added column in addition to the columns already present in filteredDataSet.
3.3 Remove the activity column (which shows the activity number) from the new data frame since it has the activity name (optional step). The new data is in newDataSet



 4. Appropriately label the data set w/ descriptive variable name
 
==========================================================================================


X_train and X_test was already read in using descriptive column names in step 1.1, so there's nothing additional to do here



 5. from data created at step 4 create a second, independent, tidy dataset
 
    with the average for each activity and each subject
    
==========================================================================================

5.1 Use ddply to split newDataSet by ActivityName and Subject and calculate mean for each measurement using the numcolwise(mean) function. New data is in tidyDataSet


6. write the dataset in a txt file created with write.table() using row.name=FALSE

=================================================================================

write.table(tidyDataSet, "tidyData.txt", row.names=FALSE)


