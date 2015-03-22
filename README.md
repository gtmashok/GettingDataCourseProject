# GettingDataCourseProject
Repository for Course Project for Getting and Cleaning Data on Coursera 

#### How to run the run_analysis.r script.
<i><b>The script assumes that the 'UCI HAR' folder has already been downloaded and unzipped in the working directory.</b></i> The run_analysis.r script must also be located in same working directory in order to execute it.

Please load the <b>'plyr' and 'dplyr' packages</b> in that order before calling this script. If these have not been installed, use the <b>install.packages()</b> function to install them in the same order. Warnings can be safely ignored.

The first steps check to see if the directory is correct.   

The script is created as a function requiring NO inputs: simply enter <b>'source("run_analysis.r")'</b> in the R console followed by <b>'run_analysis()'</b>.

#### Explanation of the run_analysis.r script.
* The <b>'features' and 'activity_labels'</b> vectors assign the column names for the measurements and activity labels that correspond to each activity code respectively. 
* Data frames are created out of the measurement, activity, and subject files found in the 'test'and 'train' folders. Then the training and test data sets are merged using <b>rbind()</b> function for measurements, activities, and subjects (who participated). Column names are also assigned to each of the 3 sets of data. 
* For the measurement data set, only the measurements on mean and standard deviation are extracted. The hyphens and parentheses are removed from the measurement column names and replaced with a period(".")

##### Creation of tidy data set
The final <b>'for'</b> loop constructs a dataframe for the second, independent tidy data set as instructed in Step 5 of the Project. 
* <i>Each</i> subject participant and activity found in 'finaldata' are selected and the mean for each measurement column is calculated. 
* Then, each set of means are concantenated to a newly created <b>'tidydata'</b> dataframe for every subject and activity iteration.
* Finally, write.table function is used to save 'tidydata' as text file in the main folder of the user. 
* The output of 'tidydata' dimensions is produced to confirm creation and validity.




