README
========================================================

This repo pertains to the course project for the Coursera course "Getting and Cleaning Data".

All the data processing and transformations are handled in a single script:
run_analysis.R.  

The run_analysis.R script returns a comma-delimited file: "project_summary.txt"

This summary file contains group averages by subject and activity of all the measurement variables, as specified in the assignment.  Descriptions of the variables in this file, as well as data processing and transformation steps taken, may be found in the markdown file:
CodeBook.md.   

The data processing steps (and corresponding R code) are described below:

### 1) Download the specified data for the project and unzip the files

```
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20   Dataset.zip", destfile="./data/20Dataset.zip", method="curl")
    unzip("./data/20Dataset.zip")              
```

This step created a directory called UCI HAR Dataset which in turn contained the train and test data directories as well as files describing the original data collection practices.  Quoting from the orignal data's README.txt:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

>For each record it is provided:

>- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
>- Triaxial Angular velocity from the gyroscope. 
>- A 561-feature vector with time and frequency domain variables. 
>- Its activity label. 
>- An identifier of the subject who carried out the experiment.

>The dataset includes the following files:

>- 'README.txt'

>- 'features_info.txt': Shows information about the variables used on the feature vector.

>- 'features.txt': List of all features.

>- 'activity_labels.txt': Links the class labels with their activity name.

>- 'train/X_train.txt': Training set.

>- 'train/y_train.txt': Training labels.

>- 'test/X_test.txt': Test set.

>- 'test/y_test.txt': Test labels.

>The following files are available for the train and test data. Their descriptions are equivalent. 

>- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.


### 2) Create a table of measurement names from the "features.txt" file
This step also creates a new "names" variable to make sure that the column names are "legal" in R.
```
    setwd("~/datasciencecoursera/UCI HAR Dataset")
    features <- read.table("features.txt")
    features$names <- make.names(features$V2)
```

### 3) Read in activity labels from the "activity_labels.txt" file
```
    labels <- read.table("activity_labels.txt", col.names=c("activity", "activity_label"))
```

### 4) Identify which columns in the list of motion measurements contain means or standard deviations
```
    means <- grep("mean", features$names)
    stds <- grep("std", features$names)
```

### 5) Process the test data
```
    setwd("~/datasciencecoursera/UCI HAR Dataset/test")

    #Read in measurement file, subject file, and activity file
    X_test <- read.table("X_test.txt", col.names=features$names)
    subject_test <- read.table("subject_test.txt", col.names="subject")
    y_test <- read.table("y_test.txt", col.names="activity")

    #Pull out columns which contain means or standard deviations from test measurements
    testdata <- X_test[, c(means, stds)]

    #Combine with subject and activity data
    testfile <- cbind(subject_test, y_test, testdata)
```

### 6) Process the training data
```
    setwd("~/datasciencecoursera/UCI HAR Dataset/train")

    #Read in measurement file, subject file, and activity file
    X_train <- read.table("X_train.txt", col.names=features$names)
    subject_train <- read.table("subject_train.txt", col.names="subject")
    y_train <- read.table("y_train.txt", col.names="activity")

    #Pull out columns which contain means or standard deviations from test measurements
    traindata <- X_train[, c(means, stds)]

    #Combine with subject and activity data
    trainfile <- cbind(subject_train, y_train, traindata)
```

### 7) Combine the test and training data into one data frame and add the activity label to the rows
```
    setwd("~/datasciencecoursera/UCI HAR Dataset")
    combined <- rbind(testfile, trainfile)
    final <- merge(combined, labels)
```

### 8) Create summary data frame by aggregating on subject ID and activity label
This step calculates the mean of each numeric motion measurement variable and renames the first two columns to be more readable.  Some redundant columns are also removed.

```
    summary <- aggregate(final, by=list(final$subject, final$activity_label), FUN=mean)
    names(summary)[names(summary)=="Group.1"] <- "Subject_ID"
    names(summary)[names(summary)=="Group.2"] <- "Activity_Label"
    summary$subject <- NULL
    #The aggregate function returns NA values for this variable so it is removed.
    summary$activity_label <- NULL
```    

### 9) Export summary data frame to comma-delimited text file
````
    write.csv(summary, file="project_summary.csv")
```
