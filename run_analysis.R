library("data.table")

# load some data.frames from files
train_activity_numbers <- read.table("./train/y_train.txt")
test_activity_numbers <- read.table("./test/y_test.txt")
activity_labels <- read.table("./activity_labels.txt")
train_subjects <- read.table("./train/subject_train.txt")
test_subjects <- read.table("./test/subject_test.txt")
train_data <- read.table("./train/X_train.txt")
test_data <- read.table("./test/X_test.txt")
features <- read.table("./features.txt")

# replace activity codes w/ descriptive string
train_activity <- merge(train_activity_numbers, activity_labels)["V2"]
test_activity <- merge(test_activity_numbers, activity_labels)["V2"]

# add subject and activity columns to the main data.frame
train <- cbind(train_subjects, train_activity, train_data)
test <- cbind(test_subjects, test_activity, test_data)

# merge the test and train data
d <- rbind(train, test)

# meaningful labels, sans bad characters
colnames(d) <- gsub("[-(),]" ,"", c("subject", "activity", t(features["V2"])))

# remove columns w/o 'mean' or 'std' in their label
names <- names(d)
means_and_std <- names[grep("(subject|activity|mean|std)", names, ignore.case = TRUE)]
subset <- subset(d, select=means_and_std)

# average per activity/subject
dt <- data.table(subset, key="subject,activity")
final <- dt[, lapply(.SD,mean), by=key(dt)]

# write final tidy dataset to file
write.table(final, "./final.txt")

