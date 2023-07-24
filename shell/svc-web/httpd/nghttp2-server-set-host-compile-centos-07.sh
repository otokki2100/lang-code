#!/bin/bash

sudo yum -y install gcc

curl -L https://github.com/nghttp2/nghttp2/releases/download/v1.55.1/nghttp2-1.55.1.tar.gz -o /tmp/nghttp2.tar.gz

tar xvzf /tmp/nghttp2.tar.gz -C /tmp/

cd /tmp/nghttp2-*

./configure --prefix=/usr/local/nghttp2

make -j$(nproc) && sudo make install
