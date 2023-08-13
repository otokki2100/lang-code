#!/bin/bash

sudo hostnamectl set-hostname ${domain}

sudo touch /tmp/${dist}

sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "${user}:password" | sudo chpasswd
echo "root:password" | sudo chpasswd

sudo systemctl restart sshd

cat << EOF | sudo tee /etc/environment
LANG=en_US.utf-8
LC_ALL=en_US.utf-8
EOF

sudo yum -y install git
