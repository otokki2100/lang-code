#!/bin/bash

sudo yum -y install git

git clone -b 1.7.4 https://github.com/apache/apr.git /tmp/apr
git clone -b 1.6.3 https://github.com/apache/apr-util.git /tmp/apr-util
