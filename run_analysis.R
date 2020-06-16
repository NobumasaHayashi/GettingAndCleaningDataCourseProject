run_analysis<-function(){
        ##libary(dplyr)
        ##1. Merge train and test data 
        TestData<-read.table("./UCI HAR Dataset/test/X_test.txt")
        TestSub<-read.table("./UCI HAR Dataset/test/subject_test.txt")
        TestLabel<-read.table("./UCI HAR Dataset/test/y_test.txt")
        Test<-cbind(TestSub, TestLabel, TestData)
        ##remove the previous data set
        rm(TestData); rm(TestSub); rm(TestLabel)
        
        TrainData<-read.table("./UCI HAR Dataset/train/X_train.txt")
        TrainSub<-read.table("./UCI HAR Dataset/train/subject_train.txt")
        TrainLabel<-read.table("./UCI HAR Dataset/train/y_train.txt")
        Train<-cbind(TrainSub,TrainLabel,TrainData)
        
        rm(TrainData); rm(TrainSub); rm(TrainLabel)
        
        MData<-rbind(Train, Test)
        
        rm(Train); rm(Test)
        
        ##4. label the names of "MData" with descriptive variable names from y_test/train.txt
        colName<-read.table("./UCI HAR Dataset/features.txt")
        clName<-c("Subject","activity", colName$V2)
        names(MData)<-clName
        
        ##2. extract the mean and standard deviation for each measurement
        MD_mean<-MData[,grep("[Mm]ean", names(MData))]
        MD_std<-MData[,grep("[Ss]td", names(MData))]
        MD_ex<-cbind(MData[,1:2],MD_mean, MD_std)
        
        rm(MD_mean); rm(MD_std)
        
        ##3. use descriptive activity names to name the activity variable names
        act_Label<-read.table("./UCI HAR Dataset/activity_labels.txt")
        MD_act<-mutate(MD_ex,activity_label = act_Label$V2[MD_ex$activity])
        
        rm(act_Label)
        
        MD_act<-MD_act[,c(1,2,89,3:88)]
        
        ##5.  create a second, independent tidy data set with the average 
        ##    of each variable for each activity and each subject.
        by_act_sub<-group_by(MD_act, Subject, activity_label)
        final<-summarize_each(by_act_sub, mean,-activity)
        rm(by_act_sub)
        
        write.table(final,file="final.txt")
}