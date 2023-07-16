#!/bin/bash

hostnamectl set-hostname ${domain}

touch /tmp/${domain}

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "${user}:password" | chpasswd
echo "root:password" | chpasswd

systemctl restart sshd
