================================================
README file describing the run_analysis.R script
================================================

1) Set your working directory to the folder where the UCI_HAR_Dataset is downloaded
2) call the dplyr package in the script. This will be used finally while taking averages grouped by Activity and Subject
3) Read the X_train, X_test, features, y_train, y_test, subject_train, subject_test, activity_labels txt files using read.table()
4) Appropriately labels the data sets with descriptive variable names.
	a) The Y datasets(HAR_Y_train and HAR_Y_test) takes "Activity_Code" as the variable name
	b) The subject datasets(HAR_subject_train and HAR_subject_test) takes "Subject" as the variable name
	c) The activity_labels dataset(HAR_activities) takes "Activity_Code","Activity" as the variable names
	d) The second column from the features data(HAR_X_features) is taken and that is used as variable names for the X datasets(HAR_X_train,HAR_X_test)
5) Merging the training and the test sets to create one data set
	a) First we use cbind() function to column bind all the train data sets(HAR_X_train,HAR_subject_train,HAR_Y_train) to get the train data set(HAR_train_dataset) and test data sets(HAR_X_test,HAR_subject_test,HAR_Y_test) to get the test data set(HAR_test_dataset)
	b) we the merge the train(HAR_train_dataset) and test(HAR_test_dataset) data sets using rbind() function to get the merged one data set(HAR_dataset)
6) Then extract only the measurements on the mean and standard deviation for each measurement. We use grep function and regular expression to get "mean\\(|std" to get variable names with mean( or std	in it. Using this we get the data set HAR_dataset_mean_sd with mean and std variables.
7) We use descriptive activity names to name the activities in the data set by taking them from HAR_activities and using the merge() function to get HAR_dataset_activity dataset
8) We create the independent tidy data set (Mean_HAR_Activity_Subject) with the average of each variable for each activity and each subject. To achieve this we use:
	a) the group_by function from dplyr package to group by Activity and Subject
	b) this group_by is applied on the summarise function of dplyr package which gets the mean of all the variables
9) We use the gsub function to clean up the variable names and include a "_Avg" to show that they are averages
10) Finally, we create the Output folder if it is not already created and then use write.table to save the dataset to the Output folder as HAR_Average_Measurement_of_Mean_SD_byActivity_Subject.txt

Note: HAR used above stands for Human Activity Recognition
