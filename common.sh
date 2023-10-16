color="\e[33m"
noclor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

status_check()
{
  if [ $1 -eq 0 ];then
    echo success
    else
    echo failure
    exit 1
  fi
}



nodejs()
{
  echo -e "$color Downloading Nodejs repo file$nocolor"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$logfile
  status_check
  echo -e "$color Installing Nodejs server$nocolor"
  yum install nodejs -y &>>$logfile
  status_check
  app_start
  npm install &>>$logfile
  status_check
  service_start
}

app_start()
{
  echo -e "$color Adding user and location$nocolor"
    id roboshop &>>$logfile
    if [ $? -eq 0 ];then
    useradd roboshop &>>$logfile
    fi
    status_check
    rm -rf ${app_path} &>>$logfile
    status_check
    mkdir ${app_path} &>>$logfile
    status_check
    cd ${app_path}
    echo -e "$color Downloading new app content and dependencies to ${component} server$nocolor"
    curl -O https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$logfile
    unzip ${component}.zip &>>$logfile
    rm -rf ${component}.zip
}

mongo_schema()
{
  echo -e "$color Downloading and installing the mongodb schema$nocolor"
  cp /root/practice-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
  yum install mongodb-org-shell -y &>>$logfile
  mongo --host mongodb-dev.nasreen.cloud <${app_path}/schema/${component}.js &>>$logfile
}

service_start()
{
  echo -e "$color creating ${component} service file$nocolor"
  cp /root/practice-shell/${component}.service /etc/systemd/system/${component}.service
  echo -e "$color Enabling and starting the ${component} service$nocolor"
  systemctl daemon-reload
  systemctl enable ${component} &>>$logfile
  systemctl restart ${component}
}

maven()
{
  echo -e "$color Installing maven server$nocolor"
  yum install maven -y &>>${logfile}
  app_start
  echo -e "$color Downloading dependencies and builiding application to ${component} server$nocolor"
  mvn clean package &>>${logfile}
  mv target/${component}-1.0.jar ${component}.jar &>>${logfile}
  mysql_schema
  service_start
}

mysql_schema()
{
  echo -e "$color Downloading and installing the mysql schema$nocolor"
  yum install mysql -y &>>${logfile}
  mysql -h mysql-dev.nasreen.cloud -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql &>>${logfile}
}

python()
{
  echo -e "$color Installing python server$nocolor"
  yum install python36 gcc python3-devel -y &>>${logfile}
  app_start
  echo -e "$color Downloading dependencies for python server$nocolor"
  pip3.6 install -r requirements.txt &>>${logfile}
  service_start
}

golang()
{
  echo -e "$color Installing golang server$nocolor"
  yum install golang -y &>>${logfile}
  app_start
  echo -e "$color Downloading dependencies for golang server$nocolor"
  go mod init dispatch &>>${logfile}
  go get &>>${logfile}
  go build &>>${logfile}
  service_start
}
