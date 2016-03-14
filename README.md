#Final work in the Getting and Cleaning Data Course

# Download data
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="/Users/alfredoacosta/Final_test/UCI HAR Dataset.zip", method="curl")
unzip("/Users/alfredoacosta/Final_test/UCI HAR Dataset.zip") 

# activity labels and features
activity_labels <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/activity_labels.txt")
activity_labels2 <-as.character(activity_labels)
features <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/features.txt")
features2 <- as.character(features)

#Select information mean and standar desviation
featuresWanted <- grep(".*mean.*|.*std.*", features2)
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

# test data
test <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/test/X_test.txt") [featuresWanted]
testSubject <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/test/y_test.txt")
test <- cbind(testSubject, testActivities, test)

# train data
train <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/train/X_train.txt") [featuresWanted]
trainSubject <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/train/subject_train.txt")
trainActivities <- read.table("/Users/alfredoacosta/Final_test/UCI HAR Dataset/train/y_train.txt")
train <- cbind(trainSubject, trainActivities, train)

# merge datasets
allData <- rbind(test, train)
write.table(allData, "tidy.txt", row.names = FALSE, quote = FALSE)
