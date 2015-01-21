---
title: "CodeBook.md"
author: "Wendy Drake"
date: "January 13, 2015"
output: html_document
---

This is the CodeBook for Coursera Data Specialization class "Getting and Cleaning Data" Final Programming Assignment. It is 1 of 3 files (**run_analysis.r** and **README.txt** are the other files) required to complete the final project for Coursera class "Getting and Cleaning Data."

Link to problem's [source data]("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip").

## Assumptions
1. The working directory to which files are downloaded is set with setwd(). 
2. The following packages are installed and loaded: RCurl, plyr, data.table, reshape2.

## Data Manipulation Actions
The following steps transformed the data from the original data set to the output file **"TidyData.txt"**.

###1. Clean the data prior to merging with the following sub-steps in order.

a. Download and unzip the zip file.

b. Import the necessary data: the six activity labels, 561 features, and the subject, x and y data for training and test. It is not necessary to import  inertial data because the mean and standard deviation data is included in the test and training data.

c. Replace the numeric codes for activities with a **new variable, Activity**, for descriptive activities then delete the no longer needed numeric code.

d. Using [CamelCase Guidelines](http://en.wikipedia.org/wiki/CamelCase) for identifier naming, add descriptive labels for features. I also found the [Gaston Sanchez's Handling & Processing Strings](http://gastonsanchez.com/Handling_and_Processing_Strings_in_R.pdf) useful for the regular expressions to create the search and replace expressions to clean up the column labels.

e. Select only the features containing mean and standard deviation data for merging. A note on angle features. The request called for *"Extracts only the measurements on the mean and standard deviation for each measurement."* Since the angles are calculated from mean and standard deviation, rather than means or standard deviations, these measures are deleted after the merge in step 1f below.

f. Merge the 3 training and 3 test files, then merge the merged training file with the merged test file into the all.data dataframe. Looking at the dimensions of the imported dataframes functions as a check to assure like tables are being merged. Delete angle measurements. Remove the duplicated columns ending with *MeanFreq*.

###2. Tidy the Data

The all.data dataframe created in step 1f contains clean data for analytics: 10,299 observations of 81 variables. However, this dataset is "untidy" with respect to [Hadley Wickham's Tidy Data paper](http://vita.had.co.nz/papers/tidy-data.pdf) definition of tidy data. From the merged data, the script fixes 1 of the five Tidy Data problems described in the paper: the feature column headings are values, not variables.

a. Use the reshape package to call the melt function to reconfigure the measures and values into column names. This creates "tall" data. Each observation or row is the unique combination of sensor measurements for each subject/activity pair. See this [Quick R Tutorial on Reshaping Data](http://www.statmethods.net/management/reshape.html) for guidance. The [Introduction by Hadley Wickham](http://had.co.nz/reshape/introduction.pdf) provided useful code examples. More detail on the reshape package can be found in [Hadley Wickham's article on the reshape package](http://www.jstatsoft.org/v21/i12/paper). 

b. "Cast" the melted data for standard deviations and for means. Note that the syntax for *dcast* does NOT require the column names to be in quotes. The references in (2a) above can also be used to further understand the syntax of cast. Drop the angle measurement columns. Note that the cast data (TidyData) is now a collection of 180 grouped means, NOT individual observations.

c. Write the output to a txt file.


## About the Tidy Data file: "TidyData.txt"
This independent tidy data set contains 180 mean observations for each unique subject:activity pair for 79 measurements.
The output format is comma separated values (txt) and is Excel input ready.

## Description of Tidied Data Variables
Measurements are normalised and so unit-less.
As noted in 1d above and due to the length of the variable names I have used a CamelCase naming standard to make them more readible.

|Column |Column Name	|Column Description|
|:-----:|:---------------|:-----------------------|
|1|Subject|The subject being measured. Values range from the numeric 1 to 30.|
|2|Activity|The activity being performed during measurement. Values are one of six activities: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.|
|3|TimeBodyAccelerometerMeanX|Mean for the mean in the X direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|4|TimeBodyAccelerometerMeanY|Mean for the mean in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|5|TimeBodyAccelerometerMeanZ|Mean for the mean in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|6|TimeBodyAccelerometerStdX|Mean for the standard deviation in the X direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|7|TimeBodyAccelerometerStdY|Mean for the standard deviation in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|8|TimeBodyAccelerometerStdZ|Mean for the standard deviation in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|9|TimeGravityAccelerometerMeanX|Mean for the mean in the X direction for the Time domain on the sensor Accelerometer for the Gravity motion component.|
|10|TimeGravityAccelerometerMeanY|Mean for the mean in the Y direction for the Time domain on the sensor Accelerometer for the Gravity motion component.|
|11|TimeGravityAccelerometerMeanZ|Mean for the mean in the Y direction for the Time domain on the sensor Accelerometer for the Gravity motion component.|
|12|TimeGravityAccelerometerStdX|Mean for the standard deviation in the X direction for the Time domain on the sensor Accelerometer for the Gravity motion component.|
|13|TimeGravityAccelerometerStdY|Mean for the standard deviation in the Y direction for the Time domain on the sensor Accelerometer for the Gravity motion component.|
|14|TimeGravityAccelerometerStdZ|Mean for the standard deviation in the Y direction for the Time domain on the sensor Accelerometer for the Gravity motion component.|
|15|TimeBodyAccelerometerJerkMeanX|Mean for the mean in the X direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|16|TimeBodyAccelerometerJerkMeanY|Mean for the mean in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|17|TimeBodyAccelerometerJerkMeanZ|Mean for the mean in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|18|TimeBodyAccelerometerJerkStdX|Mean for the standard deviation in the X direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|19|TimeBodyAccelerometerJerkStdY|Mean for the standard deviation in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|20|TimeBodyAccelerometerJerkStdZ|Mean for the standard deviation in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|21|TimeBodyGyroscopeMeanX|Mean for the mean in the X direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|22|TimeBodyGyroscopeMeanY|Mean for the mean in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|23|TimeBodyGyroscopeMeanZ|Mean for the mean in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|24|TimeBodyGyroscopeStdX|Mean for the standard deviation in the X direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|25|TimeBodyGyroscopeStdY|Mean for the standard deviation in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|26|TimeBodyGyroscopeStdZ|Mean for the standard deviation in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|27|TimeBodyGyroscopeJerkMeanX|Mean for the mean in the X direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|28|TimeBodyGyroscopeJerkMeanY|Mean for the mean in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|29|TimeBodyGyroscopeJerkMeanZ|Mean for the mean in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|30|TimeBodyGyroscopeJerkStdX|Mean for the standard deviation in the X direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|31|TimeBodyGyroscopeJerkStdY|Mean for the standard deviation in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|32|TimeBodyGyroscopeJerkStdZ|Mean for the standard deviation in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|33|TimeBodyAccelerometerMagMean|Mean for the mean in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|34|TimeBodyAccelerometerMagStd|Mean for the standard deviation in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|35|TimeGravityAccelerometerMagMean|Mean for the mean in the Y direction for the Time domain on the sensor Accelerometer for the Gravity motion component.|
|36|TimeGravityAccelerometerMagStd|Mean for the standard deviation in the Y direction for the Time domain on the sensor Accelerometer for the Gravity motion component.|
|37|TimeBodyAccelerometerJerkMagMean|Mean for the mean in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|38|TimeBodyAccelerometerJerkMagStd|Mean for the standard deviation in the Y direction for the Time domain on the sensor Accelerometer for the Body motion component.|
|39|TimeBodyGyroscopeMagMean|Mean for the mean in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|40|TimeBodyGyroscopeMagStd|Mean for the standard deviation in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|41|TimeBodyGyroscopeJerkMagMean|Mean for the mean in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|42|TimeBodyGyroscopeJerkMagStd|Mean for the standard deviation in the Y direction for the Time domain on the sensor Gyroscope for the Body motion component.|
|43|FrequencyBodyAccelerometerMeanX|Mean for the mean in the X direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|44|FrequencyBodyAccelerometerMeanY|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|45|FrequencyBodyAccelerometerMeanZ|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|46|FrequencyBodyAccelerometerStdX|Mean for the standard deviation in the X direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|47|FrequencyBodyAccelerometerStdY|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|48|FrequencyBodyAccelerometerStdZ|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|49|FrequencyBodyAccelerometerMeanFreqX|Mean for the mean in the X direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|50|FrequencyBodyAccelerometerMeanFreqY|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|51|FrequencyBodyAccelerometerMeanFreqZ|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|52|FrequencyBodyAccelerometerJerkMeanX|Mean for the mean in the X direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|53|FrequencyBodyAccelerometerJerkMeanY|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|54|FrequencyBodyAccelerometerJerkMeanZ|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|55|FrequencyBodyAccelerometerJerkStdX|Mean for the standard deviation in the X direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|56|FrequencyBodyAccelerometerJerkStdY|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|57|FrequencyBodyAccelerometerJerkStdZ|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|58|FrequencyBodyAccelerometerJerkMeanFreqX|Mean for the mean in the X direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|59|FrequencyBodyAccelerometerJerkMeanFreqY|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|60|FrequencyBodyAccelerometerJerkMeanFreqZ|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|61|FrequencyBodyGyroscopeMeanX|Mean for the mean in the X direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|62|FrequencyBodyGyroscopeMeanY|Mean for the mean in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|63|FrequencyBodyGyroscopeMeanZ|Mean for the mean in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|64|FrequencyBodyGyroscopeStdX|Mean for the standard deviation in the X direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|65|FrequencyBodyGyroscopeStdY|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|66|FrequencyBodyGyroscopeStdZ|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|67|FrequencyBodyGyroscopeMeanFreqX|Mean for the mean in the X direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|68|FrequencyBodyGyroscopeMeanFreqY|Mean for the mean in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|69|FrequencyBodyGyroscopeMeanFreqZ|Mean for the mean in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|70|FrequencyBodyAccelerometerMagMean|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|71|FrequencyBodyAccelerometerMagStd|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|72|FrequencyBodyAccelerometerJerkMagMean|Mean for the mean in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|73|FrequencyBodyAccelerometerJerkMagStd|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Accelerometer for the Body motion component.|
|74|FrequencyBodyGyroscopeMagMean|Mean for the mean in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|75|FrequencyBodyGyroscopeMagStd|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|76|FrequencyBodyGyroscopeJerkMagMean|Mean for the mean in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
|77|FrequencyBodyGyroscopeJerkMagStd|Mean for the standard deviation in the Y direction for the Frequency domain on the sensor Gyroscope for the Body motion component.|
