getdata
===========
* This project contains run_analysis.R script and CodeBook.md.
* Run the script and you get 'result.txt', which averages each original 'HAR(Human Activity Recognition)' data features (but only interesting(ex.-mean(),-std()) columns) for each subject, activity.
* CodeBook.md explains 'result.txt' columns.

* The script assumes that:
** Data folder is located with the same directory with the script
** The data folder should have the name as 'UCI Har Dataset' and includes such as:
=========
UCI HAR DATASET
|   activity_labels.txt
|   features.txt
|   features_info.txt
|   README.txt
|
+---test
|   |   subject_test.txt
|   |   X_test.txt
|   |   y_test.txt
|   |
|   \---Inertial Signals
|           body_acc_x_test.txt
|           body_acc_y_test.txt
|           body_acc_z_test.txt
|           body_gyro_x_test.txt
|           body_gyro_y_test.txt
|           body_gyro_z_test.txt
|           total_acc_x_test.txt
|           total_acc_y_test.txt
|           total_acc_z_test.txt
|
\---train
    |   subject_train.txt
    |   X_train.txt
    |   y_train.txt
    |
    \---Inertial Signals
            body_acc_x_train.txt
            body_acc_y_train.txt
            body_acc_z_train.txt
            body_gyro_x_train.txt
            body_gyro_y_train.txt
            body_gyro_z_train.txt
            total_acc_x_train.txt
            total_acc_y_train.txt
            total_acc_z_train.txt
=========
* You can obtain orignal source data from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
