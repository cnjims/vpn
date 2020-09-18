yum install -y ppp
rpm -ivh http://static.ucloud.cn/pptpd-1.3.4-2.el6.x86_64.rpm
echo localip 10.8.0.1 >> /etc/pptpd.conf
echo remoteip 10.8.0.10-100 >> /etc/pptpd.conf
echo ms-dns  8.8.8.8 >> /etc/ppp/options.pptpd
echo ms-dns  8.8.4.4 >> /etc/ppp/options.pptpd
echo account       pptpd       password       '*'   >> /etc/ppp/chap-secrets
echo net.ipv4.ip_forward = 1 >> /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables
service pptpd start
