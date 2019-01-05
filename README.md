# GettingandCleaningData_Project_Coursera_JHU

1. First I read data from the txt files in the train folder - subject_train, X_train, y_train; then I read from test folder - subject_test, X_test, Y_test; After that I read from features and activity files.

2. I merged the train data with test data and a complete data set

3. Particularly extracted out the columns with mean and standard deviation on it using grepl function

4. Updated the Activity column of the data with the help of the other activity table

5. Renaming the column for better readability

5. Finally grouped by the data to find mean for each activity and subject
