#!/bin/bash

sudo yum -y install mariadb-server

sudo systemctl enable --now mariadb
sudo systemctl status mariadb

mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password');"
