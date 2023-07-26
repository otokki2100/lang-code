#!/bin/bash

sudo apt update

sudo apt -y install apache2

sudo systemctl enable --now apache2
sudo systemctl status --no-pager apache2

apachectl -V
# Server version: Apache/2.4.41 (Ubuntu)

echo hello | sudo tee /var/www/html/index.html
