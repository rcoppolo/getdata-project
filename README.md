getdata-project
===============

The run_analysis.R script assumes it is run inside the unzipped UCI directory available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The script works as follows:

First we read in all required data files w/ read.table().

We then merge the activity\_labels w/ the y\*\_.txt activity datasets, thus including a descriptive string for the activities.

We add the activity dataset and subject dataset as columns to the main dataset w/ cbind(), for both training and test.

Finally we merge the training and test datasets w/ rbind(), created one table with all the data.

Using colnames() we apply descriptive column names to the data, labeling the measurement data w/ their respective strings in features.txt and labeling activity and subject manually.

We then use the grep() function to create a subset of the data containing only features w/ the strings "mean" and "std" in their label (while still maintaining "activity" and "subject").

We use the data.frame library to complete the project, setting the dataset's key to be based on both subject AND activity, and calculating a new dataset on the mean of each feature per key.

We write the resulting data to a file.
