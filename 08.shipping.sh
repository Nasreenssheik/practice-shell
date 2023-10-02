echo -e "\e[32m Installing maven server\e[0m"
yum install maven -y &>>/tmp/shipping.log
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop &>>/tmp/shipping.log
mkdir /app &>>/tmp/shipping.log
cd /app
echo -e "\e[32m Downloading new app content to shipping server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/shipping.log
unzip shipping.zip &>>/tmp/shipping.log
echo -e "\e[32m Downloading dependencies and builiding application to shipping server\e[0m"
mvn clean package &>>/tmp/shipping.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/shipping.log
echo -e "\e[32m creating shipping service file\e[0m"
cp /root/practice-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[32m Downloading and installing the mysql schema\e[0m"
yum install mysql -y &>>/tmp/shipping.log
mysql -h mysql-dev.nasreen.cloud -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/shipping.log
echo -e "\e[32m Enabling and starting the shipping service\e[0m"
systemctl daemon-reload
systemctl enable shipping &>>/tmp/shipping.log
systemctl restart shipping