#!/bin/bash

sudo touch /tmp/${dist}

echo "rancher:password" | chpasswd
echo "root:password" | chpasswd
