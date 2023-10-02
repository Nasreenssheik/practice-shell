echo -e "\e[32m Downloading rabbitmq repo file\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/rabbitmq.log
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash&>>/tmp/rabbitmq.log
echo -e "\e[32m Installing Rabbitmq-server\e[0m"
yum install rabbitmq-server -y &>>/tmp/rabbitmq.log
echo -e "\e[32m Enabling and starting the Rabbitmq-server\e[0m"
systemctl enable rabbitmq-server &>>/tmp/rabbitmq.log
systemctl start rabbitmq-server
echo -e "\e[32m Adding user and setting permissions \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>/tmp/rabbitmq.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/rabbitmq.log
