# Getting and Cleaning Data

> This is a step-by-step project for getting and cleaning data sets. It includes the instructions on how to do an analysis on Human Activity by using the UCI Irvine Machine Learning repositories.


## Files

- *raw data set*: [Human activity recognition using smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
- *[CODEBOOK.md](https://github.com/vcwild/data-cleaning/blob/master/CODEBOOK.md)*: step-by-step on how to get from the raw data to the tidy data set.
- *[run_analysis.R](https://github.com/vcwild/data-cleaning/blob/master/run_analysis.R)*: a script able to process and clean the raw data into the final tidy data set (and export into a *.txt file)
- *[cleanData.txt](https://github.com/vcwild/data-cleaning/blob/master/cleanData.txt)*: the exported tidy data set generated by the *run_analysis.R* script.

### Note

In order for the *run_analysis.R* script to work, you need to download the raw data set library and extract as an entire folder inside the project root folder.

# CODEBOOK

## Script steps
> The *run_analysis.R* executed the following steps to get to the tidy data set:

### Download
- Downloaded and extracted datasets using *read.table()*

### Set Variables


Set the working tables to current variables
- `feats` features.txt : 561 rows, 2 columns
*Includes the features that come from the accelerometer and gyroscope 3-axial raw signals*
- `acs` activity_labels.txt : 6 rows, 2 columns
*List of activities performed when the corresponding measurements were taken and its codes (labels)*
- `testSubject` test/subject_test.txt : 2947 rows, 1 column
*contains test data of 9/30 volunteer test subjects being observed*
- `testX` test/X_test.txt : 2947 rows, 561 columns
*contains recorded features test data*
- `testY` test/y_test.txt : 2947 rows, 1 columns
*contains test data of activities’code labels*
- `trainSubject` test/subject_train.txt : 7352 rows, 1 column
*contains train data of 21/30 volunteer subjects being observed*
- `trainX` test/X_train.txt : 7352 rows, 561 columns
*contains recorded features train data*
- `trainY` test/y_train.txt : 7352 rows, 1 columns
*contains train data of activities’code labels*

### Merge
Merging training and testing sets to create a single dataset
- `X` (10299 rows, 561 columns) is created by merging trainX and testX using rbind() function
- `Y` (10299 rows, 1 column) is created by merging trainY and testY using rbind() function
- `Subject`: (10299 rows, 1 column) is created by merging subject_train and testSubject using rbind() function
- `filterData`: (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

### Filter
Get the mean and std deviation of each measurement // Filter the activity names for the dataset
- `filterData` (10299 rows, 88 columns) is created by subsetting mergedData, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

Use descriptive activity names to name the activities in the data set

Change data labels the data set with appropriate descriptive variable names

### Re-Filter
Generate new tidy data frame for each variable based on the previous data set filter

### Clean Final Data
From the previous data set, creates a second one that includes the average of each variable for each activity and each subject
- `cleanData` (180 rows, 88 columns) is created by sumarizing fliterData, taking the means of each variable for each activity and each subject, after groupped by subject and activity.
- Export cleanData into cleanData.txt file.
