#!/bin/bash

source components/common.sh

Print "Install NodeJS"
yum install nodejs make gcc-c++ -y  &>>$LOG
Stat $?


Print "Add RoboShop User"
id roboshop &>>$LOG
if [ $? -eq 0 ]; then
  echo User RoboShop already exists &>>$LOG
else
  useradd roboshop  &>>$LOG
fi
Stat $?

Print "Download Catalogue"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
Stat $?

Print "Remove Old Content"
rm -rf /home/roboshop/catalogue
Stat $?

Print "Extract Catalogue"
unzip -o -d /home/roboshop /tmp/catalogue.zip &>>$LOG
Stat $?


#$ mv catalogue-main catalogue
#$ cd /home/roboshop/catalogue
#$ npm install
#NOTE: We need to update the IP address of MONGODB Server in systemd.service file
#Now, lets set up the service with systemctl.
#
## mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
## systemctl daemon-reload
## systemctl start catalogue
## systemctl enable catalogue
#
#New work item
