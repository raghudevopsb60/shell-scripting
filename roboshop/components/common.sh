Print() {
  LSPACE=$(echo $1 | awk '{print length}')
  SPACE=$(($MSPACE-$LSPACE))
  SPACES=""
  while [ $SPACE -gt 0 ]; do
    SPACES="$SPACES$(echo ' ')"
    SPACE=$(($SPACE-1))
  done
  echo -n -e "\e[1m$1${SPACES}\e[0m  ... "
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

DOWNLOAD() {
  Print "Download $COMPONENT_NAME"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
  Stat $?
  Print "Extract $COMPONENT_NAME Content"
  unzip -o -d $1 /tmp/${COMPONENT}.zip &>>$LOG
  Stat $?
  if [ "$1" == "/home/roboshop" ]; then
    Print "Remove Old Content"
    rm -rf /home/roboshop/${COMPONENT}
    Stat $?
    Print "Copy Content"
    mv /home/roboshop/${COMPONENT}-main /home/roboshop/${COMPONENT}
    Stat $?
  fi
}

ROBOSHOP_USER() {
  Print "Add RoboShop User"
  id roboshop &>>$LOG
  if [ $? -eq 0 ]; then
    echo User RoboShop already exists &>>$LOG
  else
    useradd roboshop  &>>$LOG
  fi
  Stat $?
}

SYSTEMD() {
  Print "Fix App Permissions"
  chown -R roboshop:roboshop /home/roboshop
  Stat $?

  Print "Update DNS records in SystemD config"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTHOST/cart.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' -e 's/AMQPHOST/rabbitmq.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service   &>>$LOG
  Stat $?

  Print "Copy SystemD file"
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
  Stat $?

  Print "Start ${COMPONENT_NAME} Service"
  systemctl daemon-reload &>>$LOG && systemctl restart ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT} &>>$LOG
  Stat $?
}

PYTHON() {
  Print "Install Python 3"
  yum install python36 gcc python3-devel -y &>>$LOG
  Stat $?

  ROBOSHOP_USER
  DOWNLOAD "/home/roboshop"

  Print "Install the dependencies"
  cd /home/roboshop/${COMPONENT}
  pip3 install -r requirements.txt &>>$LOG
  Stat $?
  USER_ID=$(id -u roboshop)
  GROUP_ID=$(id -g roboshop)

  Print "Update ${COMPONENT_NAME} Service"
  sed -i -e "/uid/ c uid = ${USER_ID}" -e "/gid/ c gid = ${GROUP_ID}" /home/roboshop/${COMPONENT}/${COMPONENT}.ini &>>$LOG
  Stat $?

  SYSTEMD
}

MAVEN() {
  Print "Install Maven"
  yum install maven -y &>>$LOG
  Stat $?

  ROBOSHOP_USER
  DOWNLOAD "/home/roboshop"

  Print "Make Maven package"
  cd /home/roboshop/${COMPONENT}
  mvn clean package &>>$LOG && mv target/shipping-1.0.jar shipping.jar &>>$LOG
  Stat $?

  SYSTEMD
}

NODEJS() {
  Print "Install NodeJS"
  yum install nodejs make gcc-c++ -y  &>>$LOG
  Stat $?

  ROBOSHOP_USER

  DOWNLOAD "/home/roboshop"

  Print "Install NodeJS dependencies"
  cd /home/roboshop/${COMPONENT}
  npm install --unsafe-perm &>>$LOG
  Stat $?

  SYSTEMD
}

CHECK_MONGO_FROM_APP() {
  Print "Checking DB Connections from APP"
  sleep 5
  STAT=$(curl -s localhost:8080/health  | jq .mongo)
  if [ "$STAT" == "true" ]; then
    Stat 0
  else
    Stat 1
  fi
}


CHECK_REDIS_FROM_APP() {
  Print "Checking DB Connections from APP"
  sleep 5
  STAT=$(curl -s localhost:8080/health  | jq .redis)
  if [ "$STAT" == "true" ]; then
    Stat 0
  else
    Stat 1
  fi
}

