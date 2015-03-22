run_analysis <- function() {
	## Please load the 'plyr' and 'dplyr' packages in that order before
	## calling this script. If these have not been installed, use the 
	## install.packages() function to install them in the same order. 
	## Warnings can be safely ignored.
	
	## The first steps check to see if the directory is correct. 
	## This assumes that 'getdata-projectfiles...' folder has already
	## been downloaded and unzipped AND that the working directory
	## is set to the location of the unzipped folder in the local machine.
	
	if (!file.exists("UCI HAR Dataset")) {
		setwd("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
	}

	## 'features' and 'activity_labels' assign the column names for the  
	## measurements and activity labels that correspond to each activity code
	## respectively.
	
	features <- read.table("features.txt",as.is=TRUE)
	activity_labels <- read.table("activity_labels.txt",as.is=TRUE)
	
	## The next two segments of code creates data frames out of the measurement, 
	## activity, and subject files found in the 'test'and 'train' folders.
	if (file.exists("test")) {
		setwd("test")							## Open the 'test' folder to read files in next lines
		Xtest <- read.table("X_test.txt",as.is=TRUE)
		Ytest <- read.table("y_test.txt",as.is=TRUE)
		subtest <- read.table("subject_test.txt",as.is=TRUE)
		setwd("..")								## Goes up the folder structure to open next set of files.
	}
	if (file.exists("train")) {
		setwd("train")							## Open the 'train' folder to read files in next lines
		Xtrain <- read.table("X_train.txt",as.is=TRUE)
		Ytrain <- read.table("y_train.txt",as.is=TRUE)
		subtrain <- read.table("subject_train.txt",as.is=TRUE)
		setwd("..")								## Goes up the folder structure.
	}


	## The next 3 segments of code merge the training and test data sets
	## using rbind() function for measurements, activities, and subjects
	## (who participated). Column names are also assigned to each of the 
	## 3 sets of data. 

	measure <- rbind(Xtest,Xtrain)		
	names(measure) <- features[,2]			## Assign column names to 'measure' data frame
	
	activity <- rbind(Ytest,Ytrain)
	activity <- join(activity,activity_labels)	## Join activity vector with activity labels to provide
									## descriptive activity names in the activity data set.
	
	names(activity) <- c("actCode","actName")		## Assign column names to 'activity' data frame
 
	subject <- rbind(subtest,subtrain)			
	names(subject) <- "subNumber"				## Assign column names to 'subject' data frame

	
	
	## The next lines of code extract only the measurements on 
	## the mean and standard deviation.

	mColName <- colnames(measure)		## Capture names of columns in 'measure' table.
	col1 <- grep("mean",mColName)		## Capture column numbers that contain mean measurements.
	col2 <- grep("std",mColName)		## Capture column numbers that contain std. dev. measurements.
	mColNum <- sort(c(col1,col2))		## Concatenate column numbers from col1 and col2 and sort in ascending order.
	
	measure <- measure[,mColNum]		## Update 'measure' to only include mean and standard deviation column 
							## measurements based on column numbers captured earlier.
	
	colName <- colnames(measure)		## Store the column names of 'measure' in a vector, colName.
	colName <- gsub("\\()","",colName)	## Remove the '()' and replace the hyphens ('-')
	colName <- gsub("-",".",colName)	## with periods and store into colName.
	colnames(measure) <- colName		## Then, 'colName' is reassigned to column names of 'measure' data frame.
	
	
	## Merge the 'subject','activity', and 'measure' data frames
	## into one final data frame ('finaldata'). 
	
	finaldata <- cbind(subject,activity,measure)	
									
	
	## The for loop below constructs a dataframe for the second, independent tidy data set
	## as instructed in Step 5 of the Project by selecting each subject participant and activity
	## found in 'finaldata' and calculates the mean for each measurement column.
						
	tidydata <- data.frame()		## Initialize the dataframe that will contain tidy data	
	for (i in 1:max(subject)) {		## Filter only data of each activity of each subject.
		for (j in seq_along(activity_labels[,2])) { 
			tempdata <- finaldata[finaldata$subNumber == i & finaldata$actName == activity_labels[j,2],]
			meandata <- sapply(tempdata[,-c(1,2,3)],mean)		## Mean is calculated after excluding first 3 columns which are non-measurement columns.
			tempdata <- tempdata[1,c(1,2,3)]				## Subject and Activity information is retained separately.
			tempdata <- c(tempdata,meandata)				## Calculated row of means and subject and activity information is reassigned to 'tempdata', which is now a list.	
			tempdata <- data.frame(matrix(unlist(tempdata), nrow=1, byrow=T))		## 'tempdata' is converted back to a dataframe

			tidydata <- rbind(tidydata,tempdata)			## Each 'tempdata' data row is added to the 'tidydata' dataframe.
		}
	}
	names(tidydata) <- names(finaldata)		## Assign same set of column names as 'finaldata' since they are in same order with same data type.
	

	## Using write.table function to save 'tidydata' as text file in the main folder of the user

	setwd("../..")
	write.table(tidydata, file = "tidydata.txt", row.name = FALSE)

	dim(tidydata) ## Output of tidydata dimensions to confirm creation and validity.
	
}