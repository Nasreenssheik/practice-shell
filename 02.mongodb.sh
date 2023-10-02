echo -e "\e[32m Downloading Mongodb Repo\e[0m"
cp /root/practice-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/mongodb.log
echo -e "\e[32m Installing Mongodb server\e[0m"
yum install mongodb-org -y &>>/tmp/mongodb.log
echo -e "\e[32m Changing the listen address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo -e "\e[32m Enabling and starting Mongodb server\e[0m"
systemctl enable mongod &>>/tmp/mongodb.log
systemctl restart mongod

