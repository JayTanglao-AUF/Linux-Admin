#!/bin/sh

# installing apache
yum install -y httpd

# To start the apache on your VM
systemctl start httpd
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload

# To start on boot and enable Apache
systemctl enable httpd

# installing PHP
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y yum-utils
yum-config-manager --enable remi-php56

yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
systemctl restart httpd

# installing MariaDB
yum install -y mariadb-server mariadb

# to start the database
systemctl start mariadb

# to run a simple security script
mysql_secure_installation

# to start at boot
systemctl enable mariadb

# to log in on as admin
mysql -u root -p