
Producing a tidy dataset from a set of files
============================================
Author: akbuddana
Date: 06/21/2015
Course: Geting and Cleaning Data - Course Project 2
===================================================

Brief description of the datasets:
==================================

This data is from a group of 30 volunteers that performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) weating a human activity recognition device. The datasets are provided in 'train', 'test' datasets which included the measurement data in the form of several features, subject vector, an activity vector, description files for features, label files for features and activities. 

Defining a tidy dataset:
========================

As per the course project, there are five steps that needs to be taken to consideration while building a dataset that is clean and is ready for analysis. This document will give step by step instructions on how to run the R code that transforms the input datasets into a tidy dataset following these five steps.

Task 1: Merges the training and the test sets to create one data set.
=====================================================================
Step I: First set the working directory and read all the files.
---------------------------------------------------------------
1) Set the working directory first to the extracted file folder where there are other folders like train, test etc.
2) Read the Train data set(dim = 7352*561) from the train folder.
3) Read the Activity vector(dim = 7352*1) for train dataset.Name the column as "Activity".
4) Read the Subject vector(dim = 7352*1) for train dataset. Name the column as "Subject".
5) Read the Test data set(dim = 2947*561) from the train folder.
6) Read the Activity vector(dim = 2947*1) for test dataset.Name the column as "Activity".
7) Read the Subject vector(dim = 2947*1) for test dataset.Name the column as "Subject".
8) Read the 561-feature vector that contains the names of measurements.
9) Read the activity label file that names the six activities that are present in the activity vectors. 

Note:
=====
There are other measurement files in the inertia folder for train and test datasets, but reading Task 2 from the course project, only the measurements that have mean and std in their names are to be taken. Hence didn't read those files.

Step II: Manipulate the files and 'bind' the two datasets(not merge)
---------------------------------------------------------------------
1) First , get a transpose of features vector to get a single row of feature names.
2) Then assign the names(train) and names(test) to be the transposed features vector, which is now a single row of column names.
3) Column bind the train subject and activity vectors to the Train dataset. Also, make a new column = "Sample" that is named as 'Train' to identify the sample. Now the dim of train is 7352*564
4) Column bind the test subject and activity vectors to the Test dataset. Also, make a new column = "Sample" that is named as 'Test' to identify the sample.Now the dim of test is 2947*564.
5) After making sure that the number of columns are all aligned carefully, both train and test datasets are now ready to be row binded. The new dataset, train_test after binding has dim = 10299*564

Task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
===============================================================================================
Step III: Grep for the pattern "-mean()" and "-std()"
----------------------------------------------------
1) Get the Subject, Activity, Sample and any column that contains the strings "-mean()" and "-std()". Used grep for this and extracted the columns. 
Desired file extract's dim = 10299*69.Name this dataset as Clean_data1.

Task 3: Uses descriptive activity names to name the activities in the data set
==============================================================================
Step IV: Get activity label instead of the numbers for activity names.
----------------------------------------------------------------------
1) From the activity label file, there are two columns that has a mapping of activity to its name.
2) Merge the extracted file from Task 2 with the activity label file providing by.x and by.y.
3) The activity names now correspond to the activity number column and now, the number column can be replaced by the string column. Dim of the file at this step = 10299*69 since no rows are added and an existing column got replaced.


Task 4: Appropriately labels the data set with descriptive variable names. 
==========================================================================
This is taken care of in Step II above and thought that the naming convention should be kept intact.
Make.names can be used but, the original naming convention is lost.
So, the datasets form Task 3 is the clean one at this point with dim = 10299*69

Task 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
======================================================================================================================
Step V: Reshaping into long form, aggregating and reshape back to wide form
---------------------------------------------------------------------------
1) The data from Step IV above, is reshaped into long form by using 'melt' function. The ID variables are Subject and Activity and the measurement variables are all the measurements in 66 columns.
2) Calculate the mean for each subject, activity and measurement in the long form. The long form has dim = 30*6*66 = 11880 rows and 4 columns for three qualitative columns and an quantitative column for the mean.
3) Reshape the long form back to wide form using dcast(dataframe-cast) to obtain a data frame of 180 rows and 68 variables. Name this dataset as Clean_data2.












