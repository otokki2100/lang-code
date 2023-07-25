#!/bin/bash

sudo yum -y remove openssl

sudo yum -y install gcc perl zlib-devel perl-IPC-Cmd perl-Test-Simple

curl https://www.openssl.org/source/openssl-3.0.7.tar.gz -o /tmp/openssl-3.0.7.tar.gz
tar xvzf /tmp/openssl-3.0.7.tar.gz -C /tmp
cd /tmp/openssl-3.0.7/

./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib no-idea no-md2 no-mdc2 no-rc5 no-rc4

make -j$(nproc) && sudo make install

cat << EOF | sudo tee /etc/ld.so.conf.d/openssl.conf
/usr/local/ssl/lib64
EOF

sudo ldconfig -v | grep "ssl/lib"

cat << EOF | sudo tee /etc/profile.d/custom.sh
PATH=\$PATH:/usr/local/ssl/bin

export PATH
EOF
. /etc/profile.d/custom.sh
echo $PATH

openssl check
echo $PATH
which openssl
openssl version -a

openssl ciphers -v | awk '{print $2}' | sort | uniq
## SSLv3
## TLSv1
## TLSv1.2
## TLSv1.3
## check openssl support protocol
