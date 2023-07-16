#!/bin/bash

touch /tmp/${domain}

echo "rancher:password" | chpasswd
echo "root:password" | chpasswd
