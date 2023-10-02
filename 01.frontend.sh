echo -e "\e[33m Installing Nginx Server\e[0m"
yum install nginx -y &>>/tmp/frontend.log
echo -e "\e[33m Removing default content\e[0m"
cd /usr/share/nginx/html
rm -rf * &>>/tmp/frontend.log
echo -e "\e[33m Downloading new content to nginx server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/frontend.log
unzip frontend.zip &>>/tmp/frontend.log
rm -rf frontend.zip
echo -e "\e[33m Configuring reverse proxy nginx server\e[0m"
cp /root/practice-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[33m enabling and starting nginx server\e[0m"
systemctl enable nginx &>>/tmp/frontend.log
systemctl restart nginx