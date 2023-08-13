#!/bin/bash

user=$1
dist=$2
domain=$3

echo ${domain} | tee /tmp/domain

sudo yum -y install squid

sudo systemctl enable --now squid
sudo systemctl status squid
