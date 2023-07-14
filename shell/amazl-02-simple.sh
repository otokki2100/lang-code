#!/bin/bash

hostnamectl set-hostname amazl-02

touch /tmp/amazl-02

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "ec2-user:password" | chpasswd

systemctl restart sshd
