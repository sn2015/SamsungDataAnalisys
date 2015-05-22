# getting row data
if(!file.exists("UCI HAR Dataset")) {
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./dataset.zip")
write(date(), file="./datedownloaded.txt")
unzip("./dataset.zip")
}

# step 1 Merging the training and the test sets to create one data set
activity_labels <- readLines("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)

# first I name variabels, so there won't be any confusing variables like V1.1 
colnames(Xtest) <- features[, 2]
colnames(ytest) <- "activity"
colnames(subject_test) <- "subject"
# merging test data
subject_activity_test <- cbind(subject_test, ytest, Xtest)

# naming train data
colnames(Xtrain) <- features[, 2]
colnames(ytrain) <- "activity"
colnames(subject_train) <- "subject"
# merging train data
subject_activity_train <- cbind(subject_train, ytrain, Xtrain)

# merging test and train data set
onedataset <- rbind(subject_activity_test, subject_activity_train)

# 2 Extracts only the measurements on the mean and standard deviation for each measurement
# according features_info.txt variables that are related to mean or standard deviation
# have "mean", "Mean", or "std" in their name, so I used function
# grep() with ignore.case = TRUE to indicate such columns and then extract them.
meancolumns <- grep("mean", names(onedataset), ignore.case = TRUE) # 53 var
stdcolumns <- grep("std", names(onedataset), ignore.case = TRUE) # 33 var
meanstdcolumns <- c(1, 2, meancolumns, stdcolumns) # 2+86 var

data <- onedataset[, meanstdcolumns]

# 3 Uses descriptive activity names to name the activities in the data set
data[, 2] <- sub("1", "walking", data[, 2])
data[, 2] <- sub("2", "walkingup", data[, 2])
data[, 2] <- sub("3", "walkingdown", data[, 2])
data[, 2] <- sub("4", "sitting", data[, 2])
data[, 2] <- sub("5", "standing", data[, 2])
data[, 2] <- sub("6", "laying", data[, 2])

data[, 1] <- paste0("subject", data[, 1])


# 4 Appropriately labels the data set with descriptive variable names.
# I changed variables names just a bit, in order to be connected to feachers_info file
# by replacing "-" minus with "" nothing, because it allows to use $ operator in subsetting etc.
# such as data$tBodyAccstdZ
# and lower all letters to make it more equal, no needs to remember which letter is which
names(data) <- gsub("-", "", names(data))
names(data) <- gsub("\\(", "", names(data))
names(data) <- gsub("\\)", "", names(data))
names(data) <- gsub(",", "", names(data))
names(data) <- tolower(names(data))

# 5 From the data set in step 4, creates a second, independent tidy data set
#        with the average of each variable for each activity and each subject.

library(dplyr)
tidydata <- data %>% group_by(subject, activity) %>% summarise_each(funs(mean))
write.table(tidydata, file="./tidydata.txt", row.name=FALSE)
View(tidydata)

