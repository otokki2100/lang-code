#!/bin/bash

sudo a2enmod remoteip
sudo systemctl restart apache2

cat << EOF | sudo tee /etc/apache2/conf-available/log.conf
LogFormat "%{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" xforwardedfor
EOF

sudo a2enconf log
sudo systemctl reload apache2

cat << EOF | sudo tee /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log xforwardedfor
</VirtualHost>
EOF

sudo systemctl reload apache2
