#!/bin/bash

sudo dnf -y install mariadb105-server

sudo systemctl enable --now mariadb

sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';"
# sudo mysql -u root -e "FLUSH PRIVILEGES;"
