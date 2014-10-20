
## R project Peer Assessment "Getting and Cleaning Data"
## Giuliano Puttini Filippini
## 10th, October, 2014

## The purpose of this script is to demonstrate the steps to collect, clean and make a tidy 
## data set for further analysis.
## The data consists on information about data collected from the accelerometers from the 
## Samsung Galaxy S smartphone. A full description is available at the site where the data 
## was obtained: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## This analysis uses the package reshape2, if you don't have this installed you can by 
## the following R code:
## install.packages("reshape2")

## 0 - library for package reshape2
library(reshape2)

## 1 - download file
if(!file.exists("./dados")){dir.create("./dados")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./dados/Dataset.zip")){
  download.file(fileUrl,destfile="./dados/Dataset.zip",method="wget")
} 
unzip("./dados/Dataset.zip",exdir="./dados")

## 2 - read the tables of interest
## Train Data
x_train<-read.table("./dados/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./dados/UCI HAR Dataset/train/y_train.txt")
subject_train <-read.table("./dados/UCI HAR Dataset/train/subject_train.txt")

## Test Data
x_test<-read.table("./dados/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./dados/UCI HAR Dataset/test/y_test.txt")
subject_test <-read.table("./dados/UCI HAR Dataset/test/subject_test.txt")

## Labels Data
activity_labels<-read.table("./dados/UCI HAR Dataset/activity_labels.txt")
features<-read.table("./dados/UCI HAR Dataset/features.txt")

## 3 - Join tables
## Train Data
c_train<-cbind(subject_train,y_train,x_train)
## Test Data
c_test<-cbind(subject_test,y_test,x_test)
## Complete Data
c_data<-rbind(c_train,c_test)

## 4 - Input labels on the full data
## column names
colnames(c_data)<-c("subject","activity",as.character(features[,2]))

## 5 - select only the fields with "mean and standard deviation"
## ("subject" and "activity" will be ids for creating the tidy data)
c_data_filter <- c_data[,grep("mean|std|subject|activity",names(c_data))]

## activity labels
colnames(activity_labels)<-c("V1","activity.label")
c_data_l <- merge(c_data_filter,activity_labels,by.x="activity",by.y="V1")

## 6 - creates the final table with the means of each measure by activity and subject
passo1<-melt(c_data_l,id.var=c("subject","activity.label"))
passo2<-dcast(passo1,subject+activity.label ~ variable, mean)

## 7 - creates a .txt file with the mesurements - a tidy data
write.table(passo2,file="./dados/tidy_data.txt",row.name=FALSE)
