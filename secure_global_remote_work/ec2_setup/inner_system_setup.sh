#!/bin/bash
echo "p@ssw0rd" | passwd --stdin root
sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/^#PermitRootLogin yes/PermitRootLogin yes/g" /etc/ssh/sshd_config
systemctl restart sshd

yum install -y httpd
systemctl start httpd & systemctl enable httpd

echo "<h1>Welcome!! Inner System Portal</h1>" > /var/www/html/index.html
