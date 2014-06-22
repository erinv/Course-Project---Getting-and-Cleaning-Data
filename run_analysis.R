
#Download the specified data for the project
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              destfile="./data/20Dataset.zip", method="curl")

#Unzip the files.  A directory called UCI HAR Dataset will be created in the working directory

unzip("./data/20Dataset.zip")

#Create a table of measurement names from the features.txt file.  Create a new "names" variable
# to make sure that the column names are "legal" in R.

setwd("~/datasciencecoursera/UCI HAR Dataset")
features <- read.table("features.txt")
features$names <- make.names(features$V2)
 
#Read in activity labels
labels <- read.table("activity_labels.txt", col.names=c("activity", "activity_label"))

#Identify which columns contain means or standard deviations of measurements
    means <- grep("mean", features$names)
    stds <- grep("std", features$names)


#==================================================================================
#Process the test data

setwd("~/datasciencecoursera/UCI HAR Dataset/test")

#Read in measurement file, subject file, and activity file
X_test <- read.table("X_test.txt", col.names=features$names)
subject_test <- read.table("subject_test.txt", col.names="subject")
y_test <- read.table("y_test.txt", col.names="activity")

#Pull out columns which contain means or standard deviations from test measurements
testdata <- X_test[, c(means, stds)]

#Combine with subject and activity data
testfile <- cbind(subject_test, y_test, testdata)

#==================================================================================
#Process the training data
setwd("~/datasciencecoursera/UCI HAR Dataset/train")

#Read in measurement file, subject file, and activity file
X_train <- read.table("X_train.txt", col.names=features$names)
subject_train <- read.table("subject_train.txt", col.names="subject")
y_train <- read.table("y_train.txt", col.names="activity")

#Pull out columns which contain means or standard deviations from test measurements
traindata <- X_train[, c(means, stds)]

#Combine with subject and activity data
trainfile <- cbind(subject_train, y_train, traindata)

#==================================================================================

#Combine the test and training data into one data frame
setwd("~/datasciencecoursera/UCI HAR Dataset")
combined <- rbind(testfile, trainfile)

#Add the activity label to the rows
final <- merge(combined, labels)

#Create summary data frame by aggregating on subject ID and activity label
# Rename the first two columns to be more readable.  Remove two colunns that have become redundant.
summary <- aggregate(final, by=list(final$subject, final$activity_label), FUN=mean)
names(summary)[names(summary)=="Group.1"] <- "Subject_ID"
names(summary)[names(summary)=="Group.2"] <- "Activity_Label"

summary$subject <- NULL
#The aggregate function returns NA values for this variable so it is removed.
summary$activity_label <- NULL

#Export summary data frame to text file
write.csv(summary, file="project_summary.csv")

