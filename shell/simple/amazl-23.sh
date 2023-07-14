#!/bin/bash

hostnamectl set-hostname ${domain}

touch /tmp/${domain}

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "ec2-user:password" | chpasswd

systemctl restart sshd
