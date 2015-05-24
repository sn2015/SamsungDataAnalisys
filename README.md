# SamsungDataAnalysis
Course project of Getting and Cleaning data

This analysis is made by Sergey Nazarov for Coursera Getting ana Cleaning data Project

Windows 8.1
R version 3.1.3 (2015-03-09) -- "Smooth Sidewalk"
Platform: x86_64-w64-mingw32/x64 (64-bit)

package: dplyr

**run_analysis.R** creates a tidy data set using row data obtained from experiments.

It creates a tidy data set with the average of each variable for each activity and each subject.
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

run_analysis.R checks if you already have UCI HAR Dataset in the in your working directory. 
If it does not exist it will try to download from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
Then unzip to your working directory and perform the analysis by following steps:

step 1 Merges the training and the test sets to create one data set
Names variabels according **features_info.txt** variabels, so there won't be any confusing variables like V1.1 

step 2 Extracts only the measurements on the mean and standard deviation for each measurement.
According **features_info.txt** variables that are related to mean or standard deviation have words "mean", "Mean", or "std" in their name, so I used function grep() with ignore.case = TRUE to indicate such columns and then extract them.

step 3 Uses descriptive activity names to name the activities in the data set
To name activity labels i used file **activity_labels.txt** that contains activities performed by volunteers with following changes
removing figures and making it lower  
* 1 WALKING" - walking
* 2 WALKING_UPSTAIRS" - walkingup
* 3 WALKING_DOWNSTAIRS" - walkingdown
* 4 SITTING" - sitting
* 5 STANDING" - standing
* 6 LAYING" - laying

step 4 Appropriately labels the data set with descriptive variable names.
I tryed to stay connected to **feachers_info.txt** file where variable names based on the action the variable is recording.
Changes I've made: 
* replace "-", "(", ")" with "" nothing, because it allows to use $ operator in subsetting such as data$tBodyAccstdZ
* and lower all letters to make it easy, no needs to remember which letter is which for instance "tBodyAcc-mean()-X" became "tbodyaccmeanx" 

step 5 From the data set in step 4, creates an independent tidy data set with the average of each variable for each activity and each subject.
then writes it to working directory as "tidydata.txt" and displays it on main window.

24.05.2015
