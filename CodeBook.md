CodeBook
========================================================

The file "project_summary.txt" contains the group average of motion measurement variables collected using Samsung smartphones.  As specified in the assignment instructions, groups were defined as combinations of 6 activities and 30 test subjects.  Thus, the 10,299 motion observations in the original data were combined into 180 rows with the means of 79 motion measurement variables. 




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
