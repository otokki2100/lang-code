#!/bin/bash

user=$1
dist=$2
domain=$3

sudo touch /tmp/${dist}

echo "rancher:password" | chpasswd
echo "root:password" | chpasswd
