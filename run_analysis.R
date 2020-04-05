# LIBS USED:
# library(dplyr)

# Set the working tables to current variables

feats <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
acs <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
trainX <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = feats$functions)
trainY <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
testX <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feats$functions)
testY <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")


# Merging training and testing sets to create a single dataset

X <- rbind(trainX, testX)
Y <- rbind(trainY, testY)
Subject <- rbind(trainSubject, testSubject)
mergedData <- cbind(Subject, Y, X)


# Get the mean and std deviation of each measurement

filterData <- mergedData %>% select(subject, id, contains("mean"), contains("std"))


# Filter the activity names for the dataset

filterData$id <- acs[filterData$id, 2]


# Set labels for upcoming data

names(filterData)[2] = "activity"
names(filterData)<-gsub("Acc", "Accelerometer", names(filterData))
names(filterData)<-gsub("Gyro", "Gyroscope", names(filterData))
names(filterData)<-gsub("BodyBody", "Body", names(filterData))
names(filterData)<-gsub("Mag", "Magnitude", names(filterData))
names(filterData)<-gsub("^t", "Time", names(filterData))
names(filterData)<-gsub("^f", "Frequency", names(filterData))
names(filterData)<-gsub("tBody", "TimeBody", names(filterData))
names(filterData)<-gsub("-mean()", "Mean", names(filterData), ignore.case = TRUE)
names(filterData)<-gsub("-std()", "STD", names(filterData), ignore.case = TRUE)
names(filterData)<-gsub("-freq()", "Frequency", names(filterData), ignore.case = TRUE)
names(filterData)<-gsub("angle", "Angle", names(filterData))
names(filterData)<-gsub("gravity", "Gravity", names(filterData))


# Generate new tidy data frame for each variable based on the previous dataset filter

cleanData <- filterData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(cleanData, "cleanData.txt", row.name=FALSE)


# Look at the clean data structure

cleanData
class(cleanData)
