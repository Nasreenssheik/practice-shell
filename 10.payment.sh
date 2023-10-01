yum install python36 gcc python3-devel -y
useradd roboshop
mkdir /app
cd /app
curl -O https://roboshop-artifacts.s3.amazonaws.com/payment.zip
unzip payment.zip
pip3.6 install -r requirements.txt
cp /root/practice-shell/payment.service /etc/systemd/system/payment.service
