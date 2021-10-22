#!/bin/bash

Print() {
  echo -n -e "\e[1m$1\e[0m  ... "
  echo -e "\n\e[36m======================== $1 ========================\e[0m" >>$LOG
}

Stat() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32mSUCCESS\e[0m"
  else
    echo -e "\e[1;31mFAILURE\e[0m"
    echo -e "\e[1;33mScript Failed and check the detailed log in $LOG file\e[0m"
    exit 1
  fi
}

LOG=/tmp/roboshop.log
rm -f $LOG

Print "Installing Nginx"
yum install nginxx -y &>>$LOG
Stat $?

Print "Enabling Nginx"
systemctl enable nginx
Stat $?

Print "Starting Nginx"
systemctl start nginx
Stat $?

exit
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx
