## Need to load the plyr library for a few functions
library(plyr)

## Read the features file into a table. 
## This table has 561 rows and 2 columns - FeatureIndex and FeatureName
features <- read.table("features.txt")

## Read the training data set file into a table. 
## Column names are obtained from the features table column 2
## This table has 7352 rows and 561 columns
trainingSet <- read.table("train/X_train.txt", col.names=features[[2]])

## Read the training activities into a table. Assign column name as "Activity"
## This table has 7352 rows and 1 column
trainingSetActivities <- read.table("train/y_train.txt", col.names="Activity")

## Read the training subjects into a table. Assign column name as "Subject"
## This table has 7352 rows and 1 columns
trainingSetSubjects <- read.table("train/subject_train.txt", col.names="Subject")

## Combine the 3 training data sets (trainingSetSubjects, trainingSetActivities and trainingSet) 
## by binding the columns together
## This combined training Set has 7352 rows and 563 columns
trainingSetFullData <- cbind(trainingSetSubjects, trainingSetActivities, trainingSet)

## Read the test data set file into a table. 
## Column names are obtained from the features table column 2
## This table has 2947 rows and 561 columns
testSet <- read.table("test/X_test.txt", col.names=features[[2]])

## Read the test activities into a table. Assign column name as "Activity"
## This table has 2947 rows and 1 column
testSetActivities <- read.table("test/y_test.txt", col.names="Activity")

## Read the test subjects into a table. Assign column name as "Subject"
## This table has 2947 rows and 1 columns
testSetSubjects <- read.table("test/subject_test.txt", col.names="Subject")

## Combine the 3 test data sets (testSetSubjects, testSetActivities and testSet) by binding the columns together
## This combined test Set has 2947 rows and 563 columns
testSetFullData <- cbind(testSetSubjects, testSetActivities, testSet)

######################################################################################################
## 1. Merge the training set and test set to create one data set
######################################################################################################

## Merge the training and test sets by binding the rows together
## This creates a table with 10299 rows and 563 columns
mergedSet <- rbind(trainingSetFullData, testSetFullData)

######################################################################################################
## 2. Extract only the measurements on the mean and standard deviation for each measurement
######################################################################################################

## Search for all columns with Mean or mean or Std or std in the names
filteredCols <- grep("[Mm]ean|[Ss]td", colnames(mergedSet))

## Extract only the columns with Mean/mean/Std/std and the first 2 columns since they have Subject and Activuty information
## This creates a table with 10299 rows but only 88 columns
filteredDataSet <- mergedSet[, c(1,2,filteredCols)]

######################################################################################################
## 3. Use descriptive activity names to name the activities in the data set
######################################################################################################

## Read the activities file into a table. Assign column names as Activity and ActivityName
## This table has 6 rows and 2 columns
activities <- read.table("activity_labels.txt", col.names=c("Activity", "ActivityName"))

## Join the activities table and the filteredDataSet table by matching the Activity column in both the tables
## This adds the "ActivityName" column to the resulting table in addition to the all the columns in filteredDataSet
newDataSet <- join(activities, filteredDataSet, by="Activity")

## Remove the Activity column(first column) from the new table since we now have activity name
newDataSet$Activity <- NULL 

######################################################################################################
## 4. Appropriately label the data set with descriptive variable names
######################################################################################################

## This is already done since column names were assigned in read.table earlier

######################################################################################################
## 5. Create a second, independent tidy data set with the average of each variable for each activity 
## and each subject 
######################################################################################################

## Use the ddply function to calculate the mean for each of the columns after splitting the 
## data frame by ActivityName and Subject
## My tidyDataSet has 180 rows(30 subjects x  6 activities) and 88 columns
tidyDataSet <- ddply(newDataSet, .(ActivityName, Subject), numcolwise(mean))

## Write the resulting data frame to a file
write.table(tidyDataSet, file="tidyData.txt", row.names=FALSE)