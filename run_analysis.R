# run_analysis.R
# Coursera Getting and Cleaning Data - Peer-graded Assignment
#
# This script:
#  1. Downloads and unzips the UCI HAR Dataset if not already present
#  2. Merges the training and test sets
#  3. Extracts mean and standard deviation measurements
#  4. Uses descriptive activity names
#  5. Labels dataset with descriptive variable names
#  6. Creates a tidy dataset with the average of each variable for each activity and subject

# Load required package
if (!require("dplyr")) install.packages("dplyr")
library(dplyr)

# Step 1: Download and unzip data if not present
data_dir <- "data"
zip_file <- file.path(data_dir, "dataset.zip")
dataset_dir <- file.path(data_dir, "UCI HAR Dataset")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!dir.exists(data_dir)) {
  dir.create(data_dir)
}

if (!dir.exists(dataset_dir)) {
  download.file(url, zip_file, mode = "wb")
  unzip(zip_file, exdir = data_dir)
}

# Step 2: Load data
features <- read.table(file.path(dataset_dir, "features.txt"), col.names = c("index", "feature"))
activities <- read.table(file.path(dataset_dir, "activity_labels.txt"), col.names = c("code", "activity"))

subject_train <- read.table(file.path(dataset_dir, "train", "subject_train.txt"), col.names = "subject")
y_train <- read.table(file.path(dataset_dir, "train", "y_train.txt"), col.names = "code")
x_train <- read.table(file.path(dataset_dir, "train", "X_train.txt"), col.names = features$feature)

subject_test <- read.table(file.path(dataset_dir, "test", "subject_test.txt"), col.names = "subject")
y_test <- read.table(file.path(dataset_dir, "test", "y_test.txt"), col.names = "code")
x_test <- read.table(file.path(dataset_dir, "test", "X_test.txt"), col.names = features$feature)

# Merge training and test sets
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
merged_data <- rbind(train, test)

# Step 3: Extract mean and standard deviation columns
tidy_data <- merged_data %>%
  select(subject, code, contains("mean"), contains("std"))

# Step 4: Replace activity codes with descriptive names
tidy_data$code <- activities[tidy_data$code, "activity"]

# Step 5: Clean variable names
names(tidy_data)[2] <- "activity"
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("-mean\\(\\)", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-std\\(\\)", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-freq\\(\\)", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("angle", "Angle", names(tidy_data))
names(tidy_data) <- gsub("gravity", "Gravity", names(tidy_data))

# Step 6: Create tidy dataset with averages
final_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# Save the final dataset
write.table(final_data, "tidy_data.txt", row.name = FALSE)

