#!/bin/bash

user=$1
dist=$2
domain=$3

echo ${domain} | tee /tmp/domain

cat << EOF | sudo tee /etc/profile.d/squid.sh
http_proxy=http://10.0.101.11:3128/
https_proxy=http://10.0.101.11:3128/
no_proxy=127.0.0.1,localhost,10.0.101.11

export http_proxy https_proxy no_proxy
EOF

source /etc/profile.d/squid.sh
