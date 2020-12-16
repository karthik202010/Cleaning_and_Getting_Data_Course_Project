##setwd("<Working Directory for the UCI_HAR_Dataset>")
library(dplyr)
# Reading the X datasets
HAR_X_train <- read.table("./train/X_train.txt")
HAR_X_test <- read.table("./test/X_test.txt")

# Reading the features of the X datasets
HAR_X_features <-read.table("./features.txt")

# Reading the Y datasets
HAR_Y_train <- read.table("./train/y_train.txt")
HAR_Y_test <- read.table("./test/y_test.txt")

# Reading the subject datasets
HAR_subject_train <- read.table("./train/subject_train.txt")
HAR_subject_test <- read.table("./test/subject_test.txt")

# Reading the activity labels
HAR_activities <- read.table("./activity_labels.txt")

# Appropriately labels the data sets with descriptive variable names.
# Assigning column names
# Assigning column names to Y datasets
colnames(HAR_Y_train) <- "Activity_Code"
colnames(HAR_Y_test) <- "Activity_Code"

# Assigning column names to subject dataset
colnames(HAR_subject_train) <- "Subject"
colnames(HAR_subject_test) <- "Subject"

# Assigning column names to activities dataset
colnames(HAR_activities) <- c("Activity_Code","Activity")

# Assigning column names to X datasets
HAR_X_colnames<-HAR_X_features[,2]
colnames(HAR_X_train) <- HAR_X_colnames
colnames(HAR_X_test) <- HAR_X_colnames

# Merging the training and the test sets to create one data set.
HAR_train_dataset <- cbind(HAR_X_train,HAR_subject_train,HAR_Y_train)
HAR_test_dataset <- cbind(HAR_X_test,HAR_subject_test,HAR_Y_test)
HAR_dataset <- rbind(HAR_train_dataset,HAR_test_dataset)

#Extracts only the measurements on the mean and standard deviation for each measurement.
Extract_mean_sd_cols <- c(colnames(HAR_dataset[grep("mean\\(|std",colnames(HAR_dataset))]),"Subject","Activity_Code")

HAR_dataset_mean_sd <-HAR_dataset[,Extract_mean_sd_cols]

# Use descriptive activity names to name the activities in the data set
HAR_dataset_activity <- merge(HAR_dataset_mean_sd,HAR_activities, by.x = "Activity_Code", by.y = "Activity_Code", all = TRUE)
HAR_dataset_activity$Activity_Code <- NULL

# Creating the independent tidy data set with the average of each variable for each activity and each subject
Mean_HAR_Activity_Subject <- HAR_dataset_activity %>% group_by(Activity,Subject) %>% summarise(across(everything(),list(mean)))

# Naming the columns appropriately using gsub function
cols_Mean_HAR_Activity_Subject<- colnames(Mean_HAR_Activity_Subject[,3:ncol(Mean_HAR_Activity_Subject)])
new_cols_Mean_HAR_Activity_Subject <- gsub("_1","_Avg",cols_Mean_HAR_Activity_Subject)
colnames(Mean_HAR_Activity_Subject) <- c("Activity","Subject",new_cols_Mean_HAR_Activity_Subject)

# Create Output folder in the Work Directory if it does not exist
if(!file.exists("./Output")){dir.create("./Output")}

# Write the tidy data set to Output folder
write.table(Mean_HAR_Activity_Subject,file="./Output/HAR_Average_Measurement_of_Mean_SD_byActivity_Subject.txt",row.names = FALSE)
