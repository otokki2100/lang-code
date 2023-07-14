#!/bin/bash

touch /tmp/${domain}

echo "rancher:password" | chpasswd
