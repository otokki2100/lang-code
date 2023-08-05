#!/bin/bash

user=$1
dist=$2
domain=$3

echo ${domain} | tee /tmp/domain

sudo yum -y install java-11-openjdk java-11-openjdk-devel
sudo yum -y install wget

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum -y install jenkins

sudo systemctl enable --now jenkins
# sudo cat /lib/systemd/system/jenkins.service
