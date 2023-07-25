#!/bin/bash

cat /usr/local/apache2/conf/httpd.conf | grep mod_status.so

cat << EOF | sudo tee /usr/local/apache2/conf.d/mod_status.conf
<Location /server-status>
    SetHandler server-status
    Require local
</Location>
EOF

sudo -u apache /usr/local/apache2/bin/apachectl restart

curl http://127.0.0.1:8080/server-status
# lynx http://127.0.0.1:8080/server-status
## If you change the Apache server port, you cannot change the default port in apachectl status.
