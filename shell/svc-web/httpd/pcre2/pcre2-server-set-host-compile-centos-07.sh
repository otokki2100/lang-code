#!/bin/bash

sudo yum -y install git gcc gcc-c++

curl -L https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.42/pcre2-10.42.tar.gz -o /tmp/pcre2.tar.gz

tar xvzf /tmp/pcre2.tar.gz -C /tmp/

cd /tmp/pcre2-10.42/
./configure --prefix=/usr/local/pcre2
make -j$(nproc) && sudo make install
echo $?
