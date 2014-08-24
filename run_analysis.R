function run_analysis(){
    
    
    #get column names for measurement data set as features
    features<-read.table("features.txt")
    #get column names for windows
    x<-c(1:128)
    as.character(x)
    windows_names<-paste("windows",x)
    
    
    #get data for test group
    subject_test<-read.table("./test/subject_test.txt",col.names="subject")
    X_test<-read.table("./test/X_test.txt",col.names=features[,2])
    y_test<-read.table("./test/y_test.txt",col.names="Activity")
    
    body_acc_x_test<-read.table("./test/Inertial Signals/body_acc_x_test.txt",col.names=paste("body_acc_x",windows_names))
    body_acc_y_test<-read.table("./test/Inertial Signals/body_acc_y_test.txt",col.names=paste("body_acc_y",windows_names))
    body_acc_z_test<-read.table("./test/Inertial Signals/body_acc_z_test.txt",col.names=paste("body_acc_z",windows_names))
    
    body_gyro_x_test<-read.table("./test/Inertial Signals/body_gyro_x_test.txt",col.names=paste("body_gyro_x",windows_names))
    body_gyro_y_test<-read.table("./test/Inertial Signals/body_gyro_y_test.txt",col.names=paste("body_gyro_y",windows_names))
    body_gyro_z_test<-read.table("./test/Inertial Signals/body_gyro_z_test.txt",col.names=paste("body_gyro_z",windows_names))

    total_acc_x_test<-read.table("./test/Inertial Signals/total_acc_x_test.txt",col.names=paste("total_acc_x",windows_names))
    total_acc_y_test<-read.table("./test/Inertial Signals/total_acc_y_test.txt",col.names=paste("total_acc_y",windows_names))
    total_acc_z_test<-read.table("./test/Inertial Signals/total_acc_z_test.txt",col.names=paste("total_acc_z",windows_names))
    
    test_data<-cbind(subject_test, X_test, y_test,body_acc_x_test,body_acc_y_test,body_acc_z_test,
                    body_gyro_x_test,body_gyro_y_test,body_gyro_z_test,
                    total_acc_x_test,total_acc_y_test,total_acc_z_test)
    
    #get data for train group
    subject_train<-read.table("./train/subject_train.txt",col.names="subject")
    X_train<-read.table("./train/X_train.txt",col.names=features[,2])
    y_train<-read.table("./train/y_train.txt",col.names="Activity")
    
    body_acc_x_train<-read.table("./train/Inertial Signals/body_acc_x_train.txt",col.names=paste("body_acc_x",windows_names))
    body_acc_y_train<-read.table("./train/Inertial Signals/body_acc_y_train.txt",col.names=paste("body_acc_y",windows_names))
    body_acc_z_train<-read.table("./train/Inertial Signals/body_acc_z_train.txt",col.names=paste("body_acc_z",windows_names))
    
    body_gyro_x_train<-read.table("./train/Inertial Signals/body_gyro_x_train.txt",col.names=paste("body_gyro_x",windows_names))
    body_gyro_y_train<-read.table("./train/Inertial Signals/body_gyro_y_train.txt",col.names=paste("body_gyro_y",windows_names))
    body_gyro_z_train<-read.table("./train/Inertial Signals/body_gyro_z_train.txt",col.names=paste("body_gyro_z",windows_names))

    total_acc_x_train<-read.table("./train/Inertial Signals/total_acc_x_train.txt",col.names=paste("total_acc_x",windows_names))
    total_acc_y_train<-read.table("./train/Inertial Signals/total_acc_y_train.txt",col.names=paste("total_acc_y",windows_names))
    total_acc_z_train<-read.table("./train/Inertial Signals/total_acc_z_train.txt",col.names=paste("total_acc_z",windows_names))

    train_data<-cbind(subject_train, X_train, y_train,body_acc_x_train,body_acc_y_train,body_acc_z_train,
                     body_gyro_x_train,body_gyro_y_train,body_gyro_z_train,
                     total_acc_x_train,total_acc_y_train,total_acc_z_train)
    
    #combine train_data and test_data in to a complete data set
    total_data<-rbind(test_data,train_data)
    
    #extract only mean and std of measurements
    df_mean<-total_data[,grep("mean",colnames(total_data))]
    df_std<-total_data[,grep("std",colnames(total_data))]
    subject<-total_data[,"subject"]
    activity<-total_data[,"Activity"]
    
    for (i in 1:length(activity)){
      if (activity[i]==1) activity[i]="WALKING"
      if (activity[i]==2) activity[i]="WALKING_UPSTAIRS"
      if (activity[i]==3) activity[i]="WALKING_DOWNSTAIRS"
      if (activity[i]==4) activity[i]="SITTING"
      if (activity[i]==5) activity[i]="STANDING"
      if (activity[i]==6) activity[i]="LAYING"
      
    }
    tidy_data<-cbind(subject,activity,df_mean,df_std)
    
    #save tidy_data to the txt file
    write.table(tidy_data,"tidy_data.txt",row.name=FALSE)
}
