#!/bin/bash
yum install -y httpd
systemctl start httpd & systemctl enable httpd
wget -O /var/www/html/index.html https://raw.githubusercontent.com/w-ryan-jung/AWSCloudFormation/main/secure_global_remote_work/ec2_setup/index.html
chown apache.root /var/www/html/index.html