# Peer-graded assignment for Getting and Cleaning data

The repository contains both the R script "run_analysis.R", the markdown file 
you are reading now "readme.md" and the code book "Codebook.md" describing the
variables. 

## The script

To run the script, you should first download the data, unzip it, then set your 
working directory as the "UCI HAR Data set" folder. From there unwards the 
script uses the different folder and .txt files to first create a train and test 
data set, and then combine these two. Then extracts the measurements on the mean
and SD for each measurement. It uses descriptive activity names and descriptive
variable names. And lastly creates a tidydata set in the form of an .txt file.
This is achieved using the dplyr package. 