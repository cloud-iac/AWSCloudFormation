#!/bin/bash
yum inatall -y httpd
systemctl start httpd & systemctl enable httpd
echo "<h1>Welcome!! Inner System Portal</h1>" > /var/www/html/index.html
