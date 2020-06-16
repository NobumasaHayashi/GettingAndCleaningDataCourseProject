# GettingAndCleaningDataCourseProject
This is my peer graded assignment for "Getting and Cleaning Data Course."

This project contains one R script "run_analysis.R", a tidy data set named as 
"final.txt", a codebook and the raw data. 

The following is the description about how to run analysis by the R script.

Note :  this scrip requires the library "dplyr". 
        Please make sure to download "dplyr" before running the script.
        
        
<run_analysis.R>
First, the raw data for the measurment, the activity label and the name of the 
subject in "test" folder are read by "read.table()", bound together and stored 
as "Test" by "cbind()". Similarly, the raw data in "train" folder are processed
and stored as "Train" by "cbind()". Then, "Test" and "Train" are combined 
together by "rbind()" and stored as "MData". After merging the data, the previous
data are removed from the memory by "rm()" for each file.

Second, the file "features.txt" containing the label names is read and stored as 
"colNames". Since "colNames" does not contain the name of the subject and the 
activity label, these two variable names are added manually. Then, the completed
label name list is assigned as the colum names of "MData" by 
"names(MData) <-colNames". 

Third, the measurement that are related to the average and the standard deviation
are extracted by searching the sequence of the text, "mean" and "std", in the 
colum names of "MData", using "grep()". Each of them are stored as "MD_mean" and
"MD_std" and combined with the colums of the subject and the activity because
these are not contained in "MD_mean" and "MD_std". The data containing the 
measurement of the average and the standard deviation are stored as "MD_ex".

Finally, the above data set is grouped by the name of the subject and the 
activity label by the function "group_by" and stored as "by_act_sub". Then, the 
mean of each valuables are calculated by the function "summarize_each()" and 
"mean()" and stored as "final". Using this "final", a tidy data set, "final.txt"
is written by "write.table()". 





