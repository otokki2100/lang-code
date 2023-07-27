#!/bin/bash

sudo hostnamectl set-hostname ${domain}

sudo touch /tmp/${domain}

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "${user}:password" | sudo chpasswd
echo "root:password" | sudo chpasswd

sudo systemctl restart sshd
