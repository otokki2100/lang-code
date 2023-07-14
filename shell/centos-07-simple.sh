#!/bin/bash

hostnamectl set-hostname centos07

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "centos:password" | chpasswd

systemctl restart sshd
