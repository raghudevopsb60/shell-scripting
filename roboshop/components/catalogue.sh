#!/bin/bash

source components/common.sh

cat $0 | grep ^Print

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

Print "Copy Content"
mv /home/roboshop/catalogue-main /home/roboshop/catalogue
Stat $?

Print "Install NodeJS dependencies"
cd /home/roboshop/catalogue
npm install --unsafe-perm &>>$LOG
Stat $?

Print "Fix App Permissions"
chown -R roboshop:roboshop /home/roboshop
Stat $?


Print "Update DNS records in SystemD config"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service   &>>$LOG
Stat $?

Print "Copy SystemD file"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
Stat $?

Print "Start Catalogue Service"
systemctl daemon-reload &>>$LOG && systemctl restart catalogue &>>$LOG && systemctl enable catalogue &>>$LOG
Stat $?

Print "Checking DB Connections from APP"
sleep 5
STAT=$(curl -s localhost:8080/health  | jq .mongo)
if [ "$STAT" == "true" ]; then
  Stat 0
else
  Stat 1
fi
