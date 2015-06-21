1.Merges the training and the test sets to create one data set.
# Assumes that the data is in the working directory,get all Training data first. Skipping Inertial signal files since step 2 asks for extracting only mean and std dev of measurements
#Measurement data
train <- read.table("train/X_train.txt")
test<- read.table("test/X_test.txt")
# Activity vector
train_l <- read.table("train/y_train.txt")
names(train_l)  = "Activity"
test_l <- read.table("test/y_test.txt")
names(test_l)  = "Activity"
# Subject Vector
subject_train<-read.table("train/subject_train.txt")
names(subject_train)  = "Subject"
subject_test<-read.table("test/subject_test.txt")
names(subject_test)  = "Subject"
# Feature(measurement) label data frame
features = read.table("features.txt")

#Get the transpose of Features to make them as column names 
features_t = t(features[,2])

4.Appropriately labels the data set with descriptive variable names. 
#Name the columns of Training and Test datasets 
names(train) <- features_t
names(test) <- features_t

#Attach the activity and subject to the Measurement data for both Train and Test. Additional variable is added to identify the rows belonging to test vs. train
train = cbind(subject_train,train_l,train)
train$sample <- "Train"
test = cbind(subject_test,test_l,test)
test$sample <- "Test"
#Join Train and Test data
train_test <- rbind(train,test)

2.Extracts only the measurements on the mean and standard deviation for each measurement. This also retains the features labels. Hence step 4 is also answered in this code

#Extract only the mean and std variables for train and test data
train_test[,c(1,2,564,grep("-mean()",names(train_test),fixed=TRUE),grep("-std()",names(train_test),fixed=TRUE))] -> train_test_extract

3.Uses descriptive activity names to name the activities in the data set
#Get activity labels dataset
activity_labels<-read.table("activity_labels.txt")
train_test_data<-merge(train_test_extract,activity_labels,by.x="Activity",by.y="V1",all.x=TRUE)
train_test_data$Activity<-train_test_data$V2
train_test_data<-train_test_data[,1:69]

#Clean data 1
Clean_Data1<-train_test_data

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Get the long form of data using reshape2 package and melt function
library(reshape2)
train_test_long <- melt(train_test_data,id.vars=c("Subject","Activity"),measure=c(names(train_test_data)[4:69]))
train_test_long1 <- aggregate(x = train_test_long, by = list(Subject = train_test_long$Subject,Activity = train_test_long$Activity,Measurement = train_test_long$variable), FUN = "mean",na.rm=TRUE,na.action=NULL)

#Provide a wide form of dataset with 180 rows and 68 columns(for measurements)
Clean_data2 <- dcast(train_test_long1[,c(1,2,3,7)], Subject+Activity ~ Measurement)









