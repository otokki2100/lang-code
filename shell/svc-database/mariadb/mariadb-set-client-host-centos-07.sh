#!/bin/bash

# mysql
sudo yum -y install mariadb

# sysbench
sudo yum -y install automake libtool
sudo yum -y install mariadb-devel

curl -L https://github.com/akopytov/sysbench/archive/refs/tags/1.0.20.tar.gz -o 1.0.20.tar.gz 
tar xvzf 1.0.20.tar.gz 
cd sysbench-*
./autogen.sh
./configure
make -j$(nproc)
sudo make install
