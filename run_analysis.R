library(dplyr)

setwd("C:/Users/farah/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train")
trainingSubjects <- read.table(file.path("subject_train.txt"))
trainingValues <- read.table(file.path("X_train.txt"))
trainingActivity <- read.table(file.path("y_train.txt"))

setwd("C:/Users/farah/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test")
testingSubjects <- read.table(file.path("subject_test.txt"))
testingValues <- read.table(file.path("X_test.txt"))
testingActivity <- read.table(file.path("y_test.txt"))

##-------****----------------------------------------------------#

setwd("C:/Users/farah/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
features <- read.table(file.path("features.txt"))
activity <- read.table(file.path("activity_labels.txt"))
#head(features)
# Step 1 - Merge the training and the test sets to create one data set
training <- cbind(trainingSubjects, trainingValues, trainingActivity)
testing <- cbind(testingSubjects, testingValues, testingActivity)
humanActivity <- rbind(training, testing)
x <- as.vector(features[,2])
colnames(humanActivity) <- c("Subject", x, "Activity")

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
columnsToKeep <- grepl("Subject|Activity|mean|Mean|std", colnames(humanActivity))
humanActivity <- humanActivity[, columnsToKeep]

# Step 3:Uses descriptive activity names to name the activities in the data set

humanActivity$Activity <- factor(humanActivity$Activity, levels = activity[, 1], labels = activity[, 2])

# Step 4 - Appropriately label the data set with descriptive variable names

renameHA_col <- colnames(humanActivity)
renameHA_col <- gsub("[\\(\\)-]", "", renameHA_col)
renameHA_col <- gsub("BodyBody", "Body", renameHA_col)
renameHA_col <- gsub("^f", "FrequencyDomain", renameHA_col)
renameHA_col <- gsub("^t", "TimeDomain", renameHA_col)
renameHA_col <- gsub("Acc", "Accelerometer", renameHA_col)
renameHA_col <- gsub("Gyro", "Gyroscope", renameHA_col)
renameHA_col <- gsub("Mag", "Magnitude", renameHA_col)
renameHA_col <- gsub("Freq", "Frequency", renameHA_col)
renameHA_col <- gsub("mean", "Mean", renameHA_col)
renameHA_col <- gsub("std", "Standard Deviation", renameHA_col)

colnames(humanActivity) <- renameHA_col

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

humanActivityMeans <- humanActivity %>% 
        group_by(Subject, Activity) %>%
        summarise_all(funs(mean))

write.table(humanActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
