#!/bin/bash
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
echo "net.ipv4.conf.eth0.send_redirects=0" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
yum -y install iptables-services
systemctl start iptables & systemctl enable iptables
iptables -F
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
service iptables save

yum install -y squid
echo "acl all src 0.0.0.0/0" >> /etc/squid/squid.conf
echo "http_access allow all" >> /etc/squid/squid.conf
echo "http_access deny all" >> /etc/squid/squid.conf

systemctl start squid.service & systemctl enable squid.service
