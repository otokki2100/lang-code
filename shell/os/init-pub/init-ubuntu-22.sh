#!/bin/bash

user=$1
dist=$2
domain=$3

sudo hostnamectl set-hostname ${domain}

sudo touch /tmp/${dist}

sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "${user}:password" | sudo chpasswd
echo "root:password" | sudo chpasswd

sudo systemctl restart sshd

sudo apt update
sudo apt -y install git
