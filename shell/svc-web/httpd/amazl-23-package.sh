#!/bin/bash

sudo dnf install -y httpd

sudo systemctl enable --now httpd

echo hello | sudo tee /var/www/html/index.html
