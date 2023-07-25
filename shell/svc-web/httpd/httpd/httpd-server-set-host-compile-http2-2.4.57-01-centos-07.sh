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

./configure --prefix=/usr/local/apache2 --enable-so --with-included-apr --with-pcre=/usr/local/pcre2/bin/pcre2-config --enable-mods-shared=most --enable-http2 --with-nghttp2=/usr/local/nghttp2 --enable-mods-shared=ssl --enable-ssl=shared --with-ssl=/usr/local/ssl
make -j$(nproc) && sudo make install
echo $?

sudo mkdir /usr/local/apache2/conf.d/
sudo touch /usr/local/apache2/conf.d/custom.conf
echo "IncludeOptional conf.d/*.conf" | sudo tee -a /usr/local/apache2/conf/httpd.conf

sudo sed -i "s/Listen 80/Listen 8080/g" /usr/local/apache2/conf/httpd.conf

cat << EOF | sudo tee /usr/local/apache2/conf.d/http2.conf
LoadModule http2_module modules/mod_http2.so

Protocols h2 h2c http/1.1
EOF

cat << EOF | sudo tee /usr/local/apache2/conf.d/ssl.conf
LoadModule ssl_module modules/mod_ssl.so
EOF

sudo chown -R daemon.daemon /usr/local/apache2

sudo -u daemon /usr/local/apache2/bin/apachectl start
apachectl -V

curl -k -I --http2 http://127.0.0.1:8080

curl http://127.0.0.1:8080

apachectl -D DUMP_MODULES | grep -E "http2|ssl"

ldd /usr/local/apache2/modules/mod_ssl.so
	# linux-vdso.so.1 =>  (0x00007ffc2c1f0000)
	# libssl.so.3 => /usr/local/ssl/lib64/libssl.so.3 (0x00007f52752f1000)
	# libcrypto.so.3 => /usr/local/ssl/lib64/libcrypto.so.3 (0x00007f5274c86000)
	# librt.so.1 => /lib64/librt.so.1 (0x00007f5274a7e000)
	# libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007f5274847000)
	# libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f527462b000)
	# libdl.so.2 => /lib64/libdl.so.2 (0x00007f5274427000)
	# libc.so.6 => /lib64/libc.so.6 (0x00007f5274059000)
	# libz.so.1 => /lib64/libz.so.1 (0x00007f5273e43000)
	# libfreebl3.so => /lib64/libfreebl3.so (0x00007f5273c40000)
	# /lib64/ld-linux-x86-64.so.2 (0x00007f52757d4000)
