color="\e[33m"
noclor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"


nodejs()
{
  echo -e "$color Downloading Nodejs repo file$nocolor"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$logfile
  echo -e "$color Installing Nodejs server$nocolor"
  yum install nodejs -y &>>$logfile
  app_start
  npm install &>>$logfile
  service_start
}

app_start()
{
  echo -e "$color Adding user and location$nocolor"
    useradd roboshop &>>$logfile
    mkdir ${app_path} &>>$logfile
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