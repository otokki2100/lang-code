#!/bin/bash

curl -L https://github.com/curl/curl/releases/download/curl-8_1_2/curl-8.1.2.tar.gz -o /tmp/curl.tar.gz

tar xvzf /tmp/curl.tar.gz -C /tmp/

cd /tmp/curl-*/

./configure --prefix=/usr/local/curl --with-ssl=/usr/local/ssl
make -j$(nproc) && sudo make install
echo $?
