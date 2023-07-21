#!/bin/bash

# mysql
sudo dnf -y install mariadb105

# sysbench
sudo dnf -y install automake libtool
sudo dnf -y install mariadb105-devel

curl -L https://github.com/akopytov/sysbench/archive/refs/tags/1.0.20.tar.gz -o 1.0.20.tar.gz 
tar xvzf 1.0.20.tar.gz 
cd sysbench-*
./autogen.sh
./configure
make -j$(nproc)
sudo make install
