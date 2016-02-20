## This R script is for Getting & Cleaning Data project
## This project is to collect , work with and clean 
## a dataset
## This script uses the plyr library for split and apply combine pattern

library(plyr) 
## This is the original zip file which has the dataset to be cleaned 
setwd("C:/Program Files/RStudio/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
## set your working directory as per your system and change the path for
## setwd as per your machine
zipfilename <- "getdata_dataset.zip" 
 

## Download and unzip the dataset: 
if (!file.exists(zipfilename)){ 
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip " 
download.file(fileURL, zipfilename) 
}   
if (!file.exists("UCI HAR Dataset")) {  
   unzip(zipfilename)  
} 

# Step 1 
# This includes Merging the training and test sets to create one data set 
######################################################################### 
#########################################################################
#########################################################################
x_read_training <- read.table("train/X_train.txt") 
y_read_training <- read.table("train/y_train.txt") 
subject_read_training <- read.table("train/subject_train.txt") 
 

x_read_test <- read.table("test/X_test.txt") 
y_read_test <- read.table("test/y_test.txt") 
subject_read_test <- read.table("test/subject_test.txt") 
 

# From this I will create 'x' dataset 
x_read_data <- rbind(x_read_training, x_read_test) 
 

# From this I will also create 'y' dataset 
y_read_data <- rbind(y_read_training, y_read_test) 
 

# Now I will create a 'subject' dataset 
subject_read_data <- rbind(subject_read_training, subject_read_test) 
 

# Step 2 
# Extract only the measurements on the mean and standard deviation for each measurement 
######################################################################################
######################################################################################
######################################################################################
read_features <- read.table("features.txt") 
 

# Extract only columns with mean() or std() in their names for each measurement
mean_std_features <- grep("-(mean|std)\\(\\)", read_features[, 2]) 
 

# Get and store the subset of the desired columns 
x_read_data <- x_read_data[, mean_std_features] 
 

# Correct the column names with appropriate variables
names(x_read_data) <- read_features[mean_std_features, 2] 
 

# Step 3 
# Use the descriptive activity names to name the activities in the dataset 
##########################################################################
##########################################################################
##########################################################################
read_activity_names <- read.table("activity_labels.txt") 
 

# Update labels in the dataset with correct activity names 
y_read_data[, 1] <- read_activity_names[y_read_data[, 1], 2] 
 

# Correct column name and assign column name as activity
names(y_read_data) <- "activity" 
 

# Step 4 
# Appropriately label the data set with descriptive variable names 
##################################################################
##################################################################
##################################################################
# Correct column name and assign column name as subject 
names(subject_read_data) <- "subject" 
 

# Binding or merging  all the data in a single dataset 
bind_all_data <- cbind(x_read_data, y_read_data, subject_read_data) 
 

# Step 5 
# From the dataset above create a second, independent tidy data set with the 
# average of each variable for each activity and each subject 
############################################################################
############################################################################
############################################################################
new_average_data_set <- ddply(bind_all_data, .(subject, activity), 
                              function(x) colMeans(x[, 1:66])) 
 
## Writes the new cleaned and mereged data in the text file
write.table(new_average_data_set, "tidy.txt", row.name=FALSE) 








