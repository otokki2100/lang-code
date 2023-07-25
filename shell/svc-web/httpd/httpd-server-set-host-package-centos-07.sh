#!/bin/bash

yum -y install httpd
# rpm -qa | grep httpd
## httpd-tools-2.4.6-97.el7.centos.2.x86_64
## httpd-2.4.6-97.el7.centos.2.x86_64
systemctl enable --now httpd && systemctl status httpd

httpd -V
## Server version: Apache/2.4.6 (CentOS)

echo hello | tee /var/www/html/index.html
