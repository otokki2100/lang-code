#!/bin/bash

hostnamectl set-hostname debian-11

touch /tmp/debian-11

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "admin:password" | chpasswd

systemctl restart sshd
