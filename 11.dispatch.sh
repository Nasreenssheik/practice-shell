yum install golang -y
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop
mkdir /app
cd /app
curl -O https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
unzip dispatch.zip
go mod init dispatch
go get
go build
cp /root/practice-shell/dispatch.service /etc/systemd/system/dispatch.service

