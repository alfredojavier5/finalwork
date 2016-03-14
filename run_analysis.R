#Final work in the Getting and Cleaning Data Course

# Features from the variables
features <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std_features]

#Reading Data
# test data
x_test <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/test/subject_test.txt")

# train data
x_train <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/train/subject_train.txt")

# Generalize
x_data <- rbind(x_test, x_train)
y_data <- rbind(y_test, y_train)
subject_data <- rbind(subject_test, subject_train)


#Naming the activities in the data set
activities <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"

#Changing data names
names(subject_data) <- "subject"

#Binding one single data set
all_data <- cbind(x_data, y_data, subject_data)

#Writting tidy_data
Installing library(dplyr)
tidy_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
View(tidy_data)
