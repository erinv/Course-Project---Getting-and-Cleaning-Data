CodeBook
========================================================

The file "project_summary.txt" contains the group average of motion measurement variables collected using Samsung smartphones.  As specified in the assignment instructions, groups were defined as combinations of 6 activities and 30 test subjects.  Thus, the 10,299 motion observations in the original data were combined into 180 rows with the means of 79 motion measurement variables. 

The first section of this markdown document describes data processing and transformations.  The second section descries the variable (column) names and values.

## Data Processing and Transformations
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

## Variables(Columns) in project_summary.csv

Note:  The first row or record contains column names/headers.  There are 180 observations of 82 variables.

[1] "Subject_ID" - (integer) Identification code for volunteer subject for each observation.  Ranges from 1 to 30.

[2] "Activity_Label" - (factor) Description of activity being performed for each observation:
WALKING
WALKING_UPSTAIRS
WALKING_DOWNSTAIRS
SITTING
STANDING
LAYING

[3] "activity"   - (numeric)  Numeric code corresponding to activity labels (1 through 6).


Columns [4] through [82] are _numeric_ and contain the **group averages** for the motion measurement observations from the original test and training data sets.  Each group is defined as a combination of test subject volunteer and activity.

The meaning of each column or variable is described in the features_info.txt document which came with the original data sets and is reproduced at the end of this code book document.  For example:

[4]"tBodyAcc.mean...X"   - refers to the mean of a time-sampled ("t") measurement of body acceleration along the X axis (each record contains the group average of this variable for a subject and activity group).


[5] "tBodyAcc.mean...Y"              
[6] "tBodyAcc.mean...Z"              
[7] "tGravityAcc.mean...X"           
[8] "tGravityAcc.mean...Y"           
[9] "tGravityAcc.mean...Z"            
[10] "tBodyAccJerk.mean...X"          
[11] "tBodyAccJerk.mean...Y"          
[12] "tBodyAccJerk.mean...Z"          
[13] "tBodyGyro.mean...X"             
[14] "tBodyGyro.mean...Y"             
[15] "tBodyGyro.mean...Z"              
[16] "tBodyGyroJerk.mean...X"         
[17] "tBodyGyroJerk.mean...Y"         
[18] "tBodyGyroJerk.mean...Z"         
[19] "tBodyAccMag.mean.."              
[20] "tGravityAccMag.mean.."          
[21] "tBodyAccJerkMag.mean.."         
[22] "tBodyGyroMag.mean.."            
[23] "tBodyGyroJerkMag.mean.."         
[24] "fBodyAcc.mean...X"              
[25] "fBodyAcc.mean...Y"              
[26] "fBodyAcc.mean...Z"              
[27] "fBodyAcc.meanFreq...X"          
[28] "fBodyAcc.meanFreq...Y"          
[29] "fBodyAcc.meanFreq...Z"           
[30] "fBodyAccJerk.mean...X"          
[31] "fBodyAccJerk.mean...Y"           
[32] "fBodyAccJerk.mean...Z"          
[33] "fBodyAccJerk.meanFreq...X"      
[34] "fBodyAccJerk.meanFreq...Y"      
[35] "fBodyAccJerk.meanFreq...Z"       
[36] "fBodyGyro.mean...X"             
[37] "fBodyGyro.mean...Y"              
[38] "fBodyGyro.mean...Z"             
[39] "fBodyGyro.meanFreq...X"          
[40] "fBodyGyro.meanFreq...Y"         
[41] "fBodyGyro.meanFreq...Z"          
[42] "fBodyAccMag.mean.."             
[43] "fBodyAccMag.meanFreq.."          
[44] "fBodyBodyAccJerkMag.mean.."     
[45] "fBodyBodyAccJerkMag.meanFreq.."  
[46] "fBodyBodyGyroMag.mean.."        
[47] "fBodyBodyGyroMag.meanFreq.."     
[48] "fBodyBodyGyroJerkMag.mean.."   
[49] "fBodyBodyGyroJerkMag.meanFreq.."
[50] "tBodyAcc.std...X"               
[51] "tBodyAcc.std...Y"                
[52]  "tBodyAcc.std...Z"               
[53] "tGravityAcc.std...X"             
[54]  "tGravityAcc.std...Y"            
[55] "tGravityAcc.std...Z"             
[56]  "tBodyAccJerk.std...X"           
[57] "tBodyAccJerk.std...Y"            
[58]  "tBodyAccJerk.std...Z"           
[59] "tBodyGyro.std...X"               
[60]  "tBodyGyro.std...Y"              
[61] "tBodyGyro.std...Z"               
[62]  "tBodyGyroJerk.std...X"          
[63] "tBodyGyroJerk.std...Y"           
[64]  "tBodyGyroJerk.std...Z"          
[65] "tBodyAccMag.std.."               
[66]  "tGravityAccMag.std.."           
[67] "tBodyAccJerkMag.std.."           
[68]  "tBodyGyroMag.std.."             
[69] "tBodyGyroJerkMag.std.."          
[70]  "fBodyAcc.std...X"               
[71] "fBodyAcc.std...Y"                
[72]  "fBodyAcc.std...Z"               
[73] "fBodyAccJerk.std...X"            
[74]  "fBodyAccJerk.std...Y"           
[75] "fBodyAccJerk.std...Z"            
[76]  "fBodyGyro.std...X"              
[77] "fBodyGyro.std...Y"               
[78]  "fBodyGyro.std...Z"              
[79] "fBodyAccMag.std.."               
[80]  "fBodyBodyAccJerkMag.std.."      
[81] "fBodyBodyGyroMag.std.."          
[82] "fBodyBodyGyroJerkMag.std.."

## Appendix: Information on "Features" from Original Data Set

Feature Selection 
=================

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

>These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

>tBodyAcc-XYZ

>tGravityAcc-XYZ

>tBodyAccJerk-XYZ

>tBodyGyro-XYZ

>tBodyGyroJerk-XYZ

>tBodyAccMag

>tGravityAccMag

>tBodyAccJerkMag

>tBodyGyroMag

>tBodyGyroJerkMag

>fBodyAcc-XYZ

>fBodyAccJerk-XYZ

>fBodyGyro-XYZ

>fBodyAccMag

>fBodyAccJerkMag

>fBodyGyroMag

>fBodyGyroJerkMag

>The set of variables that were estimated from these signals are: 

>mean(): Mean value

>std(): Standard deviation

>mad(): Median absolute deviation

>max(): Largest value in array

>min(): Smallest value in array

>sma(): Signal magnitude area

>energy(): Energy measure. Sum of the squares divided by the number of values. 

>iqr(): Interquartile range 

>entropy(): Signal entropy

>arCoeff(): Autorregresion coefficients with Burg order equal to 4

>correlation(): correlation coefficient between two signals

>maxInds(): index of the frequency component with largest magnitude

>meanFreq(): Weighted average of the frequency components to obtain a mean frequency

>skewness(): skewness of the frequency domain signal 

>kurtosis(): kurtosis of the frequency domain signal 

>bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
>angle(): Angle between to vectors.

>Additional vectors obtained by averaging the signals in a signal window sample. These are >used on the angle() variable:

>gravityMean

>tBodyAccMean

>tBodyAccJerkMean

>tBodyGyroMean

>tBodyGyroJerkMean

Note:  The characters "()" and ":" were changed to "." for use in R in the project_summary data file.
