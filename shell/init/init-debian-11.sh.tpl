#!/bin/bash

sudo hostnamectl set-hostname ${domain}

sudo touch /tmp/${domain}

sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "${user}:password" | sudo chpasswd
echo "root:password" | sudo chpasswd

sudo systemctl restart sshd

# code
sudo mkdir /home/${user}/code

git clone https://otokki2100@github.com/otokki2100/cloud-aws.git /home/${user}/code/cloud-aws
git clone https://otokki2100@github.com/otokki2100/svc-iac.git /home/${user}/code/svc-iac
git clone https://otokki2100@github.com/otokki2100/svc-web.git /home/${user}/code/svc-web
git clone https://otokki2100@github.com/otokki2100/svc-conn.git /home/${user}/code/svc-conn
git clone https://otokki2100@github.com/otokki2100/svc-repo.git /home/${user}/code/svc-repo
git clone https://otokki2100@github.com/otokki2100/lang-code.git /home/${user}/code/lang-code

sudo chown -R ${user}:${user} /home/${user}/code
