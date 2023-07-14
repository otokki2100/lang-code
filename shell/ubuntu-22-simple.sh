#!/bin/bash

hostnamectl set-hostname ubuntu-22

touch /tmp/ubuntu-22

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "ubuntu:password" | chpasswd

systemctl restart sshd
