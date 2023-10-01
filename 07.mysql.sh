echo -e "\e[32m Disabiling Mysql default version\e[0m"
yum module disable mysql -y
echo -e "\e[32m Setuping the MySQL5.7 repo file\e[0m"
cp /root/practice-shell/mysql.repo /etc/yum.repos.d/mysql.repo
