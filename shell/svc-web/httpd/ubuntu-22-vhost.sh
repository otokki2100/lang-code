#!/bin/bash

cat << EOF | sudo tee /etc/apache2/sites-available/test1.otokki.com.conf
<VirtualHost *:80>
        ServerName test1.otokki.com
        DocumentRoot /var/www/html/test1

        ErrorLog \${APACHE_LOG_DIR}/test1_error.log
        CustomLog \${APACHE_LOG_DIR}/test1_access.log common
</VirtualHost>
EOF

cat << EOF | sudo tee /etc/apache2/sites-available/test2.otokki.com.conf
<VirtualHost *:80>
        ServerName test2.otokki.com
        DocumentRoot /var/www/html/test2

        ErrorLog \${APACHE_LOG_DIR}/test2_error.log
        CustomLog \${APACHE_LOG_DIR}/test2_access.log common
</VirtualHost>
EOF

sudo a2ensite test1.otokki.com
sudo a2ensite test2.otokki.com

sudo systemctl reload apache2

sudo mkdir /var/www/html/{test1,test2}
echo test1 | sudo tee /var/www/html/test1/index.html
echo test2 | sudo tee /var/www/html/test2/index.html
