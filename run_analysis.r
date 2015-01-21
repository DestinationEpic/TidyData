#run_analysis prepares a tidy data set from Source Data.
#It is 1 of 3 files required to complete the final project for Coursera class "Getting and Cleaning Data."
#See the README.md for an explanation of the script and CodeBook.md for a description of the variables, the data, and all
#transformations and work performed to clean up the data.

#SETUP ENVIRONMENT
        install.packages("RCurl")
        install.packages("reshape2")
        install.packages("plyr")
        install.packages("data.table")

        library(RCurl)
        library(reshape2)
        library(plyr)
        library(data.table)
        
        setwd("/Users/wendy/Coursera/GetCleanData/Final Project")

#CLEAN DATA
      
        #1a - Download and unzip zip file
                url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(url, destfile = "./HARData.zip", method = "curl")
                unzip("HARData.zip", overwrite = TRUE, exdir = "Data")

        #1b - Import Data
                #Activity Labels
                activity.labels <- read.table("./Data/activity_labels.txt")[,2]

                #Features
                features <- read.table("./Data/features.txt")[,2]
                
                #Training and Test Data
                print("Reading data...")
                subject.train <- read.table("./Data/train/subject_train.txt")
                x.train <- read.table("./Data/train/x_train.txt")
                y.train <- read.table("./Data/train/y_train.txt")
                subject.test <- read.table("./Data/test/subject_test.txt")
                x.test <- read.table("./Data/test/x_test.txt")
                y.test <- read.table("./Data/test/y_test.txt")
                print("Done reading data")
                
        #1c - Append the descriptive Activity to the y_* data.
                y.train[,2] <- activity.labels[y.train[,1]]
                y.test[,2] <- activity.labels[y.test[,1]]
                #Delete the no longer needed activity id.
                y.train$V1 = NULL
                y.test$V1 = NULL
                
        #1d - Clean up and label columns descriptively with CamelCase
                features <- gsub("(", "", features, fixed = TRUE) #Illegal
                features <- gsub(")", "", features, fixed = TRUE) #Illegal
                features <- gsub(",", "", features, fixed = TRUE) #Illegal
                features <- gsub("-", "", features, fixed = TRUE) #Unnecessary
                features <- gsub("mean", "Mean", features, fixed = TRUE) #CamelCase
                features <- gsub("std", "Std", features, fixed = TRUE) #CamelCase
                features <- gsub("^f", "Frequency", features) #CamelCase
                features <- gsub("^t", "Time", features) #CamelCase
                features <- gsub("Acc", "Accelerometer", features) #CamelCase
                features <- gsub("Gyro", "Gyroscope", features) #CamelCase
                features <- gsub("BodyBody", "Body", features) #Fixes Typo
                
                #Label the columns.
                names(subject.train) = "Subject"
                names(x.train) = features
                names(y.train) = "Activity"
                names(subject.test) = "Subject"
                names(x.test) = features
                names(y.test) = "Activity"
                print("Done Labeling Columns")
        
        #1e - Extract only the Features (columns) from x_train and x_test containing mean or standard deviation
                print("Extracting only means and stdevs")
                #Features whose measures are mean or standard deviation.
                Features2Extract <- grepl("Mean|Std", features)
                
                #Extract means and stdev features.
                x.train <- x.train[, Features2Extract]
                x.test <- x.test[, Features2Extract]
                print("Done Extracting only means and stdevs")
        
        #1f - Merge Training and Test Data sets
                print("Merging Test Data")
                test.data <- cbind(y.test, x.test, subject.test)
                print("Merging Training Data")
                training.data <- cbind(y.train, x.train, subject.train)
                print("Merging Test and Training Data")
                all.data <- rbind(test.data, training.data)
                #Remove all the columns referring to 'angle' measurements.
                all.data <- all.data[-grep('^angle',colnames(all.data))]
                #Remove the duplicated columns ending in 'MeanFreq'
                all.data <- all.data[-grep('MeanFreq$',colnames(all.data))]
                
                print("Done Merging all Data")
                
                #Housecleaning
                rm(x.test,x.train,y.test,y.train,subject.test,subject.train,features,activity.labels, Features2Extract, test.data, training.data)
        
 #STEP 2 -  Tidy the dataset and export.
                x <- melt(all.data, c("Subject","Activity"))
                TidyData <- dcast(x, Subject + Activity ~ variable, mean)
                print("Tidied AllData")
                write.table(TidyData, file ="TidyData.txt", sep = ",", qmethod = "double", row.name=FALSE)