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

cat <<EOF> /etc/squid/allowlist.txt
.opfcaptcha-prod.s3.amazonaws.com
.d2td7dqidlhjx7.cloudfront.net
.device-metrics-us-2.amazon.com
.d32i4gd7pg4909.cloudfront.net
.d21ui22avrxoh6.cloudfront.net
.d1cbg795sa4g1u.cloudfront.net
.d3s98kk2h6f4oh.cloudfront.net
.dyqsoz7pkju4e.cloudfront.net
.fls-na.amazon.com
.skylight-client-ds.ap-northeast-2.amazonaws.com
.ws-client-service.ap-northeast-2.amazonaws.com
.dtyv4uwoh7ynt.cloudfront.net
.ws-broker-service.ap-northeast-2.amazonaws.com
.workspaces.ap-northeast-2.amazonaws.com
.skylight-cm.ap-southeast-2.amazonaws.com
.ap-northeast-2.rdn.amazonaws.com
.awsapps.com
.clients.amazonworkspaces.com
EOF

systemctl restart squid