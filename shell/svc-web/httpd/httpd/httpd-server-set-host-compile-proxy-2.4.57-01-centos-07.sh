#!/bin/bash

cat << EOF | sudo tee /etc/profile.d/custom.sh
PATH=\$PATH:/usr/local/apache2/bin
EOF
source /etc/profile.d/custom.sh

sudo yum -y install git gcc gcc-c++ make libtool autoconf expat-devel libxml2-devel perl-devel
## install the basic library packages required for compile

git clone -b 2.4.57 https://github.com/apache/httpd.git /tmp/httpd

cp -r /tmp/apr /tmp/httpd/srclib/apr
cp -r /tmp/apr-util /tmp/httpd/srclib/apr-util
## prefer not to use the system-provided versions

cd /tmp/httpd/

sed -i "s/-ldl/-ldl -lexpat/g" /tmp/httpd/build/config_vars.mk

./buildconf

./configure --prefix=/usr/local/apache2 --enable-so --with-included-apr --with-pcre=/usr/local/pcre2/bin/pcre2-config --enable-mods-shared=most
make -j$(nproc) && sudo make install
echo $?

sudo mkdir /usr/local/apache2/conf.d/
sudo touch /usr/local/apache2/conf.d/custom.conf
echo "IncludeOptional conf.d/*.conf" | sudo tee -a /usr/local/apache2/conf/httpd.conf

sudo sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf

cat << EOF | sudo tee /usr/local/apache2/conf.d/proxy.conf
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so
EOF

sudo chown -R daemon.daemon /usr/local/apache2

sudo -u daemon /usr/local/apache2/bin/apachectl start
apachectl -V

curl http://127.0.0.1:8080
