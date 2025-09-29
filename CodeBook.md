# CodeBook for the Tidy Dataset

This CodeBook describes the variables, data, and transformations performed to clean up the dataset.

## Source Data

Original data: [UCI Machine Learning Repository - Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The dataset includes measurements from accelerometers and gyroscopes of the Samsung Galaxy S smartphone, collected from 30 volunteers performing six activities.

## Transformations

The following steps were applied (implemented in `run_analysis.R`):

1. **Merge training and test sets** into one dataset.
2. **Extract mean and standard deviation measurements** using column names containing "mean()" or "std()".
3. **Replace activity codes with descriptive names** using `activity_labels.txt`.
4. **Clean variable names**:
   - `t` → `Time`
   - `f` → `Frequency`
   - `Acc` → `Accelerometer`
   - `Gyro` → `Gyroscope`
   - `Mag` → `Magnitude`
   - `BodyBody` → `Body`
   - `-mean()` → `Mean`
   - `-std()` → `STD`
   - `-freq()` → `Frequency`
   - `angle` → `Angle`
   - `gravity` → `Gravity`
5. **Create tidy dataset** with the average of each variable for each subject and activity.

## Variables in Final Dataset

- **Identifiers**:
  - `subject`: ID of the test subject (1–30)
  - `activity`: Activity performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

- **Measurements** (averages of each):  
  - TimeBodyAccelerometerMeanX  
  - TimeBodyAccelerometerMeanY  
  - TimeBodyAccelerometerMeanZ  
  - TimeBodyAccelerometerSTDX  
  - TimeBodyAccelerometerSTDY  
  - TimeBodyAccelerometerSTDZ  
  - … and so on for all mean/std features from accelerometer, gyroscope, magnitude, etc.

In total, the final tidy dataset contains **180 rows** (30 subjects × 6 activities) and **68 columns** (66 measurement variables + subject + activity).
