## first we have to activate the dplyr package 
library(dplyr)

## this requires you to already have downloaded the data set and assigned your 
## working directory to the folder with the data in it (the "UCI HAR Dataset").


## Step 1 
## Read all the train files and assign them
x_train_files <- read.table("train/X_train.txt")
y_train_files <- read.table("train/y_train.txt")
subject_train_file <- read.table("train/subject_train.txt")

## Read all the test files and assign them
x_test_files <- read.table("test/X_test.txt")
y_test_files <- read.table("test/y_test.txt")
subject_test_file <- read.table("test/subject_test.txt")

## read features
features <- read.table("features.txt")

## Reading the acitivity labels
activity <- read.table("activity_labels.txt")
colnames(activity) <- c("activityID", "activityType")

## Assign variable names
colnames(x_train_files) <- features[, 2]
colnames(y_train_files) <- "activityID"
colnames(subject_train_file) <- "subjectID"

colnames(x_test_files) <- features[, 2]
colnames(y_test_files) <- "activityID"
colnames(subject_test_file) <- "subjectID"

## Merging y, x and subject data for train and test separately, by columns
train_data <- cbind(y_train_files, subject_train_file, x_train_files)
test_data <- cbind(y_test_files, subject_test_file, x_test_files)

## Merging the test and train data from before, to one 
train_test_data_combined <- rbind(train_data, test_data)


## Step 2  
## Extracting the measurements of the mean and SD for each measurement from the 
## combined data
mean_and_sd <- grepl("activityID|subjectID|mean\\(\\)|std\\(\\)", colnames(train_test_data_combined))
MeanandSd_data <- train_test_data_combined[, mean_and_sd]


## Step 3
## Merging the mean and SD with the activity ID and the descriptive acitivity 
## name/type (obs. will be displayed as the last column)
ActivityName_MeanandSd <- merge(MeanandSd_data, activity, by = "activityID", all.x = TRUE)

## Step 4 
## Labelling the data set with the so-called "descriptive variable names"
colnames(ActivityName_MeanandSd) <- gsub("^t", "Time", colnames(ActivityName_MeanandSd))
colnames(ActivityName_MeanandSd) <- gsub("^f", "Frequency", colnames(ActivityName_MeanandSd))
colnames(ActivityName_MeanandSd) <- gsub("Acc", "Accelerometer", colnames(ActivityName_MeanandSd))
colnames(ActivityName_MeanandSd) <- gsub("Gyro", "Gyroscope", colnames(ActivityName_MeanandSd))
colnames(ActivityName_MeanandSd) <- gsub("Mag", "Magnitude", colnames(ActivityName_MeanandSd))
colnames(ActivityName_MeanandSd) <- gsub("BodyBody", "Body", colnames(ActivityName_MeanandSd))

## Step 5 
## Creating a second, independent tidy data set using %>% to pass one function
## as an argument to another function 
tidydata <- ActivityName_MeanandSd %>%
  group_by(subjectID, activityID, activityType) %>%
  summarise_all(mean)

## Writing the tidy data to a seperate file
write.table(tidydata, "tidydata.txt", row.names = FALSE)

