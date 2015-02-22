library(plyr)

#Reading and merging data sets

x_train <- read.table("train/X_train.txt")

y_train <- read.table("train/y_train.txt")

subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")

y_test <- read.table("test/y_test.txt")

subject_test <- read.table("test/subject_test.txt")

x_full <- rbind(x_train, x_test)

y_full <- rbind(y_train, y_test)

subject_full <- rbind(subject_train, subject_test)

#Extracting only mean and standard deviation for each measurement

features <- read.table("features.txt")

mean_std_columns <- grep("-(mean|std)\\(\\)", features[, 2])

x_full <- x_full[, mean_std_columns]

names(x_full) <- features[mean_std_columns, 2]

#Reading descriptive ability labels

activities <- read.table("activity_labels.txt")

y_full[, 1] <- activities[y_full[, 1], 2]

names(y_full) <- "activity"

#Applying descriptive variable names

names(subject_full) <- "subject"

#Merging all columns into one data set

all_full <- cbind(x_full, y_full, subject_full)

#Creating the final data set with column means for all columns by subject and activity
dataset <- ddply(all_full, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(dataset, "dataset.txt", row.name=FALSE)