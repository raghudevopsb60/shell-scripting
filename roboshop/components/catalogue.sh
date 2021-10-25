#!/bin/bash

source components/common.sh

MSPACE=$(cat $0 | grep ^Print | awk -F '"' '{print $2}' | awk '{ print length }' | sort | tail -1)


COMPONENT_NAME=Catalogue
COMPONENT=catalogue
NODEJS


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
