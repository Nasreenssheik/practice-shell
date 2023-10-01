yum install maven -y
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop
mkdir /app
cd /app
curl -O https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
unzip shipping.zip
mvn clean package
mv target/shipping-1.0.jar shipping.jar
cp /root/practice-shell/shipping.service /etc/systemd/system/shipping.service