#!/bin/sh

echo "====================> INSTALLING HTTPD NOW <===================="
# installing apache
yum install -y httpd

echo "====================>  STARTING HTTPD NOW  <===================="
# to start the apache on your VM
systemctl start httpd

echo "====================>    ADDING FIREWALL   <===================="
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload

# to start httpd on boot and enable Apache
systemctl enable httpd

echo "====================> INSTALLING PHP AND UTILS NOW <===================="
# installing PHP
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y yum-utils
yum-config-manager --enable remi-php56
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
systemctl restart httpd

echo "====================> INSTALLING MARIADB NOW <===================="
# installing MariaDB
yum install -y mariadb-server mariadb

echo "====================> STARTING MARIADB NOW <===================="
# to start the database
systemctl start mariadb

# answering all questions to yes and setting up a password
mysql_secure_installation <<EOF

y
2486181999j
2486181999j
y
y
y
y
EOF

# to start mariadb at boot
systemctl enable mariadb

# to log in on as an admin
mysql -u root -p2486181999J
echo "CREATE DATABASE wordpress; CREATE USER 
wordpressuser@localhost IDENTIFIED by '2486181999j'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED by '2486181999j'; FLUSH PRIVILEGES; "| mysql -u root -p2486181999j

# we need to install the following tools
yum install -y php-gd
yum install -y tar
yum install -y wget

# restart the apche web server
systemctl restart httpd 

echo "====================> INSTALLING WGET NOW <===================="
# using wget to get the wordpress
wget http://wordpress.org/latest.tar.gz
#this will install all the archive files with wordpress files
tar xzvf latest.tar.gz

echo "====================> INSTALLING RSYNC NOW <===================="
# install the rsync tool
yum install -y rsync

# creating a directory called wordpress and transfer all wordpress files there
rsync -avP wordpress/ /var/www/html/
cd /var/www/html/
mkdir /var/www/html/wp-content/uploads

echo "====================> FILES TRANSFERED <===================="
echo "------------------------------------------------------------------------------------"

# assign the correct ownerships and permission
chown -R apache:apache /var/www/html/*
cp wp-config-sample.php wp-config.php
cd /var/www/html/
sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/wordpressuser/g' wp-config.php
sed -i 's/password_here/2486181999j/g' wp-config.php
systemctl restart httpd

echo "====================> LAMP STACK IS INSTALLED AND READY TO USE <===================="
echo "====================>         THANK YOU FOR YOUR PATIENCE      <===================="
echo "See, you not only have to be a good coder to create a system like Linux, you have to be a sneaky bastard too. -Linus Torvalds"