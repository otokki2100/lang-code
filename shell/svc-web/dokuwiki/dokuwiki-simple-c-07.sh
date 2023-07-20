#!/bin/bash

echo ${domain} | tee /tmp/domain

sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

sudo yum -y install httpd

sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum -y install epel-release
sudo yum -y install yum-utils
sudo yum-config-manager --disable remi-php54
sudo yum-config-manager --enable remi-php74
sudo yum clean all
sudo yum makecache fast
sudo yum -y install php php-{cli,common,gd,mbstring,mysqlnd,xml}

php -v

curl -L https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz -o dokuwiki-stable.tgz
sudo mkdir -p /var/www/html/dokuwiki/
sudo tar xvzf dokuwiki-stable.tgz -C /var/www/html/dokuwiki --strip-components=1

sudo cp /var/www/html/dokuwiki/.htaccess.dist /var/www/html/dokuwiki/.htaccess

cat << EOF | sudo tee /etc/httpd/conf.d/dokuwiki.conf
<Virtualhost *:80>
  ServerName ${domain}
  DocumentRoot /var/www/html/dokuwiki

  <Directory "/var/www/html/dokuwiki">
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
  </Directory>

  LogLevel warn
  ErrorLog "logs/dokuwiki_error_log"
  CustomLog "logs/dokuwiki_access_log" common
</Virtualhost>
EOF

sudo chown -R apache:apache /var/www/html/dokuwiki

sudo systemctl enable --now httpd

sudo reboot
