#!/bin/bash

hostnamectl set-hostname ${domain}

touch /tmp/${domain}

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "ubuntu:password" | chpasswd

systemctl restart sshd
