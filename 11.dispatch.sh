echo -e "\e[32m Installing golang server\e[0m"
yum install golang -y &>>/tmp/dispatch.log
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop &>>/tmp/dispatch.log
mkdir /app &>>/tmp/dispatch.log
cd /app
echo -e "\e[32m Downloading new app content,dependencies and building software to dispatch server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/dispatch.log
unzip dispatch.zip &>>/tmp/dispatch.log
go mod init dispatch &>>/tmp/dispatch.log
go get &>>/tmp/dispatch.log
go build &>>/tmp/dispatch.log
echo -e "\e[32m creating dispatch service file\e[0m"
cp /root/practice-shell/dispatch.service /etc/systemd/system/dispatch.service
echo -e "\e[32m Enabling and starting the dispatch service\e[0m"
systemctl daemon-reload
systemctl enable dispatch &>>/tmp/dispatch.log
systemctl restart dispatch
