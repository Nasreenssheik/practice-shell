echo -e "\e[32m Installing python server\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/payment.log
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop &>>/tmp/payment.log
mkdir /app &>>/tmp/payment.log
cd /app
echo -e "\e[32m Downloading new app content and dependencies to payment server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/payment.log
unzip payment.zip &>>/tmp/payment.log
pip3.6 install -r requirements.txt&>>/tmp/payment.log
echo -e "\e[32m creating payment service file\e[0m"
cp /root/practice-shell/payment.service /etc/systemd/system/payment.service
echo -e "\e[32m Enabling and starting the payment service\e[0m"
systemctl daemon-reload
systemctl enable payment &>>/tmp/payment.log
systemctl restart payment
