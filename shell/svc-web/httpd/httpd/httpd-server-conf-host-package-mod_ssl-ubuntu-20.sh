#!/bin/bash

a2enmod ssl

systemctl restart apache2

apachectl -t -D DUMP_MODULES | grep ssl
