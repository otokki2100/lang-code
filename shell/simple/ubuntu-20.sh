#!/bin/bash

hostnamectl set-hostname ubuntu-20

touch /tmp/ubuntu-20

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "ubuntu:password" | chpasswd

systemctl restart sshd
