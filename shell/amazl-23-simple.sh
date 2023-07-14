#!/bin/bash

hostnamectl set-hostname amazl-23

touch /tmp/amazl-23

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "ec2-user:password" | chpasswd

systemctl restart sshd
