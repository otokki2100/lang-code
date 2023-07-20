#!/bin/bash

sudo apt update

sudo apt -y install apache2

sudo systemctl enable --now apache2

echo hello | sudo tee /var/www/html/index.html
