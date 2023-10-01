echo -e "\e[31m Downloading mongodb repo file\e[0m"
cp /root/practice-shell/mongodb.repo  /etc/yum.repos.d/mongodb.repo
echo -e "\e[31m Installing mongodb\e[0m"
yum install mongodb-org -y
echo -e "\e[32m Changing the listen address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo -e "\e[32m Enabling and starting mongodb\e[0m"
systemctl enable mongod
systemctl start mongod

