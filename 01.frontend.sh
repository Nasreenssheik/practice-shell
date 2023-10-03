color="\e[33m"
noclor="\e[0m"
log_file="&>>/tmp/frontend.log"

echo -e "$color Installing Nginx Server$nocolor"
yum install nginx -y $log_file
echo -e "$color Removing default content$nocolor"
cd /usr/share/nginx/html
rm -rf * $log_file
echo -e "$color Downloading new content to nginx server$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip $log_file
unzip frontend.zip $log_file
rm -rf frontend.zip
echo -e "$color Configuring reverse proxy nginx server$nocolor"
cp /root/practice-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "$color enabling and starting nginx server$nocolor"
systemctl enable nginx $log_file
systemctl restart nginx