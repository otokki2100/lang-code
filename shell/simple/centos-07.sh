#!/bin/bash

hostnamectl set-hostname centos-07

touch /tmp/centos-07

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "centos:password" | chpasswd

systemctl restart sshd
