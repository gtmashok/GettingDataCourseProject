# GettingDataCourseProject
Repository for Course Project for Getting and Cleaning Data on Coursera 

##### Instructions for running run_analysis.r script.
Please load the 'plyr' and 'dplyr' packages in that order before calling this script. If these have not been installed, use the
install.packages() function to install them in the same order. Warnings can be safely ignored.

The first steps check to see if the directory is correct. This assumes that 'getdata-projectfiles...' folder has already been downloaded and unzipped AND that the working directory is set to the location of the unzipped folder in the local machine.

The 'features' and 'activity_labels' vectors assign the column names for the measurements and activity labels that correspond to each activity code respectively. Data frames are created out of the measurement, activity, and subject files found in the 'test'and 'train' folders. Then the training and test data sets are merged using rbind() function for measurements, activities, and subjects (who participated). Column names are also assigned to each of the 3 sets of data. For the measurement data set, only the measurements on mean and standard deviation are extracted. The hyphens and parentheses are removed from the measurement column names and replaced with a period(".")



