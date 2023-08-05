#!/bin/bash

user=$1
dist=$2
domain=$3

echo ${domain} | tee /tmp/domain

sudo apt update

sudo apt -y install openjdk-11-jdk

sudo apt -y install ca-certificates

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get -y install jenkins

sudo systemctl enable --now jenkins
# sudo cat /lib/systemd/system/jenkins.service

# sudo ufw allow 8080
# sudo ufw status
