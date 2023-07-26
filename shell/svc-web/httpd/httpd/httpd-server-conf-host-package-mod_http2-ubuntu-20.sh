#!/bin/bash

a2enmod http2
ls /etc/apache2/mods-enabled/http2.load
cat /etc/apache2/mods-enabled/http2.conf
# <IfModule !mpm_prefork>
#     Protocols h2 h2c http/1.1
# </IfModule>

systemctl restart apache2

apachectl -t -D DUMP_MODULES | grep http2
