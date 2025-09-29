# Getting and Cleaning Data - Course Project

This repository contains the work for the Coursera course **Getting and Cleaning Data** (Johns Hopkins University).

## Files

- `run_analysis.R`  
  R script that performs the data cleaning steps. Running this script will:
  1. Download and unzip the UCI HAR Dataset if not already present
  2. Merge the training and test sets to create one dataset
  3. Extract only the measurements on the mean and standard deviation
  4. Use descriptive activity names for the activities
  5. Appropriately label the dataset with descriptive variable names
  6. Create a tidy dataset with the average of each variable for each activity and subject, saved as `tidy_data.txt`

- `tidy_data.txt`  
  Final output: a tidy dataset containing the average of each variable for each subject and activity.

- `CodeBook.md`  
  Describes the variables, data, and transformations performed.

## How to run the analysis

1. Clone or download this repository.
2. Open `run_analysis.R` in RStudio (or run it in R).
3. Run the script. It will automatically:
   - Download the dataset if not present
   - Create the tidy dataset
4. The output file `tidy_data.txt` will appear in the repo root.

## Dependencies

This script uses the following R package:

- `dplyr`

If not installed, the script will install it automatically.
