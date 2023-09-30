echo -e "\e[33m Installing Nginx Server\e[0m"
yum install nginx -y
echo -e "\e[33m Removing default content\e[0m"
cd /usr/share/nginx/html
rm -rf *
echo -e "\e[33m Downloading new content to nginx server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
unzip frontend.zip
rm -rf frontend.zip
echo -e "\e[33m Configuring reverse proxy nginx server\e[0m"
cp /root/practice-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[33m enabling and starting nginx server\e[0m"
systemctl enable nginx
systemctl restart nginx