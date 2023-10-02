echo -e "\e[32m Downloading Nodejs repo file\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/cart.log
echo -e "\e[32m Installing Nodejs server\e[0m"
yum install nodejs -y &>>/tmp/cart.log
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop &>>/tmp/cart.log
mkdir /app &>>/tmp/cart.log
cd /app
echo -e "\e[32m Downloading new app content and dependencies to cart server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/cart.log
unzip cart.zip &>>/tmp/cart.log
rm -rf cart.zip
npm install &>>/tmp/cart.log
echo -e "\e[32m creating cart service file\e[0m"
cp /root/practice-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[32m Enabling and starting the cart service\e[0m"
systemctl daemon-reload
systemctl enable cart &>>/tmp/cart.log
systemctl restart cart