#!/bin/bash

sudo dnf -y install httpd

sudo systemctl enable --now httpd

echo hello | sudo tee /var/www/html/index.html
